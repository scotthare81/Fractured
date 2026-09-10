# Wild creatures — bestiary (stock models only)

Wild threats are **mostly human-shaped** — scavengers, drifters, brutes, squatters. You can lean a little into horror in **journal prose**, but bodies stay **mundane** (plague, malnutrition, patchwork, ash — not ghosts, elementals, or demons).

**Abilities:** creatures **may** use spell-like skills (pull, scream, root, spore burst). That’s combat tech — not “this thing is a magical species.” Journal names abilities in plain Thal'vaeth terms (*“Throws a hook”*, *“Shrieks for help”*).

**Models:** vanilla WotLK **display IDs** only. MPQ recolor on **Sleeper** (22844 + red eyes).

See [CREATURE-JOURNAL.md](CREATURE-JOURNAL.md).

---

## Naming rules

| Do | Don't |
|----|--------|
| Human social/behavior tags (*Scavenger, Drifter, Brute, Sleeper*) | L4D specials (Smoker, Boomer, …) |
| Plague-grounded bodies (ghoul, wretch, patchwork) | **Magical** species (shade, wraith, banshee, elemental) as default roster |
| Plain sighted lines (*"Still wearing a collar."*) | Fantasy taxonomy (*Gloam, Veilbound*) |
| `ability_map` with mundane descriptions | Raw WoW spell names in UI |

**Player** = Remnant. Wild humans are **not** Remnants — they’re what’s left out here.

---

## Mundane vs magical (bodies)

| OK (humanoid, mundane horror) | Avoid for core roster (magical body) |
|-------------------------------|--------------------------------------|
| Zombie / ghoul / plague peasant | Spectral citizen, lost soul, shade |
| Wretched / starved humanoid | Banshee, wailer, lichling |
| Patchwork / stitched construct | Slime, elemental, wisp |
| Broken One (warped flesh, still a person-shape) | Floating ghost models |

*Exception:* underlayer may spawn **vermin** (rat) as minor fodder — not the main identity.

---

## Fodder — human castoffs

| Tag | `archetype` | DisplayID | Ref | Behavior | Sighted |
|-----|-------------|-----------|-----|----------|---------|
| **Scavenger** | `scavenger` | **10973** | Mindless Zombie (1501) | Packs; noise-curious; low threat | *"Picks at the rubble. Still has hands."* |
| **Drifter** | `drifter` | **15513** | Wretched Captive (16916) | Solo wander; slow to aggro | *"Wrong gait. Won't meet your eyes."* |
| **Stumbler** | `stumbler` | **559** | Plague Ghoul (10405) | Tankier fodder; blocks doorways | *"Shouldn't stand. Does anyway."* |
| **Ghoul** | `ghoul` | **10626** | Ghoul Ravener (10406) | Fast rush when roused | *"All teeth. Used to be a jaw."* |

**District display swaps** (same archetype):

| Tone | Scavenger alt | Stumbler alt |
|------|---------------|--------------|
| Ash / patchwork | **9785** Plaguebone (15654) | **1693** Patchwork (10414) |
| Starved elite zones | **22845** Wretched Skulker (24688) | **7858** Stitched Golem (8545) |
| Cellar (minor) | **1141** Rat (4075) — *vermin*, not human | — |

---

## Specials — one rule each (humanoid)

Director-expensive. **Setpiece:** Sleeper is designer-placed, not random trash.

### Sleeper — *don't wake them* (locked silhouette)

| Field | Value |
|-------|--------|
| Tag / `archetype` | **Sleeper** / `sleeper` |
| DisplayID | **22844** (Wretched Husk rig) |
| MPQ | Ash/grey + **glowing red eyes** — uncanny, not spell effects on the mesh |
| Rule | Kneel/cower idle; **no aggro** until noise, light, or Hustle → stand + brutal punish |
| Abilities | Charge / rake — **mundane** animation; high damage OK |
| Sighted | *"Crouched like sleep. Eyes open. Don't run past."* |
| Counter | Walk; wide berth; Still Breath |

### Rafter — *from the landing above*

| Field | Value |
|-------|--------|
| Tag / `archetype` | `rafter` |
| DisplayID | **22843** (Wretched Skulker /24689) |
| Rule | Spawn on ledge/pipe; **leaps** when player under or crosses trigger |
| Abilities | Leap (spell id OK — journal: *"Drops from the rail"*) |
| Sighted | *"Someone on the catwalk. Not moving. Yet."* |
| Counter | Don't idle under overhangs; listen for shoe scrape |

### Caller — *brings the rest*

| Field | Value |
|-------|--------|
| Tag / `archetype` | `caller` |
| DisplayID | **14537** (Plagued Peasant /14485) or **22844** variant |
| Rule | On aggro or death → **Scavenger/Ghoul wave** (Director spend) |
| Abilities | Shriek / AoE fear — **looks** loud; journal: *"Calls the others"* not *Shadow Word* |
| Sighted | *"Hand over mouth. Waiting to scream."* |
| Counter | Kill fast; silence before fight; Resin lure (future) |

