# Run district — gates & bounds

Runs are **open-world** pockets on map **0**, walled off with **gameobjects** — not instance geometry.

First district: **Rotwood** (Duskwood worgen cluster). See [NAMES.md](NAMES.md), [MAPS.md](MAPS.md).

---

## Why objects, not map edits

| Approach | Use |
|----------|-----|
| **Perimeter fences** | Hard boundary on open map 0 — players cannot leave the run |
| **Segment gates** | Director opens the next chunk when budget/ kills satisfied |
| **Extract gate** | Final GO — interact to end run → Hearthglen |
| **Invisible blockers** | Fill gaps between fence models (type 0 door, unclickable) |

No custom ADT geometry v1. Reposition stock **Fence** / **Lordaeron Wall** GOs in SQL; tune in GM mode.

---

## Gate tiers

| Tier | Tag | Behaviour |
|------|-----|-----------|
| **Shell** | `gate_shell` | Ring around whole district; always solid |
| **Segment** | `gate_segment` | Blocks path to next POI; Director sets `GO_STATE_ACTIVE` or despawn |
| **Extract** | `gate_extract` | Opens when extract conditions met; script ports to Hearthglen |

Internal script names: `go_thalvaeth_gate_segment`, `go_thalvaeth_gate_extract`.

---

## Phase & spawn rules

| Rule | Detail |
|------|--------|
| Phase | Remnants on run use **phase 2** (home = phase 1) — vanilla Duskwood mobs hidden |
| Creature spawns | 90001–90010 only inside run areatrigger |
| Vanilla cleanup | DELETE/disable `creature` / `gameobject` in district bbox on boot script |
| Ash Hollow | Breather volume **inside** shell AT — once per run |

---

## Stock GO models (v1)

| Template | Vanilla entry | Role |
|----------|---------------|------|
| `rotwood_fence` (91001) | clone **180035** Fence | Shell + segment lines |
| `rotwood_wall` (91002) | clone **19384** Lordaeron Walls | Corners / hard block |
| `rotwood_extract_gate` (91004) | clone **175570** Gate | Extract interact |

Custom entries **91001–91010** in `rev_thalvaeth_run_gates.sql`.

---

## Director hooks (future)

```
OnSegmentClear(segmentId) → open gate_segment for segmentId+1
OnExtractReady()          → open gate_extract
OnRunStart()              → close all segment gates; apply SetRunFog; clear persistent-HP map
```

Creature health **persists within a run** — no out-of-combat regen, no evade heal-to-full. The Director holds the per-GUID last-known-HP map and clears it on `OnRunStart`. Spec: [CREATURES.md → Persistent run health](CREATURES.md#persistent-run-health--no-damage-revive).

Full run pacing (rhythm, heat/noise, segments): [DIRECTOR.md](DIRECTOR.md).

---

## Related

- [MAPS.md](MAPS.md)
- `src/mod-thalvaeth/data/sql/updates/pending_db_world/rev_thalvaeth_run_gates.sql`
- `src/mod-thalvaeth/src/ThalvaethRunGates.cpp`
