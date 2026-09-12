# Journal Record — v1 content map

This file turns [JOURNAL-RECORD.md](JOURNAL-RECORD.md) into actual v1 Journal content.

It defines **what appears**, **what begins known**, **what may appear only as a silhouette**, and **what kinds of hints can be learned**.

This is design content, not final item IDs or UI art.

---

# 1. Creatures tab

All current creature catalogue entries occupy a stable slot in the Creatures index. Unknown entries reveal **shape only**, never their player-facing name.

| Entry | Player-facing name | Initial Journal state | Deeper observed knowledge |
|-------|--------------------|-----------------------|---------------------------|
| 90001 | Ash Sleeper | silhouette | wake behaviour, brutal opener |
| 90002 | Cellar Scavenger | silhouette | wound-tearing attack / pack behaviour |
| 90003 | Catwalk Prowler | silhouette | leap / overhead ambush |
| 90004 | Ash Caller | silhouette | shriek / calls more scavengers |
| 90005 | Patchwork Brute | silhouette | stomp / extreme toughness / territorial leash inferred through play |
| 90006 | Broken Snare | silhouette | hook / choke control |
| 90007 | Edge Stalker | silhouette | pacing / breaks off when struck |
| 90008 | Drifter | silhouette | slow response / lone wander |
| 90009 | Stumbler | silhouette | heavy doorway pressure / wide swing |
| 90010 | Ghoul | silhouette | rush / frenzy / wound tearing |

The exact observed prose belongs in `CREATURES.md` / `ability_map`; this table defines discovery placement only.

---

# 2. Survival tab

## 2.1 Food

### Known at start

A new Remnant must not be unable to feed themselves. These are basic field knowledge:

| Entry | Starts | Journal note |
|-------|--------|--------------|
| Campfire Roast | Known | Meat over fire. Crude, immediate food. |
| Crude Broth | Known or learn-by-doing on first boil | Bone/meat + water; weak but useful |
| Boiled Roots | Known | Safe basic preparation for known roots/tubers |

### Discoverable preparations

| Entry | First visibility | Discovery route | Example near-miss knowledge |
|-------|------------------|-----------------|----------------------------|
| Stew | inferred after first cooked meat + pot/cookfire use | experiment / taught | *Needs enough liquid to cook through without washing everything out.* |
| Bread | silhouette after grain is identified | experiment / fragment | *The grain needs breaking down first.* |
| Porridge | silhouette after flour/grain handling | experiment | *Too dry to soften.* |
| Sausage | hidden until casing/salt concepts known | experiment / note | *Loose meat will not keep its shape.* |
| Jerky | silhouette after spoilage/preservation problem is encountered | Preservation gate | *Still too wet to keep.* |
| Smoked Meat | same family as Jerky | Preservation gate | *Heat alone cooks it; smoke and time are doing something different.* |
| Pemmican | hidden until preserved meat + rendered fat known | fragment / experiment | *Dry meat alone travels badly; it needs something rich to bind it.* |
| Pickles | silhouette after brine/vinegar learned | Preservation | *Fresh water will not hold it.* |
| Black Pudding | hidden until blood use inferred | experiment / fragment | *It will not set without grain or another body.* |
| Mushroom Fry | silhouette once an edible mushroom is positively identified | experiment | *This cap is food, but raw it sits badly.* |
| Forage Pottage | inferred after several edible forage types known | experiment | *One thin root is not much of a meal.* |
| Grilled Fish | known after first edible fish + fire | learn-by-doing | — |
| Fish Stew | silhouette after Grilled Fish/Stew knowledge overlaps | experiment | *The bones cloud it; clean the fish first.* |
| Smoked Fish | silhouette after Preservation + fish | experiment | *Cooking it fast is not preserving it.* |

Food pages should show **only preparations the Remnant has reason to infer**. Late recipes do not all appear as silhouettes on character creation.

---

## 2.2 Water

| Entry | Starts | Discovery / inference | Near-miss examples |
|-------|--------|-----------------------|--------------------|
| Crude Boil | Known | Tier 0 survival knowledge | — |
| Cloth Strain | Inferred after collecting visibly dirty water | simple experiment | *The grit is gone. The foulness isn't.* |
| Charcoal Filter | hidden until Charcoal is discovered | Charcoal + water experimentation / note | *Ash muddies it. The blackened wood behaves differently.* |
| Distilled Water | hidden until Distilling | distillation discovery | *Steam leaves the filth behind.* |
| Brine | silhouette after Grave Salt + water known | experiment | *Not for drinking. It draws moisture from food.* |
| Vinegar | hidden until fermentation knowledge | experiment / note | *The souring did not ruin it; it changed it.* |

The Journal must distinguish **drinkability** from hidden numerical purity. The player learns practical outcomes first.

---

## 2.3 Medicine & wound care

