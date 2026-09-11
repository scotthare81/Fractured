# Thal'vaeth — Agent handoff

**Revision:** 2026-09-10 — locked names (NAMES.md) + Rotwood run district  

**Mobs:** [docs/CREATURES.md](../docs/CREATURES.md)

---

## Creature design (locked direction)

| Rule | Detail |
|------|--------|
| **Human-like** | Primary Wild roster = humanoid bodies |
| **Not magical** | No shade/banshee/elemental **species**; plague, patchwork, starvation OK |
| **Horror lean** | OK in journal prose + Sleeper red eyes — not fantasy taxonomy |
| **Abilities** | Spell-like skills OK; journal uses mundane Thal'vaeth names |
| **Models** | Stock display IDs; **Sleeper** 22844 + MPQ recolor |
| **Player** | Remnant — wild humanoids are not Remnants |

---

## Roster summary

**Fodder:** Scavenger (10973), Drifter (15513), Stumbler (559), Ghoul (10626)  

**Specials:** Sleeper (22844), Rafter (22843), Caller (14537), Snare (4688), Stalker (22845), Brute (7858)  

**v1 POC:** Scavenger → Sleeper → Rafter/Caller → Brute → Snare/Stalker  

---

## Maps (locked)

| Place | Name | Map |
|-------|------|-----|
| Home | **Thal'vaeth Monastery** | 0 (Hearthglen — Brill-adjacent MPQ) |
| First run district | **Rotwood** | 0 (Duskwood worgen cluster, gated) |
| Mid-run breather | **Ash Hollow** | volume in Rotwood |

See [docs/NAMES.md](../docs/NAMES.md), [docs/MAPS.md](../docs/MAPS.md).

## Other locked systems

Solo Wild, no magic heal, Vigor/Hustle, aptitudes, safe pockets, invisible Director (no pressure meter v1), items 60001+.

## Implementation (this package)

| Component | Status |
|-----------|--------|
| Creature catalog SQL (90001–90010) | Ready |
| Special AI (C++) | Sleeper, Caller, Rafter, Snare, Stalker, Brute |
| Fodder SmartAI | Scavenger, Drifter, Stumbler, Ghoul |
| Journal + ThalvaethUI addon wire | Stub |
| POC spawns | Placeholder coords — edit before test |
| MPQ Sleeper eyes | Doc only |

See [docs/TODO.md](../docs/TODO.md).

---

## Agent rules

- SQL: `pending_db_*` only  
- **Git: Thal'vaeth** (`scotthare81/Thalvaeth`) — not AiCraft-WotLK ([REPO.md](../docs/REPO.md))  
- No build unless Scott asks  

**End.**
