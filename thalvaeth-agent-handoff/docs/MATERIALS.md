# Materials — dropped, foraged, mined, scavenged

The **raw** half of the economy: everything you pull off creatures, forage from the ground, cut from nodes, or strip from ruins. Crafting *recipes* (what these become — food, drink, refined liquids, components, gear upgrades) live in the companion doc **`CRAFTING.md`** (TODO). This file is the input list.

Rules that hold for every entry:
- **Everything uses or breaks→uses (L7)** — no dead loot. If it's here, it feeds a recipe, a meal, a cure, a repair, or a barter.
- **Tiered** — **Common** (bulk) or **Uncommon** (tougher source / deeper node); this is the barter ladder in [ECONOMY.md](ECONOMY.md).
- **Satchel-borne** — raw materials ride the gather satchel, *except* perishable meat/liquids which carry a spoil timer.
- **Original IP (L15)** — names are Thal'vaeth-mundane. Where a material loads on a WoW node/drop model, that's a *source note* for implementers, never a player-facing name.

**ID bands (proposed):** finished items + components **60001+** (existing 60001–60005 sit here); **raw materials 61xxx** (this doc, by category below); **knowledge/recipes 62xxx**. Per-item IDs are TBD — ranges only for now (docs, no SQL).

---

## Nodes vs forage vs drop vs scavenge

| Source | How | Container | Loads on (WoW model) |
|--------|-----|-----------|----------------------|
| **Node** | Fixed gather point (mine/cut/quarry) | Satchel | Ore veins, mining/stone nodes |
| **Forage** | Free anywhere; yield by district | Satchel | Herb nodes + on-the-fly picks |
| **Drop** | Butcher animals / strip the dead | Satchel (meat perishable) | Creature loot |
| **Scavenge** | Search containers, wrecks, corpses | Satchel / main bag | Chests, junk, refuse |

---

## 1. Metals & scrap — `611xx` (nodes: reclaimed metal)

Reframed WoW ore veins. No fantasy ore. Two ways to get metal: **scavenge worked metal** (nails, tools, fittings) or **mine ore → smelt → ingot**.

| Material | Tier | Source | Used for → |
|----------|------|--------|-----------|
| Scrap Iron | Common | Iron-vein node / broken tools | Blades, plates, nails |
| Copper Bits | Common | Copper-vein node / wire, fittings | Wire, fine tools, bronze |
| Tin | Common | Tin-vein node | Solder, **bronze** (alloy) |
| Lead | Common | Pipe/weights | Weights, sling shot, sealing |
| Iron Ore | Common | Iron-vein node | Smelt → Iron Ingot |
| Copper Ore | Common | Copper-vein node | Smelt → Copper Ingot |
| Silver | Uncommon | Silver-vein node / reclaimed | Fine work; **antiseptic** (Infection-resist wraps) |
| Wrought Iron | Uncommon | Sturdy stock / rails | Armor plates, heavy blade |
| Rusted Steel | Uncommon | Old blades | Reforge → blade edge |
| Wire | Common | Drawn from copper | Snares, mending, bindings |
| Nails / Rivets | Common | Scavenge / cut from stock | Assembly, gear frames |
| **Iron Ingot** | Uncommon | *Smelt* Iron Ore + charcoal | Forge: blade, plates, tools |
| **Steel** | Uncommon | *Smelt* iron + charcoal (hotter) | Best blades, spring, tools |
| **Bronze** | Uncommon | *Alloy* copper + tin | Fittings, tools, trim |

> Chain teaser: `Ore → (smelt: charcoal + stone furnace) → Ingot → (forge) → blade / plate / tool`. Detail in `CRAFTING.md`.

---

## 2. Stone & mineral — `612xx` (nodes: quarry / mining)

| Material | Tier | Source | Used for → |
|----------|------|--------|-----------|
| Rough Stone | Common | Stone node | Whetstone, furnace, weights |
| Flint | Common | Stone node / gravel | Firestarting, crude edge |
| Whetstone Grit | Uncommon | Fine stone | Sharpen blades (durability) |
| Clay | Common | Bank/streambed | Pots, molds, sealing, oven |
| Chalk / Lime | Common | Chalk node | Mortar, **lye/tanning**, marking |
| Coal | Common | Coal seam | Fuel (smelt/cook) |
| Peat | Common | Bog | Slow fuel, fire |
| Sulfur | Uncommon | Mineral node | Fumigants, tinctures, matches |
| Saltpetre | Uncommon | Cave/mineral | Preserving, fumigation |
| Alum | Uncommon | Mineral node | **Tanning**, styptic (stop bleeding) |
| Ochre / Pigment | Common | Clay/mineral | Dye, marking, warpaint |

---