### Known / bootstrap

| Entry | State | Note |
|-------|-------|------|
| Crude Bandage | Known | Stops/controls bleeding; not magic healing |
| Stitch Kit | silhouette or early inferred | First serious wound/keeper introduction reveals need |

### Discoverable

| Entry | Discovery route | Near-miss knowledge |
|-------|-----------------|--------------------|
| Stitch Kit | Stitching / taught / experiment | *Cloth closes nothing by itself; it needs thread and a way to pull the wound together.* |
| Poultice | medicinal plant + wound experiment | *Dry leaves fall away; crushed wet plant matter stays against the wound.* |
| Salve | Rendering + medicinal herb | *The herb needs a carrier that stays on the skin.* |
| Styptic | Bloodcap/alum experimentation | *This one dries and tightens blood quickly.* |
| Ash Tea | Brewing / experiment | *The herb steeped, but foul water spoiled it.* / *It needs heat.* |
| Fever Tincture | Brewing + fever herb | *Water draws too little; something stronger is needed.* |
| Antiseptic Wash | vinegar/spirits/lye/silver knowledge | *The wound closed, but quickly fouled.* / *Cleaning before stitching matters.* |
| Stimulant | Emberleaf experiment | *It sharpens you briefly, then leaves you worse.* |

Known effects should be written in terms such as **eases Infection**, **cleans a wound**, **stops bleeding**, **briefly restores drive**, not raw percentages unless later playtesting demands numbers.

---

## 2.4 Herbs & fungi

Material pages are not recipes; they record **identity + learned properties + known uses**.

### Herbs / useful plants

| Material | Initial reveal | Properties that can be learned | Possible linked uses |
|----------|----------------|--------------------------------|----------------------|
| Ashbloom | name after collection | medicinal / bitter / brewable | Ash Tea, advanced tinctures |
| Veilspore | name after collection | unusual spore; aptitude material | Veil Sachet |
| Emberleaf | name after collection | stimulating / risky | Stimulant, Emberleaf Cord |
| Fevermint | name after collection | cooling/bitter medicinal | Fever Tincture |
| Gravemoss | name after collection | wound-safe when prepared | Poultice |
| Duskflower | name after collection | sedative property | Resin Lure, Sedative Draught |
| Tallowroot | name after collection | edible starch | Boiled Roots, pottage |
| Wild Grain | name after collection | edible after processing | flour, bread, porridge |
| Berries / Rosehip | obvious food once safely eaten/identified | food / syrup / ferment | ration, mash, syrup |

### Fungi

The first pickup **does not automatically reveal edible/medicinal/poison class**.

| Fungus | True class | Ways the class might be learned | Known-use possibilities |
|--------|------------|----------------------------------|-------------------------|
| Brown Cap | edible | cautious cooking/eating, field note, keeper | Mushroom Fry |
| Button | edible | same | cooking |
| Morel | edible choice | same | high-quality food |
| Goldgill | edible choice | same | high-quality food |
| Bloodcap | medicinal | experiment / note / wound observation | Styptic |
| Fevergill | medicinal | experiment / note | fever treatment |
| Gravecap | poison | bad ingestion, poison note, deliberate test | Weakening Coat / poisoned bait |
| Palecap | poison | bad ingestion, poison note, deliberate test | stronger coats |
| Weeping Fungus | poison | experiment / note | smoke / poison work |

### Identification hints

Hints can teach **tells** without giving recipes:

- *The gills stain dark when bruised.*
- *Animals have eaten around this one, not through it.*
- *A bitter milk beads from the cut stem.*
- *Heat removes the harsh smell.*
- *The colour deepens where it touches blood.*

Once a tell is learned, future pickups may be identifiable without repeating the dangerous experiment.

---

## 2.5 Fishing

### Methods / equipment

| Entry | Visibility | Discovery |
|-------|------------|-----------|
| Crude Fishing Line | inferred near viable water / cordage | simple craft |
| Bone Hook | silhouette after bone + line | experiment |
| Metal Hook | silhouette after forge + fishing knowledge | gear/tool upgrade |
| Fishing Rod | inferred after line/hook | workbench / taught |
| Net | hidden until cordage depth | craft / taught |
| Fish Trap / Weir | silhouette after trap-making + fishing | experiment / fragment |

### Catches

River Fish, Perch, Catfish, Eel, Bottomfeeder and Minnows become named after first confident identification/catch. Their **uses remain separately discoverable**:

- grill;
- stew;
- smoke;
- fish oil;
- roe as food/bait;
- fish skin;
- bone/needle/glue.

Example fish-page unknown-use display:

```text
EEL

Known uses:
[grilled icon] Grilled Fish
[grey jar]     ???
[grey strip]   ???
```

---

## 2.6 Poisons

Poison entries should be particularly conservative: knowing a poisonous fungus exists is not the same as knowing a reliable dose/formula.

