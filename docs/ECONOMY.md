# Economy — no coin, tiered barter

**There is no coin currency in Thal'vaeth.** No gold, silver, copper. The things you pull off creatures and out of run **nodes** *are* the currency. You barter them at the **Thal'vaeth Monastery** between runs.

One rule keeps it honest (L7 — everything findable uses or breaks→uses): **every currency material is also a crafting reagent.** Spending ashbloom as "money" means you didn't brew with it. That trade-off *is* the economy — nothing is trash you haul to a vendor.

**Where you spend:** the Monastery (home), between runs. **What's at stake:** currency is physical and carried, so it's part of the haul — die in the run and you lose what you were carrying (satchel included). Extraction is how you get paid.

---

## The material ladder (two tiers)

No rare "mark" / premium token. Just **Common** and **Uncommon** materials. Elites and rare beasts pay out in *more and better* of the same mats (plus gear) — a big-ticket upgrade costs a **large Uncommon bundle**, not a unique currency.

| Tier | From **nodes** (gather) | From **creatures** (drops) | Buys |
|------|-------------------------|----------------------------|------|
| **Common** | Ashbloom (herb), Grave Salt, Pitch/Resin, Scrap | Raw Hide, Rags / Ash Thread, Tallow, Raw Meat | Consumables, repairs, bait, basic components |
| **Uncommon** | Veilspore, Refined Ash | Sinew, Cured Hide, Fang / Claw, Teeth, Boar Tusk, Bone | Gear, aptitude unlocks, bag / satchel upgrades, Monastery improvements |

You called it: an NPC takes **herb nodes** as payment — that's Ashbloom, the same plant Ash-craft brews with. Spend it or brew it, every run.

---

## Monastery keepers (barter NPCs)

Maps onto the trades (see [CONTENT.md](CONTENT.md)). No gold prices — each keeper takes materials and gives goods.

| Keeper (Remnant) | Takes | Gives |
|------------------|-------|-------|
| **The Stitcher** | hide, sinew, thread, tusk, bone | armor, Stitch Kits, **bag & satchel upgrades** |
| **The Asher** (brewer) | ashbloom, veilspore, salt, resin | tinctures, Resin Lures, wards, **aptitude unlocks** |
| **The Keeper** (quartermaster) | Uncommon bundles | Monastery upgrades, new run access, big-ticket kit |

---

## Carrying it home — bags & satchel

Two containers, a hard line between them. The **satchel** holds raw materials so foraging doesn't eat your survival space. The **main bag** (a small bulk pool) holds everything that keeps you alive or that you'd fight over.

| **Satchel** — raw trade / craft materials | **Main bag** — survival, tools, valuables |
|-------------------------------------------|-------------------------------------------|
| Nodes: ashbloom, veilspore, salt, resin, scrap | **Cooked food, water** (finished survival) |
| Beast harvest: hide, sinew, tallow, fang, tusk, bone | Stitch Kits, tinctures, lures, wards |
| Human strip: rags, thread, teeth | Tools / weapons (knife, cleaver), armor |
| **Raw Meat** (perishable — spoil timer, see below) | Keepsakes / valuables you carry out |

Rule of thumb: **raw material → satchel; finished, or a tool/gear → main bag.** Cooking converts a satchel raw (meat) into a main-bag good (stew).

Satchel rules:
- **Lost on death**, like the rest of the haul — a big gather run wiped by a bad death has to sting.
- **Bounded and upgradeable** (the Stitcher sells satchel expansions) — you still can't hoard a whole district in one trip.
- **Curated allow-list** — only raw materials qualify (the left column). Finished consumables, tools, gear, and valuables never go in it.

### Bulk — items take space by size

Capacity is measured in **bulk**, not raw slots. Every item has a hidden **bulk 1 / 2 / 4**:

| Bulk | Feel | Examples |
|------|------|----------|
| **1** | small | herbs, mushrooms, vials, tinctures, thread, cord, daggers, charms, ammo, small components |
| **2** | bulky | 1H weapons, coats, waders, rope, tools, a raw haunch, a full waterskin |
| **4** | huge | two-handed weapons, plate pieces, big tools (axe/pick), a carcass quarter |

Bags and the satchel are **bulk pools** (upgradeable), so a greataxe eats what four herbs would. **Worn gear is free** — only *carried* items count against bulk. This makes bulk diegetic: you feel the weight of hauling something big out of a run.

**Now vs later.** v1 enforces bulk as a **capacity budget** (a server-checked number — simple). The **fancy version renders it as a true footprint grid** (a 2×2 sword sitting in your pack), which needs a custom addon inventory + a server-side virtual inventory (see `ITEMS.md` / TODO). The bulk values are identical either way — **the budget now is the grid's foundation.**

---

## Raw meat & spoilage

Raw Meat lives in the **satchel** and carries a **spoil timer**. Before it turns you either:

- **Eat / cook it** → answers **Hunger** (raw is worse than a cooked stew — see cooking, [CONTENT.md](CONTENT.md)), or
- **Use it** → render to **Tallow** (Brewing), cut into **bait** (a lure the way Resin Lure distracts a Caller), or barter it as a Common material.

Cooked food (main bag) lasts longer than raw. Meat is never dead loot: it feeds you or it feeds something else.

---

## No-coin plumbing (future, when code starts)

Documentation notes so nobody wires gold back in:

- **Zero mob money.** Creature loot drops materials, not coin.
- **Barter, not price tags.** Keepers are a custom exchange (item-in → item-out gossip), not gold-costed vendors.
- **Repairs / unlocks** are paid in materials too — no durability-gold sink.

---

## Open

| Item | Notes |
|------|--------|
| Infection tuning | Meter is named + in (replaces Corruption). Open: rise rate per plague hit, cure cost, debuff thresholds. Brewing teas target it. |
| Animal names | Convention **`<District> <Kind>`** locked (Rotwood Hound / Boar / Deer / Hare / Tusker) — [NAMES.md](NAMES.md) |
| Node placement | Which gather nodes seed Rotwood, and density per segment ([RUN-GATES.md](RUN-GATES.md)) |
| Satchel size / upgrade curve | Starting slots and Stitcher upgrade steps |
| Spoil timers | Raw meat clock; render vs eat break-even |

---

## Related

- [CONTENT.md](CONTENT.md) — items, spawn kit, survival clocks, trades
- [CREATURES.md](CREATURES.md) — the animal layer that supplies hide / meat / tusk
- [APTITUDES.md](APTITUDES.md) — what aptitude unlocks cost
- [MAPS.md](MAPS.md) — the Monastery (home) where you barter