## 3. Salt, ash & chemical — `613xx` (nodes + fire byproducts)

| Material | Tier | Source | Used for → |
|----------|------|--------|-----------|
| Grave Salt | Common | Salt-crust node | Preserve meat, brine, tanning |
| Ash | Common | Any fire | Lye, tanning, tea base, fertilizer |
| Charcoal | Common | Burn wood low-air | Smelt fuel, **water filter**, tincture |
| Soot | Common | Fire | Ink, pigment |
| Potash / Lye | Uncommon | Leach ash | Soap, tanning, **wound wash** |
| Chalk-lime slaked | Uncommon | Burn chalk | Mortar, de-hair hide |

---

## 4. Wood, resin & fiber — `614xx` (nodes: cut deadfall / bark / sap)

Rotwood is a forest — wood is everywhere, quality varies.

| Material | Tier | Source | Used for → |
|----------|------|--------|-----------|
| Deadwood | Common | Deadfall | Fuel, hafts, stakes, fences |
| Green Wood | Common | Living tree | Bows, poles, springs |
| Rotwood (punk) | Common | Rotten trunks (Rotwood) | Tinder, slow-burn, poor fuel |
| Bark | Common | Strip tree | Tannin (tanning), cordage, tinder |
| Pitch / Resin | Common | Bark/sap | Glue, torches, waterproofing, **Resin Lure** |
| Sap | Common | Tap tree | Sugar, drink base (liquids) |
| Vine / Root Fiber | Common | Undergrowth | Cordage, snares, wraps |
| Kindling / Splinters | Common | Any wood | Firestarting |

---

## 5. Forage — herbs & fungus — `615xx` (free everywhere; yield by district)

Reframed WoW herb nodes + on-the-fly picks. Some edible, some medicinal, some **risky** (discovery: a wrong pick can sicken you).

| Herb / fungus | Tier | Effect line | Used for → |
|---------------|------|-------------|-----------|
| **Ashbloom** | Common | The classic; grey bloom | Ash tea (Infection), currency, dye |
| **Veilspore** | Uncommon | Pale fungus | Stealth tincture (Veil Skip), reagent |
| Fevermint | Common | Cooling leaf | **Reduces Infection/fever** tea |
| Achebark | Common | Bitter bark (willow-like) | Pain/fever salve + tincture |
| Gravemoss | Common | Damp moss | Poultice (wounds), dye |
| Bitterroot | Common | Sharp root | Tincture base, curbs Hunger pangs |
| Bloodcap | Uncommon | Red-gilled fungus | Styptic (stop bleeding) — poison if raw |
| Fenwort | Common | Marsh weed | Antiseptic wash, wet-district cure |
| Emberleaf | Common | Warm-scented | Warmth tea (cold/heat), stimulant |
| Duskflower | Uncommon | Pale night bloom | Sedative — lures, calm, sleep aid |
| Tallowroot | Common | Starchy tuber | Food staple (Hunger), starch |
| Wild Grain | Common | Grass seed | Flour → bread/porridge (Hunger) |
| Rosehip / Berries | Common | Bramble | Food, a little Thirst; spoils |
| Edible Mushroom | Common | Shaded ground | Food — **some poisonous** (discovery) |
| Lichen | Common | Rock/bark | Famine food, dye |

---

## 6. Creature parts — `616xx` (drops: butcher / strip)

**From the animal layer** ([CREATURES.md](CREATURES.md)):

| Part | Tier | From | Used for → |
|------|------|------|-----------|
| Raw Hide | Common | deer, boar, hound | Cure → leather |
| Thick Hide | Uncommon | Tusker, big beasts | Heavy leather, armor |
| Sinew | Common | most beasts | Cord, bowstring, stitching |
| Bone | Common | most beasts | Needles, tools, broth, buttons |
| Fang / Claw | Uncommon | hound | Blade inlay, charm, tips |
| Tusk | Uncommon | boar, Tusker | Weapon, carving, charm |
| Antler | Common | deer | Tools, buttons, charm |
| Fur / Pelt | Common | most beasts | Warmth (Thirst/heat), trim |
| Fat / Tallow | Common | boar, Tusker | Render → oil, candles, soap, food |
| Gut / Casing | Common | most beasts | Cord, sausage casing (food) |
| Hoof | Common | deer, boar | Hide glue |

**From the human dead** (strip; **plague-tainted** — handling raises Infection):

| Part | Tier | Used for → |
|------|------|-----------|
| Rags | Common | Bandage, cord, tinder |
| Cloth Scraps | Common | Wraps, patches |
| Teeth | Common | Charm, grind, barter |
| Keepsake | Uncommon | Charm base, barter, lore |
| Plaguebone | Uncommon | Usable bone — **Infection risk** to harvest |
| Rotten Sinew | Uncommon | Poor cord — **Infection risk** |
| Shroud Cloth | Common | Wraps, oilcloth base |

