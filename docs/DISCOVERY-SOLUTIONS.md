# Discovery solutions — authoritative recipe and near-miss matrix

This document is the **server-side truth behind the Journal hint system**.

`JOURNAL-HINTS.md` defines what the Remnant may read. This document defines what is actually wrong, which correction fixes it, which hint may be awarded, which blocker wins when several things are wrong, and what successful result is produced.

The design goal is deterministic discovery rather than arbitrary recipe guessing.

> **Player-facing hints remain diegetic. This file is implementation-facing canon.**

---

# 1. Core rules

## 1.1 Evaluation order

Every experiment is evaluated in this order:

1. **Knowledge gate** — is this recipe/process allowed to be discovered by experiment at all?
2. **Station/process gate** — is the player using a valid station or field process?
3. **Core ingredient family** — is the experiment recognisably aimed at a real recipe family?
4. **Preparation state** — are required inputs refined/prepared correctly?
5. **Contamination / incompatible input** — is a valid ingredient present in a wrong state or paired with something that prevents the process?
6. **Structural requirement** — binder, liquid, preserving agent, carrier, fuel, fastening, etc.
7. **Heat / time / control** — temperature, duration, sequence, pressure, air exposure.
8. **Quality-only issue** — recipe succeeds but result quality is degraded.
9. **Success** — create result, unlock recipe, resolve inferred Journal entry.

Only the **highest-priority meaningful blocker** normally produces a new hint.

Example: Ashbloom + foul water with no heat has two problems. The foul water blocker wins first. After the player corrects the water, the no-heat blocker becomes eligible.

## 1.2 One new hint per attempt

A failed experiment may award at most **one new persistent hint** unless a specific scripted tutorial says otherwise.

If the winning hint was already learned, the evaluator may:

- award the next eligible unlearned hint from the same attempt, **only if the player has already demonstrated the earlier correction**, or
- simply fail with no Journal update.

Do not dump several answers from one failure.

## 1.3 Near-miss threshold

An attempt is hint-eligible only if it satisfies at least one of these:

- contains the recipe's core ingredient;
- uses the correct process/station with a close ingredient family;
- contains all major ingredients but one required function is missing;
- uses a correct ingredient in the wrong preparation state;
- follows a previously learned hint but misses the next stage.

Random piles of unrelated items return **no useful information**.

## 1.4 Hint strength

Each recipe may have up to three hint strengths:

- **H1 — property:** vague observation, e.g. `Too wet.`
- **H2 — process:** points toward what kind of correction is needed, e.g. `It needs drier air or steadier smoke.`
- **H3 — near-solution:** clear but still diegetic, e.g. `The salt never worked through the cut.`

H2 requires either H1 already known or a closer attempt. H3 requires H2 or an almost-correct attempt.

## 1.5 Success persistence

On success:

- mark the recipe/process **Known**;
- preserve previously learned hints as field notes unless they become misleading;
- reveal the result icon/name;
- link the result to its known ingredients/materials;
- do not reveal undiscovered sibling recipes or upgrade branches.

---

# 2. Canonical solution record shape

Implementation should model every discoverable recipe/process with these fields conceptually:

```text
solution_key
category
result
experimentable            true / false
knowledge_gate             discovery prerequisite if any
valid_stations             allowed station/process
core_inputs                ingredient families that establish intent
required_inputs            exact game inputs or accepted families
required_preparation       input-state requirements
required_process           heat/time/air/control requirements
optional_inputs             quality or variant modifiers
failure_rules[]            ordered blockers
success_effects            output + Journal unlocks
```

Each `failure_rule` should contain:

```text
failure_key
priority
condition
correction
hint_key
hint_strength
consumption_policy
```

`correction` is implementation-facing and **never printed directly** to the player.

---

# 3. Consumption policy on failed experiments

Failure should not always consume everything.

| Failure type | Default handling |
|---|---|
| Wrong station | consume nothing |
| Obviously unrelated ingredients | consume nothing |
| Wrong preparation state | consume time; return most materials unless the process destroys them |
| Contaminated cooking/brewing batch | consume vulnerable food/herb/liquid inputs |
| Burn/scorch/overheat | consume or downgrade heat-sensitive ingredients |
| Structural assembly failure | return hard components; consume or damage thread/binder |
| Near-success food craft | create poor/spoiled/inedible by-product where appropriate |
| Metal failure | preserve metal where reasonable, but consume fuel |

The economy should punish experimentation enough to matter without making discovery feel reckless or save-scum dependent.

---

# 4. Survival — Food

## 4.1 Campfire Roast

**Solution key:** `food.campfire_roast`

**Result:** Roast

**Experimentable:** yes; crude version effectively tutorial-known.

**Station:** campfire / cookfire.

**Required:** raw meat + heat.

**Preferred process:** moderate direct heat; cut not excessively thick.

### Failure precedence

1. **No valid heat source**
   - Correction: use a campfire/cookfire.
   - Hint: `heat.not_enough`
   - Copy family: *Not enough heat.*

2. **Cut too thick for direct-fire process**
   - Correction: cut thinner or use a pot/slow process.
   - Hint: `roast.cut_too_thick`
   - Copy: *The cut is too thick for this fire.*

3. **Heat too fierce / outside burns first**
   - Correction: reduce/direct less heat or increase distance/time.
   - Hint: `roast.burnt_outside`
   - Copy: *Burnt outside, raw within.*

4. **Lean/tough cut dries before cooking through**
   - Correction: switch to broth/stew process or add fat/liquid.
   - Hint: `roast.needs_moisture`
   - Copy: *It needs fat or liquid to keep from turning to leather.*

**Success:** unlock Roast; record meat as a known cooked use.

---

## 4.2 Broth

**Solution key:** `food.broth`

**Result:** Broth

**Experimentable:** yes.

**Station:** cookfire with vessel.

**Required:** clean/usable water + bone/marrow or meat scraps + sustained heat.

### Failure precedence

1. Foul/contaminated water
   - Correction: use boiled/clean water or first purify it.
   - Hint: `broth.water_fouled`
   - Copy: *Something in the water fouled it.*

2. No stock-giving ingredient
   - Correction: add bone, marrow, or suitable meat scraps.
   - Hint: `broth.no_body`
   - Copy: *Thin. Nothing gave the water body.*

3. Heat too brief
   - Correction: simmer longer.
   - Hint: `broth.needs_time`
   - Copy: *It wants longer, slower heat.*

**Success:** unlock Broth.

---

## 4.3 Stew

**Solution key:** `food.stew`

**Result:** Stew

**Experimentable:** yes.

**Station:** cookfire + vessel.

**Required:** meat or substantial forage + usable water + sustained simmer.

**Optional:** roots, herbs, salt, fat improve quality.

### Failure precedence

1. Water unusable
   - Correction: cleaner water.
   - Hint: `stew.bad_water`
   - Copy: *The water spoiled the mixture.*

2. Too much water / too little solid food
   - Correction: reduce liquid or add solids.
   - Hint: `stew.too_thin`
   - Copy: *Too much water drowned everything else.*

3. Tough ingredients not softened
   - Correction: longer lower heat.
   - Hint: `stew.needs_slow_heat`
   - Copy: *The meat stayed tough.*

4. Bitter/harsh forage dominates
   - Correction: prepare/leach ingredient first or balance with suitable food/fat.
   - Hint: `stew.bitterness`
   - Copy: *It needs something to round the bitterness.*

**Success:** unlock Stew; quality depends on ingredient quality and balance.

---

## 4.4 Porridge

**Solution key:** `food.porridge`

**Result:** Porridge

**Experimentable:** yes.

**Required:** milled grain + water + gentle heat.

### Failure precedence

1. Whole/coarse grain not milled enough
   - Correction: grind finer.
   - Hint: `grain.too_coarse`
   - Copy: *The grain is too coarse.*

2. Too little water
   - Correction: add enough liquid.
   - Hint: `porridge.too_dry`
   - Copy: *The meal never took enough water.*

3. Too much water
   - Correction: reduce ratio or cook longer.
   - Hint: `porridge.too_wet`
   - Copy: *Too wet to hold shape.*

4. Heat too fierce
   - Correction: slower heat.
   - Hint: `porridge.slower_heat`
   - Copy: *This wants slower heat.*

**Success:** unlock Porridge.

---

## 4.5 Bread / Acorn Bread

**Solution key:** `food.bread`

**Result:** Bread / Acorn Bread variant

**Experimentable:** yes after flour preparation is known.

**Required:** prepared flour + water + worked dough + controlled heat.

**Acorn variant additional requirement:** bitterness removed by leaching/preparation.

### Failure precedence

