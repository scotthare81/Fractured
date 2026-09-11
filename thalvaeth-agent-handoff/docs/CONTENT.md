# Content — items, band, spawn kit

## Item band

Custom items start at **60001**. Never reuse vanilla IDs.

| ID | Name | Role |
|----|------|------|
| 60001 | Veilspore | Crafting reagent |
| 60002 | Ash Thread | Stitch Kit component |
| 60003 | Stitch Kit | Field bandage — **no magic heal** |
| 60004 | Resin Lure | Future: distract Caller |
| 60005 | Small Brown Pouch | Starter bag (4496 reskin OK) |

Raw **materials / currency** (hide, sinew, ashbloom, salt, resin, tusk, raw meat, …) are their own band, defined with the barter ladder in [ECONOMY.md](ECONOMY.md). Every one doubles as a crafting reagent (L7) — spend it or craft it.

## Survival clocks

| Clock | Status | Notes |
|-------|--------|-------|
| **Hunger** | In | Fed by cooked/raw meat from the animal layer; raw is worse than stew |
| **Thirst** | In | Water is a main-bag consumable; Burn/heat makes it bite |
| **Vigor** | In | Stamina pool per segment; no magic regen ([APTITUDES.md](APTITUDES.md)) |
| **Corruption** | **Under review** | Considering replacing with **Rot** (infection meter), **Dread/Nerve**, or dropping it — [ECONOMY.md](ECONOMY.md) Open |

## Cooking, trades & the satchel

- **Cooking** turns raw meat → stew (quality-in → weighted-out, **no levels**). Cooked lasts longer than raw.
- **Trades** (no skill levels): Fieldcraft/Butcher, Cooking, Stitching (no magic heal), Brewing/Ash-craft.
- **Raw meat** rides in the **satchel** with a spoil timer — eat it or render it (tallow / bait / trade) before it turns. Full bag vs satchel split: [ECONOMY.md](ECONOMY.md).

## Spawn kit (Remnant)

| Slot | Item | Ref |
|------|------|-----|
| Head | Hooded Cowl | 3732 display |
| Body | Patchwork set | TBD entries |
| Bag | Small Brown Pouch | 4496 |

## Race / class

- **Human** + **Rogue** only at char create (hidden Human acceptable)
- Class shown as **Remnant** in UI (client string override)

## SQL

Pending world updates for items live beside creature SQL in `server/sql/pending_db_world/` (add when item templates are authored).
