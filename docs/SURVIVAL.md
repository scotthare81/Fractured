# Survival — Hunger, Thirst, Vigor, Infection

Four meters run the Wild. The point that ties them together:

**The meters don't kill you — they starve your Vigor, and the world kills you.** No meter causes an instant death. The **only hard fail is Vigor collapse** — when you can't run, sneak, or fight, the persistent-damage Wild and the Director finish you. Home (the Thal'vaeth Monastery) resets everything; the run is the pressure.

---

## Vigor — the hub (capacity to act)

A **pool**, not a decay clock. Spent by **Hustle** (fast move), **Short Burst** (sprint — loud), and **aptitudes** (Veil Skip, Root Ash, …) — see [APTITUDES.md](APTITUDES.md).

- **Recovery is weak in the field.** Walking trickles a *little* Vigor back, but it **never fills the bar away from home** — there's a field ceiling well below max.
- **Recovery ladder:** walk (tiny trickle, up to the field ceiling) → **safe pocket / Ash Hollow** (a bigger partial restore, once per run, still under max) → **Monastery** (full refill, between runs).
- **Vigor collapse is the only hard fail.** Empty = no Hustle, no Short Burst, no aptitudes → no sprint, no stealth, no escape. You don't die *from* Vigor; you die *without* it.

The other three meters all feed **into** Vigor. Neglect them and your pool shrinks, drains faster, or won't come back — until the Wild catches a slow, gassed Remnant.

---

## Hunger & Thirst — the time-and-exertion clocks

- Rise on **time** (just being out) **and on exertion** — **Hustle and fighting speed them**. Pushing hard costs Vigor/Infection *and* burns the food clock faster: hard running is doubly expensive.
- **Thirst runs faster** than Hunger; heat (Burn-type spaces) makes it bite.
- **Restore is partial and sit/channel** (vulnerable while you eat/drink). Cooked food > raw meat for Hunger; water for Thirst. Food and water ride the **main bag** and fight your ~6 slots.
- **Neglect erodes Vigor** (never a direct kill):
  - High **Hunger** → Vigor **regen ↓**, then **cap ↓** (weak).
  - High **Thirst** → Vigor **drains faster** (gassed), then stagger.

---

## Infection — the combat clock

- Rises when **plague creatures wound you** (the humanoid roster). Persistent run health makes fights **attrition**, so trading blows accrues Infection.
- **Cured by Stitch Kit + tinctures** (Brewing) — sit/channel + materials; the same no-magic-heal discipline that closes wounds ([CONTENT.md](CONTENT.md)).
- **Neglect** erodes **Vigor max** and ticks you down. At full it becomes **Fevered** — a heavy slow/weak state (the near-death fail state), still not an instant kill, but usually a death sentence out here.

---

## How it all couples

```
            TIME + exertion                  getting wounded
                 │                                 │
                 ▼                                 ▼
        ┌──────────────────┐            ┌────────────────────┐
        │  Hunger · Thirst │            │     Infection      │
        └────────┬─────────┘            └─────────┬──────────┘
    erode regen /│ cap                   erode max│ + tick
                 ▼                                 ▼
             ┌────────────────────────────────────────┐
             │                 VIGOR                   │  walk → tiny (field-capped)
             │     Hustle · Short Burst · aptitudes    │  safe pocket → partial
             └───────────────────┬────────────────────┘  Monastery → full
                                 │ empty
                                 ▼
                     can't run / sneak / fight
                                 │
                                 ▼
                    the Wild finishes you → morgue
```

### The tensions that make it a game, not four bars
- **Fight vs sneak = Infection vs Vigor.** Killing plague enemies costs **Infection**; avoiding them (Still Breath past a Sleeper, Veil Skip) costs **Vigor**.
- **Push vs pace.** Hustle/fight cuts time but **spends Vigor and accelerates Hunger/Thirst** (and, in a fight, Infection). Walking is slow — and the only thing that hands Vigor back.
- **Restores compete.** Eat, drink, and stitch are all sit/channel + slots/materials. You can't top everything before something needs you.
- **Survival vs payday.** Food, water, and cures burn materials that are also **currency** ([ECONOMY.md](ECONOMY.md)) — a rough run leaves nothing to barter.

---

## Failure & reset

Vigor collapses → you're caught → **death**: lose the haul **and the satchel**, wake in the Monastery **morgue**. The character persists (not permadeath). Home is the full reset — eat, drink, stitch, rest — and then you go again.

---

## Open (tuning — numbers TBD)

| Knob | Notes |
|------|-------|
| Vigor field ceiling | The % you can walk-recover to away from home |
| Walk trickle rate | How slow the field regen is |
| Safe-pocket restore | Partial amount + that it pauses Infection |
| Hunger/Thirst tick | Base time rate vs the Hustle/fight multiplier; Thirst-faster ratio |
| Infection | Rise per hit; cure cost/time; **Fevered** threshold |

---

## Related

- [CONTENT.md](CONTENT.md) — the clocks table, cooking, trades, satchel
- [APTITUDES.md](APTITUDES.md) — what spends Vigor
- [ECONOMY.md](ECONOMY.md) — restores also cost currency materials
- [CREATURES.md](CREATURES.md) — what raises Infection
- [MAPS.md](MAPS.md) — safe pocket (Ash Hollow) and the Monastery