1. Flour not sufficiently prepared
   - Correction: mill finer; acorn/nut flour must be leached first.
   - Hint: `bread.flour_unprepared`
   - Copy: *The bitterness stayed in the meal.* / *The grain is too coarse.*

2. Dough too wet
   - Correction: rebalance flour/liquid.
   - Hint: `bread.too_wet`
   - Copy: *Too wet to hold shape.*

3. Dough not worked/bound
   - Correction: knead/work before baking.
   - Hint: `bread.needs_working`
   - Copy: *It needs working before it will bind.*

4. Centre undercooked
   - Correction: lower/longer heat.
   - Hint: `bread.raw_centre`
   - Copy: *The centre stayed heavy and raw.*

**Success:** unlock relevant bread variant.

---

## 4.6 Jerky / Dried Meat

**Solution key:** `food.jerky`

**Result:** Jerky

**Experimentable:** yes after Preservation is discovered.

**Knowledge gate:** Preservation.

**Required:** meat cut thin + preserving salt + low/dry heat or controlled drying.

### Failure precedence

1. Meat slices too thick
   - Correction: cut thinner.
   - Hint: `preserve.cut_too_thick`
   - Copy: *The cut is too thick to dry safely.*

2. No preserving agent
   - Correction: salt/brine stage.
   - Hint: `preserve.needs_drying_agent`
   - Copy: *It needs more protection from spoilage.*

3. Salt only reaches surface
   - Correction: thinner cuts / longer cure.
   - Hint: `preserve.salt_not_through`
   - Copy: *The salt never worked through the cut.*

4. Drying too fast
   - Correction: lower heat / slower drying.
   - Hint: `preserve.case_hardened`
   - Copy: *The outside hardened too quickly.*

5. Drying too slow/wet
   - Correction: drier airflow or steadier heat.
   - Hint: `preserve.still_wet`
   - Copy: *Still too wet to keep.*

**Success:** unlock Jerky / Dried Meat.

---

## 4.7 Smoked Meat / Smoked Fish

**Solution key:** `food.smoked`

**Result:** Smoked Meat or Smoked Fish

**Knowledge gate:** Preservation.

**Required:** prepared protein + prior cure/salt + sustained cool/steady smoke.

### Failure precedence

1. No cure/preservation stage
   - Correction: cure first.
   - Hint: `smoke.needs_preserve_stage`
   - Copy: *Smoke touched it, but did not preserve it.*

2. Fire too hot
   - Correction: smoke, not roast.
   - Hint: `smoke.too_hot`
   - Copy: *The smoke was too hot; the flesh cooked instead of keeping.*

3. Smoke too brief
   - Correction: longer exposure.
   - Hint: `smoke.too_brief`
   - Copy: *Smoke touched it, but did not preserve it.*

4. Product too wet
   - Correction: dry surface / improve airflow.
   - Hint: `smoke.too_wet`
   - Copy: *It needs drier air or steadier smoke.*

**Success:** unlock the appropriate smoked product.

---

## 4.8 Pemmican

**Solution key:** `food.pemmican`

**Result:** Pemmican

**Experimentable:** yes after Preservation.

**Required:** thoroughly dried meat + rendered fat + dried berries/optional forage binder.

### Failure precedence

1. Meat not dry enough
   - Correction: use fully dried meat.
   - Hint: `pemmican.meat_too_wet`
   - Copy: *There was too much water for it to set.*

2. Fat not rendered
   - Correction: render fat first.
   - Hint: `pemmican.fat_unprepared`
   - Copy: *The parts fit, but don't stay together.*

3. Mixture ratio fails to bind
   - Correction: rebalance dry/fat components.
   - Hint: `pemmican.wont_bind`
   - Copy: *It holds for a moment, then crumbles.*

**Success:** unlock Pemmican.

---

## 4.9 Pickles / Brined Roots

**Solution key:** `food.pickles`

**Result:** Pickles

**Knowledge gate:** Preservation.

**Required:** edible root/vegetable + brine + clean vessel + time.

### Failure precedence

1. Plain water used
   - Correction: proper brine.
   - Hint: `pickle.weak_brine`
   - Copy: *It would not preserve. Something needs to draw the moisture out.*

2. Dirty vessel / contamination
   - Correction: clean vessel.
   - Hint: `pickle.dirty_vessel`
   - Copy: *The batch turned before it could settle.*

3. Open/incorrect exposure
   - Correction: controlled covered rest.
   - Hint: `pickle.air_control`
   - Copy: *Too much air got to it.*

4. Too little time
   - Correction: wait longer.
   - Hint: `pickle.too_soon`
   - Copy: *The change had started, but was stopped early.*

**Success:** unlock Pickles.

---

# 5. Survival — Water and drink

## 5.1 Crude Boil

**Solution key:** `water.crude_boil`

**Result:** Boiled Water

**Known at start:** yes.

**Required:** water + vessel + sustained boil.

### Failure precedence

1. No vessel
   - Correction: use heat-safe vessel.
   - Hint: `water.needs_vessel`
   - Copy: *The vessel is wrong for the process.*

2. Not held hot long enough
   - Correction: sustained boil.
   - Hint: `water.boil_too_short`
   - Copy: *Hot, but not held long enough.*

3. Heavy sediment remains
   - Correction: settle/strain first; boiling alone does not remove solids.
   - Hint: `water.sediment`
   - Copy: *Sediment remains after the boil.*

**Success:** produce Boiled Water. This is safer but not necessarily equivalent to later filtered/distilled water quality.

---

## 5.2 Charcoal-filtered Water

**Solution key:** `water.charcoal_filter`

**Result:** Clean Water

**Knowledge gate:** Charcoal discovery.

**Required:** pre-boiled or otherwise usable water + charcoal filter medium + layered filter bed.

### Failure precedence

1. Charcoal unknown/unprepared
   - Correction: discover and prepare charcoal.
   - Hint: `filter.needs_active_medium`
   - Copy: *The water passed through unchanged.*

2. Filter too coarse
   - Correction: finer/layered bed.
   - Hint: `filter.too_coarse`
   - Copy: *The filter is too coarse.*

3. Channeling around filter
   - Correction: pack/seal bed correctly.
   - Hint: `filter.channeling`
   - Copy: *The water found a path around the filter.*

4. Filter spent
   - Correction: replace medium.
   - Hint: `filter.spent`
   - Copy: *The filtering material is spent.*

**Success:** unlock Clean Water filtration.

---

## 5.3 Distilled Water

**Solution key:** `water.distilled`

**Result:** Distilled Water

**Knowledge gate:** Distilling.

**Required:** water + still setup + boil + vapour capture + cooling/receiver.

### Failure precedence

1. No closed vapour path
   - Correction: seal vessel and route steam.
   - Hint: `distill.steam_escape`
   - Copy: *The steam escaped.*

2. No condenser/cooling stage
   - Correction: provide cooling path.
   - Hint: `distill.no_cooling`
   - Copy: *The vapour had nowhere to cool.*

3. Receiver missing/wrong
   - Correction: capture condensate.
   - Hint: `distill.no_receiver`
   - Copy: *The liquid boiled. Nothing was captured.*

4. Heat uncontrolled
   - Correction: steadier lower boil.
   - Hint: `distill.too_hot`
   - Copy: *Too much heat pushed everything through at once.*

**Success:** unlock Distilled Water.

---

## 5.4 Tea

**Solution key:** `drink.tea`

**Result:** Tea variant

**Required:** known edible/medicinal herb + clean hot water + steeping.

### Failure precedence

1. Foul water
   - Correction: use clean water.
   - Hint: `tea.bad_water`
   - Copy: *The water spoiled what the herb could do.*

2. Herb used whole when crushing is required
   - Correction: bruise/crush/prep herb.
   - Hint: `tea.needs_crush`
   - Copy: *The useful part is still trapped inside.*

3. Water insufficiently hot
   - Correction: hotter steep.
   - Hint: `tea.needs_heat`
   - Copy: *Cold water draws almost nothing from it.*

4. Overheated delicate herb
   - Correction: steep off fierce heat.
   - Hint: `tea.overheated`
   - Copy: *Too much heat. Whatever mattered burned off.*

**Success:** unlock the appropriate tea.

---

# 6. Survival — Medicine and wounds

## 6.1 Bandage

**Solution key:** `medicine.bandage`

**Result:** Bandage

**Known at start:** crude version.

**Required:** clean cloth/rags + suitable strip/preparation.

### Failure precedence

1. Dirty material
   - Correction: clean/boil cloth first where possible.
   - Hint: `bandage.dirty_material`
   - Copy: *The wound would close, but not stay clean.*

2. Material too weak/rotted
   - Correction: stronger cloth.
   - Hint: `bandage.too_weak`
   - Copy: *The patch is clean, but too weak.*

