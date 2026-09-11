# Aptitudes (not WoW spells)

Remnants use **aptitudes** — learned survival tricks. UI never shows retail spell names.

| Aptitude | Charm (item) | Effect | Notes |
|----------|--------------|--------|-------|
| **Hustle** | — (innate) | Default fast-walk mode | Director noise input |
| **Still Breath** | Stillstone | Walk silently; reduces noise-wake radius | Counters Sleeper, Caller pulls |
| **Veil Skip** | Veil Sachet (Veilspore) | Short semi-stealth burst | Drains Vigor; not full invisibility |
| **Root Ash** | Ash Pouch (Ash) | Throw ash; brief root on a humanoid | Mundane item interaction |
| **Short Burst** | Emberleaf Cord (Emberleaf) | Sprint spike; loud | Drains Vigor hard; avoid near Sleepers |

## Charms — the items that grant aptitudes

No talent tree: your aptitude kit **is your equipped charms** — mundane focuses and pouches (an ash sachet, a clutched worry-stone) worn in the **charm slots** ([GEAR.md](GEAR.md)). Two steps:

1. **Get the charm** — craft it from its material (Veilspore → Veil Sachet, Ash → Ash Pouch), find it, or have a keeper teach it. The aptitude is now *available*.
2. **Equip it** — **2 charm slots** (WotLK's trinket slots), so you run up to **two** aptitudes at once. **Hustle** is innate (always on, no slot). Choosing your two is a real loadout call — e.g. Still Breath + Short Burst = sneak in, burst out.

**Passive charms** compete for those same slots — a Vigor-pool token, an Infection-resist charm, a warmth/carry trinket. So each slot is **active aptitude vs passive perk**.

**Invisible quality** applies ([ITEMS.md](ITEMS.md)): a *"well-worked"* Veil Sachet gives a longer skip for less Vigor than a *"crude"* one. Charms **upgrade** like gear (materials + a discovered diagram) — no skill levels.

### Charm materials (ties to the economy)

| Charm | Aptitude | Made from |
|-------|----------|-----------|
| Stillstone | Still Breath | Smooth stone + cord |
| Veil Sachet | Veil Skip | **Veilspore** + cloth |
| Ash Pouch | Root Ash | **Ash** + pouch |
| Emberleaf Cord | Short Burst | **Emberleaf** + tallow |

### Passive charms (trade a slot for a perk)

Instead of an aptitude, a slot can hold a **passive charm** — a small always-on perk. Same craft/find/upgrade rules; invisible quality scales the amount.

| Charm | Effect | Made from |
|-------|--------|-----------|
| Deep-Lung Token | **+ Vigor pool** | Carved bone + cord |
| Ward Fetish | **+ Infection-resist** | **Silver** + dried herb |
| Warm Fetish | + Warmth (stacks with the warmth layer) | Fur + sinew |
| Porter's Strap | + Carry (bulk capacity) | Leather + buckle |
| Steady Cord | + Butcher / craft yield | Sinew + bone |
| Keepsake | Minor found perk (varies) | Found in runs |

So a two-slot loadout might be **two aptitudes** (Still Breath + Short Burst), **one of each** (Veil Skip + Deep-Lung Token), or **two passives** (Ward Fetish + Porter's Strap) for a heavy-hauler fighter. Your charms are your subclass.

### Proposed aptitudes / charms (depth — TBD)

| Aptitude | Charm | Does |
|----------|-------|------|
| Night Eyes | Ember Lens | See in dark / fog (fog & snow runs) |
| Iron Gut | Bitter Fetish | Resist bad-food / poison sickness |
| Deadened Step | Padded Charm | Don't trigger traps; quiet on debris |
| Steady Hand | Bone Fetish | Better butcher / craft yield |
| Second Wind | Breath Knot | Small one-off Vigor recovery (long cooldown) |

## Vigor

- Max pool; **no magic regen**. It's the hub — Hunger, Thirst, and Infection all erode it, and **Vigor collapse is the only hard fail** ([SURVIVAL.md](SURVIVAL.md)).
- Walk is default and trickles a little Vigor back, but **never fills the bar away from home** (field ceiling).
- Hustle / Short Burst / aptitudes spend it; Hustle + fighting also speed Hunger/Thirst.
- Recovery ladder: walk (tiny) → safe pocket / Ash Hollow (partial, pauses Infection) → Monastery (full).

## Implementation

- Strip class spells at login (PlayerScript)
- Grant aptitude auras as hidden passive + item/gossip triggers
- Spell IDs are internal; journal/aptitude bar uses Thal'vaeth names

See [ITEMS.md](ITEMS.md) for the charm items and [GEAR.md](GEAR.md) for the charm slots.

## Open

| Item | Notes |
|------|-------|
| Charm slot count | 2 (aptitude vs passive) — confirm |
| Charm quality curve | How much a better charm cuts Vigor cost / boosts effect |
| Proposed aptitudes | Which of Night Eyes / Iron Gut / Deadened Step / Steady Hand / Second Wind ship for v1 |
