# Discovery solutions — authoritative recipe and near-miss matrix

This document is the **server-side truth** behind Journal experimentation and the hint library.

`JOURNAL-HINTS.md` defines what the Remnant may read. This file defines **why an attempt failed, which correction actually fixes it, what succeeds, and which hint is allowed to surface first**.

The Journal must never infer recipe truth from flavour copy. Implementation should evaluate structured rules, then choose approved copy from `JOURNAL-HINTS.md`.

---

# 1. Evaluation model

Every experiment is evaluated in this order:

1. **Knowledge gate** — is this recipe experimentally discoverable yet, or fragment/keeper/diagram gated?
2. **Station gate** — is the attempt being made at a station capable of the process?
3. **Required process gate** — boil, steep, char, dry, tan, ferment, distil, forge, stitch, smoke, etc.
4. **Core ingredient family** — are the indispensable ingredients present?
5. **Ingredient state** — raw/refined, clean/foul, dried/fresh, crushed/whole, cooked/raw.
6. **Functional component** — binder, carrier, preservative, fuel, filter medium, fastening, haft, lining, etc.
7. **Ratio / moisture / heat / time window** — where recipe-specific tolerances matter.
8. **Quality check** — recipe succeeds, but poor inputs/process can degrade the hidden quality result.

Only the **highest-priority unresolved blocker** generates a near-miss hint for that attempt.

A single attempt should normally reveal **one new persistent hint**. If the highest-priority blocker is already known, the evaluator may advance to the next unresolved blocker and teach that instead.

Random material piles that do not satisfy a recipe's minimum near-miss predicate return no persistent knowledge.

---

# 2. Hint strength

Each recipe may expose hints at three strengths.

| Strength | When allowed | Example |
|---|---|---|
| **Weak** | Player is in the right family but missing broad understanding | “It spoiled before it changed.” |
| **Focused** | Player has the core materials/process mostly right | “The liquid needs to be cleaner.” |
| **Strong** | Attempt is one meaningful correction from success or prerequisite knowledge is already learned | “It needs steady heat, not open flame.” |

Strong hints still describe **properties/process**, not exact item names unless the item/property is already known to the Remnant.

---

# 3. Precedence rules

These rules stop contradictory or misleading hints.

## 3.1 Dirty before hot

If a liquid is invalid **and** heat is wrong, teach the liquid problem first. Heating the wrong liquid should not appear to be the solution.

## 3.2 Wrong station before fine process

If a process is impossible at the current station, teach station/process mismatch before timing or ratio.

## 3.3 Missing core before missing modifier

If the defining ingredient is absent, do not hint about salt, binding, heat duration, garnish, or quality.

## 3.4 Unsafe preparation before optimisation

If a material is poisonous/unsafe because it is unprepared, reveal that problem before quality or flavour issues.

## 3.5 Discovery gates do not masquerade as recipe failure

If a recipe is fragment/diagram/keeper gated, experimentation cannot brute-force the final answer. The player may receive an **inference hint** that a capability exists, but the final recipe remains undiscoverable until the gate is satisfied.

## 3.6 Success beats hinting

If the attempt satisfies the success predicate, craft the result and discover the recipe. Do not emit a failure hint merely because the result is low quality.

---

# 4. Canonical recipe identifiers

Stable internal keys should use namespaces rather than player-facing names.

Examples:

```text
recipe.food.campfire_roast
recipe.food.stew
recipe.food.jerky
recipe.water.crude_boil
recipe.water.charcoal_filter
recipe.med.ash_tea
recipe.refine.charcoal
recipe.refine.cured_hide
recipe.refine.iron_ingot
recipe.gear.iron_blade
recipe.gear.oilcloth
recipe.field.snare
```

Hints use stable keys such as:

```text
hint.recipe.med.ash_tea.clean_water
hint.recipe.med.ash_tea.needs_heat
hint.recipe.refine.charcoal.low_air
hint.recipe.refine.cured_hide.preserve_before_working
```

Player-facing copy can change without migrations.

---

# 5. Food and cooking solutions

## 5.1 Campfire Roast — Tier 0

**Key:** `recipe.food.campfire_roast`

**Known at start:** yes.

**Success:** edible raw meat + cookfire/open heat + sufficient cook duration.

**Failure matrix:**

| Predicate | Actual correction | Hint family |
|---|---|---|
| cut too thick / insufficient duration | cook longer or reduce cut thickness | heat/time |
| fire excessively hot | lower/direct less heat | heat |
| tough cut dried before tender | use slower heat or convert to stew | cooking meat |
| spoiled meat | use unspoiled meat | contamination |

**Quality:** fresh/fat meat and controlled heat bias upward; stringy/spoiling meat biases downward.

---

## 5.2 Stew

**Key:** `recipe.food.stew`

**Discovery:** learn-by-doing after first usable pot/cookfire experiment.

**Core:** meat OR fish OR substantial forage + water + pot + sustained low heat.

**Optional quality/body:** root/grain/fat/herb/salt.