3. Wrong cut/shape
   - Correction: cut strips suitable for wrapping.
   - Hint: `bandage.bad_cut`
   - Copy: *The cut is wrong for the job.*

**Success:** unlock Bandage if not already tutorial-known.

---

## 6.2 Stitch Kit

**Solution key:** `medicine.stitch_kit`

**Result:** Stitch Kit

**Experimentable:** yes after basic stitching knowledge.

**Required:** clean strong thread + suitable needle + clean cloth/support material.

### Failure precedence

1. No needle/piercing tool
   - Correction: use bone/metal needle.
   - Hint: `stitch.no_needle`
   - Copy: *This cannot be worked properly by hand.*

2. Thread too weak
   - Correction: stronger thread/sinew.
   - Hint: `stitch.thread_weak`
   - Copy: *The thread tears under tension.*

3. Dirty components
   - Correction: clean components.
   - Hint: `stitch.dirty`
   - Copy: *It needs cleaning before it is closed.*

4. No support/binding material
   - Correction: include clean cloth/bandage support.
   - Hint: `stitch.no_support`
   - Copy: *The stitch holds, but the edges gape.*

**Success:** unlock Stitch Kit.

---

## 6.3 Poultice

**Solution key:** `medicine.poultice`

**Result:** Poultice

**Required:** suitable medicinal herb + carrier/base + crushing/mixing.

### Failure precedence

1. Herb not processed
   - Correction: crush/grind.
   - Hint: `poultice.herb_unprocessed`
   - Copy: *The herb is present, but not drawn out.*

2. No carrier
   - Correction: add suitable moist/fat/paste carrier.
   - Hint: `poultice.needs_carrier`
   - Copy: *The mixture needs a carrier.*

3. Too wet
   - Correction: reduce liquid/thicken.
   - Hint: `poultice.too_runny`
   - Copy: *Too runny to stay on the wound.*

4. Too dry
   - Correction: add suitable liquid/base.
   - Hint: `poultice.too_dry`
   - Copy: *Too dry to spread.*

**Success:** unlock Poultice.

---

## 6.4 Salve

**Solution key:** `medicine.salve`

**Result:** Salve

**Knowledge gate:** Rendering or equivalent carrier knowledge.

**Required:** suitable medicinal herb + rendered fat/oil carrier + controlled mixing.

### Failure precedence

1. Unrendered fat
   - Correction: render first.
   - Hint: `salve.carrier_unprepared`
   - Copy: *The mixture separates as it warms.*

2. Herb not extracted/crushed
   - Correction: prepare herb.
   - Hint: `salve.herb_locked`
   - Copy: *The useful part never left the leaf.*

3. Too much heat
   - Correction: lower heat during infusion.
   - Hint: `salve.overheated`
   - Copy: *Heat destroys the smell that seemed useful.*

4. Ratio too thin/thick
   - Correction: rebalance carrier/herb.
   - Hint: `salve.consistency`
   - Copy: *Too runny to stay on the wound.* / *Too dry to spread.*

**Success:** unlock Salve.

---

## 6.5 Ash Tea

**Solution key:** `medicine.ash_tea`

**Result:** Ash Tea

**Knowledge gate:** Brewing.

**Required:** Ashbloom + Clean Water + steeping heat.

### Failure precedence

1. Foul/unusable water
   - Correction: use Clean Water.
   - Hint: `ash_tea.clean_water`
   - Copy: *The herb steeped, but the water spoiled it.*

2. Ashbloom unprepared/whole where extraction is weak
   - Correction: bruise/crush as required by implementation.
   - Hint: `ash_tea.prepare_herb`
   - Copy: *The useful part is still trapped inside.*

3. No/insufficient heat
   - Correction: steep with controlled heat.
   - Hint: `ash_tea.needs_heat`
   - Copy: *The leaves gave almost nothing. It needs heat.*

4. Fierce boil destroys quality
   - Correction: steep, don't aggressively boil.
   - Hint: `ash_tea.too_hot`
   - Copy: *Too much heat. Whatever mattered burned off.*

**Success:** unlock Ash Tea; record `Eases Infection` as known effect.

---

## 6.6 Fever Tincture

**Solution key:** `medicine.fever_tincture`

**Result:** Fever Tincture

**Knowledge gate:** Advanced Apothecary; strong variant may require Distilling.

**Required:** Fevermint/Achebark family + clean tincture base + extraction process.

### Failure precedence

1. Water-only base when tincture strength is required
   - Correction: use unlocked tincture/spirits base.
   - Hint: `tincture.base_too_weak`
   - Copy: *It needs something sharper than water.*

2. Plant not prepared
   - Correction: cut/crush/dry as appropriate.
   - Hint: `tincture.plant_unprepared`
   - Copy: *The plant gave colour, not strength.*

3. Extraction too brief
   - Correction: longer controlled extraction.
   - Hint: `tincture.too_soon`
   - Copy: *The useful part never left the leaf.*

4. Overheated
   - Correction: lower heat/control.
   - Hint: `tincture.overheated`
   - Copy: *Strong enough to hurt; not clean enough to help.*

**Success:** unlock Fever Tincture.

---

## 6.7 Antiseptic Wash

**Solution key:** `medicine.antiseptic_wash`

**Result:** Antiseptic Wash

**Knowledge gate:** Advanced Apothecary; stronger variants may require Distilling.

**Required:** known cleansing base + clean water where applicable + valid preparation.

**Important:** the game should use **fictionalised item rules**, not real-world medical instructions.

### Failure precedence

1. Base too weak/dirty
   - Correction: use a stronger unlocked cleansing base.
   - Hint: `wash.base_too_weak`
   - Copy: *It numbs the wound but does not clean it.*

2. Residue/contamination
   - Correction: refine/strain/prepare base.
   - Hint: `wash.residue`
   - Copy: *The wash stings, but leaves residue behind.*

3. Mixture overly harsh / poor quality
   - Correction: rebalance using the game's recipe rule.
   - Hint: `wash.too_harsh`
   - Copy: *Strong enough to hurt; not clean enough to help.*

**Success:** unlock Antiseptic Wash.

---

## 6.8 Styptic

**Solution key:** `medicine.styptic`

**Result:** Styptic

**Required:** Bloodcap/approved styptic material + dried/fine powder state.

### Failure precedence

1. Material wet/fresh when powder is required
   - Correction: dry first.
   - Hint: `styptic.needs_drying`
   - Copy: *The material draws moisture, but not fast enough.*

2. Too coarse
   - Correction: grind finer.
   - Hint: `styptic.too_coarse`
   - Copy: *The powder is too coarse.*

3. No way to hold against wound
   - Correction: pair with dressing where recipe requires.
   - Hint: `styptic.no_hold`
   - Copy: *It will not stay against the wound.*

**Success:** unlock Styptic.

---

# 7. Survival — Herbs and fungi knowledge

Herb/fungus entries can unlock separately from recipes.

## 7.1 Identification states

Each plant/fungus can progress through:

1. **Collected** — name/icon known if the world identity is obvious.
2. **Observed property** — smell, stain, skin irritation, animal avoidance, etc.
3. **Classified use** — edible / medicinal / poisonous / fibrous / resinous.
4. **Linked recipes** — only those actually discovered.

## 7.2 Property tests

Property tests should be game abstractions, not instructions for real-world ingestion or toxicity testing.

### Example: Gravecap

**Solution key:** `material.gravecap_identification`

- Pickup: identity known as Gravecap, class unknown.
- Failed food use: can reveal `poisonous` property through game consequence.
- Ash-still experiment: can infer a toxin branch.
- Successful poison recipe: links known use.

Allowed hints:

- *Animals leave this one untouched.*
- *The flesh stains after cutting.*
- *The sap irritates bare skin.*

Do **not** provide real toxicology specifics.

### Example: Bloodcap

**Solution key:** `material.bloodcap_identification`

- Initial: unknown medicinal value.
- Ground/dried attempt near Styptic recipe can reveal absorbent/styptic property.
- Successful Styptic unlock links the use.

---

# 8. Survival — Fishing

## 8.1 Crude Fishing Line

**Solution key:** `fishing.line`

**Result:** Fishing Line

**Required:** suitable fibre/cordage + sufficient twist/length.

### Failure precedence

1. Fibre too short
   - Correction: combine longer strands.
   - Hint: `line.short_fibres`
   - Copy: *The fibres are too short.*

2. Twist too loose
   - Correction: tighter/more strands.
   - Hint: `line.loose_twist`
   - Copy: *The twist is too loose.*

3. Knot slips wet
   - Correction: use appropriate knot/cord quality.
   - Hint: `line.wet_knot`
   - Copy: *The knot slips when wet.*

**Success:** unlock Fishing Line.

---

## 8.2 Bone Hook / Metal Hook

**Solution key:** `fishing.hook`

