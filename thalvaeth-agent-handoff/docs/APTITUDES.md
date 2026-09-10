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

- Max pool per run segment; no magic regen
- Walk is default; Hustle drains over time
- Safe pockets pause corruption only — **no** full vigor refill in v1

## Implementation

- Strip class spells at login (PlayerScript)
- Grant aptitude auras as hidden passive + item/gossip triggers
- Spell IDs are internal; journal/aptitude bar uses Thal'vaeth names

See [CONTENT.md](CONTENT.md) for items that unlock aptitudes.