**Near-miss minimum:** food base + liquid at a cook-capable station.

**Precedence:** foul water → wrong vessel/station → no sustained heat → grossly excessive water → insufficient time.

**Failure matrix:**

| Predicate | Correction | Hint |
|---|---|---|
| foul/unsafe water | use drinkable/boiled water | “Something in the water fouled it.” |
| no pot / wrong station | use cookfire + vessel | “The material is right. The station is not.” |
| no sustained heat | simmer over steady heat | “It wants longer, slower heat.” |
| excessive liquid | reduce water/add solid body | “Too much water drowned everything else.” |
| tough meat undercooked | longer low heat | “The meat stayed tough.” |
| bitter forage dominates | balance with fat/root/salt where known | “It needs something to round the bitterness.” |

**Success output:** Stew, hidden quality Model C.

---

## 5.3 Broth

**Key:** `recipe.food.broth`

**Core:** bone/marrow + clean water + boil/simmer.

**Near miss:** bone/marrow + any water.

**Corrections:** clean water first; then sufficient extraction time; optional salt/herb only affects quality.

---

## 5.4 Porridge

**Key:** `recipe.food.porridge`

**Core:** milled/crushed grain + water + pot + steady heat.

**Failure:** whole grain → grind; too little water → add; too much → reduce/longer cook; undercooked → longer heat.

---

## 5.5 Bread / flatbread

**Key:** `recipe.food.bread`

**Core:** flour/meal + controlled water + worked dough + heat.

**Near miss:** flour/meal + water.

**Corrections:** coarse grain → mill; too wet/dry → adjust moisture; no working → knead/work; centre raw → slower/longer heat.

Leavening is not required for the v1 survival bread unless later explicitly added.

---

## 5.6 Boiled Roots

**Key:** `recipe.food.boiled_roots`

**Core:** edible root/tuber + clean water + boil.

**Failure:** poisonous/unidentified root is not converted into safe food merely by guessing. Identification gate takes precedence.

---

## 5.7 Sausage

**Key:** `recipe.food.sausage`

**Discovery gate:** Preservation.

**Core:** prepared meat + casing + salt/preservative + stuffing/tying process.

**Near miss:** prepared meat + casing.

**Corrections:** no preservation → salt/preserve; casing tears → finer filling/better casing; poor bind → more suitable fat/filling preparation.

---

## 5.8 Jerky

**Key:** `recipe.food.jerky`

**Discovery gate:** Preservation.

**Core:** thin meat strips + salt/preservation + drying OR low smoke + time.

**Failure precedence:** cut thickness → preservation treatment → drying/smoke conditions → time.

**Success:** Jerky.

---

## 5.9 Smoked Meat / Smoked Fish

**Key:** `recipe.food.smoked_meat`, `recipe.food.smoked_fish`

**Core:** prepared thin/medium cuts + salt where required + **cool/steady smoke**, not direct cooking flame.

**Failures:** direct heat cooks rather than preserves; insufficient smoke; centre remains wet; too thick; short duration.

---

## 5.10 Pemmican

**Key:** `recipe.food.pemmican`

**Discovery gate:** Preservation.

**Core:** fully dried meat + rendered fat + dried berry/fruit component.

**Near miss:** dried meat + fat.

**Precedence:** meat not fully dried → wrong fat state → missing dense fruit component → poor binding ratio.

**Success:** Pemmican.

---

## 5.11 Pickles

**Key:** `recipe.food.pickles`

**Discovery gate:** Preservation.

**Core:** suitable root/vegetable + brine/vinegar + clean vessel + time.

**Failure:** plain water → preservation liquid; dirty vessel → clean; insufficient time → wait; bad seal/storage → correct vessel handling.

---

## 5.12 Black Pudding

**Key:** `recipe.food.black_pudding`

**Core:** blood + grain/filler + fat + casing/vessel + thorough cooking.

**Near miss:** blood + grain/fat.

**Failure:** won't bind → grain/filler; dries/crumbles → fat/moisture; unsafe/raw centre → longer controlled cooking.

---

# 6. Water and liquid solutions

## 6.1 Crude Boil — Tier 0

**Key:** `recipe.water.crude_boil`

**Known at start:** yes.

**Core:** foul/raw water + boil + minimum hold time.

**Success:** drinkable boiled water (basic Clean Water state).

**Failure:** merely warming does not count; insufficient hold time → “Hot, but not held long enough.”

Sediment may remain visually; this does not automatically make the water unsafe if the boil succeeded, though quality can be lower.

---

## 6.2 Charcoal filtration

**Key:** `recipe.water.charcoal_filter`

**Gate:** Charcoal discovery.

**Core:** pre-treated/settled or boiled water + charcoal + cloth/fine layered filter + correct flow path.

**Near miss:** water + charcoal OR water + filter structure after Charcoal known.

**Precedence:** charcoal not discovered → inference only; wrong/dirty medium → coarse bed → bypass/channeling → spent filter.

