# Aptitudes (not WoW spells)

Remnants use **aptitudes** — learned survival tricks. UI never shows retail spell names.

| Aptitude | Effect | Notes |
|----------|--------|-------|
| **Still Breath** | Walk silently; reduces noise wake radius | Counters Sleeper, Caller pulls |
| **Veil Skip** | Short semi-stealth burst; drains Vigor | Not full invisibility |
| **Root Ash** | Throw ash; brief root on humanoid | Mundane item interaction |
| **Short Burst** | Sprint spike; loud; drains Vigor hard | Avoid near Sleepers |
| **Hustle** | Default fast walk mode | Director noise input (future) |

## Vigor

- Max pool; **no magic regen**. It's the hub — Hunger, Thirst, and Infection all erode it, and **Vigor collapse is the only hard fail** ([SURVIVAL.md](SURVIVAL.md)).
- Walk is default and trickles a little Vigor back, but **never fills the bar away from home** (field ceiling).
- Hustle / Short Burst / aptitudes spend it; Hustle + fighting also speed Hunger/Thirst.
- Recovery ladder: walk (tiny) → safe pocket / Ash Hollow (partial, pauses Infection) → Monastery (full).

## Implementation

- Strip class spells at login (PlayerScript)
- Grant aptitude auras as hidden passive + item/gossip triggers
- Spell IDs are internal; journal/aptitude bar uses Thal'vaeth names

See [CONTENT.md](CONTENT.md) for items that unlock aptitudes.