**Result:** Hook variant

**Required:** bone/metal blank + shaping + sharp point + eye/attachment.

### Failure precedence

1. Point blunt
   - Correction: sharpen/refine point.
   - Hint: `hook.blunt`
   - Copy: *The hook is too blunt.*

2. Shape opens/turns out
   - Correction: curve/temper shape better.
   - Hint: `hook.bad_shape`
   - Copy: *The hook turns out of the mouth.*

3. Attachment weak
   - Correction: improve eye/knot/connection.
   - Hint: `hook.attachment`
   - Copy: *The fastening is the weak point.*

**Success:** unlock relevant Hook.

---

## 8.3 Fish Trap / Weir

**Solution key:** `fishing.fish_trap`

**Result:** Fish Trap / Weir

**Knowledge gate:** Trap-making or Cordage.

**Required:** reeds/wood frame + cord + funnel/guiding entrance.

### Failure precedence

1. Gaps too wide
   - Correction: tighten weave/gaps.
   - Hint: `fishtrap.gaps`
   - Copy: *The gaps are too wide.*

2. Entrance lets catch escape
   - Correction: funnel/non-return shape.
   - Hint: `fishtrap.escape`
   - Copy: *Fish enter, then find their way back out.*

3. Current collapses frame
   - Correction: stronger frame/anchoring.
   - Hint: `fishtrap.frame_weak`
   - Copy: *The frame collapses under the current.*

4. Placement wrong
   - Correction: position in flow/depth suitable for fish path.
   - Hint: `fishtrap.placement`
   - Copy: *The trap sits too high in the water.*

**Success:** unlock Fish Trap / Weir.

---

## 8.4 Fish Smoking

Use `food.smoked` rules with fish as protein family. Additional near-miss:

- Fine bones/poor cleaning
  - Correction: prepare fish properly first.
  - Hint: `fish.prep_bones`
  - Copy: *Too many fine bones left in the flesh.*

---

# 9. Survival — Traps and fieldcraft

## 9.1 Snare

**Solution key:** `trap.snare`

**Result:** Snare

**Knowledge gate:** Cordage / Trap-making.

**Required:** cord/rope + loop + anchor + trigger/set.

### Failure precedence

1. Cord too weak
   - Correction: stronger cord/more strands.
   - Hint: `snare.weak_cord`
   - Copy: *The fibres pull apart under load.*

2. Anchor weak
   - Correction: stronger anchor.
   - Hint: `snare.anchor`
   - Copy: *The anchor gives before the snare does.*

3. Loop mechanics bind
   - Correction: improve knot/loop movement.
   - Hint: `snare.loop_bind`
   - Copy: *The knot tightens on itself before the loop moves.*

4. Trigger too stiff/sensitive
   - Correction: tune trigger.
   - Hint: `snare.trigger`
   - Copy: *The trigger takes too much force.* / *The trigger fires from the wind.*

**Success:** unlock Snare.

---

## 9.2 Deadfall

**Solution key:** `trap.deadfall`

**Result:** Deadfall

**Required:** weighted mass + support + trigger + bait/approach point.

### Failure precedence

1. Mass too light
   - Correction: heavier fall mass.
   - Hint: `deadfall.too_light`
   - Copy: *Too light to matter.*

2. Trigger cannot hold mass
   - Correction: rebalance support/trigger.
   - Hint: `deadfall.too_heavy_for_trigger`
   - Copy: *Too heavy for the trigger to hold.*

3. Support binds
   - Correction: improve release geometry.
   - Hint: `deadfall.binds`
   - Copy: *The support binds instead of releasing.*

4. Fall path misses lure point
   - Correction: align trigger/fall zone.
   - Hint: `deadfall.misses`
   - Copy: *The fall misses the bait point.*

**Success:** unlock Deadfall.

---

## 9.3 Tripwire Alarm

**Solution key:** `trap.tripwire_alarm`

**Result:** Tripwire + Alarm

**Required:** cord + anchors + noise-maker.

### Failure precedence

1. Slack
   - Correction: tension correctly.
   - Hint: `tripwire.slack`
   - Copy: *Too much slack.*

2. Over-tensioned
   - Correction: reduce tension/anchor better.
   - Hint: `tripwire.too_tight`
   - Copy: *Too tight; it pulls free on its own.*

3. Alarm too quiet
   - Correction: improve noise-maker.
   - Hint: `tripwire.quiet`
   - Copy: *The alarm is too quiet.*

4. Wind false-triggers
   - Correction: shield/tune mechanism.
   - Hint: `tripwire.wind`
   - Copy: *The alarm rings in the wind.*

**Success:** unlock Tripwire Alarm.

---

## 9.4 Jaw Trap

**Solution key:** `trap.jaw_trap`

**Result:** Jaw Trap

**Knowledge gate:** Trap-making + Smelting/metalworking.

**Required:** forged jaws/frame + spring/trigger + anchor.

### Failure precedence

1. No metalworking gate
   - Correction: unlock Forge branch.
   - Hint: no recipe-specific hint until the player has inferred metal trap technology.

2. Spring/trigger weak
   - Correction: stronger spring/tempered component.
   - Hint: `jawtrap.spring_weak`
   - Copy: *The fastening is the weak point.*

3. Frame bends
   - Correction: stronger metal/shape.
   - Hint: `jawtrap.frame_bends`
   - Copy: *The edge needs something behind it.*

4. Trigger too sensitive/stiff
   - Correction: tune trigger.
   - Hint: `jawtrap.trigger`
   - Copy family: *The trigger fires from the wind.* / *The trigger takes too much force.*

**Success:** unlock Jaw Trap.

---

# 10. Materials and refining

## 10.1 Rendering Fat → Tallow/Oil

**Solution key:** `refine.rendering`

**Result:** Tallow / Rendered Oil

**Knowledge gate:** Rendering discovery.

**Required:** fat + low/steady heat + vessel.

### Failure precedence

1. Open flame/high heat scorches
   - Correction: gentler indirect heat.
   - Hint: `render.too_hot`
   - Copy: *It scorched before it transformed.*

2. Heat too brief
   - Correction: longer steady heat.
   - Hint: `render.too_short`
   - Copy: *It needs heat held longer.*

3. No suitable vessel
   - Correction: vessel that contains rendered liquid.
   - Hint: `render.no_vessel`
   - Copy: *The vessel is wrong for the process.*

**Success:** unlock Rendering and appropriate product.

---

## 10.2 Cordage

**Solution key:** `refine.cordage`

**Result:** Cord

**Required:** suitable fibres/sinew + separated strands + twist.

### Failure precedence

1. Fibres not separated/prepared
   - Correction: strip/separate first.
   - Hint: `cord.fibres_unprepared`
   - Copy: *The fibres need separating first.*

2. Fibres too short
   - Correction: overlap/combine more strands.
   - Hint: `cord.too_short`
   - Copy: *The fibres are too short.*

3. Twist too loose
   - Correction: tighter/more even twist.
   - Hint: `cord.twist_loose`
   - Copy: *The twist is too loose.*

4. Too few strands
   - Correction: increase strand count.
   - Hint: `cord.more_strands`
   - Copy: *It needs more strands before it will hold.*

**Success:** unlock Cord.

---

## 10.3 Rope

**Solution key:** `refine.rope`

**Result:** Rope

**Knowledge gate:** Cordage.

**Required:** multiple cords + opposing twist/braid + tension.

### Failure precedence

1. Base cord weak
   - Correction: improve cord first.
   - Hint: `rope.base_weak`
   - Copy: *The fibres pull apart under load.*

2. Twist/braid wrong
   - Correction: bind multiple cords correctly.
   - Hint: `rope.twist_wrong`
   - Copy: *The cord kinks instead of bending.*

3. Join weak
   - Correction: improve splice/bind.
   - Hint: `rope.join_weak`
   - Copy: *The join slips under weight.*

**Success:** unlock Rope.

---

## 10.4 Charcoal

**Solution key:** `refine.charcoal`

**Result:** Charcoal

**Experimentable:** yes; major milestone discovery.

**Required:** good Deadwood + **low-air char pit/kiln process** + sustained controlled heat.

**Never:** open cookfire. Open burning produces Ash.

### Failure precedence

1. Open flame / too much air
   - Correction: restrict air using char pit/kiln.
   - Hint: `charcoal.low_air`
   - Copy: *It burned through to ash. Too much air.*

2. Wood too wet/green
   - Correction: use dry good Deadwood.
   - Hint: `charcoal.wood_too_wet`
   - Copy: *The core is still damp.*

3. Poor punk/rotted wood
   - Correction: use sound Deadwood.
   - Hint: `charcoal.poor_wood`
   - Copy: *It crumbled before it held any useful heat.*