**Success:** higher-quality Clean Water / purified state.

---

## 6.3 Distilled Water

**Key:** `recipe.water.distilled`

**Gate:** Distilling.

**Core:** water + sealed heated vessel + vapour path + cooled receiver.

**Failure:** steam escape → seal; no condenser/receiver → capture; excessive heat → controlled boil; contamination at receiver → clean setup.

**Success:** Distilled Water.

---

## 6.4 Brine

**Key:** `recipe.liquid.brine`

**Core:** clean water + Grave Salt at sufficient concentration.

**Near miss:** clean water + any salt-like mineral if identified.

**Failure:** too dilute → more salt / less water; contaminated water → clean first.

---

## 6.5 Syrup

**Key:** `recipe.liquid.syrup`

**Core:** suitable sap/sweet liquid + controlled reduction heat.

**Failure:** too hot → scorching; too short → remains thin; wrong watery base → no useful concentration.

---

## 6.6 Vinegar

**Key:** `recipe.liquid.vinegar`

**Gate:** fermentation knowledge.

**Core:** fermentable fruit/sap base + clean vessel + souring/air exposure stage + time.

**Failure:** sealed too tightly → no souring; dirty vessel → spoilage; too little sugar/base → weak result.

---

## 6.7 Spirits / Rotgut

**Key:** `recipe.liquid.spirits`

**Gate:** Brewing + Distilling.

**Core:** fermented mash + still + controlled distillation + receiver.

**No real-world procedural detail should be player-facing beyond the fictional game abstraction.**

**Failure:** unfermented mash → ferment first; leaks → seal; vapour not captured → condenser/receiver; overdriven heat → slower distillation.

**Success:** Spirits / Rotgut game item.

---

# 7. Medicine and apothecary solutions

## 7.1 Crude Bandage — Tier 0

**Key:** `recipe.med.bandage`

**Core:** clean-enough cloth/rags + wrapping process.

**Success:** Crude Bandage.

**Quality failure:** dirty rags can produce poor/unsafe bandage rather than hard fail if design wants consequence; Journal learns contamination risk after observed consequence.

---

## 7.2 Stitch Kit

**Key:** `recipe.med.stitch_kit`

**Core:** thread + clean cloth/rags + needle/closure tool where required.

**Near miss:** thread + cloth.

**Failure:** weak thread → stronger thread; no needle/tool → proper stitch tool; contaminated materials → clean; insufficient structural material → reinforce.

**Success:** Stitch Kit.

---

## 7.3 Ash Tea

**Key:** `recipe.med.ash_tea`

**Gate:** Brewing.

**Core:** Ashbloom + Clean Water + steep/heat process.

**Precedence:** wrong water → no extraction/heat → overheat → insufficient time.

**Failure matrix:**

| Attempt | Correction | Hint key |
|---|---|---|
| Ashbloom + Foul Water | use Clean Water | `ash_tea.clean_water` |
| Ashbloom + Clean Water, no heat | steep with controlled heat | `ash_tea.needs_heat` |
| excessive heat | gentler extraction | `ash_tea.overheated` |
| too brief | steep longer | `ash_tea.time` |

**Success:** Ash Tea; reduces Infection in game terms.

---

## 7.4 Fever Tincture

**Key:** `recipe.med.fever_tincture`

**Gate:** Brewing; stronger version may require Advanced Apothecary/Distilling.

**Core:** identified Fevermint or Achebark + suitable clean liquid base + extraction process.

**Failure:** unidentified/wrong herb family → no recipe hint; whole/unprepared herb → crush/cut; weak water extraction when stronger carrier required → infer sharper base after advanced knowledge.

---

## 7.5 Poultice

**Key:** `recipe.med.poultice`

**Core:** identified Gravemoss/appropriate medicinal plant + crushed plant matter + enough clean liquid/carrier to make adhesive paste.

**Failures:** whole plant → crush; too runny → less liquid/binder; too dry → small liquid/carrier; won't stay on dressing → carrier/binding.

---

## 7.6 Salve

**Key:** `recipe.med.salve`

**Gate:** Brewing/Rendering.

**Core:** medicinal herb + rendered fat/tallow carrier + controlled mixing heat.

**Failure:** no carrier → tallow/fat function; too hot → destroys plant property; separation → controlled mixing/ratio.

---

## 7.7 Styptic

**Key:** `recipe.med.styptic`

**Gate:** Advanced Apothecary.

**Core:** identified Bloodcap or Alum-like astringent material + dry/fine preparation.

**Failure:** too coarse → grind; too wet → dry; won't remain at wound → dressing/carrier method.

---

## 7.8 Antiseptic Wash

**Key:** `recipe.med.antiseptic_wash`

**Gate:** Advanced Apothecary; strong version can require Distilling.

**Core:** known cleansing base (vinegar / game Spirits / lye solution / silver-based game reagent) + clean water where dilution is required.

**Failure:** contaminated water → clean; base too weak → stronger known cleansing base; too harsh → dilution/process correction.

