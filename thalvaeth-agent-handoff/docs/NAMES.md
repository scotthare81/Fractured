# Locked names

Single source of truth for **player-facing** names. Code, SQL, and docs must match this table — not vanilla zone labels, not internal tag names, not retired placeholders.

**Spelling:** *Thal'vaeth* (apostrophe, lowercase *vaeth*).

---

## Places

| Concept | Player name | Script / SQL key | Map anchor |
|---------|-------------|------------------|------------|
| Home | **Thal'vaeth Monastery** | `at_thalvaeth_monastery` (90001) | Hearthglen, map 0 |
| First run district | **Rotwood** | `at_thalvaeth_rotwood` (90002) | Duskwood worgen cluster, map 0 |
| Mid-run breather | **Ash Hollow** | `at_thalvaeth_ash_hollow` (90003) | volume inside Rotwood |

Vanilla geography (dev/tele refs only — **not** player names):

| Ref | Coords |
|-----|--------|
| Brightwood Grove | `-10443.9, -830.975, 49.7` |
| The Rotting Orchard | `-11028.6, -883.618, 61.4` |
| The Yorgen Farmstead | `-11049.3, -488.388, 30.3` |

---

## Creatures (90001–90010)

`creature_template.name` = `journal_name`. Tags (`Scavenger`, `Sleeper`, …) are internal only.

| Entry | Player name | Tag |
|-------|-------------|-----|
| 90001 | Ash Sleeper | Sleeper |
| 90002 | Cellar Scavenger | Scavenger |
| 90003 | Catwalk Prowler | Rafter |
| 90004 | Ash Caller | Caller |
| 90005 | Patchwork Brute | Brute |
| 90006 | Broken Snare | Snare |
| 90007 | Edge Stalker | Stalker |
| 90008 | Drifter | Drifter |
| 90009 | Stumbler | Stumbler |
| 90010 | Ghoul | Ghoul |

Player = **Remnant**. Class shown as Remnant in UI (Rogue chassis).

---

## Animals (per-district)

Fauna are named **`<District> <Kind>`** — the run you're in supplies the prefix. Mainstays are **Hound** (predator) and **Boar** (forage beast).

| Kind | In Rotwood | Model |
|------|-----------|-------|
| Predator | **Rotwood Hound** | worg display (never "worg" in UI) |
| Forage beast | **Rotwood Boar** | boar display |
| Neutral | **Rotwood Deer**, **Rotwood Hare** | deer / hare display |
| Rare / elite | **Rotwood Tusker** | apex boar |

The same kind in a future run district takes that district's prefix (e.g. `<District> Hound`). Original IP holds (L15): the worg model always reads as a **Hound**.

---

## Retired (do not use)

| Old name | Reason |
|----------|--------|
| Tranquil Fold | Wrong location |
| Brightwood Fold | Vanilla zone name as player label |
| Scarlet Wing (189) | Indoor; fog failed v1 POC |
| Thalvaeth \<Tag\> creature prefix | Use journal names above |
| Wax End | Retired breather name |

---

## Related

- [MAPS.md](MAPS.md) — coords and flow
- [CREATURE-JOURNAL.md](CREATURE-JOURNAL.md) — journal tiers
- [CREATURES.md](CREATURES.md) — bestiary detail
