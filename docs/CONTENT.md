# Content — items, band, spawn kit

## Item band

Custom items start at **60001**. Never reuse vanilla IDs. Full finished/found catalog: [ITEMS.md](ITEMS.md).

| ID | Name | Role |
|----|------|------|
| 60001 | Veilspore | Crafting reagent |
| 60002 | Ash Thread | Stitch Kit component |
| 60003 | Stitch Kit | Field bandage — **no magic heal** |
| 60004 | Resin Lure | Future: distract Caller |
| 60005 | Small Brown Pouch | Starter bag (4496 reskin OK) |

Raw **materials / currency** (hide, sinew, ashbloom, salt, resin, tusk, raw meat, ore/metal, …) get their own catalog in [MATERIALS.md](MATERIALS.md) — dropped, foraged, mined, scavenged. Every one doubles as a crafting reagent (L7) — spend it or craft it; the barter tiers are in [ECONOMY.md](ECONOMY.md).

## Survival clocks

| Clock | Status | Notes |
|-------|--------|-------|
| **Hunger** | In | Fed by cooked/raw meat from the animal layer; raw is worse than stew |
| **Thirst** | In | Water is a main-bag consumable; Burn/heat makes it bite |
| **Vigor** | In | Stamina pool per segment; no magic regen ([APTITUDES.md](APTITUDES.md)) |
| **Infection** | In (replaces Corruption) | Plague creatures raise it (combat/wounds); Stitching / tinctures cure it; too high = debuffs |

**How they interlock** — meters erode Vigor; Vigor collapse is the only hard fail: [SURVIVAL.md](SURVIVAL.md).

## Cooking, trades & the satchel

- **Cooking** turns raw meat → stew (quality-in → weighted-out, **no levels**). Cooked lasts longer than raw.
- **Trades** (no skill levels): Fieldcraft/Butcher, Cooking, Stitching (no magic heal), Brewing/Ash-craft. Recipes, discovery + stations, durability/mend: [CRAFTING.md](CRAFTING.md).
- **Raw meat** rides in the **satchel** with a spoil timer — eat it or render it (tallow / bait / trade) before it turns. Full bag vs satchel split: [ECONOMY.md](ECONOMY.md).

## Spawn kit (Remnant)

The whole start is crude — a blade and rags. Everything else is crafted/upgraded (**no gear drops**): [GEAR.md](GEAR.md).

| Slot | Item | Ref |
|------|------|-----|
| Main hand | **Crude Dagger** | crude blade; first butcher tool |
| Body | **Rag Armour** (cloth) | patchwork/rags — ~no protection |
| Head | Rag Hood | 3732 display |
| Bag | Small Brown Pouch (+ satchel) | 4496 |

## Race / class

- **Human** + **Rogue** only at char create (hidden Human acceptable)
- Class shown as **Remnant** in UI (client string override)

## SQL

Pending world updates for items live beside creature SQL in `server/sql/pending_db_world/` (add when item templates are authored).