Exact real-world concentrations are intentionally outside the design.

---

## 7.9 Stimulant

**Key:** `recipe.med.stimulant`

**Gate:** Brewing.

**Core:** identified Emberleaf + clean extraction base + controlled preparation.

**Failure:** overheat destroys effect; too weak extraction; uncontrolled dose yields poor/risky quality.

---

# 8. Herb and fungus knowledge solutions

These are **identification/discovery rules**, not all recipes.

## 8.1 Identification states

For each forage material:

```text
unknown specimen
→ named/recognised specimen
→ property learned (edible / medicinal / poisonous / fibrous / resinous)
→ one or more uses discovered
```

Picking up an item can reveal identity without revealing its property.

## 8.2 Edible fungi

Brown Cap, Button, Morel, Goldgill become safely edible only after one of:

- keeper/field note teaching;
- successful safe identification tell;
- previously learned species knowledge.

Blind eating can teach by consequence, but it is not required and should not be the preferred route.

## 8.3 Medicinal fungi

Bloodcap / Fevergill require identified medicinal property before recipe-specific hints become strong.

## 8.4 Poison fungi

Gravecap / Palecap / Weeping Fungus may reveal warning properties through smell/stain/skin irritation/animal avoidance observations. The Journal must never turn this into real-world toxicology guidance; these are fictional game materials.

---

# 9. Poison-system solutions

All poison recipes are **fictional game abstractions**. Implementation keys define gameplay effects, not real chemistry.

## 9.1 Weakening Coat

**Key:** `recipe.poison.weakening_coat`

**Gate:** Advanced Apothecary + identified Gravecap.

**Core:** fictional Gravecap extract + oil/carrier that adheres to a blade.

**Failure:** beads/runs off → better carrier/binding; flakes → more flexible carrier; overheated → cold/low-heat extraction; too thick/thin → ratio correction.

## 9.2 Necrotic Coat

**Key:** `recipe.poison.necrotic_coat`

**Gate:** Advanced Apothecary + identified Palecap.

**Core:** Palecap game extract + binding carrier.

Same adhesion precedence as Weakening Coat.

## 9.3 Sedative Draught

**Key:** `recipe.poison.sedative_draught`

**Gate:** Advanced Apothecary + identified Duskflower.

**Core:** Duskflower game extract + suitable base.

**Failure:** smell too strong → process refinement; overheat destroys effect; poor carrier prevents bait uptake.

## 9.4 Poisoned Bait

**Key:** `recipe.poison.poisoned_bait`

**Core:** edible bait + already-known poison preparation.

Do not allow raw unknown toxic material + meat to accidentally reveal a full poison formula.

## 9.5 Choking Smoke

**Key:** `recipe.poison.choking_smoke`

**Core:** fictional smoke-producing irritant mix + smoulder-capable fuel medium.

**Failure:** burns too cleanly → smoulder medium; too wet → dry; no lingering smoke → slower burn/containment.

---

# 10. Fishing solutions

## 10.1 Crude line and hook

**Key:** `recipe.fishing.line_hook`

**Core:** cord/line + hook form.

Bone hook may be pre-forge; metal hook is an upgrade.

**Failure:** knot slips → knot/cordage knowledge; hook blunt/wrong shape → refine hook; weak line → stronger cord.

## 10.2 Fishing Rod

**Key:** `recipe.fishing.rod`

**Core:** flexible shaft + line + hook + fastening.

**Failure:** shaft too stiff/weak; line attachment slips; imbalance affects quality.

## 10.3 Net

**Key:** `recipe.fishing.net`

**Gate:** Cordage.

**Core:** sufficient cord + repeating mesh + reinforced edge.

**Failure:** gaps too large; knots slip; edge collapses.

## 10.4 Fish Trap / Weir

**Key:** `recipe.fishing.trap`

**Gate:** Cordage / Trap-making.

**Core:** frame/reeds/cord + guided entrance + retention geometry.

**Failure:** entrance lets fish escape; frame collapses; current closes entrance; wrong placement is a deployment failure, not crafting failure.

## 10.5 Fish products

- Grilled Fish: raw identified fish + cookfire.
- Fish Stew: fish + stew process.
- Smoked Fish: preservation process.
- Fish Oil: scraps/fatty fish + Rendering.
- Roe: butcher/clean fish observation.
- Fish Skin: careful skinning.
- Fish Bone: breakdown/byproduct.

Each product unlocks independently through use/processing.

---

# 11. Trap and fieldcraft solutions

## 11.1 Snare

**Key:** `recipe.trap.snare`

**Gate:** Cordage or Trap-making.

**Core:** cord + loop + anchor + trigger/tension arrangement.

**Craft failures:** weak cord, bad loop, poor trigger construction.

**Deployment failures:** loop height, trail placement, anchor location. Deployment hints are stored separately from recipe hints.

## 11.2 Deadfall

**Key:** `recipe.trap.deadfall`

**Core:** weight + stable support + trigger + bait point.