4. Heat stopped too soon
   - Correction: sustain controlled char longer.
   - Hint: `charcoal.too_short`
   - Copy: *The change had started, but was stopped early.*

5. Air reintroduced too early
   - Correction: cool/seal before exposure.
   - Hint: `charcoal.reignited`
   - Copy: *It caught again before the change could hold.*

**Success:** unlock Charcoal; unlock the Forge discovery spine and charcoal-filter inference.

---

## 10.5 Lye / Potash

**Solution key:** `refine.lye_potash`

**Result:** Lye / Potash game reagent

**Knowledge gate:** refining/apothecary discovery.

**Required:** clean Ash + water + leaching/settling process.

### Failure precedence

1. Ash contaminated with unburned debris
   - Correction: sift/refine Ash.
   - Hint: `lye.dirty_ash`
   - Copy: *The useful part is there, but contaminated.*

2. Too much water
   - Correction: concentrate process.
   - Hint: `lye.too_dilute`
   - Copy: *There was too much water for it to set.*

3. Insufficient leach/settling
   - Correction: more time/control.
   - Hint: `lye.needs_time`
   - Copy: *It needs time without being disturbed.*

**Success:** unlock game reagent. Do not expose real-world caustic preparation specifics in player text.

---

## 10.6 Hide Glue

**Solution key:** `refine.hide_glue`

**Result:** Hide Glue

**Required:** appropriate bone/hoof/hide scraps + long controlled simmer + concentration.

### Failure precedence

1. Pieces too large/unprepared
   - Correction: break/cut smaller.
   - Hint: `glue.prep`
   - Copy: *The pieces are too large to work evenly.*

2. Heat too fierce
   - Correction: steady low heat.
   - Hint: `glue.too_hot`
   - Copy: *It scorched before it transformed.*

3. Too dilute
   - Correction: concentrate longer.
   - Hint: `glue.too_thin`
   - Copy: *It thickened, then broke apart.*

4. Insufficient time
   - Correction: longer simmer.
   - Hint: `glue.too_soon`
   - Copy: *Left longer, this might become something useful.*

**Success:** unlock Hide Glue.

---

# 11. Leather, textiles and waterproofing

## 11.1 Cured Hide / Tanning

**Solution key:** `leather.tanning`

**Result:** Cured Hide

**Knowledge gate:** Tanning.

**Required:** Raw Hide + Grave Salt + tanning agent family (bark/alum equivalent in game) + working/drying.

### Failure precedence

1. Hide not cleaned/scraped
   - Correction: remove residual flesh/fat first.
   - Hint: `tan.hide_unclean`
   - Copy: *The hide is still slick inside.*

2. No preserving salt/drying stage
   - Correction: salt/cure before full tanning.
   - Hint: `tan.needs_cure`
   - Copy: *It softened, but did not preserve.*

3. No tanning agent
   - Correction: add approved bark/alum tanning component.
   - Hint: `tan.needs_tannin`
   - Copy: *It dried hard as board.*

4. Treatment not reaching thick sections
   - Correction: thin/work/extend process.
   - Hint: `tan.not_through`
   - Copy: *The treatment never reached the thicker parts.*

5. Not worked while drying
   - Correction: work/stretch during dry stage.
   - Hint: `tan.needs_working`
   - Copy: *It needs more working while it dries.*

**Success:** unlock Cured Hide/Tanning branch.

---

## 11.2 Leather

**Solution key:** `leather.leather`

**Result:** Leather

**Required:** Cured Hide + cutting/working at stitch table.

### Failure precedence

1. Hide merely dried, not cured
   - Correction: complete Tanning first.
   - Hint: `leather.not_cured`
   - Copy: *It dried hard as board.*

2. Cut against useful sections / poor preparation
   - Correction: trim/cut correctly.
   - Hint: `leather.bad_cut`
   - Copy: *The cut is wrong for the job.*

**Success:** unlock Leather.

---

## 11.3 Padding

**Solution key:** `textile.padding`

**Result:** Padding

**Required:** fur/cloth filler + outer cloth + quilting/stitching.

### Failure precedence

1. Loose stacked layers
   - Correction: quilt/secure them.
   - Hint: `padding.needs_quilting`
   - Copy: *It needs quilting, not just stacking.*

2. Padding bunches
   - Correction: more even stitching/compartments.
   - Hint: `padding.bunches`
   - Copy: *The padding bunches when worn.*

3. Seam too weak
   - Correction: stronger thread/stitch pattern.
   - Hint: `padding.seam_weak`
   - Copy: *The seam carries all the strain.*

**Success:** unlock Padding.

---

## 11.4 Oilcloth

**Solution key:** `textile.oilcloth`

**Result:** Oilcloth

**Knowledge gate:** Waterproofing + Rendering.

**Required:** cloth + rendered oil/pitch treatment + controlled warming/application.

### Failure precedence

1. Raw/unrendered fat
   - Correction: render first.
   - Hint: `oilcloth.unrendered`
   - Copy: *The oil never soaked into the weave.*

2. Too little treatment
   - Correction: better coverage.
   - Hint: `oilcloth.seams_leak`
   - Copy: *Water still finds the seams.*

3. Too much treatment
   - Correction: reduce coating.
   - Hint: `oilcloth.too_stiff`
   - Copy: *Too much treatment makes the cloth stiff.*

4. Overheated coating
   - Correction: lower heat.
   - Hint: `oilcloth.overheated`
   - Copy: *Heat thinned the coating too far.*

**Success:** unlock Oilcloth.

---

# 12. Forge and metals

## 12.1 Smelting Iron

**Solution key:** `metal.smelting_iron`

**Result:** Iron Ingot

**Knowledge gate:** Charcoal + Smelting discovery.

**Required:** Iron Ore + Charcoal + Forge + sufficient sustained heat.

### Failure precedence

1. No Charcoal / wrong fuel
   - Correction: use Charcoal.
   - Hint: `smelt.fuel_wrong`
   - Copy: *The fire is hot, but not hot enough to change the ore.*

2. Wrong station/open fire
   - Correction: Forge.
   - Hint: `smelt.needs_forge`
   - Copy: *The fire is hot enough, but the setup is wrong.*

3. Heat too low
   - Correction: hotter sustained forge heat.
   - Hint: `smelt.heat_low`
   - Copy: *Warm, but not hot enough to change it.*

4. Ore unprepared/too dirty
   - Correction: sort/crush/clean ore as required.
   - Hint: `smelt.ore_dirty`
   - Copy: *The useful part is there, but contaminated.*

5. Heat stops early
   - Correction: sustain longer.
   - Hint: `smelt.too_short`
   - Copy: *The change had started, but was stopped early.*

**Success:** unlock Iron Ingot and iron-work branch.

---

## 12.2 Steel

**Solution key:** `metal.steel`

**Result:** Steel

**Knowledge gate:** Steelworking; requires Iron Smelting.

**Required:** Iron + Charcoal + higher controlled forge heat/process.

### Failure precedence

1. Steelworking not unlocked
   - Correction: discover diagram/keeper knowledge as designed.
   - Hint: none unless the player has an explicit fragment hint.

2. Heat insufficient
   - Correction: hotter/more controlled forge process.
   - Hint: `steel.needs_hotter_fire`
   - Copy: *The metal moved, but never changed enough.*

3. Fuel insufficient/poor
   - Correction: sufficient Charcoal quality/quantity.
   - Hint: `steel.fuel_weak`
   - Copy: *The heat faded before the metal was ready.*

4. Overworked/overheated quality loss
   - Correction: better control.
   - Hint: `steel.overworked`
   - Copy: *The edge looked right, then lost itself in the heat.*

**Success:** unlock Steel.

---

## 12.3 Bronze

**Solution key:** `metal.bronze`

**Result:** Bronze

**Knowledge gate:** Alloying + Charcoal.

**Required:** Copper + Tin + Forge/alloy process.

### Failure precedence

1. Missing second alloy component
   - Correction: use both alloy metals.
   - Hint: `bronze.needs_second_metal`
   - Copy: *The metal is workable, but not what the mixture was meant to become.*

2. Wrong ratio/family
   - Correction: rebalance copper/tin according to game rule.
   - Hint: `bronze.balance`
   - Copy: *It cast, but came out too soft.*

3. Heat/control wrong
   - Correction: proper alloy heat.
   - Hint: `bronze.heat`
   - Copy: *The metals never became one.*

**Success:** unlock Bronze.

---

## 12.4 Whetstone

**Solution key:** `tool.whetstone`

**Result:** Whetstone

**Required:** suitable rough stone + grit/shaping.

### Failure precedence

1. Stone too soft/smooth
   - Correction: rougher suitable stone.
   - Hint: `whetstone.too_smooth`
   - Copy: *The stone polishes the edge instead of biting it.*

