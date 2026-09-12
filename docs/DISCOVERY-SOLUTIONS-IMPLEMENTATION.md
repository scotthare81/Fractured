# Discovery evaluator — implementation contract

This companion to [DISCOVERY-SOLUTIONS.md](DISCOVERY-SOLUTIONS.md) translates the design into an implementation shape suitable for AzerothCore.

The purpose is to stop recipe logic, Journal copy and UI state from becoming tangled.

---

## 1. Separation of concerns

### Server recipe evaluator
Owns:

- recipe eligibility;
- prerequisite knowledge;
- station/process validation;
- ingredient-role matching;
- ingredient-state validation;
- blocker precedence;
- candidate ranking;
- success/failure;
- hidden quality result;
- discovery awards;
- persistent hint awards.

### Journal/discovery persistence
Owns:

- known recipes;
- inferred recipe nodes;
- learned material properties;
- learned hint keys;
- diagram/fragment/keeper unlocks;
- timestamps and optional observation payloads.

### ThalvaethUI
Owns only:

- displaying safe state sent by server;
- silhouettes and masked nodes;
- tabs/categories;
- approved hint copy;
- experiment input UI if/when built.

The addon must never decide that a recipe is valid.

---

## 2. Functional ingredient roles

Recipe matching should avoid hardcoding every recipe as one exact unordered list of item IDs.

Useful roles include:

```text
food.meat
food.fish
food.root
food.grain
food.fat
water.raw
water.clean
preservative.salt
carrier.fat
carrier.liquid
binder.thread
binder.cord
textile.cloth
textile.padding
hide.raw
hide.cured
fuel.wood
fuel.charcoal
metal.iron
metal.steel
metal.copper
metal.tin
wood.haft
herb.medicinal
herb.ashbloom
fungus.poison
trap.trigger
trap.anchor
```

An item may expose several internal roles after its properties are known.

Role matching lets a future district add equivalent materials without cloning recipe logic.

---

## 3. Ingredient state flags

Recipe inputs may carry state requirements such as:

```text
clean
foul
raw
cooked
dried
fresh
spoiled
crushed
milled
rendered
fermented
identified
refined
```

State belongs to the server-side item/process model, not tooltip text.

---

## 4. Candidate recipe selection

Pseudo-flow:

```text
EvaluateExperiment(player, station, process, inputs):
    candidates = FindCandidates(station, process, inputs)

    candidates = candidates where NearMissMinimum(candidate, inputs)

    if candidates empty:
        return NoKnowledge

    score each candidate by:
        gate eligibility
        core role coverage
        process similarity
        station similarity
        ingredient state similarity
        correction distance

    best = highest deterministic score

    if Success(best):
        result = Craft(best)
        AwardRecipeDiscovery(best)
        AwardLinkedKnowledge(best)
        return Success(result)

    blocker = FirstUnknownFailedBlocker(best)

    if blocker exists:
        AwardHint(blocker.hint_key)
        AwardInferenceIfConfigured(best)
        return NearMiss(blocker.hint_key)

    return KnownFailureNoNewKnowledge
```

Tie-breaking must be stable so identical experiments do not oscillate between unrelated hints.

---

## 5. Blocker model

A blocker should have:

```text
key
priority
predicate
hint_key_weak
hint_key_focused
hint_key_strong
required_prior_knowledge[]
correction_tag
```

Example:

```text
blocker = {
  key = "clean_water",
  priority = 20,
  predicate = inputs.has_role("water.clean"),
  hint_key_weak = "ash_tea.water_fouled",
  hint_key_focused = "ash_tea.clean_water",
  correction_tag = "replace_liquid_with_clean_water"
}
```

The correction tag is implementation-facing and never shown to the player.

---

## 6. Gate model

```text
NONE
BORN_KNOWN
SOFT_DISCOVERY
HARD_FRAGMENT
HARD_DIAGRAM
HARD_KEEPER
MILESTONE
```

### Soft discovery

Can be solved through experimentation. Notes/fragments accelerate it.

### Hard gate

Experiments may infer that a hidden node exists, but cannot produce the recipe result until the unlock is owned.

This distinction must be enforced server-side before candidate success evaluation.

---

## 7. Hint escalation

For a blocker with three approved hint levels:

```text
weak → focused → strong
```

Escalation can occur when:

- the weaker key is already learned;
- prerequisite property knowledge increased;
- the new attempt is objectively closer to the solution.