**Failure:** weight too light/heavy for support; support binds; trigger placement wrong.

## 11.3 Net Trap

**Key:** `recipe.trap.net`

**Gate:** Cordage/Trap-making.

**Core:** net + trigger + anchor/release arrangement.

## 11.4 Jaw Trap

**Key:** `recipe.trap.jaw`

**Gate:** Forge + Trap-making + diagram recommended.

This should be **diagram-gated** in v1 to prevent brute-force experimentation from skipping the metal progression.

## 11.5 Tripwire Alarm

**Key:** `recipe.trap.tripwire_alarm`

**Core:** cord + anchors + noise-maker.

**Failure:** slack/tension; weak alarm; wind false-positive is deployment/tuning observation.

## 11.6 Tripwire Spikes

**Key:** `recipe.trap.tripwire_spikes`

**Gate:** Trap-making.

**Core:** cord + stakes/spikes + trigger geometry.

---

# 12. Rendering, refining and component solutions

## 12.1 Tallow / Rendered Oil

**Key:** `recipe.refine.tallow`

**Gate:** Rendering.

**Core:** animal fat + gentle sustained heat + collection vessel.

**Failure:** open flame too fierce → scorching; insufficient heat/time → fat remains; contamination → poor quality.

## 12.2 Thread

**Key:** `recipe.refine.thread`

**Core:** suitable long fibre/rag fibre + separation + twist/spin.

**Failure:** fibres too short/coarse; twist too loose.

## 12.3 Cord

**Key:** `recipe.refine.cord`

**Gate:** Cordage.

**Core:** sinew/vine/bark fibre + separated strands + twist.

**Failure:** fibres too short; weak twist; wet stretch.

## 12.4 Rope

**Key:** `recipe.refine.rope`

**Core:** multiple cords/long fibres + opposing/reinforced twist.

**Failure:** too few strands; twist direction/strength; inconsistent fibre lengths.

## 12.5 Charcoal

**Key:** `recipe.refine.charcoal`

**Gate:** discoverable by experiment or fragment.

**Core:** good Deadwood + char pit/kiln + **low-air controlled char** + time.

**Hard rule:** open fire produces Ash, never Charcoal.

**Near-miss precedence:** wrong wood quality → open-air burn → insufficient char duration → excessive air ingress.

**Hints:**

- open flame: “It burned through to ash. Too much air.”
- poor punk wood: “It collapses before it chars cleanly.”
- too short: “The outer wood blackened. The centre did not change.”

**Success:** Charcoal; unlocks Forge branch and charcoal filtration.

## 12.6 Lye / Potash

**Key:** `recipe.refine.lye`

**Gate:** Brewing/Advanced Apothecary depending final balance.

**Core:** Ash + clean water + leaching/settling process.

No real-world concentration instructions should be surfaced.

## 12.7 Hide Glue

**Key:** `recipe.refine.hide_glue`

**Core:** bone/hoof/hide scraps + water + long controlled boil/reduction.

## 12.8 Pitch / Tar

**Key:** `recipe.refine.pitch`

**Core:** bark/resin + controlled heating/reduction vessel.

**Failure:** overheat burns useful fraction; underheat remains thin; wrong vessel/process loses material.

## 12.9 Whetstone

**Key:** `recipe.tool.whetstone`

**Core:** rough suitable stone + grit/shaping.

**Failure:** stone too soft; surface too coarse/fine for intended stage.

---

# 13. Leather, cloth and waterproofing solutions

## 13.1 Cured Hide

**Key:** `recipe.refine.cured_hide`

**Gate:** Tanning.

**Core:** Raw Hide + Grave Salt + bark/alum-like game tanning reagent + stitch table/work area + time/working.

**Precedence:** hide not cleaned → preservation salt absent → tanning agent absent → thick sections untreated → insufficient working while drying.

**Failure matrix:**

| Predicate | Correction | Hint |
|---|---|---|
| raw/fleshy hide | clean/scrape first | “The hide is still slick inside.” |
| no preservative | salt/dry first | “It softened, but did not preserve.” |
| no tanning agent | use known tanning reagent | “It dried hard as board.” |
| poor penetration | thinner/even treatment/time | “The treatment never reached the thicker parts.” |
| not worked | flex/work during drying | “It needs more working while it dries.” |

**Success:** Cured Hide.

## 13.2 Leather / Heavy Leather

**Key:** `recipe.refine.leather`

**Core:** Cured Hide + cutting/working.

Heavy Leather requires thicker/better hide input and more work, not merely stacking normal leather unless later specified.

## 13.3 Oilcloth

**Key:** `recipe.textile.oilcloth`

**Gate:** Waterproofing + Rendering.

**Core:** cloth + rendered oil/pitch treatment + controlled application/drying.

**Failure:** too much treatment → stiff/cracked; too little → leaks; seams untreated → leakage; overheat thins/burns treatment.

## 13.4 Padding

**Key:** `recipe.textile.padding`

**Core:** fur/cloth stuffing + layered/stitched containment.