### Snare — *the hook*

| Field | Value |
|-------|--------|
| Tag / `archetype` | `snare` |
| DisplayID | **4688** (Broken One /5980) |
| Rule | Fights from doorway; **pulls** player into choke |
| Abilities | Hook / drag spell — magical VFX fine; body is twisted humanoid |
| Sighted | *"Wrong shoulder. Still throws a line."* |
| Counter | Break LOS; don't stand in door frame |

### Stalker — *matches your pace*

| Field | Value |
|-------|--------|
| Tag / `archetype` | `stalker` |
| DisplayID | **22845** (Wretched Skulker /24688) |
| Rule | Stays at **max range**; closes when you stop; flees after hit → re-stalk |
| Abilities | Optional short stealth — journal: *"Keeps to the edge"* |
| Sighted | *"Parallel. Never closer. Never leaving."* |
| Counter | Turn and force fight; don't Hustle away (noise) |

### Brute — *won't let you through*

| Field | Value |
|-------|--------|
| Tag / `archetype` | `brute` |
| DisplayID | **7858** (Stitched Golem /8545) or **1693** Patchwork (10414) |
| Rule | Slow, loud, high HP; **blocks** corridor / extract |
| Abilities | Heavy swing; optional stun — no bolt casting |
| Sighted | *"Stitched to stand guard. Still is."* |
| Counter | Kite; Stitch Kit before commit; Short Burst out |

### Watcher — *optional v1* (line in the sand)

| Field | Value |
|-------|--------|
| Tag / `archetype` | `watcher` |
| DisplayID | **15513** (Wretched Urchin /16916) — seated |
| Rule | Neutral until player crosses marked line or shines light |
| Abilities | None until triggered — then Ghoul-speed rush |
| Sighted | *"Sitting in the chair. Watching the floor."* |
| Counter | Route around; darkness aptitude |

---

## Abilities policy (locked)

| OK | Not OK (for identity) |
|----|------------------------|
| Pull, leap, scream, root, disease cloud **as skills** | Creature **is** a shade/banshee/elemental |
| Spell IDs under the hood + Thal'vaeth `ability_map` names | WoW spell names in journal/tooltip |
| VFX that reads “wrong” but body stays human | Floating, translucent, no legs |

Example `ability_map`:

```json
{
  "53400": { "name": "Throws a hook", "note": "Drags you into the choke." },
  "57045": { "name": "Shrieks for help", "note": "More Scavengers answer." }
}
```

---

## Retired tags (do not use)

Animal-primary roster (Rat, Boar, Bull, Cur, Coyote, Bear, Hornet, Eel, Snake as main tags), L4D names (Husk, Vault, Gloam, …), magical species as defaults (Shade, Wraith, Banshee).

---

## Director spawn sketch

| Budget | Spawns |
|--------|--------|
| Valley | Scavenger pairs, lone Drifter |
| Rising | Stumbler, Stalker (low) |
| Peak | Caller + wave, Rafter, Ghoul rush after noise |
| Setpiece | **Sleeper** (placed) |
| Post-peak | Scavenger only |

Noise (Hustle, lockpick fail) → Ghoul or Stalker weight up.

---

## v1 POC roster

| # | Tag | DisplayID |
|---|-----|-----------|
| 1 | Scavenger | 10973 |
| 2 | **Sleeper** | 22844 (+ MPQ eyes) |
| 3 | Rafter **or** Caller | 22843 / 14537 |
| 4 | Brute | 7858 |
| 5 | Snare **or** Stalker | 4688 / 22845 |

Defer: Watcher, vermin rat, district alts.

---

## Catalog example

```sql
INSERT INTO `thalvaeth_creature_catalog`
  (`entry`, `journal_name`, `sighted_description`, `tags`, `archetype`, `ability_map`) VALUES
(90001, 'Ash Sleeper', 'Crouched like sleep. Eyes open. Don''t run past it.',
 'sleeper,special', 'sleeper', '{}'),
(90002, 'Cellar Scavenger', 'Picks at the rubble. Still has hands.',
 'scavenger', 'scavenger', '{}');
```

**90xxx** templates only — never reuse vanilla entries.

---

## Open (Scott)

| Item | Notes |
|------|--------|
| Sleeper one-shot vs near-lethal | Tune after POC |
| Caller vs Rafter for v1 slot 3 | Wave vs ambush |
| Ghoul vs Stumbler as fast fodder | One or both |
| Rare vermin in underlayer | Rat OK as minority? |

---

## Related

- [CREATURE-JOURNAL.md](CREATURE-JOURNAL.md)
- [L4D-INSPIRED.md](L4D-INSPIRED.md)
- [HANDOFF.md](../HANDOFF.md)