It should **not** escalate merely because the player repeated the same exact failure.

Recommended rule:

```text
same input fingerprint + same blocker = no escalation
meaningfully improved fingerprint + same blocker = may escalate one level
```

---

## 8. Experiment fingerprint

Store or derive a normalized experiment fingerprint for spam control:

```text
station
process
sorted input roles/items
input states
major process parameters bucketed into broad bands
```

Do not persist every exact numeric value forever. The purpose is simply to distinguish a genuinely improved attempt from identical spam.

---

## 9. Persistence namespaces

Recommended generic discovery keys:

```text
recipe:<key>
hint:<key>
material:<key>:identified
material:<key>:property:<property>
gear:<key>:inferred
gear:<key>:known
gate:<key>
```

Creature observations can remain in their specialized journal table.

---

## 10. Linked knowledge awards

A successful discovery may atomically award related safe knowledge.

Examples:

- Charcoal → infer Forge branch + filtration branch.
- Cured Hide → reveal Leather as a known material/use.
- Iron Ingot → infer first metal blade/tool nodes.
- Ash Tea → mark Ashbloom known use `medicine`.
- Smoked Fish → mark identified fish known use `preservation`.

Linked awards must never reveal a hard-gated recipe name unless its inference policy allows that silhouette/node.

---

## 11. Failure result types

Use explicit result classes rather than a generic false:

```text
SUCCESS
NEAR_MISS_NEW_HINT
NEAR_MISS_KNOWN_HINT
NO_RELEVANT_RECIPE
HARD_GATE_BLOCKED
INVALID_STATION
INVALID_PROCESS
UNSAFE_ATTEMPT
```

Player-facing output can collapse several classes into subtle flavour while telemetry/logging remains precise.

---

## 12. Quality evaluation

Quality runs **after success**.

Conceptual inputs:

```text
input quality
freshness
station quality/upgrades
process control
known recipe bonus (optional; not XP)
material suitability
```

Output remains hidden Model C quality.

Quality must not make the recipe matcher say a valid recipe failed.

---

## 13. Test matrix requirement

Every live recipe should have automated or scripted tests for:

1. exact success;
2. each blocker individually;
3. two simultaneous blockers to prove precedence;
4. repeated identical near miss to prove no duplicate hint;
5. improved attempt to prove escalation/next blocker;
6. random unrelated inputs to prove no useful hint;
7. hard-gated correct ingredients to prove no progression skip;
8. successful low-quality input path;
9. Journal discovery persistence after relog/reload sync.

---

## 14. Example test — Ash Tea

```text
Given Brewing known
And Ash Tea unknown

Foul Water + Ashbloom + heat
→ fail clean_water blocker
→ award ash_tea.clean_water

Repeat identical attempt
→ no new hint

Clean Water + Ashbloom without heat
→ fail extraction_heat blocker
→ award ash_tea.needs_heat

Clean Water + Ashbloom + controlled heat
→ success Ash Tea
→ discover recipe.med.ash_tea
→ record Ashbloom medicine use
```

---

## 15. Example test — Charcoal hard progression role

```text
Deadwood + open fire
→ Ash
→ award low-air hint

Deadwood + low-air pit, too short
→ award time hint

Deadwood + low-air pit + duration
→ Charcoal success
→ gate:charcoal known
→ Forge branch inference appears
→ filtration branch inference appears
```

---

## 16. Example test — masterwork weapon

```text
Player owns all physical materials
But masterwork diagram unknown

Exact material attempt at Forge
→ HARD_GATE_BLOCKED
→ may reveal silhouette only if inference_allowed
→ never crafts masterwork weapon
→ no exact recipe answer revealed
```

---

## 17. Logging for tuning

Development logs should capture:

```text
player (dev-safe identifier)
recipe candidate
candidate score
failed blocker
hint awarded
input fingerprint hash
result class
```

This will make it possible to see whether players are getting nonsense candidates/hints without exposing hidden logic in the client.

---

## 18. Definition of done for the evaluator

The system is ready for content authoring when:

- recipes are data-driven enough that new recipes do not require bespoke UI logic;
- blocker precedence is deterministic;
- hint keys map to real corrections;
- duplicate hint spam is impossible;
- hard gates cannot be bypassed;
- success and quality are separate;
- full Journal state survives relog/reload;
- tests cover simultaneous failures and ambiguous candidates.
