# Fractured — Build sequence

Go **one step at a time**. Finish the current step before starting the
next. The 29-space network, MPQ polish, and mystery leads wait until
the loop is playable.

| Step | Name | Done when |
|------|------|-----------|
| 1 | Own server | Isolation spec agreed; tree is not AICraft |
| 2 | Module skeleton | Empty Fractured module compiles in *this* project |
| 3 | Three spaces | Sanctuary, Mouth, Cut have map IDs and a one-pager each |
| 4 | The tax | Hunger / Thirst / Corruption, sit/channel, tiny bags, forage / butcher |
| 5 | One Record line | First butcher writes a learned fact, not a quest |

**Current step: 2.** Step 1 isolation is agreed (`docs/DEPLOY.md`).

## Step 1 — Own server

Isolate Fractured from AICraft. Same machine is allowed. Same
directory, database, ports, restarter, or modules folder is not.

See `docs/DEPLOY.md`. Isolation is agreed. Live/dev folders and
ports are in that file. Do not clone AzerothCore in this step.

## Step 2 — Module skeleton

After isolation is agreed: an empty module in this repo
(`src/mod-fractured`) with hooks for survival meters, Gate (bots
blocked), and death → morgue. Live vs dev run dirs and ports live in
`docs/DEPLOY.md`. Compile is the point once AC is cloned under
`fractured-server/src/azerothcore` and linked with
`scripts/link-module.sh`. Behavior can be stubs.

## Step 3 — Three spaces

Reuse obscure WotLK instance maps. Assign real map/instance IDs for
**Sanctuary**, **Mouth**, and **Cut** only. One-pager each. Leave
every other district TBD.

## Step 4 — The tax

Crude survival: meters, sit/channel food and water, ~6 bag slots,
forage a deer analog, butcher with knife 5278. Death drops the haul.
Character persists. Wake in the morgue.

## Step 5 — One Record line

After the first successful butcher, the Journal Record logs that the
meat is venison (or the species you actually butchered). No “go do
X.” That proves L10.

## Not a step yet

Full gate matrix, 12 underlayer names, lead pool, Nursery / Edge,
Sanctuary upgrade costs, co-op Gate UX, AutoBalance tuning, MPQ Tier
A file list. Write those when the slice exists, not before.
