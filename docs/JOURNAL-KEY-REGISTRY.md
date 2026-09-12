# Journal key registry

This file is the canonical registry of stable Journal/discovery keys intended for the first implementation.

It exists to prevent different code paths from inventing slightly different identifiers for the same fact.

Rules:

- keys are lowercase ASCII;
- words use underscores;
- hierarchy uses dots;
- once shipped, keys are append-only contracts;
- player-facing renames do not rename keys;
- do not embed volatile DB IDs, item IDs, display IDs, or spell IDs in generic discovery keys.

---

## 1. Namespaces

| Namespace | Meaning |
|---|---|
| `recipe` | learned preparation / crafted result knowledge |
| `hint` | persistent near-miss learning |
| `material` | material identity, property, and use knowledge |
| `process` | milestone processes and production methods |
| `gear` | upgrade tree knowledge |
| `diagram` | explicit diagram/schematic acquisition where separate tracking is useful |

Creature entry/tier state remains in the specialised creature journal.

---

## 2. v1 Survival recipe keys

Born-known or early slice:

```text
recipe.crude_roast
recipe.crude_boil
recipe.crude_bandage
recipe.ash_tea
recipe.stitch_kit
recipe.grilled_fish
recipe.snare
recipe.whetstone
```

Reserved next-wave keys:

```text
recipe.stew
recipe.broth
recipe.jerky
recipe.smoked_meat
recipe.pemmican
recipe.porridge
recipe.bread
recipe.boiled_roots
recipe.salve
recipe.poultice
recipe.antiseptic_wash
recipe.styptic
recipe.fever_tincture
recipe.smoked_fish
recipe.fish_stew
recipe.resin_lure
```

---

## 3. v1 process keys

```text
process.firestart
process.charcoal
process.water_filter
process.tanning
process.cordage
process.smelting_iron
process.steelworking
```

Reserved:

```text
process.preservation
process.brewing
process.distilling
process.waterproofing
process.advanced_apothecary
process.alloying_bronze
process.trap_making
```

---

## 4. v1 material identity/property keys

### Ashbloom

```text
material.ashbloom.identity
material.ashbloom.medicinal
material.ashbloom.use.ash_tea
```

### Gravecap

```text
material.gravecap.identity
material.gravecap.poisonous
```

The first playable slice does **not** require unlocking a full poison formula from Gravecap; only layered material knowledge is needed.

### Charcoal

```text
material.charcoal.identity
material.charcoal.use.filter
material.charcoal.use.forge
```

### Generic early materials

```text
material.deadwood.identity
material.raw_meat.identity
material.raw_fish.identity
material.clean_water.identity
material.foul_water.identity
material.rags.identity
material.thread.identity
material.rough_stone.identity
material.iron.identity
material.steel.identity
```

Reserved material families can be added as authored; do not pre-seed every future material into code unless the static catalogue needs it.

---

## 5. Ash Tea hint keys

Canonical v1 chain:

```text
hint.ash_tea.clean_water
hint.ash_tea.needs_heat
```

Optional stronger/quality hints reserved for later:

```text
hint.ash_tea.overheated
hint.ash_tea.weak_extraction
```

The first implementation should prove the two-step chain before expanding.

---

## 6. Charcoal hint keys

Canonical v1 chain:

```text
hint.charcoal.low_air
hint.charcoal.needs_dry_wood
hint.charcoal.needs_time
```

Preferred first proof case is `low_air`: open burning produces ash and teaches that the process needs less air.

---

## 7. Stitching hint keys

```text
hint.stitch_kit.needs_thread
hint.stitch_kit.needs_clean_material
hint.stitch_kit.needs_stronger_binding
```

First slice only needs enough of this family to prove that Survival hints are not exclusive to brewing.

---

## 8. Water hint keys

```text
hint.water.boil_longer
hint.water.sediment_remains
hint.water.filter_too_coarse
hint.water.filter_bypass
```

`recipe.crude_boil` is born-known; these are later observations/process improvements, not blockers for initial survival.

---

## 9. Fishing hint keys

```text
hint.fishing.line_too_weak
hint.fishing.knot_slips
hint.fishing.hook_too_blunt
hint.fishing.smoke_too_hot
```