2. Shape poor
   - Correction: flatten/form usable face.
   - Hint: `whetstone.bad_shape`
   - Copy: *The tool cannot hold the pressure this needs.*

**Success:** unlock Whetstone.

---

# 13. Gear — weapons

Gear upgrades are normally **diagram-gated**. Experimentation may produce hints about why an attempted upgrade fails, but must not bypass a diagram-only gate.

## 13.1 Crude Dagger → Flint/Bone Blade

**Solution key:** `weapon.flint_bone_blade`

**Result:** Flint/Bone Blade

**Experimentable:** yes early.

**Required:** flint/bone edge blank + haft/binding + sharpening.

### Failure precedence

1. Edge too coarse
   - Correction: knap/grind sharper.
   - Hint: `blade.edge_coarse`
   - Copy: *The edge is too blunt for a clean cut.*

2. Binding weak
   - Correction: stronger cord/binding.
   - Hint: `blade.binding_weak`
   - Copy: *The fastening is the weak point.*

3. Haft wrong
   - Correction: fit shaped handle.
   - Hint: `blade.haft_fit`
   - Copy: *The parts fit, but don't stay together.*

**Success:** unlock the early blade.

---

## 13.2 Iron Knife

**Solution key:** `weapon.iron_knife`

**Result:** Iron Knife

**Knowledge gate:** Smelting/Iron + appropriate diagram or discoverable pattern as designated.

**Required:** Iron Ingot + Haft + Forge/Workbench + edge shaping.

### Failure precedence

1. Scrap/raw ore used instead of Ingot
   - Correction: smelt/refine first.
   - Hint: `iron_knife.metal_unprepared`
   - Copy: *The useful metal is there, but it cannot be worked like this.*

2. Wrong station
   - Correction: Forge for blade shaping.
   - Hint: `iron_knife.needs_forge`
   - Copy: *The material is right. The station is not.*

3. Edge too soft/poorly worked
   - Correction: refine forge/sharpen process.
   - Hint: `iron_knife.edge_soft`
   - Copy: *The edge would not hold.*

4. Haft/binding weak
   - Correction: improve fitting.
   - Hint: `iron_knife.haft_weak`
   - Copy: *The fastening is the weak point.*

**Success:** unlock Iron Knife.

---

## 13.3 Steel Blade

**Solution key:** `weapon.steel_blade`

**Result:** Steel Blade

**Knowledge gate:** Steelworking + diagram/branch knowledge.

**Required:** Steel + Haft + Forge + sharpening.

### Failure precedence

1. Iron used where Steel is required for this tier
   - Correction: produce Steel first.
   - Hint: `steel_blade.material_tier`
   - Copy: *The shape is right, but the metal will not keep the edge this needs.*

2. Steelworking unknown
   - Correction: discover gate.
   - Hint: none unless fragment indicates a higher-quality blade exists.

3. Heat treatment/control wrong
   - Correction: refine forging process.
   - Hint: `steel_blade.heat_control`
   - Copy: *The edge looked right, then lost itself in the heat.*

4. Final sharpening poor
   - Correction: use Whetstone/finish edge.
   - Hint: `steel_blade.finish`
   - Copy: *The blade is formed. The edge is not finished.*

**Success:** unlock Steel Blade and expose late weapon fork silhouettes if the player is allowed to infer them.

---

## 13.4 Paired Daggers / Twin Blades

**Solution key:** `weapon.dual_blades`

**Result:** Paired Daggers / Twin Blades tier

**Knowledge gate:** corresponding diagram.

**Required:** matched blade components + balanced weight + pair assembly.

### Failure precedence

1. Diagram missing
   - Correction: acquire diagram.
   - Hint: no direct solution hint; tree remains silhouette.

2. Mismatched blade weights
   - Correction: match/balance pair.
   - Hint: `dual.balance`
   - Copy: *One hand always outruns the other.*

3. Handles/grips inconsistent
   - Correction: match haft/grip setup.
   - Hint: `dual.grips`
   - Copy: *The pair does not sit the same in each hand.*

**Success:** unlock relevant dual-wield node.

---

## 13.5 Greatsword / Greataxe

**Solution key:** `weapon.twohander`

**Result:** Greatsword / Greataxe tier

**Knowledge gate:** corresponding diagram + Forge tier.

**Required:** large blade/head + reinforced haft/tang + sufficient metal + balance.

### Failure precedence

1. Diagram missing
   - Correction: acquire diagram.
   - Hint: none beyond inferred silhouette.

2. Insufficient structural reinforcement
   - Correction: stronger haft/tang/frame.
   - Hint: `twohander.structure`
   - Copy: *The edge needs something behind it.*

3. Balance poor
   - Correction: redistribute weight.
   - Hint: `twohander.balance`
   - Copy: *The head pulls away from the hands.*

4. Haft fastening weak
   - Correction: stronger fitting/binding.
   - Hint: `twohander.fastening`
   - Copy: *The fastening is the weak point.*

**Success:** unlock the appropriate 2H node.

---

# 14. Gear — armour

## 14.1 Quilted Coat

**Solution key:** `armour.quilted_coat`

**Result:** Quilted Coat

**Required:** cloth + Padding + thread + quilting/stitching.

### Failure precedence

1. Loose layers only
   - Correction: quilt layers.
   - Hint: `quilted.needs_quilting`
   - Copy: *It needs quilting, not just stacking.*

2. Padding uneven
   - Correction: distribute and secure.
   - Hint: `quilted.padding_bunches`
   - Copy: *The padding bunches when worn.*

3. Seams weak
   - Correction: stronger stitch/thread.
   - Hint: `quilted.seams`
   - Copy: *The seam carries all the strain.*

**Success:** unlock Quilted Coat.

---

## 14.2 Boiled Leather

**Solution key:** `armour.boiled_leather`

**Result:** Boiled Leather armour tier

**Knowledge gate:** Tanning + armour diagram if required.

**Required:** Leather + shaping/hardening process + stitching/straps.

### Failure precedence

1. Raw/Cured Hide used instead of finished Leather
   - Correction: make Leather first.
   - Hint: `boiled_leather.material_state`
   - Copy: *The hide stayed too stiff to work.*

2. Hardening uneven
   - Correction: more controlled shaping/treatment.
   - Hint: `boiled_leather.uneven`
   - Copy: *The thicker parts never took the treatment.*

3. Fastening weak
   - Correction: better straps/rivets/thread.
   - Hint: `boiled_leather.fastening`
   - Copy: *The fastening is the weak point.*

**Success:** unlock Boiled Leather armour.

---

## 14.3 Studded / Hardened Leather

**Solution key:** `armour.advanced_leather`

**Knowledge gate:** respective diagram.

**Required:** prior leather tier + metal/bone reinforcement as design dictates + upgraded stitching/frame.

### Failure precedence

1. Diagram missing
   - No explicit recipe answer.

2. Reinforcement tears through leather
   - Correction: distribute load/back reinforcement.
   - Hint: `leather.reinforcement_tears`
   - Copy: *The seam tears before the material does.*

3. Reinforcement too heavy for base
   - Correction: heavier/thicker Leather tier.
   - Hint: `leather.base_too_light`
   - Copy: *The edge needs something behind it.*

**Success:** unlock relevant tier.

---

## 14.4 Ring Mail

**Solution key:** `armour.ring_mail`

**Result:** Ring Mail

**Knowledge gate:** Smelting/Iron + diagram.

**Required:** iron rings + leather/cloth support + assembly.

### Failure precedence

1. Rings too soft/open
   - Correction: stronger/closed rings.
   - Hint: `mail.rings_open`
   - Copy: *The links spread under strain.*

2. No underlayer/support
   - Correction: use quilted/leather backing as specified.
   - Hint: `mail.needs_underlayer`
   - Copy: *The weight hangs from too few points.*

3. Assembly pattern poor
   - Correction: denser/valid weave.
   - Hint: `mail.pattern`
   - Copy: *The weave opens under strain.*

**Success:** unlock Ring Mail.

---

## 14.5 Riveted Chain / Splinted Mail

**Solution key:** `armour.advanced_mail`

**Knowledge gate:** respective diagram + improved metalworking.

**Required:** prior mail tier + wire/rivets/splints.

### Failure precedence

1. Diagram missing
   - no direct recipe hint.

2. Rivets fail
   - Correction: stronger/consistent riveting.
   - Hint: `mail.rivets_weak`
   - Copy: *The fastening is the weak point.*

3. Splints concentrate load
   - Correction: distribute/overlap properly.
   - Hint: `mail.splints_load`
   - Copy: *The seam carries all the strain.*

**Success:** unlock respective mail tier.

---

## 14.6 Half-Plate / Full Plate

