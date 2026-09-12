# Creature journal

The creature journal is the **bestiary** — the Remnant's private field notes on what walks the Wild. It is the **Creatures tab** of the broader [Journal Record](JOURNAL-RECORD.md) and obeys the same law: it logs **what you learned**, after you learned it. It never tells you what to do next, never tracks an objective, never points at the designer-intended beat.

The shared Journal presentation rule applies here: **unknown creatures are silhouettes / greyed, unreadable entries**. Their identity is not shown behind a lock icon.

**Bestiary content + roster:** [CREATURES.md](CREATURES.md) — humanoid-first, mundane bodies, spell-like **abilities** OK.

Shipped implementation this doc describes:
`src/mod-thalvaeth/data/sql/updates/pending_db_world/rev_thalvaeth_creature_catalog.sql` (catalog),
`src/mod-thalvaeth/data/sql/updates/pending_db_characters/rev_thalvaeth_creature_journal.sql` (per-player state),
`src/mod-thalvaeth/src/ThalvaethCreatureJournal.cpp` (tier hooks + addon sync),
`src/mod-thalvaeth/client/ThalvaethUI/` (panel stub).

---

## Tiers

Knowledge is earned in three steps. A creature is not a checklist entry you tick; it's a thing you slowly come to understand by surviving it.

| Tier | How you reach it | What the journal shows |
|------|------------------|------------------------|
| **Unknown** | No encounter yet | Grey silhouette / obscured icon; name masked |
| **Sighted** | Mouse over / target a catalog creature within **25y** | `journal_name` + `sighted_description` + intentionally player-facing classification |
| **Engaged** | That creature **enters combat** with you | Adds observed vitality/health and (designed) the abilities you witnessed |

Triggers are grounded in `ThalvaethCreatureJournal.cpp`:

- **Sighted** — the client sends the `SIGHTED` addon opcode (on mouseover/target). The server resolves the player's target, or the nearest catalog creature (entry `90001–90010`) within 25y, and writes `sighted_at`.
- **Engaged** — the server's `OnUnitEnterCombat` hook fires when a catalog creature enters combat with the player; it writes `engaged_at` and `observed_health_max`, then pushes an `engaged` update to the addon.

