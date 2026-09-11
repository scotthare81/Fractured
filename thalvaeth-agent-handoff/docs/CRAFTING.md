# Crafting — recipes, discovery, stations, upkeep

What the raw catalog ([MATERIALS.md](MATERIALS.md)) *becomes*: food, drink, clean water, cures, components, tools, and gear upgrades. Two laws hold throughout:

- **No skill levels (L8)** — knowledge + ingredient quality replace XP. A desperate first stew and a careful hundredth use the same rules with different inputs.
- **Discovery-first (L9/L10)** — the recipe book is the Journal Record, and it starts nearly empty. It logs what you *learned*, never a to-do.

---

## Discovery — how you learn to make things

Unknown recipes are **blanked** in the Record (the same Unknown→learned feel as the creature journal). You fill them three ways:

1. **Learn-by-doing** (bootstraps you). The first butcher teaches render/cure basics; the first cookfire teaches a rough stew. No new Remnant is stranded.
2. **Experiment with hints** (the hours engine). Slot materials at a station and **attempt**. A valid combo succeeds and logs to the Record (*"You learned to boil bark into pitch"*). A near-miss gives a **hint, not a wall** — *"needed a binder," "too wet," "not enough heat."* Crafting becomes deduction, not blind brute-force.
3. **Recipe fragments & taught knowledge** (deep/gated). Fragments, diagrams, and keeper's notes found in runs ([MATERIALS.md](MATERIALS.md) §10) hint or unlock specific recipes; keepers teach whole branches for materials. The deep and rare recipes live here, so runs pull you out to **discover**, not to loot gear.

**Milestone discoveries gate whole tiers.** Some recipes are *not* bootstrapped — you must discover them, and doing so unlocks a capability. The marquee one is **Charcoal**: you don't start knowing it, and until you discover it (a recipe fragment or the right low-air experiment) the **forge and all metalworking stay locked** (`Ore → smelt → Ingot` needs charcoal). Tanning→leather and distilling→spirits gate the same way. This is where a lot of the "hours of discovery" lives — the tech opens up as you learn it.