**Solution key:** `armour.plate`

**Knowledge gate:** Steelworking + respective diagram.

**Required:** shaped Steel plates + underlayer/mail foundation + straps/rivets + fitting.

### Failure precedence

1. Steelworking/diagram missing
   - no explicit recipe answer.

2. Plate formed but cannot articulate
   - Correction: segment/joint design.
   - Hint: `plate.articulation`
   - Copy: *It protects one position and traps the next.*

3. Straps/fasteners weak
   - Correction: stronger leather/buckles/rivets.
   - Hint: `plate.fasteners`
   - Copy: *The fastening is the weak point.*

4. No proper underlayer
   - Correction: quilted/mail layer as required.
   - Hint: `plate.underlayer`
   - Copy: *The weight has nowhere to spread.*

5. Poor fit
   - Correction: refit/shaping.
   - Hint: `plate.fit`
   - Copy: *The protection is there, but movement is wrong.*

**Success:** unlock the appropriate plate tier.

---

# 15. Gear — tools

## 15.1 Skinning Knife

**Solution key:** `tool.skinning_knife`

**Required:** small keen blade + comfortable grip + fine edge.

### Failure precedence

1. Blade too heavy/coarse
   - Correction: smaller/finer blade.
   - Hint: `skinning.too_heavy`
   - Copy: *The cut is wrong for the job.*

2. Edge not keen enough
   - Correction: sharpen better.
   - Hint: `skinning.edge`
   - Copy: *The edge would not hold.*

**Success:** unlock Skinning Knife.

---

## 15.2 Woodcutter's Axe

**Solution key:** `tool.wood_axe`

**Required:** shaped axe head + reinforced haft + secure wedge/binding.

### Failure precedence

1. Head too soft
   - Correction: better metal/tier.
   - Hint: `axe.head_soft`
   - Copy: *The edge folds instead of biting.*

2. Haft weak
   - Correction: stronger Deadwood/haft.
   - Hint: `axe.haft_weak`
   - Copy: *The handle gives before the head does.*

3. Head fastening weak
   - Correction: better fit/wedge/binding.
   - Hint: `axe.fastening`
   - Copy: *The fastening is the weak point.*

**Success:** unlock Woodcutter's Axe.

---

## 15.3 Pick

**Solution key:** `tool.pick`

**Required:** metal head + strong haft + secure assembly.

### Failure precedence

1. Point too blunt
   - Correction: forge sharper/harder point.
   - Hint: `pick.blunt`
   - Copy: *The point glances instead of biting.*

2. Haft/fitting weak
   - Correction: reinforce.
   - Hint: `pick.fastening`
   - Copy: *The fastening is the weak point.*

**Success:** unlock Pick.

---

# 16. Gear — charms

Charm crafting is deliberately mundane and should use fictional game properties rather than occult/magical recipe logic.

## 16.1 Stillstone

**Solution key:** `charm.stillstone`

**Result:** Stillstone

**Required:** smooth stone + cord + finishing/handling step defined by game recipe.

### Failure precedence

1. Stone too rough/large
   - Correction: shape/smooth appropriate stone.
   - Hint: `stillstone.shape`
   - Copy: *Too coarse to sit comfortably in the hand.*

2. Cord weak
   - Correction: better Cord.
   - Hint: `stillstone.cord`
   - Copy: *The fastening is the weak point.*

**Success:** unlock Stillstone and Still Breath aptitude availability.

---

## 16.2 Veil Sachet

**Solution key:** `charm.veil_sachet`

**Result:** Veil Sachet

**Required:** Veilspore + cloth sachet + secure closure.

### Failure precedence

1. Veilspore used loose
   - Correction: contain it in cloth sachet.
   - Hint: `veil.needs_container`
   - Copy: *The useful part is there, but it will not stay where it is needed.*

2. Cloth too open/weak
   - Correction: finer/stronger cloth.
   - Hint: `veil.cloth_weak`
   - Copy: *The weave opens under strain.*

3. Closure poor
   - Correction: secure cord/thread.
   - Hint: `veil.closure`
   - Copy: *The fastening is the weak point.*

**Success:** unlock Veil Sachet / Veil Skip.

---

## 16.3 Ash Pouch

**Solution key:** `charm.ash_pouch`

**Result:** Ash Pouch

**Required:** prepared Ash + pouch + closure.

### Failure precedence

1. Ash contaminated/coarse
   - Correction: sift/refine.
   - Hint: `ash_pouch.dirty_ash`
   - Copy: *The useful part is there, but contaminated.*

2. Pouch leaks
   - Correction: tighter weave/stitching.
   - Hint: `ash_pouch.leaks`
   - Copy: *The weave opens under strain.*

**Success:** unlock Ash Pouch / Root Ash.

---

## 16.4 Emberleaf Cord

**Solution key:** `charm.emberleaf_cord`

**Result:** Emberleaf Cord

**Required:** Emberleaf + Tallow + Cord; controlled binding/infusion.

### Failure precedence

1. Raw fat used instead of Tallow
   - Correction: render first.
   - Hint: `emberleaf.tallow_unprepared`
   - Copy: *The mixture separates as it warms.*

2. Emberleaf not prepared
   - Correction: bruise/process according to game recipe.
   - Hint: `emberleaf.prepare`
   - Copy: *The useful part is still trapped inside.*

3. Cord does not take mixture
   - Correction: prep/apply controlled carrier.
   - Hint: `emberleaf.cord_absorption`
   - Copy: *The coating sits on the surface and flakes away.*

**Success:** unlock Emberleaf Cord / Short Burst.

---

## 16.5 Passive charms

Passive charm solutions follow the same pattern:

| Charm | Required core materials | Main blockers |
|---|---|---|
| Deep-Lung Token | carved bone + Cord | bone too brittle; attachment weak |
| Ward Fetish | Silver + dried herb | metal unworked; herb wet/unprepared; binding weak |
| Warm Fetish | Fur + Sinew | fur poorly prepared; sinew weak; bulk/binding poor |
| Porter's Strap | Leather + Buckle | leather uncured; buckle weak; stitching/load distribution poor |
| Steady Cord | Sinew + Bone | sinew unprepared; bone too coarse; binding poor |

Exact numerical passive strength comes from hidden quality, not recipe identity.

---

# 17. Poisons — fictional game solution rules

All poison discovery must remain **fictional/game-system specific**. Do not translate these into real-world toxicology instructions, concentrations, or practical harmful procedures.

## 17.1 Weakening Coat

**Solution key:** `poison.weakening_coat`

**Result:** Weakening Coat

**Knowledge gate:** Advanced Apothecary.

**Required:** Gravecap game reagent + oil carrier + fictional preparation state.

### Failure precedence

1. Poison material not identified
   - Correction: identify Gravecap's poisonous property first.
   - Hint: `poison.unknown_material`
   - Copy: *The smell changes when bruised.*

2. No carrier
   - Correction: use game oil carrier.
   - Hint: `poison.needs_carrier`
   - Copy: *It beads on the blade instead of clinging.*

3. Mixture too thin/thick
   - Correction: rebalance per game recipe.
   - Hint: `poison.consistency`
   - Copy: *Too thin to stay on the edge.* / *Too thick to spread evenly.*

4. Heated too strongly
   - Correction: use the game's low/no-heat process.
   - Hint: `poison.heat_loss`
   - Copy: *It loses strength when heated.*

**Success:** unlock Weakening Coat.

---

## 17.2 Necrotic Coat

**Solution key:** `poison.necrotic_coat`

**Result:** Necrotic Coat

**Knowledge gate:** Advanced Apothecary.

**Required:** Palecap + game mordant/binder (`alum` as fictionalised game reagent) + carrier.

### Failure precedence

1. Palecap not identified as poison material
   - Correction: identify property first.
   - Hint: property clue only.

2. No binder/carrier
   - Correction: use correct game binder/carrier.
   - Hint: `necrotic.wont_cling`
   - Copy: *The active part separates from the carrier.*

3. Coating damages/dulls blade
   - Correction: improve preparation/balance.
   - Hint: `necrotic.dulls_blade`
   - Copy: *The mixture dulls the blade before it harms anything else.*

**Success:** unlock Necrotic Coat.

---

## 17.3 Sedative Draught / Poisoned Bait

**Solution keys:** `poison.sedative_draught`, `poison.poisoned_bait`

Use only fictional game items such as Duskflower/poison caps.

### Failure precedence

1. Smell too obvious
   - Correction: use a compatible bait/carrier in game.
   - Hint: `bait.smell_obvious`
   - Copy: *The mixture is obvious to anything with a nose.*

2. Mixture runs off bait
   - Correction: improve carrier/absorption.
   - Hint: `bait.runs_off`
   - Copy: *The liquid runs off instead of soaking in.*