Progression is one-way and additive: `sighted_at` is only stamped once (later sightings don't overwrite it), and Engaged never downgrades to Sighted.

---

## Data model

Two tables. The **catalog** is shared world content (what a creature *is*); the **player journal** is per-character progress (what *you* have learned).

### `thalvaeth_creature_catalog` (world DB)

| Column | Meaning |
|--------|---------|
| `entry` | 90001–90010 (matches `creature_template.entry`) |
| `journal_name` | Player-facing name (= `creature_template.name`) |
| `sighted_description` | The one-line "sighted" prose |
| `tags` | Internal (`sleeper,special`) — filtering, not shown raw |
| `archetype` | Internal — drives AI/Director |
| `silhouette_icon` | Icon shown at Unknown tier *(currently 0 — see Open)* |
| `ability_map` | JSON: internal key → `{ name, note }` shown at Engaged tier |

### `thalvaeth_player_creature_journal` (characters DB)

| Column | Meaning |
|--------|---------|
| `guid` | Player |
| `creature_entry` | Catalog entry |
| `sighted_at` | Unix time of first sight (0 = not yet) |
| `engaged_at` | Unix time of first combat (NULL = never) |
| `observed_health_max` | Max HP you saw — retained as observed data; UI may render a diegetic vitality band instead of the raw number |
| `observed_abilities` | Abilities you've seen it use *(designed; not yet written — see Open)* |

Primary key `(guid, creature_entry)`; upserts are idempotent.

---

## Ability discovery (Engaged, deep)

Abilities are **learned by being on the receiving end**, then named in plain Thal'vaeth terms — never raw DBC spell names.

Intended loop:

1. A creature uses an ability (e.g. the Snare casts Grab, spell `49366`).
2. The server maps that spell to the creature's `ability_map` key (`hook`).
3. The key is appended to your `observed_abilities`.
4. The journal shows the value's `name` (*"Throws a hook"*) and `note` (*"Drags you into the choke."*).

Until you've witnessed it, the ability line stays absent or obscured — you know *that* it fights, not *how*, which preserves the first-encounter dread.

> **Status:** the `observed_abilities` column and every creature's `ability_map` are the plumbing for this, but the Engaged hook currently records only `observed_health_max`. Wiring spell→key capture is open work (see Open, and the `ability_map` rows proposed in [CREATURES.md](CREATURES.md)).

---

## Naming layers

The journal exists so internal names never leak. Four layers, one direction of visibility:

| Layer | Field | Shown | Example |
|-------|-------|-------|---------|
| Tag | `tags` | No | `sleeper,special` |
| Archetype | `archetype` | No | `sleeper` |
| Journal name | `journal_name` | Yes | Ash Sleeper |
| Ability display | `ability_map[*].name` | Yes (once observed) | *Wakes swinging* |

Player = **Remnant**. Wild humanoids ≠ Remnants — the journal describes *them*, the things left out here.

---

## UI presentation per tier

| Tier | Panel shows |
|------|-------------|
| Unknown | Grey silhouette / obscured icon, name masked (`— — —`) |
| Sighted | Name, sighted line, intentionally player-facing classification; abilities hidden |
| Engaged | Adds observed vitality/health and an ability list that fills in as you witness skills |

The panel lives inside the **Creatures tab** of the [Journal Record](JOURNAL-RECORD.md). It never renders a "next objective," a map ping, a route, or a completion fraction — it is a notebook, not a quest tracker.

---

## Addon protocol

Server ↔ client sync uses hidden addon whispers (`LANG_ADDON`), prefix `THALVAETH`, field separator `~` (`ThalvaethCommon.h`).

| Direction | Opcode | Payload | Meaning |
|-----------|--------|---------|---------|
| S → C | `HELLO` | `1` | Sent on login; addon handshake |
| C → S | `SIGHTED` | *(target implied)* | "I'm looking at this creature" → server records Sighted |
| S → C | `JOURNAL` | `<entry>~<tier>` | Tier changed (`sighted` / `engaged`) — refresh the panel |

Wire format: `THALVAETH\t<opcode>~<payload>`. Only entries in the catalog band (`90001–90010`) are accepted; everything else is ignored server-side.

### Full-state sync requirement

The existing `JOURNAL` message is an incremental update only. The finished Journal **must reconstruct the Remnant's complete persistent knowledge after login or `/reload`**. The server remains authoritative; addon SavedVariables are not the discovery database.

The umbrella design in [JOURNAL-RECORD.md](JOURNAL-RECORD.md) specifies a begin/full-state/end handshake (exact wire format TBD during implementation).

---

## Rules (locked)

- **Learned facts only.** No "Go to Rotwood and kill three Scavengers." No tracked objectives. No glowing path.
- **Unknown means unreadable.** Silhouette / greyed icon / masked text, never the actual answer with a padlock over it.
- **Thal'vaeth names for abilities.** *"Throws a hook,"* not *Grab*/*Shadow Word*. DBC spell names never reach the UI.
- **You witnessed it.** Health/vitality and abilities are what *this Remnant* observed, not datamined truth.
- **Mundane framing.** Sighted/engaged prose stays human-scale horror; no magical-species language for the standard roster ([CREATURES.md](CREATURES.md)).
- **Bestiary ≠ quest log.** Completeness is a soft, self-directed pull (you *want* to fill it), never a task list the game hands you.

---

## Open

| Item | Notes |
|------|-------|
| Wire `observed_abilities` | Capture spell→`ability_map` key on cast/receipt at the Engaged tier |
| Populate `ability_map` | Add the proposed rows (Sleeper/Brute/Stalker/fodder) in [CREATURES.md](CREATURES.md) |
| Set `silhouette_icon` | Per-entry Unknown-tier silhouettes/icons (all default 0 today) |
| Full-state sync | Restore complete persistent creature knowledge on login/reload |
| Journal panel UI | Build inside the tabbed Journal Record shell ([JOURNAL-RECORD.md](JOURNAL-RECORD.md)) |
| "Sighted" fidelity | Confirm mouseover vs target-only, and the 25y radius, feel right in play |

---

## Related

- [JOURNAL-RECORD.md](JOURNAL-RECORD.md) — umbrella UI, Survival/Gear tabs, shared discovery language and hint system
- [CREATURES.md](CREATURES.md) — full roster, AI behavior, ability spell map
- [NAMES.md](NAMES.md) — locked names
- [APTITUDES.md](APTITUDES.md) — how the Remnant answers what the journal records
