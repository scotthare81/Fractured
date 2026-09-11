# Wild creatures — bestiary (stock models only)

Wild threats are **mostly human-shaped** — scavengers, drifters, brutes, squatters. You can lean a little into horror in **journal prose**, but bodies stay **mundane** (plague, malnutrition, patchwork, ash — not ghosts, elementals, or demons).

**Abilities:** creatures **may** use spell-like skills (pull, scream, root, spore burst). That's combat tech — not "this thing is a magical species." Journal names abilities in plain Thal'vaeth terms (*"Throws a hook"*, *"Shrieks for help"*).

**Models:** vanilla WotLK **display IDs** only. MPQ recolor on **Sleeper** (22844 + red eyes).

**Player** = Remnant. Wild humans are **not** Remnants — they're what's left out here.

This file is the roster source of truth. It matches the shipped data:
`server/sql/pending_db_world/rev_thalvaeth_creature_catalog.sql` (catalog + `creature_template`),
`server/sql/pending_db_world/rev_thalvaeth_fodder_smartai.sql` (fodder), and
`server/scripts/ThalvaethCreatures.cpp` (specials). Journal tiers: [CREATURE-JOURNAL.md](CREATURE-JOURNAL.md).

---

## Naming rules

| Do | Don't |
|----|--------|
| Human social/behavior tags (*Scavenger, Drifter, Brute, Sleeper*) | L4D specials (Smoker, Boomer, …) |
| Plague-grounded bodies (ghoul, wretch, patchwork) | **Magical** species (shade, wraith, banshee, elemental) as default roster |
| Plain sighted lines (*"Still wearing a collar."*) | Fantasy taxonomy (*Gloam, Veilbound*) |
| `ability_map` with mundane descriptions | Raw WoW spell names in UI |

Three name layers per creature (see [CREATURE-JOURNAL.md](CREATURE-JOURNAL.md)):

| Layer | Field | Player sees it? | Example |
|-------|-------|-----------------|---------|
| Tag | `tags` | No (internal) | `sleeper,special` |
| Archetype | `archetype` | No (drives AI/Director) | `sleeper` |
| Journal name | `journal_name` = `creature_template.name` | **Yes** | Ash Sleeper |
| Ability display | `ability_map` value `name` | **Yes** (once observed) | *"Wakes swinging"* |

**Player** = Remnant. Wild humanoids ≠ Remnants.

---

## Mundane vs magical (bodies)

| OK (humanoid, mundane horror) | Avoid for core roster (magical body) |
|-------------------------------|--------------------------------------|
| Zombie / ghoul / plague peasant | Spectral citizen, lost soul, shade |
| Wretched / starved humanoid | Banshee, wailer, lichling |
| Patchwork / stitched construct | Slime, elemental, wisp |
| Broken One (warped flesh, still a person-shape) | Floating ghost models |

*Exception:* underlayer may spawn **vermin** (rat) as minor fodder — not the main identity.

Engine note: fodder that reads as a corpse (Stumbler, Ghoul) ships as `creature_template.type` **7 (undead)**; everything else is **6 (humanoid)**. Undead-as-plague-corpse is inside the mundane rule; do **not** promote it to "magical species."

---

## Locked catalog — 90001–90010

The band is locked (see [NAMES.md](NAMES.md)). `journal_name` = `creature_template.name`. `type`: 6 humanoid, 7 undead. `HP×`/`Dmg×` are `HealthModifier`/`DamageModifier`. AI: `SmartAI` (data) or a C++ `ScriptName`.