| Entry | First inference | Discovery | Possible near-miss hint |
|-------|-----------------|-----------|-------------------------|
| Weakening Coat | once poison material + blade coating concepts overlap | advanced apothecary experiment | *The paste dried and flaked off. It needs oil or another carrier.* |
| Necrotic Coat | later poison knowledge | fragment / experiment | *Too weak after heating; this one should stay cold.* |
| Sedative Draught | Duskflower property known | brewing | *Too concentrated to swallow safely.* |
| Poisoned Bait | poison + bait known | experiment | *The smell is wrong; the animal will not touch it.* |
| Choking Smoke | sulfur/fungus + fire interaction observed | experiment / fragment | *Burning it in open air wastes it.* |

The Journal can record self-risk only after the Remnant learns it.

---

## 2.7 Traps & fieldcraft

| Entry | First visibility | Discovery / gate | Near-miss idea |
|-------|------------------|------------------|----------------|
| Snare | inferred after Cordage | experiment / taught | *The loop slips closed but will not stay anchored.* |
| Fish Trap / Weir | fishing + cordage | experiment | *The opening lets the catch turn around.* |
| Deadfall | wood + bait + trap knowledge | experiment | *Too light to hold anything worth eating.* |
| Pit / Stake Pit | deeper trap knowledge | taught / fragment | *Visible stakes warn more than they catch.* |
| Net Trap | Rope + trap-making | experiment | *The mesh spreads, but there is no trigger.* |
| Jaw Trap | forge + trap-making | diagram | *The spring is too soft.* |
| Tripwire Alarm | Cordage + noise tool | experiment | *The line works; it needs something that speaks when pulled.* |
| Tripwire Spikes | trap-making | experiment | *It trips them, but does no harm.* |
| Firestart | Known | Tier 0 | — |
| Crude Sharpen | Known / early learn-by-doing | whetstone + blade | — |
| Field Patch | Known after first damaged cloth/leather gear | learn-by-doing | — |

---

# 3. Gear tab

## 3.1 Weapons

The player can see a **partial topology** of the weapon tree without seeing names of unknown nodes.

### Shared line

| Node | Initial state | Reveal gate |
|------|---------------|-------------|
| Crude Dagger | Known | start |
| Flint / Bone Blade | silhouette early | material experimentation |
| Iron Knife / Short Blade | silhouette only after forge/iron is inferred | Smelting / Forge |
| Steel Blade | hidden/silhouette after iron line exists | Steelworking |

### Dual-wield branch

| Node | Reveal |
|------|--------|
| Fighting Dagger / Shortsword | branch silhouette after Steel Blade + suitable diagram/inference |
| Paired Daggers / Steel Shortswords | next obscured node |
| Twin Blades | endgame silhouette until masterwork knowledge |

### Two-handed branch

| Node | Reveal |
|------|--------|
| War Cleaver / Iron Greatblade | branch silhouette after relevant diagram/inference |
| Steel Greatsword / Greataxe | next obscured node |
| Masterwork Greatsword / Greataxe | endgame silhouette |

Unknown branch example:

```text
Steel Blade →┬→ [grey long blade]
             └→ [grey heavy shape]
```

Do not label the silhouettes `Dual Wield` / `Greatsword` before the player knows those paths.

### Weapon observations

A discovered weapon page may reveal practical facts learned through use:

- butchers well;
- poor butcher tool;
- chops wood;
- loud;
- heavy Vigor use;
- holds edge well;
- bronze feels lighter but dulls faster.

Not all material trade-offs have to be given immediately on unlock.

---

## 3.2 Armour

### Known start

- Rag Armour
- Rag Hood

### Discovery path

| Class/node | Reveal gate |
|------------|-------------|
| Quilted Coat | stitching/padding discovery |
| Boiled Leather | Tanning |
| Studded Leather | diagram / metal fittings |
| Hardened Leather | deep tanning diagram |
| Ring Mail | Smelting/Iron |
| Riveted Chain | wire/rivet knowledge |
| Splinted Mail | diagram |
| Half-Plate | Steelworking |
| Full Plate | late diagram/masterwork |

The UI may reveal that heavier branches exist while keeping their identity unreadable.

### Warmth gear

Padded Shirt, Fur Mantle and Fur Scarf/Muffler belong under Armour/Clothing knowledge but may remain obscured until weather/warmth relevance is inferred.

---

## 3.3 Tools

| Tool | Discovery state idea |
|------|----------------------|
| Butcher Knife | Crude Dagger begins as the first butcher tool; dedicated knife inferred from poor yields |
| Skinning Knife | silhouette once hide harvesting matters |
| Cleaver | inferred from heavy butchering + forge |
| Woodcutter's Axe | silhouette after Deadwood/Charcoal loop matters |
| Pick | silhouette after ore is encountered |
| Awl | inferred at Stitch table |
| Saw | Workbench knowledge |
| Needle | bone version early; metal upgrade later |
| Whetstone | early known/learned |
| Flint & Steel | silhouette after metal + firestart |
| Fishing Rod / Net | shared link to Survival/Fishing page |