The v1 slice needs only one catch and one preparation path, but keys are reserved so copy and code remain consistent.

---

## 10. Snare / fieldcraft hint keys

```text
hint.snare.loop_too_slow
hint.snare.anchor_weak
hint.snare.trigger_too_heavy
hint.snare.trigger_too_sensitive
```

---

## 11. Whetstone hint keys

```text
hint.whetstone.grit_too_coarse
hint.whetstone.stone_too_soft
hint.whetstone.edge_wrong_angle
```

Only use hints that map to fictional/game abstractions; do not turn the Journal into detailed real-world weapon maintenance instruction.

---

## 12. v1 gear keys — weapons

```text
gear.weapon.crude_dagger
gear.weapon.iron_knife
gear.weapon.steel_blade
gear.weapon.greatsword
gear.weapon.twin_blades
```

Suggested v1 states:

- Crude Dagger: known at character start.
- Iron Knife: inferred/known through early metal progression.
- Steel Blade: inferred until steelworking/diagram conditions are met.
- Greatsword: one visible hidden branch that becomes known in the slice.
- Twin Blades: hidden sibling branch remains inferred/unknown depending on test scenario.

---

## 13. v1 gear keys — armour

```text
gear.armour.rag_armour
gear.armour.quilted_coat
gear.armour.boiled_leather
gear.armour.ring_mail
gear.armour.half_plate
```

Later:

```text
gear.armour.studded_leather
gear.armour.hardened_leather
gear.armour.riveted_chain
gear.armour.splinted_mail
gear.armour.full_plate
```

---

## 14. v1 gear keys — tools

```text
gear.tool.whetstone
gear.tool.skinning_knife
gear.tool.fishing_rod
```

Reserved:

```text
gear.tool.woodcutters_axe
gear.tool.pick
gear.tool.awl
gear.tool.saw
gear.tool.net
```

---

## 15. v1 gear keys — charms

```text
gear.charm.stillstone
gear.charm.deep_lung_token
```

Reserved current canon:

```text
gear.charm.veil_sachet
gear.charm.ash_pouch
gear.charm.emberleaf_cord
gear.charm.ward_fetish
gear.charm.warm_fetish
gear.charm.porters_strap
gear.charm.steady_cord
```

---

## 16. Diagram keys

Use separate diagram keys only where acquisition itself matters independently from the resulting gear knowledge.

V1 proof keys:

```text
diagram.weapon.greatsword
```

Reserved:

```text
diagram.weapon.twin_blades
diagram.armour.boiled_leather
diagram.armour.ring_mail
diagram.armour.half_plate
```

Granting a diagram may promote an associated `gear.*` node from inferred to known, but the two concepts are not identical.

---

## 17. Creature ability keys

These remain per-creature ability-map keys rather than generic discovery keys.

Current special examples:

```text
90001: wake_rake
90003: leap
90004: shriek
90005: stomp
90006: hook
90007: pace
```

Fodder may gain ability keys as observed-ability capture is expanded.

Never use raw spell IDs as the player-facing or protocol-facing ability identity.

---

## 18. Notification kinds

Stable wire/UI values:

```text
entry
hint
observation
```

These are not persistent discovery namespaces; they classify notification strength.

---

## 19. State integers

Generic discovery state values:

```text
1 = inferred
2 = known
3 = observed/deep-known
```

Do not define alternate state numbering in Lua and C++ independently. Put the values in one shared implementation contract and test them.

---

## 20. Reserved-key policy

A key listed as reserved is **not** automatically shipped content.

Reserved means:

- the identifier is claimed;
- future implementation should use it if that concept ships;
- current player state need not contain it;
- current UI need not expose its silhouette unless the relevant design says it should.

---

## 21. Key review checklist

Before adding a new key, confirm:

- Does an existing key already mean this?
- Is this a persistent fact or merely runtime state?
- Is it player knowledge rather than hidden server truth?
- Does it need its own independently queryable state?
- Will a player-facing rename leave the key valid?
- Is it free of volatile numeric IDs?
- Does it fit an existing namespace?

If those answers are unclear, do not ship the key yet.