## 13.5 Padded Shirt / Fur Mantle / Fur Scarf

**Keys:** `recipe.gear.padded_shirt`, `recipe.gear.fur_mantle`, `recipe.gear.fur_scarf`

**Core:** appropriate cloth/fur/padding + thread/cord + Stitch table.

These are garment constructions; diagrams may improve tiers but basic forms can be experiment-discoverable.

---

# 14. Metalworking solutions

## 14.1 Iron Ingot

**Key:** `recipe.refine.iron_ingot`

**Gate:** Charcoal + Smelting discovery + Forge.

**Core:** iron-bearing ore/scrap + Charcoal + Forge heat + smelting process.

**Precedence:** no Charcoal knowledge → gate hint; wrong station → Forge; insufficient heat → fuel/air/forge; bad feedstock → ore/scrap quality.

**Success:** Iron Ingot.

## 14.2 Copper Ingot

Same structural rules as Iron, using copper-bearing feedstock.

## 14.3 Steel

**Key:** `recipe.refine.steel`

**Gate:** Steelworking + Iron smelting.

**Core:** Iron + Charcoal + hotter/controlled Forge process.

**Failure:** ordinary smelt heat → “The metal softens, but never changes.”; poor carbon/fuel process → “The edge still behaves like iron.”

Exact metallurgy is deliberately abstracted for gameplay.

## 14.4 Bronze

**Key:** `recipe.refine.bronze`

**Gate:** Alloying + Charcoal.

**Core:** Copper + Tin game materials + Forge/alloy process.

**Failure:** only one metal → no alloy; poor heat/mixing → separation/weak cast.

## 14.5 Rivets / Nails / Buckles / Wire

**Keys:** component recipes under `recipe.metal.*`

Require appropriate ingot/metal stock + Forge/Workbench shaping. Some become automatically known once basic metalworking is learned rather than each requiring separate discovery.

---

# 15. Weapon solutions

Gear upgrades are not ordinary “throw ingredients together” recipes. They require:

```text
base item + unlocked material tier + required station + materials + discovered diagram where specified
```

## 15.1 Iron Knife / Short Blade

**Key:** `recipe.weapon.iron_blade`

**Gate:** Smelting + Forge.

**Core:** Iron Ingot + Haft + Forge shaping + edge finishing.

**Failure precedence:** metal tier locked → no ingot → no haft → wrong station → edge unfinished.

## 15.2 Steel Blade

**Key:** `recipe.weapon.steel_blade`

**Gate:** Steelworking.

**Core:** Steel + Haft + Forge + finishing.

## 15.3 Fighting Dagger / Shortsword

**Key:** `recipe.weapon.fast_entry`

**Gate:** diagram OR inferred after Steel Blade, depending final progression.

If diagram-gated, silhouettes can show branch existence but experimentation cannot reveal exact form.

## 15.4 Paired Daggers / Steel Shortswords

**Key:** `recipe.weapon.fast_mid`

**Gate:** fast-line diagram + Steelworking.

## 15.5 Twin Blades

**Key:** `recipe.weapon.fast_end`

**Gate:** masterwork diagram; not brute-force discoverable.

## 15.6 War Cleaver / Iron Greatblade

**Key:** `recipe.weapon.heavy_entry`

**Gate:** heavy-line diagram or explicit branch discovery.

## 15.7 Steel Greatsword / Greataxe

**Key:** `recipe.weapon.heavy_mid`

**Gate:** Steelworking + heavy-line diagram.

## 15.8 Masterwork Greatsword / Greataxe

**Key:** `recipe.weapon.heavy_end`

**Gate:** masterwork diagram; never brute-force through hint spam.

## Weapon near-miss hint classes

- edge rolls/dulls → metal/heat/finishing problem;
- tang/haft loosens → fastening/fit;
- weapon too heavy/unbalanced → proportion/haft/material choice;
- blade chips → heat/material quality;
- blade bends → insufficient material/treatment.

Hints should reveal **craft problem**, not DPS/stat outcomes.

---

# 16. Armour solutions

## 16.1 Rag Armour / Rag Hood

Starting gear; no discovery needed.

## 16.2 Quilted Coat

**Key:** `recipe.armour.quilted`

**Core:** cloth + padding + thread + quilting at Stitch table.

**Failure:** simply stacking cloth/padding → “It needs quilting, not just stacking.”; weak seams → reinforce; bunching → better distributed stitch pattern.

## 16.3 Boiled Leather

**Key:** `recipe.armour.leather_entry`

**Gate:** Tanning.

**Core:** Leather + shaped/stiffened construction + stitching.

## 16.4 Studded Leather

**Gate:** leather entry + metal studs/rivets + diagram recommended.

## 16.5 Hardened Leather

**Gate:** high leather tier + diagram; bone/tusk lamellar reinforcement.

## 16.6 Ring Mail

**Key:** `recipe.armour.mail_entry`

**Gate:** Smelting + metal rings + Quilted Coat underlayer.