| Entry | Journal name | Archetype | DisplayID (ref) | Type | Lvl | HP× | Dmg× | AI | Role |
|-------|--------------|-----------|-----------------|------|-----|-----|------|----|------|
| 90001 | **Ash Sleeper** | `sleeper` | 22844 (Wretched Husk) | 6 | 24 | 8.0 | 2.5 | `npc_thalvaeth_sleeper` | Setpiece punish |
| 90002 | **Cellar Scavenger** | `scavenger` | 10973 (Mindless Zombie) | 6 | 22 | 1.2 | 1.0 | SmartAI | Fodder pack |
| 90003 | **Catwalk Prowler** | `rafter` | 22843 (Wretched Skulker) | 6 | 23 | 2.0 | 1.5 | `npc_thalvaeth_rafter` | Ambush from above |
| 90004 | **Ash Caller** | `caller` | 14537 (Plagued Peasant) | 6 | 22 | 1.5 | 1.0 | `npc_thalvaeth_caller` | Wave trigger |
| 90005 | **Patchwork Brute** | `brute` | 7858 (Stitched Golem) | 6 | 25 | 12.0 | 2.0 | `npc_thalvaeth_brute` | Corridor block |
| 90006 | **Broken Snare** | `snare` | 4688 (Broken One) | 6 | 24 | 3.0 | 1.2 | `npc_thalvaeth_snare` | Choke puller |
| 90007 | **Edge Stalker** | `stalker` | 22845 (Wretched Skulker alt) | 6 | 23 | 2.0 | 1.0 | `npc_thalvaeth_stalker` | Pace pressure |
| 90008 | **Drifter** | `drifter` | 15513 (Wretched Captive) | 6 | 21 | 1.0 | 0.9 | SmartAI | Lone wander fodder |
| 90009 | **Stumbler** | `stumbler` | 559 (Plague Ghoul) | 7 | 22 | 2.5 | 1.1 | SmartAI | Tanky doorway fodder |
| 90010 | **Ghoul** | `ghoul` | 10626 (Ghoul Ravener) | 7 | 23 | 1.8 | 1.3 | SmartAI | Fast rush fodder |

`faction` 14 (monster) and `VerifiedBuild` 12340 across the band. Never reuse a vanilla entry number — only 90xxx.

---

## Fodder — human castoffs

Fodder is cheap Director budget: it fills valleys and swells peaks. All fodder is `SmartAI` (no C++). Species-alt models below are display swaps only — **same archetype, same journal identity**, not new catalog rows.

### Cellar Scavenger — 90002 · `scavenger`

| Field | Value |
|-------|-------|
| Behavior | OOC random wander (~5–15s); noise-curious; low threat, spawns in pairs |
| Ability | **Rend** (spell 11977) IC — journal: *"Tears at the wound"* |
| Sighted | *"Picks at the rubble. Still has hands."* |
| Counter | Cheap kill; don't let a Caller stack them on you |
| Director | Valley/peak filler |

### Drifter — 90008 · `drifter`

| Field | Value |
|-------|-------|
| Behavior | Slow, wide OOC wander (~8–25s); slow to aggro; solo |
| Ability | Melee only (no cast) |
| Sighted | *"Wrong gait. Won't meet your eyes."* |
| Counter | Route around it; it barely reacts |
| Director | Valley ambience; sells "the Wild is inhabited" |

### Stumbler — 90009 · `stumbler` (undead)

| Field | Value |
|-------|-------|
| Behavior | Tanky; blocks doorways; slow walk (0.6) |
| Ability | **Cleave** (spell 40505) IC — journal: *"Wide swing"* |
| Sighted | *"Shouldn't stand. Does anyway."* |
| Counter | Don't fight it in the frame it's plugging; step out and pull |
| Director | Rising pressure; soft wall |

### Ghoul — 90010 · `ghoul` (undead)

| Field | Value |
|-------|-------|
| Behavior | Fast rush (run 1.4) when roused |
| Abilities | **Enrage** (spell 8599) below 40% HP; **Rend** (spell 11977) IC — journal: *"Frenzies"* / *"Tears at the wound"* |
| Sighted | *"All teeth. Used to be a jaw."* |
| Counter | Kill before it enrages, or Short Burst away from the pack |
| Director | Peak / noise-punish (Hustle and lockpick fails weight Ghouls up) |

---

## Specials — one rule each (humanoid)

Director-expensive. Each special is **one legible rule**, implemented in `ThalvaethCreatures.cpp`. Behavior below is what the shipped AI actually does; tuning numbers are POC values.

### Ash Sleeper — 90001 · *don't wake it* (locked silhouette)