Cross-links should avoid duplicate knowledge: one discovery can illuminate the tool in both the Survival context and Gear context.

---

## 3.4 Charms

### Aptitude charms

| Charm | State |
|-------|-------|
| Stillstone | silhouette until taught/found/crafted |
| Veil Sachet | silhouette once Veilspore use is inferred |
| Ash Pouch | silhouette once ash/root interaction is learned |
| Emberleaf Cord | silhouette once Emberleaf's stimulating property is known |

### Passive charms

| Charm | State |
|-------|-------|
| Deep-Lung Token | hidden until passive-charm concept known |
| Ward Fetish | silhouette after Infection-resist materials/knowledge |
| Warm Fetish | silhouette after warmth matters |
| Porter's Strap | silhouette after carry upgrades become available |
| Steady Cord | silhouette after yield/tool expertise becomes relevant |
| Keepsake | revealed by finding it; exact perk may itself require use/observation |

The two charm slots themselves can be known before all possible charm identities are known.

---

# 4. Hint families

To keep authoring coherent, v1 near-miss hints should come from a controlled vocabulary of **meaning**, while final prose remains bespoke.

| Hint family | What it teaches | Example prose |
|-------------|-----------------|---------------|
| `needs_cleaner_input` | source material is contaminated | *The water spoiled it.* |
| `needs_heat` | process lacks heat | *It never opened up. It needs heat.* |
| `too_hot` | ingredient/property destroyed by heat | *Whatever mattered burned off.* |
| `needs_binder` | mixture will not hold | *Wouldn't bind.* |
| `needs_drying` | preservation/tanning moisture problem | *Still too wet to keep.* |
| `needs_preservative` | spoilage not controlled | *It turned before it cured.* |
| `needs_carrier` | salve/poison will not stay applied | *It dried and fell away.* |
| `needs_stronger_solvent` | water extraction insufficient | *Water draws too little from it.* |
| `needs_trigger` | trap mechanism incomplete | *The trap has no moment that closes it.* |
| `needs_anchor` | snare/trap structure unstable | *It closes, then pulls free.* |
| `needs_tension` | spring/wire weakness | *The spring is too soft.* |
| `wrong_preparation` | ingredient valid, form wrong | *The raw hide refuses the needle.* |
| `ingredient_conflict` | two materials spoil/cancel one another | *Together they curdle into useless sludge.* |
| `dangerous_dose` | preparation works but is unsafe | *Strong enough to numb the tongue. Too strong to drink.* |

These are **authoring concepts**, not player-facing keys.

---

# 5. What should NOT become Journal entries

Avoid turning the Record into a dump of every database row.

Do not create standalone Journal entries for:

- every intermediate scrap unless it has meaningful discovery value;
- trivial containers with no knowledge progression;
- raw numerical stats;
- vendor/barter price tables;
- quest-like goals;
- generic monster locations;
- hidden quality roll percentages;
- exact Director rules/heat budgets;
- future content the Remnant has no reason to infer.

The Journal should feel authored and useful, not exhaustive.

---

# 6. Recommended first playable Journal slice

For implementation testing, the first playable slice should deliberately include examples of each reveal type.

### Creatures
- Ash Sleeper: silhouette → sighted → engaged + one observed ability.
- Ash Caller: silhouette → sighted → engaged + shriek observation.

### Survival
- Campfire Roast: already known.
- Ash Tea: two-step near-miss hints → successful reveal.
- Gravecap: unknown-property fungus → poison identification → Weakening Coat link.
- Crude Boil → Charcoal Filter: milestone knowledge reveal.
- Basic Fishing: catch → cooking use → smoked use.

### Gear
- Crude Dagger → Iron Knife → Steel Blade.
- Steel Blade shows **two unreadable branch silhouettes**.
- One diagram resolves one branch while the other stays unknown.
- Rag Armour → Quilted Coat → unreadable Leather branch until Tanning.
- One aptitude charm and one passive charm compete for the same visible slot structure.

If this slice feels compelling, scale the same language across the full catalogue.

---

## Related

- [JOURNAL-RECORD.md](JOURNAL-RECORD.md) — architecture and locked Journal rules
- [CREATURE-JOURNAL.md](CREATURE-JOURNAL.md) — creature-specific state
- [CRAFTING.md](CRAFTING.md) — recipe/discovery logic
- [ITEMS.md](ITEMS.md) — item catalogue
- [GEAR.md](GEAR.md) — upgrade ladders
- [MATERIALS.md](MATERIALS.md) — raw materials