---

## 7. Meat & fat — `617xx` (perishable — satchel + spoil timer)

Animal-only (you don't eat people). Eat, cook, or render before it turns ([SURVIVAL.md](SURVIVAL.md)).

| Meat | Tier | From | Hunger value |
|------|------|------|--------------|
| Venison | Common | deer | Good |
| Pork | Common | boar | Good |
| Hound Meat | Common | hound | Poor, stringy |
| Small Meat | Common | hare | Little |
| Tusker Meat | Uncommon | Tusker | Best, rich |
| Offal / Organs | Common | any beast | Risky food or **bait** |
| Marrow | Common | bone | Rich broth/food |

---

## 8. Liquids — `618xx` (containers / spoil)

Raw liquids. **Refining** (foul → clean water, distilling spirits, rendering oil) is in `CRAFTING.md`.

| Liquid | Tier | Source | Used for → |
|--------|------|--------|-----------|
| Foul Water | Common | Puddle, well | **Refine** → drinkable; raw = Thirst + Infection risk |
| Rainwater | Uncommon | Catch/streams | Thirst (cleaner) |
| Sap | Common | Tapped tree | Sugar, drink, boil → syrup |
| Rendered Oil | Common | Render tallow | Cooking, lamps, waterproofing |
| Blood | Common | Butcher | Pudding (food), bait, dye |
| Brine | Common | Salt + water | Preserve, pickle |
| Vinegar | Uncommon | Ferment sap/fruit | Preserve, **wound wash** (Infection), sour drink |
| Spirits / Rotgut | Uncommon | Distill | **Antiseptic** (Infection), risky drink, fuel |
| Broth | Common | Boil bone/marrow | Food + a little Thirst |

---

## 9. Cloth & scavenged goods — `619xx` (search containers / ruins)

| Item | Tier | Used for → |
|------|------|-----------|
| Coarse Cloth | Common | Wraps, bandage, patches |
| Cord / Twine | Common | Bindings, snares |
| Rope | Uncommon | Climbing, hauling, fences |
| Leather Scraps | Common | Patches, straps, mend |
| Buckles / Fittings | Common | Gear frames, upgrades |
| Broken Tools | Common | Salvage → metal |
| Wax / Candle | Common | Light, sealing, waterproof |
| Oilcloth | Uncommon | Waterproof wrap, waders |
| Empty Vial / Jar | Common | Hold tinctures/liquids (bag efficiency) |
| Whetstone | Common | Sharpen (durability) |
| Flint & Steel | Common | Reliable firestarting |

---

## 10. Knowledge — `62xxx` (discovery: found, not crafted)

The "find" reward that replaces gear drops (`GEAR.md`, TODO). Feeds the discovery loop — see `CRAFTING.md`.

| Item | Tier | Source | Does |
|------|------|--------|------|
| Recipe Fragment | Common | Ruins, corpses | Hints an unknown recipe |
| Diagram / Schematic | Uncommon | Deep/rare finds | Unlocks a gear-upgrade path |
| Keeper's Note | Uncommon | Ruins, keepers | Teaches a craft branch |
| Field Sketch | Common | Scattered | Creature/plant lore (journal) |

---

## Cross-cutting hooks

- **Antiseptics → Infection:** silver, vinegar, spirits, alum, charcoal, fenwort, fevermint — real-world grim medicine, no magic. These are why Brewing/Stitching can cure Infection.
- **Preservation → spoil clock:** salt, brine, smoke, vinegar slow the meat/liquid timers ([SURVIVAL.md](SURVIVAL.md)).
- **Plague risk:** harvesting human/plague parts (plaguebone, rotten sinew) raises Infection — a real risk/reward on stripping the dead.
- **Currency:** any of these can be bartered ([ECONOMY.md](ECONOMY.md)); spending vs crafting is the choice.

---

## Open

| Item | Notes |
|------|-------|
| Per-item IDs | Assign within the 61xxx bands when authored |
| District yields | Which forage/nodes are dense in Rotwood vs future districts |
| Node models | Confirm which WoW vein/herb models each loads on |
| Risky forage/parts | Poison/Infection chances + tells |

---

## Related

- `CRAFTING.md` — what these become (recipes, food, drink, refining) — *next pass*
- [ECONOMY.md](ECONOMY.md) — barter tiers, keepers, satchel
- [SURVIVAL.md](SURVIVAL.md) — Hunger / Thirst / Infection the materials feed
- [CREATURES.md](CREATURES.md) — what drops what
- [CONTENT.md](CONTENT.md) — finished items + trades