**Failure:** rings pull apart → closure/rivet quality; no underlayer → poor wearable result.

## 16.7 Riveted Chain

**Gate:** improved wire/rivet capability + diagram.

## 16.8 Splinted Mail

**Gate:** advanced mail diagram + iron splints.

## 16.9 Half-Plate

**Key:** `recipe.armour.plate_entry`

**Gate:** Steelworking + diagram + mail/quilted base layers.

## 16.10 Full Plate

**Gate:** masterwork plate diagram; no brute-force discovery.

## Armour near-miss classes

- seam/rivet failure;
- plate/ring misfit;
- padding distribution;
- mobility restriction;
- noise/rattle from loose fit;
- weak joint articulation.

These can feed quality improvements even after the recipe is known.

---

# 17. Tool solutions

## 17.1 Butcher / Skinning Knife

Metal/bone blade + suitable handle. Better edge material and fit affect quality/yield.

## 17.2 Cleaver

Heavier blade + reinforced haft/handle; metal gate applies.

## 17.3 Woodcutter's Axe

Metal head + strong haft + secure wedge/fastening.

**Failure:** head slips → haft fit; head rolls/chips → metal/edge quality; bad balance → handle/head geometry.

## 17.4 Pick

Metal head + strong haft; Forge gate.

## 17.5 Awl / Saw / Hook

Basic metalworking components; can become automatically discoverable from Workbench + Smelting rather than requiring separate milestone gates.

---

# 18. Charm solutions

Charms are **loadout progression**, so discovery should mix experimentation with fragments/keeper teaching.

## 18.1 Stillstone

**Key:** `recipe.charm.stillstone`

**Core:** Smooth Stone + cord + learned Still Breath aptitude pattern.

Aptitude effect must already be discoverable/taught; random stone + cord should not grant abilities by accident.

## 18.2 Veil Sachet

**Core:** identified Veilspore + cloth/sachet + learned Veil Skip pattern.

## 18.3 Ash Pouch

**Core:** Ash + pouch + learned Root Ash pattern.

## 18.4 Emberleaf Cord

**Core:** identified Emberleaf + tallow + cord + learned Short Burst pattern.

## 18.5 Passive charms

Deep-Lung Token, Ward Fetish, Warm Fetish, Porter's Strap, Steady Cord similarly require their pattern/knowledge plus materials.

**Rule:** materials can infer that a charm branch exists, but **aptitude/passive effects are not brute-force discoverable from random crafting** unless intentionally designed so.

---

# 19. Quality failures versus recipe failures

Once a recipe is known and successfully matched, poor execution should usually create a **lower-quality item**, not a hard failure.

Examples:

- thin stew rather than “failed stew”;
- rough cord rather than no cord;
- chipped blade rather than nothing;
- stiff leather rather than total loss, when still structurally usable.

Hard failures are reserved for missing essential process/function.

Quality observations can still produce Journal notes:

- “The edge will not hold.”
- “The seams carry all the strain.”
- “The broth is thin.”
- “The coating cracks when folded.”

These notes improve player reasoning but do not expose hidden quality numbers.

---

# 20. No-information outcomes

The evaluator should intentionally return **no persistent hint** when:

- ingredients do not overlap any discoverable recipe family enough;
- the player has not reached the prerequisite capability and the recipe is hard-gated;
- the attempt repeats an already-resolved mistake and reveals nothing new;
- the mixture is contradictory enough that no single meaningful correction exists.

Optional transient flavour:

- “Nothing useful came of it.”
- “The mixture spoiled.”
- “These parts do not seem to belong together.”

These do **not** create Journal knowledge keys.

---

# 21. Multiple-failure selection algorithm

Recommended deterministic selection:

```text
candidate recipes = recipes whose near-miss predicate matches attempt
if none:
    no persistent hint

rank candidates by:
    1. prerequisite eligibility
    2. number of core functions satisfied
    3. process similarity
    4. ingredient-family similarity
    5. smallest correction distance

choose best candidate

for blocker in recipe.precedence:
    if blocker fails and corresponding hint is not known:
        award that hint
        stop

if all failed blockers already known:
    either award next stronger variant if allowed
    or produce no new knowledge
```

Do **not** choose a candidate purely because it shares the most raw item IDs. Functional roles matter more than exact counts.

---

# 22. Recipe metadata contract for implementation

Each experiment-discoverable recipe should eventually have structured metadata equivalent to:

```text
key
category
result
knowledge_gate
station
process
core_roles[]
optional_roles[]
ingredient_state_rules[]
near_miss_predicate
blocker_precedence[]
hint_keys_by_blocker{}
success_predicate
quality_inputs[]
discovery_on_success
```

Diagram/keeper/fragment-gated recipes additionally need:

```text
gate_mode = hard | soft
inference_allowed = true | false
```

**Hard gate:** recipe cannot be discovered by experimentation.

**Soft gate:** experimentation may discover it, but a fragment/keeper note provides a strong shortcut.

---

# 23. Recommended gate classifications