| Field | Value |
|-------|-------|
| DisplayID | **22844** + MPQ ash/grey + **glowing red eyes** (uncanny, not mesh spell FX) |
| Idle | Kneels (`UNIT_STAND_STATE_KNEEL`), **passive**, no aggro |
| Wake trigger | A player within **10y** who is **in combat** or **running** → stands, goes aggressive, opens with a rake |
| Ability | **Claw Rampage** (spell 48256) on wake — journal: *"Wakes swinging"* |
| Sighted | *"Crouched like sleep. Eyes open. Don't run past it."* |
| Counter | **Walk** past it (see below); wide berth; **Still Breath** aptitude keeps you under the wake radius |
| Director | **Setpiece** — designer-placed, never random trash |

> **Wake nuance (design ↔ engine):** the AI wakes on `IsInCombat() || IsRunning()`. Players default to *running*, so a Remnant must actually be in **walk** mode — via the **Still Breath** aptitude / walk toggle ([APTITUDES.md](APTITUDES.md)) — to slip past. "Noise/light/Hustle" is the design vocabulary; `IsRunning()` is the v1 stand-in for it. If we later want light or lockpick-fail noise to wake it, that's a Director hook, not a body change.

### Catwalk Prowler — 90003 · *from the landing above*

| Field | Value |
|-------|-------|
| DisplayID | **22843** (Wretched Skulker) |
| Idle | **Passive** on a ledge/pipe until a player enters its trigger |
| Rule | When a player is within **6y** (and in LOS) → **leaps** onto them (`MoveJump`), then attacks ~0.8s after landing. One-shot; won't re-leap |
| Ability | **Leap** (movement, `ability_map` key `leap`) — journal: *"Drops from the rail"* |
| Sighted | *"Someone on the catwalk. Not moving. Yet."* |
| Counter | Don't idle/cross under overhangs; bait the leap from range, then fight it grounded |
| Director | Ambush accent at peaks and choke approaches |

### Ash Caller — 90004 · *brings the rest*

| Field | Value |
|-------|-------|
| DisplayID | **14537** (Plagued Peasant) |
| Rule | ~2s after engage → **shrieks once**: spawns a Scavenger wave (**+2**), and on **death** spawns another (**+3**) |
| Ability | **Terrifying Screech** (spell 38607) — journal: *"Shrieks for help"* (**not** *Shadow Word*) |
| Sighted | *"Hand over mouth. Waiting to scream."* |
| Counter | Burst it down before the 2s shriek; break LOS to the room it would fill; kill it somewhere you can handle +3 |
| Director | Peak trigger — the Caller *is* the budget spend |

### Patchwork Brute — 90005 · *won't let you through*

| Field | Value |
|-------|-------|
| DisplayID | **7858** (Stitched Golem) |
| Rule | Slow, loud, very high HP (×12); **defensive**; opens with a stomp; **leashes at 12y** from its post (evades + teleports home if dragged out) |
| Ability | **Stomp** (spell 42723) on engage — journal: *"Stomps the ground"* |
| Sighted | *"Stitched to stand guard. Still is."* |
| Counter | You cannot outrace its slot — kite inside the leash, Stitch Kit before you commit, **Short Burst** past once it's low |
| Director | Corridor/extract gatekeeper (setpiece-adjacent) |

