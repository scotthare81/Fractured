# The Director — run pacing

The **Stress Director** shapes the tension of a run. It is **invisible** — no pressure meter, no on-screen state in v1 ([L4D-INSPIRED.md](L4D-INSPIRED.md)). It decides *what spawns, when, and how loud a run gets*, so a run breathes instead of being a flat corridor of mobs.

Engine: `src/mod-thalvaeth/src/ThalvaethDirector.{h,cpp}` (a stub today — waves + fog); the full model below is the target.

---

## The rhythm (valleys and peaks)

A run is not constant pressure. The Director paces a **curve** — quiet stretches that let you gather and think, then spikes, then a breather. Left 4 Dead's lesson: dread lives in the *quiet before*, not in a wall of enemies.

```
pressure
   ^           /\            /\  (setpiece)
   |    /\    /  \    /\    /  \
   |___/  \__/    \__/  \__/    \___  time →
     valley  rising  peak  post-peak
```

| Band | Feel | Spawns (from [CREATURES.md](CREATURES.md)) |
|------|------|--------------------------------------------|
| **Valley** | Gather, breathe | Scavenger pairs, a lone Drifter |
| **Rising** | Something's wrong | Stumbler; a low Stalker |
| **Peak** | It's happening | Caller + wave, Rafter, Ghoul rush |
| **Setpiece** | Held breath | **Sleeper** — *placed*, never random |
| **Post-peak** | Limp on | Scavenger only |

---

## Noise & heat (the input)

The Director listens. Loud play raises the run's **heat**; quiet play lets it cool.

| Louder (heat ↑) | Quieter (heat ↓) |
|-----------------|------------------|
| Hustle, **Short Burst** (sprint) | Walking, **Still Breath** |
| Fighting, especially a Caller's shriek | Avoiding, sneaking past |
| Lockpick fail, breaking things | Patience |

Heat weights the roster (more **Ghoul**/**Stalker**), pulls peaks earlier, and can wake a **Sleeper** you tiptoed near. This is the loop that makes the survival clocks matter: Hustling to beat Hunger/Thirst is *loud*, and loud is dangerous. (`NotifyNoise` hook — TODO.)

---

## Segments (the structure)

Rotwood is a **fenced pocket** split into **segments** by gates ([RUN-GATES.md](RUN-GATES.md)). The Director paces each segment, then opens the next when you clear it:

- `OnRunStart` → close segment gates, set base fog, clear persistent-HP map.
- Per segment → run a valley→peak→post-peak beat sized to the segment.
- `OnSegmentClear(id)` → open the gate to segment `id+1`.
- **Safe pocket** (**Ash Hollow**, once per run) → a forced **valley**: pauses Infection, restores some Vigor ([SURVIVAL.md](SURVIVAL.md)) — the breather before the last push.
- `OnExtractReady` → open the extract gate → out to the Monastery.

Shipped POC beat (`rev_thalvaeth_poc_spawns.sql`):

```
Entry yard (valley)         → Scavengers, a Drifter
[gate 1]  (rising→peak)     → Sleeper (setpiece) → Caller + wave
Ash Hollow (safe pocket)    → breather
[gate 2]  (peak)            → Brute / Snare at the choke
Extract   (post-peak)       → limp out
```

---

## Extraction pressure

The Director doesn't nag you to leave — the **clocks** do. Hunger/Thirst climb with time and exertion, Vigor won't refill in the field, and Infection only rises. The longer you push for one more room, the weaker you are for the walk out. Whether the Director (or the Stalker) can follow *through* the extract gate is **TBD** ([RUN-GATES.md](RUN-GATES.md)) — the lock is that death and extraction are the only ways home.

---

## Director hooks (summary)

| Hook | Does |
|------|------|
| `OnRunStart` | Close gates, base fog, clear persistent-HP |
| `OnSegmentClear(id)` | Open next segment gate |
| `OnExtractReady` | Open the extract gate |
| `NotifyNoise(src, radius, intensity)` | Feed heat (Hustle/fight/fail) — *TODO* |
| `SpawnScavengerWave(anchor, n)` | The wave a Caller triggers — *shipped* |
| `SetRunFog` / `ClearRunFog` | Atmosphere peaks (Duskwood/Mor'Ladim) — *shipped* |

---

## v1 scope vs future

- **v1 (stub):** Caller waves + fog control; segment gates opened by script; Sleeper placed by hand.
- **Future (full Director):** live **heat** tracking, dynamic budget per band, noise weighting, earlier/later peaks, Stalker leash tuning. Numbers are all TBD.

**The lock is the role:** always-on, invisible pressure that rises with how loud, how rotten (Infection), and how deep you are — a reason to leave, not a spawn to farm.

---

## Related

- [L4D-INSPIRED.md](L4D-INSPIRED.md) — the pacing vocabulary
- [RUN-GATES.md](RUN-GATES.md) — segments, gates, hooks
- [CREATURES.md](CREATURES.md) — the roster the Director spends
- [SURVIVAL.md](SURVIVAL.md) — the clocks that pace extraction
- [MAPS.md](MAPS.md) — Rotwood, Ash Hollow, the Monastery