## Tier 0 — born known

- Crude butcher
- Campfire Roast
- Crude Boil
- Firestart
- Crude Bandage
- Forage

## Experiment-discoverable / soft-gated

- Stew
- Broth
- Porridge
- Rendering
- Cordage
- Charcoal
- Brine
- basic Preservation
- Tanning
- Ash Tea / basic Brewing
- basic Poultice/Salve
- Water filtration after Charcoal
- basic snares
- basic fishing tackle
- Iron smelting after Charcoal/Forge access

## Hard-gated or diagram-led

- advanced poison formulas
- Distilling
- Steelworking
- Bronze alloying if desired
- advanced traps such as Jaw Trap
- advanced weapon branches
- masterwork weapons
- upper armour tiers
- Full Plate
- advanced aptitude charms

This preserves discovery without letting random experimentation skip the progression spine.

---

# 24. Cross-system consistency rules

- A material cannot be used as a known functional role before that property has been learned, unless blind experimentation is explicitly allowed for that recipe.
- Discovering a material property can unlock new **inferred silhouettes** without revealing recipes.
- Discovering a recipe can reveal one or more linked material uses.
- Hints are per-Remnant persistent knowledge.
- Recipe success is per-Remnant knowledge unless taught account-wide later by an explicit design.
- Internal item IDs and WoW spell names never appear in Journal text.
- Recipe logic belongs server-side; Lua receives safe discovery state and approved copy keys.

---

# 25. Worked full examples

## 25.1 Ash Tea

```text
Attempt A: Ashbloom + Foul Water
Candidate: Ash Tea
Blocker 1: water state invalid
Award: ash_tea.clean_water

Attempt B: Ashbloom + Clean Water, cold mixing
Blocker 1 now satisfied
Blocker 2: extraction process missing
Award: ash_tea.needs_heat

Attempt C: Ashbloom + Clean Water + controlled steep
Success
Discover recipe.med.ash_tea
Resolve silhouette → Ash Tea
Retain learned field-note trail
```

## 25.2 Charcoal

```text
Attempt A: Deadwood on open cookfire
Candidate: Charcoal
Blocker: oxygen/process wrong
Result: Ash, not Charcoal
Award: charcoal.low_air

Attempt B: Deadwood in poor covered heap, opened too soon
Blocker: duration/centre not charred
Award: charcoal.time

Attempt C: good Deadwood + low-air char pit + sufficient time
Success: Charcoal
Unlock Forge branch inference + filtration inference
```

## 25.3 Cured Hide

```text
Attempt A: Raw Hide left to dry
Candidate: Cured Hide
Blocker: preservation/treatment incomplete
Award: cured_hide.preserve

Attempt B: cleaned Raw Hide + Salt, dried hard
Blocker: tanning agent / working missing
Award: cured_hide.stiff

Attempt C: cleaned hide + Salt + tanning reagent + working/time
Success: Cured Hide
Unlock Leather uses
```

## 25.4 Iron Blade

```text
Attempt A: iron-bearing scrap at cookfire
Candidate: Iron Ingot / Blade family
Blocker: station/heat capability
Award forge-capability inference only

Attempt B: Iron Ingot + no haft at Forge
Candidate: Iron Blade
Blocker: structural handle missing
Award blade.haft

Attempt C: Iron Ingot + Haft + Forge + shaping/finishing
Success: Iron Knife / Short Blade
```

---

# 26. Implementation review checklist

Before adding a recipe to live experimentation, confirm:

- [ ] Does it have a stable recipe key?
- [ ] Is its gate classification explicit?
- [ ] Is the station/process explicit?
- [ ] Are essential ingredient **roles** defined rather than only exact item IDs?
- [ ] Is the near-miss minimum strict enough to avoid spam?
- [ ] Is blocker precedence deterministic?
- [ ] Does each persistent hint map to exactly one real correction?
- [ ] Can the attempt accidentally skip a major progression gate?
- [ ] Is success distinct from quality?
- [ ] Are unsafe/toxic fictional systems kept game-abstract rather than real-world instructional?
- [ ] Does success update the Journal and linked silhouettes correctly?

---

# 27. Related canon

- [JOURNAL-HINTS.md](JOURNAL-HINTS.md) — approved Remnant-facing hint language
- [JOURNAL-RECORD.md](JOURNAL-RECORD.md) — discovery UI and persistence model
- [JOURNAL-CONTENT.md](JOURNAL-CONTENT.md) — what the three Journal tabs contain
- [CRAFTING.md](CRAFTING.md) — stations, discovery tree and craft catalogue
- [ITEMS.md](ITEMS.md) — made/found item catalogue
- [MATERIALS.md](MATERIALS.md) — raw material catalogue
- [GEAR.md](GEAR.md) — weapon/armour upgrade ladders

---

## Locked rule

**Every persistent near-miss hint must correspond to a real, testable correction in this solution model.** If a hint cannot be mapped to an actual blocker and correction, it is flavour text and must not be stored as discovery knowledge.