**Quality — Model C.** Same recipe, better inputs → weighted-better result: roughly **70% standard / 20% good / 10% best**. Quality-in still gates the band (a poor carcass can't roll "best"). No levels.

---

## Discovery tree — pinned milestone gates

**Born knowing (Tier 0, never gated):** crude butcher, campfire roast, **crude boil** (drinkable water), firestart (flint), crude bandage, forage. You can eat, warm up, drink, and stop bleeding from the first minute.

Everything else is **discovered** (recipe fragment or experiment-with-hints). Pinned gates and what each opens — *which specific recipe sits under a gate is tunable; the gates + dependencies are the lock:*

| Discovery | Unlocks | Needs first | Where |
|-----------|---------|-------------|-------|
| Rendering | Fat → Tallow / Oil (light, waterproof, soap, food) | — | Cookfire |
| Cordage | Cord → Rope (bindings, snares, climbing) | — | Field |
| Preservation (salt / smoke) | Jerky, smoked meat, pemmican, pickling — **long-shelf food** that beats the spoil clock | Salt | Cookfire |
| Tanning | Hide → Leather / Heavy Leather (armor, straps, waders base) | Salt | Stitch table |
| Brewing | Ash-still medicine: **Ash Tea ↓ Infection**, salves, poultices | — | Ash-still |
| **Charcoal (char pit)** | **The forge gate** — smelting + all metalwork; plus charcoal water-filter & tincture base | — | Charcoal pit |
| Water purification (filter) | Pure water — removes the raw-water **Infection** risk | **Charcoal** | Cookfire |
| Distilling | **Spirits** (strong antiseptic, fuel), distilled water | Brewing | Ash-still |
| Waterproofing | Oilcloth → **waders**, sealed packs (wet districts) | Rendering | Stitch table |
| Advanced apothecary | Tinctures, antiseptic wash, styptics, wards, lures | Brewing (+ Distilling for the strong stuff) | Ash-still |
| Smelting → Iron | Iron Ingot → iron blades, plates, tools, **metal repair** | **Charcoal** | Forge |
| Steelworking | Steel → best blades, springs | Smelting | Forge |
| Alloying (Bronze) | Bronze fittings, tools | **Charcoal** | Forge |
| Trap-making | Snares / traps → catch small game, slow enemies | Cordage / Wire | Field / Workbench |

**The spine:** **Charcoal** is the pivot — it gates the entire **Forge** branch (Iron → Steel → Bronze, all metal gear and metal repair) *and* the best water purification. Early Remnants live off butcher / cook / stitch / brew and leather; **metal is an earned mid-game unlock**. Tanning opens leather armor; Brewing + Distilling open real Infection medicine; Preservation is what lets you run longer without your food rotting.

## Stations (Monastery) vs field

Deep crafting needs a **station at home**. In a run you only get **crude** versions.

| Station | Makes | Key inputs |
|---------|-------|-----------|
| **Butcher block** | Carcass → meat, hide, sinew, bone, fat | Blade |
| **Cookfire** | Meals, drinks, boil/refine water, render, smoke | Fuel, water, food mats |
| **Stitch table** | Bandages, wraps, oilcloth, cloth/leather repair | Thread, cloth, leather |
| **Ash-still** | Teas, tinctures, salves, wards, distilling, lye | Herbs, ash, water, spirits |
| **Forge** | Smelt ore→ingot, blades, plates, metal repair | Ore/metal, charcoal |
| **Workbench** | Assembly: hafts, buckles, tools, gear frames, mends | Components |

**Field crafting (crude, in a run):** quick butcher, campfire cook/boil, quick bandage, firestart, blade **sharpen** (crude whetstone), temporary patch-mend. Everything else waits for home.

---

## Durability & mending

Gear and blades **wear with use** — this is a real upkeep sink and part of the material economy.

- **Wear sources:** blades dull per butcher/fight; armor frays per hit and per run; boots wear with distance; waders leak over time.
- **Condition tiers:** **Fine → Worn → Damaged → Broken.** Effectiveness scales down the ladder (a dull blade = less damage + less butcher yield; a frayed coat = less mitigation/Infection-resist). **Broken = heavy penalty, not gone** — you limp it home; gear is never lost to wear (only the run haul is lost on death).
- **Two fixes:**
  - **Sharpen** (blades) — a whetstone restores the edge. Cheap, frequent, doable **in the field** with a crude whetstone; full at the Forge/Workbench.
  - **Mend/Repair** (structural) — restores condition with materials: **Stitch table** for cloth/leather (thread, patches, leather scraps), **Forge** for metal (rivets, ingot). Field = crude **temporary** patch (partial); full repair only at home.
- **Cost:** repair burns the same materials you'd craft or barter with — upkeep competes with upgrades and payday ([ECONOMY.md](ECONOMY.md)).

Per-slot wear rates and which upgrade axes decay live in `GEAR.md` (next).

---

## Recipe catalog

Finished items/components sit in the **60xxx** band; IDs TBD. Organized by station. This is the deep list — expect it to keep growing as fragments unlock more.

### A. Refining & components (Workbench / Forge / Ash-still)

| Make | From | → feeds |
|------|------|---------|
| Cured Hide | Raw Hide + Grave Salt + Bark/Alum (tan) | Leather |
| Leather / Heavy Leather | Cured / Thick Hide (cut) | Armor, straps, waders |
| Tallow / Oil | Fat (render at cookfire) | Cooking, lamps, soap, waterproof |
| Thread | Rags / plant fiber (spin) | Stitching |
| Cord → Rope | Sinew / vine / bark (twist) | Bindings, snares, climbing |
| Charcoal | Good **Deadwood** in a **charcoal pit/kiln** (low-air char) | Smelt fuel, **water filter**, tincture |
| Iron / Copper Ingot | Ore + Charcoal (smelt) | Blades, plates, tools |
| Steel | Iron + Charcoal (hotter smelt) | Best blades, springs |
| Bronze | Copper + Tin (alloy) | Fittings, tools |
| Lye / Potash | Leach Ash + water | Soap, tanning, wound wash |
| Hide Glue | Hoof / bone (boil) | Assembly, hafts |
| Whetstone | Rough Stone + Grit (shape) | Sharpen blades |
| Bone Needle / Buttons | Bone (carve) | Stitching, fasteners |
| Pitch / Tar | Bark / resin (boil) | Waterproof, torch, Resin Lure |

> **Charcoal, the one right way.** Charcoal is made **only** at a **charcoal pit/kiln** — a deliberate *low-air char* of good **Deadwood**. An open cookfire (or any burning) yields **Ash**, never charcoal; **Rotwood punk** gives poor charcoal. And you must **discover** it first — it is **not known at start** (a recipe fragment or the right low-air experiment). Until then, no charcoal — and no forge. This is intentional: charcoal is the fuel that **gates all metalworking** (`Ore → smelt → Ingot`), so it must be a discovered, real craft — never a free byproduct, and never from an open fire.

### B. Water & liquid refining (Cookfire / Ash-still)

| Make | From | Result |
|------|------|--------|
| **Clean Water** | Foul Water → **boil** + **Charcoal filter** / cloth strain | Thirst; removes Infection risk |
| Distilled Water | Clean Water (distill) | Purest; tincture base |
| **Spirits / Rotgut** | Sap/berry **mash** → ferment → **distill** | Antiseptic (Infection), risky drink, fuel |
| Vinegar | Sap/fruit (ferment sour) | Preserve, wound wash, sour drink |
| Brine | Grave Salt + water | Preserve, pickle |
| Syrup | Sap (boil down) | Sugar, sweeten, food |
| Broth | Bone / Marrow + water (boil) | Food + a little Thirst |
| Rendered Oil | Fat (render) | Cooking, lamps, waterproof |

### C. Cooking — food & drink (Cookfire) → Hunger / Thirst

| Make | From | Note |
|------|------|------|
| Roast / Stew | Meat (+ root, herb, salt) | Better than raw; Model C quality |
| Bread / Porridge | Wild Grain → flour (+ water) | Staple Hunger |
| Boiled Roots | Tallowroot / tuber | Cheap Hunger |
| Sausage | Meat + Gut casing + Salt | Portable, keeps |
| **Jerky / Smoked Meat** | Meat + Salt + smoke | **Long shelf** — beats the spoil timer |
| **Pemmican** | Dried meat + Fat + Berries | Dense travel ration |
| Pickles | Root/veg + Brine | Keeps; a little Thirst |
| Black Pudding | Blood + grain + fat | Grim Hunger food |
| Tea (drink) | Herb + Clean Water | Warmth / mild effects |
| Sap Drink / Small Beer | Sap / mash (light ferment) | Thirst, morale — risky |

> **Discovery risk:** wrong mushroom or a bad ferment can **sicken** you — a real reason to learn the tells.

### D. Apothecary / Brewing (Ash-still) → Infection / wounds / utility

| Make | From | Does |
|------|------|------|
| **Ash Tea** | Ashbloom + Clean Water | Reduce **Infection** |
| Fever Tincture | Fevermint / Achebark | Infection / fever |
| Antiseptic Wash | Vinegar / Spirits / Lye / Silver | Clean wounds → less Infection |
| Salve | Tallow + herb + Ash | Wounds (pairs with Stitch) |
| Styptic | Bloodcap / Alum | Stop bleeding |
| Poultice | Gravemoss | Wounds |
| Stimulant | Emberleaf | Short Vigor boost — risky |
| **Resin Lure** | Resin + Duskflower (sedative) | Distract a Caller |
| Bait | Offal / meat scraps | Draw / distract beasts |
| Ward | Herb + Salt + Ash | Protective (future districts) |

### E. Stitching / textiles (Stitch table) → kit + repair

| Make | From | Does |
|------|------|------|
| **Bandage / Stitch Kit** | Thread + Cloth/Rags | Close wounds (no magic heal) |
| Wraps | Leather / Cloth | Armor component; Cut-district staple |
| Oilcloth | Cloth + Oil/Pitch | Waterproof → waders, packs |
| Patch | Leather/Cloth scraps | Repair gear |
| Padding | Fur / cloth | Warmth lining |

### F. Forge / Workbench → tools, weapons, gear frames

| Make | From | Does |
|------|------|------|
| Blade (knife → cleaver line) | Ingot/Steel + Haft (deadwood) | Weapon + butcher tool |
| Armor Plates | Wrought Iron / Steel | Coat reinforcement |
| Tools (awl, saw, hook) | Metal + haft | Craft/utility |
| Buckles / Rivets / Nails | Metal | Assembly, gear frames |
| Snare / Trap | Wire + wood | Catch small game / slow enemies |
| Torch | Haft + Pitch + cloth | Light |

---

## Full-chain examples (the depth)

```
Blade:    Iron Ore → smelt(Charcoal) → Iron Ingot → forge + Haft(Deadwood)
          → Iron Blade → sharpen(Whetstone) → [dulls with use] → mend/sharpen

Waders:   Raw Hide → tan(Salt + Bark + Alum) → Leather
          + Oilcloth(Cloth + Pitch) → Waders → upgrade at Workbench

Ration:   Venison → dry(Salt) + Fat + Berries → Pemmican (long-lasting Hunger)

Water:    Foul Water → boil + Charcoal filter → Clean Water
          → ferment mash + distill → Spirits (antiseptic for Infection)

Cure:     Ashbloom + Clean Water → Ash Tea (↓ Infection)
          — or — Spirits → Antiseptic Wash + Stitch Kit (wound + Infection)
```

Every node here is a **choice**: the same Charcoal smelts a blade *or* filters water; the same Salt preserves meat *or* tans hide *or* barters. Scarcity + the satchel + the spoil clock make each craft a real decision.

---

## Open

| Item | Notes |
|------|-------|
| Recipe count target | How many per station for v1 (bounded — L14) |
| Hint copy | The near-miss lines per failed attempt |
| Quality bands | Model C thresholds; what "best" grants |
| Wear rates | Per-slot degrade + sharpen/mend costs (→ `GEAR.md`) |
| Fragment gating | Which recipes are experiment-able vs fragment-only |

---

## Related

- [MATERIALS.md](MATERIALS.md) — the raw inputs
- [SURVIVAL.md](SURVIVAL.md) — Hunger / Thirst / Vigor / Infection these feed
- [ECONOMY.md](ECONOMY.md) — materials are also currency; repair competes with barter
- [CONTENT.md](CONTENT.md) — item band, trades, spawn kit
- [GEAR.md](GEAR.md) — upgrade-only gear/weapons + per-slot wear
