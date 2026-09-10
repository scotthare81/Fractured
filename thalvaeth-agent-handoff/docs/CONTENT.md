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