3. Heat destroys effect
   - Correction: use uncooked/cool preparation as defined by game recipe.
   - Hint: `bait.heat_loss`
   - Copy: *Whatever was useful cooked away.*

**Success:** unlock appropriate game item.

---

## 17.4 Choking Smoke

**Solution key:** `poison.choking_smoke`

**Result:** Choking Smoke deployable

**Required:** fictional game smoke reagent + smoulderable carrier/fuel.

### Failure precedence

1. Burns too clean
   - Correction: use smouldering carrier.
   - Hint: `smoke.burns_clean`
   - Copy: *It burns too cleanly.*

2. Too damp
   - Correction: dry carrier.
   - Hint: `smoke.too_damp`
   - Copy: *Too damp to keep burning.*

3. Smoke disperses too quickly
   - Correction: change game composition/deployment method.
   - Hint: `smoke.disperses`
   - Copy: *The smoke rises too quickly to linger.*

**Success:** unlock Choking Smoke.

---

# 18. Discovery fragments, diagrams and taught knowledge

Not every solution is experimentable.

## 18.1 Diagram-only examples

These should **not** be brute-forced through random ingredient experiments:

- high-end weapon branches;
- Full Plate patterns;
- complex trap mechanisms where design wants exploration gating;
- selected advanced charms;
- rare Monastery upgrades.

Near-miss attempts may reveal that the player lacks knowledge, but must not leak the exact missing diagram.

Allowed note:

> *The materials are good. The shape is beyond what you know.*

Do not reveal:

> *Find the Full Plate Diagram in Rotwood segment 3.*

## 18.2 Fragment behaviour

A Recipe Fragment may:

- reveal an inferred Journal silhouette;
- unlock H1/H2 hint strength for a recipe family;
- expose one process requirement without granting the full recipe;
- convert a completely hidden branch into a visible grey node.

It should not necessarily unlock success immediately.

## 18.3 Keeper teaching

Keeper teaching may:

- grant a full recipe;
- grant a discovery branch/milestone;
- raise hint strength across a family.

Examples:

- teach Brewing;
- teach Tanning;
- teach the principle of Distilling;
- teach a specific charm pattern.

---

# 19. Quality failures vs recipe failures

A valid recipe can still produce a poor result.

Do not treat these as discovery blockers.

Examples:

- watery stew;
- weak tincture;
- dull blade;
- loose stitching;
- rough leather;
- brittle cord.

The Journal may record quality observations such as:

- *The edge is right, but soft.*
- *The broth came together, but weak.*
- *The stitching holds, though barely.*

But the recipe remains **Known**.

Quality is influenced by:

- input quality;
- ingredient preparation;
- optional supporting ingredients;
- hidden Model C roll.

The player sees descriptive result names/effects, never quality numbers.

---

# 20. Failure precedence examples

## Example A — Ash Tea

Attempt:

```text
Ashbloom + Foul Water, no heat
```

Detected blockers:

- bad water;
- no heat.

Winner: **bad water**.

Award: `ash_tea.clean_water`.

After player switches to Clean Water but still uses no heat:

Winner: **no heat**.

Award: `ash_tea.needs_heat`.

Then success.

## Example B — Jerky

Attempt:

```text
Very thick raw meat + salt + strong open fire
```

Detected blockers:

- cut too thick;
- heat too fierce.

Winner: **cut too thick** because preparation precedes process.

After thin slicing, same strong fire:

Winner: **heat too fierce / outside hardens too fast**.

Then success with controlled drying.

## Example C — Iron Knife

Attempt:

```text
Iron Ore + Haft at Workbench
```

Detected blockers:

- ore is unrefined;
- wrong station.

Winner: **metal unprepared**.

Once Iron Ingot is used at Workbench:

Winner: **wrong station**.

Then player moves to Forge.

## Example D — Charcoal

Attempt:

```text
Deadwood on open fire
```

Result is Ash, not Charcoal.

Award: `charcoal.low_air`.

The failure produces a real by-product, teaching the player that simple burning is the wrong process.

---

# 21. Generic failure-key families

Where possible, implementation should reuse semantic families while keeping stable keys recipe-specific.

| Family | Meaning |
|---|---|
| `.bad_water` | liquid contamination/quality blocker |
| `.needs_heat` | heat absent/insufficient |
| `.too_hot` | overheat/scorch/quality destruction |
| `.needs_time` | process stopped early |
| `.too_wet` | too much moisture to set/preserve |
| `.too_dry` | insufficient liquid/flexibility |
| `.wont_bind` | missing binder/structure |
| `.needs_carrier` | active ingredient lacks medium |
| `.material_unprepared` | wrong refinement/preparation state |
| `.wrong_station` | station/process mismatch |
| `.fastening` | structural join weak |
| `.contaminated` | dirt/impurity prevents process |
| `.diagram_gate` | knowledge missing; no explicit solution hint |

The stable persisted key should still be recipe-specific, e.g. `ash_tea.needs_heat`, not merely `needs_heat`.

---

# 22. Server evaluation pseudocode

```text
EvaluateExperiment(player, station, inputs, process):
    candidates = FindCandidateSolutions(station, inputs)

    if candidates.empty:
        return Failure(no_hint)

    solution = BestIntentMatch(candidates)

    if !KnowledgeGateAllowsAttempt(solution, player):
        return Failure(solution.gated_feedback_or_none)

    failures = EvaluateOrderedFailureRules(solution, player, station, inputs, process)

    for failure in failures by priority:
        if !player.knows_hint(failure.hint_key):
            ApplyFailureConsumption(failure)
            PersistHint(player, failure.hint_key)
            InferJournalNodeIfAllowed(solution)
            return Failure(failure.hint_key)

    if failures not empty:
        ApplyFailureConsumption(failures[0])
        return Failure(no_new_hint)

    result = Craft(solution)
    PersistDiscovery(player, solution.solution_key, KNOWN)
    RevealJournalResult(solution)
    return Success(result)
```

`BestIntentMatch` must be conservative. It should prefer a recipe only when the player's ingredients/process plausibly express that intent.

---

# 23. Data separation

The implementation should keep these separate:

## Static solution definition

What the world knows:

- recipe rules;
- allowed stations;
- blockers;
- hint mappings;
- result identity;
- gate requirements.

## Player discovery state

What this Remnant knows:

- inferred recipe node;
- learned hint keys;
- known recipe;
- known material properties;
- known linked uses.

## Runtime attempt

What just happened:

- station;
- inputs;
- input states;
- process choices;
- matched candidate;
- winning blocker;
- consumed/returned materials.

Do not bake player discovery into item templates or Lua SavedVariables.

---

# 24. Audit checklist for every new recipe

Before adding a new discoverable craft, answer all of these:

1. Is it **experimentable, fragment-gated, diagram-gated, or taught**?
2. What establishes player **intent** strongly enough to enter this recipe family?
3. What is the exact successful input/process truth?
4. Which preparation states matter?
5. What are the ordered blockers?
6. Which blocker wins when two are wrong?
7. Which hint key maps to each blocker?
8. Is each hint vague enough not to print the answer?
9. What does failure consume?
10. What by-product, if any, is created?
11. What Journal node becomes inferred?
12. What becomes Known on success?
13. What material entries gain linked uses?
14. Can the recipe be accidentally brute-forced too cheaply?
15. Does a random unrelated attempt correctly produce no knowledge?

If these answers are missing, the recipe is not ready for implementation.

---

# 25. Locked decisions

- `JOURNAL-HINTS.md` is **player-facing copy canon**.
- This file is **solution/logic canon**.
- Every persistent hint must map to a real failure condition and a real correction.
- The server evaluates **one highest-priority meaningful blocker** per failed attempt.
- One attempt normally teaches **at most one new hint**.
- Random ingredient spam produces no useful knowledge.
- Diagram-only content cannot be bypassed by experimentation.
- Quality failures do not erase recipe discovery.
- Failure consumption is type-specific; experimentation should cost something but not become punitive save-scumming.
- Poison rules remain fictional game abstractions and must not become real-world toxicology instructions.
- Recipe success, hints and inferred nodes are all persisted server-side.

---

## Related

- [JOURNAL-HINTS.md](JOURNAL-HINTS.md) — approved player-facing near-miss copy
- [JOURNAL-RECORD.md](JOURNAL-RECORD.md) — Journal discovery architecture
- [JOURNAL-CONTENT.md](JOURNAL-CONTENT.md) — Journal content map
- [CRAFTING.md](CRAFTING.md) — discovery tree, stations and recipe catalogue
- [ITEMS.md](ITEMS.md) — made/found items
- [MATERIALS.md](MATERIALS.md) — raw inputs
- [GEAR.md](GEAR.md) — gear trees and upgrade gates
