# Maps & places

**Names:** [NAMES.md](NAMES.md) — locked player-facing labels.

## Locked names

| Concept | Player name | Map | Notes |
|---------|-------------|-----|-------|
| **Home** | **Thal'vaeth Monastery** | **0** — **Hearthglen** (WPL) | Brill-adjacent palette (MPQ) |
| **Run district** | **Rotwood** | **0** — **Duskwood** (worgen cluster) | Outdoor; Mor'Ladim fog native |
| **Mid-run breather** | **Ash Hollow** | volume inside Rotwood | Once per run |

---

## Thal'vaeth Monastery (home) — Hearthglen

Between runs — stash, stitch, plan. **Brill-grey**, readable sky (MPQ).

| Field | Value |
|-------|--------|
| Spawn | `2793.09, -1621.40, 129.33` |
| Bounds | ~120y AT (90001) |
| Phase | **1** |

See [client/mpq/README.md](../client/mpq/README.md) for Hearthglen recolor.

---

## Rotwood (first run district) — outdoor Duskwood

**Why open world:** Mor'Ladim / Duskwood fog only reads correctly **outdoors**.

**Why worgen cluster:** Brightwood Grove and the Rotting Orchard — dense woods, ruined orchards. Thal'vaeth humanoids replace Nightbane on phase 2; vanilla worgen stripped on boot.

| Field | Value |
|-------|--------|
| Location | Duskwood worgen cluster (see tele refs in [NAMES.md](NAMES.md)) |
| Center | `-10736, -857, 55` (midpoint between grove and orchard) |
| Entry spawn | `-10850, -1150, 52` (graveyard 90002) |
| Bounds | ~320y AT (90002) |
| Phase | **2** (creatures + Rotwood gates) |
| Fog | **Native zone 10** Duskwood + Director `SetRunFog` peaks |

### Gating — gameobjects, not terrain

District is a **fenced pocket** on map 0:

| Layer | Purpose |
|-------|---------|
| **Shell fences** | Perimeter — player cannot walk out of the run |
| **Segment gates** | Director opens path to next POI |
| **Extract gate** | Interact → return to Hearthglen |

Full spec: [RUN-GATES.md](RUN-GATES.md) · SQL: `rev_thalvaeth_run_gates.sql`

### POC creature path (segment order)

```
Entry yard → Scavengers → [gate 1] → Sleeper → Caller → [gate 2] → Brute / Snare → Extract
```

Spawns: `rev_thalvaeth_poc_spawns.sql` (phase 2).

### Retired for v1 POC

**Scarlet Wing** (map 189) — indoor; fog never matched Mor'Ladim reference.

**Tranquil Fold** / **Brightwood Fold** — superseded by **Rotwood**.

---

## Ash Hollow (mid-run breather)

AT **90003** inside Brightwood Grove (`-10520, -810, 50`). Once per run. Corruption pause.

---

## Flow (v1)

```
Hearthglen — Thal'vaeth Monastery (phase 1, grey)
        │
        │  Enter Rotwood (teleport to entry spawn)
        ▼
Rotwood (phase 2, Duskwood fog, gated segments)
        │
        └──── extract gate / death ────► Hearthglen
```

---

## Fog summary

| Place | Fog |
|-------|-----|
| Home | Brill-grey, lighter — MPQ on Hearthglen |
| Run | Duskwood zone 10 baked + Director peaks |
| Reference | Mor'Ladim `-10363, 359, 53` |

---

## Future run environments (proposed)

Runs past Rotwood get their own **environment + hazard**, answered by loadout (the gate philosophy — waders for wet, warmth for cold, …). Two on the table:

| Run | Hazard | Loadout answer | Source (outdoor, map 0 EK) |
|-----|--------|----------------|----------------------------|
| **Snow / cold** | Cold taxes Vigor/Hunger; exposure | **Warmth layer** (shirt / tabard / neck) becomes a real **gate** — [GEAR.md](GEAR.md) | Alterac Mountains / Dun Morogh (snow zones, MPQ recolor) |
| **Fog** | Heavy fog cuts sight — dread + Stalker/Sleeper lean harder | Light, quiet, nerve; extends the Duskwood/Mor'Ladim fog tech (`SetRunFog`) | Deep Duskwood / moor / swamp |

Cold runs are what turn **warmth** from optional comfort into a gate — and push "cold" toward a tracked environmental factor ([GEAR.md](GEAR.md) Open). Per-district naming still applies (`<District> <Kind>` — a frost hound, etc.; [NAMES.md](NAMES.md)), original IP.

---

## Related

- [NAMES.md](NAMES.md)
- [RUN-GATES.md](RUN-GATES.md)
- [CHAR-CREATE.md](CHAR-CREATE.md)
- [GEAR.md](GEAR.md)
- [HANDOFF.md](../HANDOFF.md)