> **Keeps its wounds.** On leash it returns to its post but **retains HP** — a chipped gatekeeper stays chipped. See [Persistent run health](#persistent-run-health--no-damage-revive).

### Broken Snare — 90006 · *the hook*

| Field | Value |
|-------|-------|
| DisplayID | **4688** (Broken One) |
| Rule | ~3s after engage, then every ~8s: if the target is in LOS and **>5y** away → **hooks** them into the choke |
| Ability | **Grab** (spell 49366) — journal: *"Throws a hook"* |
| Sighted | *"Wrong shoulder. Still throws a line."* |
| Counter | **Break LOS** on the hook timer; don't fight from the doorway it wants to drag you into; close the gap so the >5y check fails |
| Director | Choke/doorway accent |

### Edge Stalker — 90007 · *matches your pace*

| Field | Value |
|-------|-------|
| DisplayID | **22845** (Wretched Skulker alt) |
| Rule | Walks; paces to hold **~22–26y** off the nearest player (within 40y); when **hit once** → breaks off, wanders ~15y, re-stalks after ~8s |
| Ability | Pace/flee behavior (no offensive cast v1) — journal: *"Keeps to the edge"* |
| Sighted | *"Parallel. Never closer. Never leaving."* |
| Counter | Turn and **force** the fight (it flees on the first solid hit); don't Hustle away — noise weights the peak |
| Director | Always-on unease between fights |

> **Keeps its wounds.** The flee must be a *stay-in-run disengage*, not a true evade — a Stalker you shot to half re-stalks you at half. See [Persistent run health](#persistent-run-health--no-damage-revive).

### Watcher — *proposed, deferred* (line in the sand)

Not in the shipped catalog (would be **90011**). Neutral-until-provoked seated humanoid; rushes at Ghoul speed when a player crosses a marked line or shines light. DisplayID **15513** (seated). Keep it for after the POC — logged in **Open** below.

---

## Animal layer — neutral / hostile / rare

A second roster runs alongside the humanoid castoffs: real beasts, mundane bodies — the wild that preys on both you and the dead. This does **not** demote the humanoid horror roster; it's a parallel ecology that feeds the **Hunger** clock (meat) and the **barter economy** (hide, sinew, tusk) — see [ECONOMY.md](ECONOMY.md). Persistent run health applies here too: a rare beast can be worn down across a run, not just one-shot.

Proposed band **90101+** (kept clear of the humanoid `90001–90019`). Display IDs are stock boar / worg / deer models (TBD).

**Naming convention (locked):** animals are **`<District> <Kind>`** — the run supplies the prefix. Mainstays are **Hound** (predator) and **Boar** (forage beast); the same beast in a future district takes that district's prefix. See [NAMES.md](NAMES.md).

| Tier | Name (in Rotwood) | Kind | Behavior | Drops |
|------|-------------------|------|----------|-------|
| Neutral | **Rotwood Deer** | deer | Flees; low threat | Venison (Hunger), Raw Hide, Sinew |
| Neutral | **Rotwood Hare** | small game | Bolts | Small meat, scrap hide |
| Hostile | **Rotwood Boar** | forage beast | Aggressive, esp. while you butcher | Pork (Hunger), Raw Hide, Tusk |
| Hostile | **Rotwood Hound** | predator (worg model) | Territorial; guards nodes; packs | Raw Hide, Fang / Claw, Sinew |
| Rare / elite | **Rotwood Tusker** | apex boar | A hunt — rare spawn, high HP | More / better Uncommon mats + gear (no unique mark) |

Original IP holds (L15): the **worg model ships as a Hound** — never "worg" in the UI. Same mundane-body rule as the humanoids — no spectral or magical beasts.

Blades pull double duty again: the knife (5278) / cleaver **butcher** these for meat + hide *and* strip the human dead + salvage. Rare/elite beasts reward volume, quality, and gear — not a currency token (there is no rare mark; [ECONOMY.md](ECONOMY.md)).

## Persistent run health — no damage revive

**Rule (locked direction):** inside a run, damage you deal to a Wild creature **sticks**. A live creature never regenerates or resets to full. Shoot an Edge Stalker to half, it flees at half and re-stalks you at half. Chip a Patchwork Brute, back off, and it's still chipped when you come back. Health only resets when the creature **dies** or the **run ends** (extract or death → the district respawns fresh).

This makes the run one continuous attrition encounter (L4D-style — [L4D-INSPIRED.md](L4D-INSPIRED.md)): hit-and-run is a real tactic, every shot/aptitude spend matters, and a wounded thing *staying* wounded is the horror — not a health-bar that heals the moment you look away.

### Why it doesn't happen by default

AzerothCore revives creature damage two ways. Both must be switched off for the run band (90001–90010):

| Cause | Default behavior | Fix |
|-------|------------------|-----|
| **Out-of-combat regen** | A creature out of combat ticks back to full in a few seconds | Data: `creature_template.RegenHealth = 0` |
| **Evade / reset heal** | On leash, lost target, or home return the creature evades and is restored to **full** | Code: run creatures must not full-heal on evade/reset — retain current HP |

Today both fire: the **Brute** calls `EnterEvadeMode()` on its 12y leash (→ full heal + teleport home), and the **Stalker**'s flee can drop combat and evade. `RegenHealth` is on by default for the whole band.

### Implementation approach (not yet built)

1. **Data — kill OOC regen.** Set `RegenHealth = 0` on 90001–90010 in `rev_thalvaeth_creature_catalog.sql` (or the `CREATURE_FLAG_EXTRA_NO_HEALTH_REGEN` extra flag). One line, no code.
2. **AI — kill evade heal.** Give run creatures a shared base (`ThalvaethCreatureAI`) whose evade/reset **keeps current health** instead of `SetFullHealth()`:
   - **Edge Stalker** — flee becomes a *stay-in-run disengage*, not a true evade, so HP carries while it re-stalks.
   - **Patchwork Brute** — returns to post on leash but **retains HP**.
3. **Director — remembered HP (belt-and-suspenders).** The Director holds a per-GUID last-known-health map for live run creatures; if anything would reset one to full (evade edge cases, phase/grid churn), it clamps back. Cleared on `OnRunStart` — [RUN-GATES.md](RUN-GATES.md).

### Boundaries & edge cases

- **Run-scoped, not permanent.** Persistence lasts the active run; extract/death resets the district and spawns fresh (phase 2) — [MAPS.md](MAPS.md).
- **Summoned waves are exempt.** Caller Scavengers spawn `TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT` — they despawn, not attrition-persist. Intended: they're pressure, not a health pool.
- **Setpiece Sleeper.** You can pre-soften a Sleeper before waking it — or fail and pay full price. Intended.
- **Kite-safety tradeoff (Scott).** With no evade-heal, chip → retreat → repeat carries no risk. That's *intended* attrition for a solo run — but if a gatekeeper (e.g. the Brute) should heal only when you fully leave its segment, flag it. Logged in Open.

## District display swaps (alts)

Same archetype and journal identity, different `CreatureDisplayID` for local palette. Implement as `creature_template_model` variants, **not** new journal rows.

| Tone | Scavenger alt | Stumbler alt |
|------|---------------|--------------|
| Ash / patchwork | **9785** Plaguebone | **1693** Patchwork |
| Starved elite zones | **22845** Wretched Skulker | **7858** Stitched Golem |
| Cellar (minor) | **1141** Rat — *vermin*, not human | — |

---

## Abilities policy (locked) + spell map

| OK | Not OK (for identity) |
|----|------------------------|
| Pull, leap, scream, root, disease cloud **as skills** | Creature **is** a shade/banshee/elemental |
| Spell IDs under the hood + Thal'vaeth `ability_map` names | WoW spell names in journal/tooltip |
| VFX that reads "wrong" but body stays human | Floating, translucent, no legs |

Shipped ability stand-ins (`ThalvaethCommon.h`) and their journal-facing names. Keys in **bold** already exist in the catalog's `ability_map`; the rest are **proposed** so every witnessed ability can be named (today they are `NULL` in `rev_thalvaeth_creature_catalog.sql`).

| Creature | Spell ID | `ability_map` key | Journal name | In catalog? |
|----------|----------|-------------------|--------------|-------------|
| Catwalk Prowler | — (MoveJump) | **leap** | *Drops from the rail* | Yes |
| Ash Caller | 38607 | **shriek** | *Shrieks for help* | Yes |
| Broken Snare | 49366 | **hook** | *Throws a hook* | Yes |
| Ash Sleeper | 48256 | rake | *Wakes swinging* | Proposed |
| Patchwork Brute | 42723 | stomp | *Stomps the ground* | Proposed |
| Edge Stalker | — (pace) | pace | *Keeps to the edge* | Proposed |
| Cellar Scavenger | 11977 | rend | *Tears at the wound* | Proposed |
| Stumbler | 40505 | cleave | *Wide swing* | Proposed |
| Ghoul | 8599 / 11977 | frenzy / rend | *Frenzies* / *Tears at the wound* | Proposed |

`ability_map` value shape (movement or spell both allowed):

```json
{
  "hook":   { "name": "Throws a hook",     "note": "Drags you into the choke." },
  "shriek": { "name": "Shrieks for help",  "note": "More Scavengers answer." },
  "leap":   { "name": "Drops from the rail","note": "Leap from above." }
}
```

---

## Director spawn budget → roster

The Director is invisible (no pressure meter v1). Budget bands map to who shows up:

| Budget | Spawns |
|--------|--------|
| Valley | Scavenger pairs, lone Drifter |
| Rising | Stumbler; Stalker (low) |
| Peak | Caller + wave, Rafter, Ghoul rush after noise |
| Setpiece | **Sleeper** (placed) |
| Post-peak | Scavenger only |

Noise inputs (Hustle, lockpick fail, Short Burst) weight **Ghoul** and **Stalker** up. Pacing rationale: [L4D-INSPIRED.md](L4D-INSPIRED.md).

---

## v1 POC roster & path

Shipped POC path (`rev_thalvaeth_poc_spawns.sql`, phase 2, Rotwood):

```
Entry yard → Scavengers (+ Drifter) → [gate 1] → Sleeper → Caller → [gate 2] → Brute / Snare → Extract
```

| # | Slot | Entry / DisplayID |
|---|------|-------------------|
| 1 | Scavenger | 90002 / 10973 |
| 2 | **Sleeper** (setpiece) | 90001 / 22844 (+ MPQ eyes) |
| 3 | Rafter **or** Caller | 90003 / 22843  ·  90004 / 14537 |
| 4 | Brute | 90005 / 7858 |
| 5 | Snare **or** Stalker | 90006 / 4688  ·  90007 / 22845 |

Defer: Watcher, vermin rat, district alts.

---

## Retired tags (do not use)

The **humanoid castoffs stay the primary horror roster**; animals are a *secondary* fauna layer (Rotwood Boar, Rotwood Hound, deer/hare, rare Rotwood Tusker — see [Animal layer](#animal-layer--neutral--hostile--rare)), not the identity of the Wild. Still off the table: **L4D names** (Husk, Vault, Gloam, …), **magical species as defaults** (Shade, Wraith, Banshee), and **"worg" in player-facing text** (use the district Hound). Boar and the worg model (now the district Hound) are no longer retired.

---

## Open (Scott)

Tuning:

| Item | Notes |
|------|--------|
| Sleeper one-shot vs near-lethal | ×2.5 dmg + Claw Rampage at lvl 24 — tune after POC |
| Caller vs Rafter for v1 slot 3 | Wave vs ambush |
| Ghoul vs Stumbler as fast fodder | One or both |
| Rare vermin in underlayer | Rat OK as minority? |
| Stalker offensive kit | Pure pace v1, or add a poke that doesn't break the "never closer" read? |
| Kite-safe attrition | With persistent health (no evade-heal), chip-and-retreat is risk-free — OK for all, or should the Brute / gatekeepers heal only on a full segment-leave? |

Data/plumbing gaps found while writing this:

| Gap | Detail |
|-----|--------|
| `ability_map` mostly `NULL` | Only Rafter/Caller/Snare are populated; add the **Proposed** rows above so the journal can name every observed ability |
| `silhouette_icon` unset | Catalog column exists but all rows default 0 — needed for the Unknown-tier journal silhouette ([CREATURE-JOURNAL.md](CREATURE-JOURNAL.md)) |
| `observed_abilities` not written | The journal's Engaged tier records max HP but never records which abilities you saw — abilities can't yet surface per-player |
| Damage revives on reset | `RegenHealth` is on for the band, and Brute leash + Stalker flee evade-heal to full — needs the [Persistent run health](#persistent-run-health--no-damage-revive) fix |
| Watcher not authored | Reserve **90011** if we keep it |

---

## Related

- [CREATURE-JOURNAL.md](CREATURE-JOURNAL.md) — tiers, tables, addon protocol
- [NAMES.md](NAMES.md) — locked names
- [L4D-INSPIRED.md](L4D-INSPIRED.md) — pacing vocabulary
- [APTITUDES.md](APTITUDES.md) — Remnant counters (Still Breath, Short Burst, …)
- [HANDOFF.md](../HANDOFF.md)
