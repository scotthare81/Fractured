# Journal v1 playable slice

This document defines the **first implementation slice** of the Journal Record. It is intentionally smaller than the full canon.

The goal is to prove the discovery loop end-to-end:

**encounter → infer → experiment → fail intelligently → learn a hint → succeed → persist → reload → still know it**

If this slice is satisfying and technically stable, expand from it. Do not implement the entire catalogue first.

Related:

- [JOURNAL-RECORD.md](JOURNAL-RECORD.md)
- [JOURNAL-IMPLEMENTATION-SPEC.md](JOURNAL-IMPLEMENTATION-SPEC.md)
- [JOURNAL-UI-SPEC.md](JOURNAL-UI-SPEC.md)
- [DISCOVERY-SOLUTIONS.md](DISCOVERY-SOLUTIONS.md)
- [JOURNAL-HINTS.md](JOURNAL-HINTS.md)

---

## 1. Slice objectives

The first playable Journal must prove all of these systems:

- server-authoritative persistence;
- full login/reload sync;
- generic discovery states;
- three-tab UI shell;
- creature Unknown/Sighted/Engaged;
- Survival known/inferred/known-after-success;
- persistent near-miss hints;
- one-hint-per-attempt behaviour;
- material property/use knowledge;
- one gear branch with obscured sibling topology;
- diagram-gated content that cannot be brute-forced;
- restrained update notifications.

If a feature does not help prove one of these, it is probably outside this slice.

---

## 2. Explicitly out of scope

Do not include in the first slice:

- full item catalogue;
- every herb/fungus;
- every recipe;
- full poison tree;
- all fish species;
- full armour ladder;
- all charm variants;
- final bespoke notebook artwork;
- global search;
- achievement/completion tracking;
- fancy footprint inventory;
- full crafting-station redesign;
- multiplayer sharing;
- account-wide discoveries.

Character-specific only.

---

# Creatures slice

## 3. Required creature entries

Implement Journal behaviour for these four first:

| Entry | Name | Why included |
|---:|---|---|
| 90001 | Ash Sleeper | tests Sighted + special observed behaviour |
| 90002 | Cellar Scavenger | basic fodder baseline |
| 90004 | Ash Caller | tests observed ability/event behaviour |
| 90006 | Broken Snare | tests distinctive ability discovery |

The remaining 90001–90010 catalogue may continue using existing plumbing, but polished v1 UI acceptance focuses on these four.

---

## 4. Creature discovery cases

### Ash Sleeper

Unknown:

- silhouette;
- masked name.

Sighted:

- Ash Sleeper;
- sighted prose.

Engaged/observed:

- vitality band;
- `Wakes swinging` only after witnessed.

### Cellar Scavenger

Sighted:

- identity + prose.

Engaged:

- vitality band;
- simple attack observation if ability capture is wired.

### Ash Caller

Observed ability target:

- `Shrieks for help` after actual shriek is witnessed.

### Broken Snare

Observed ability target:

- `Throws a hook` after hook is witnessed.

---

## 5. Creature acceptance

Pass if:

1. New character sees masked creature entries.
2. Mouseover/target within valid range promotes Sighted server-side.
3. Engage promotes Engaged.
4. Ability does not show before observation.
5. Ability appears after observation.
6. Relog preserves all states.
7. `/reload` reconstructs all states from server snapshot.

---

# Survival slice

## 6. Born-known entries

The Remnant starts knowing only enough not to be stranded.

Required born-known Journal records:

- Campfire Roast
- Crude Boil
- Crude Bandage
- Firestart
- Crude Butcher

These appear as known entries from first login.

They are not discovered through experimentation.

---

## 7. Core experimental recipe: Ash Tea

Ash Tea is the primary end-to-end discovery test because it touches material knowledge, water quality, process, hints, success and Infection-related survival.

### Initial state

Ash Tea itself is not known.

Once Ashbloom has been identified/collected, an **inferred preparation** may become visible:

```text
[grey bottle]
— — —

Ashbloom
+ ???
```

### Failure path A — bad water

Attempt concept:

```text
Ashbloom + Foul Water
```

Expected:

- fail;
- partial/full consumption according to solution matrix;
- grant hint `ash_tea.clean_water` if not known;
- Journal shows field note equivalent to:
  - `The water needs to be cleaner.`

### Failure path B — no heat / wrong process

Attempt:

```text
Ashbloom + Clean Water
```

without the required heat/process.

Expected:

- fail;
- grant `ash_tea.needs_heat` if appropriate and previous blocker no longer applies;
- Journal adds heat/process note.

### Success

Correct preparation resolves silhouette into:

**Ash Tea**

Journal shows:

- actual name;
- Ashbloom;
- Clean Water;
- required heat/process;
- qualitative effect: `Eases Infection`;
- previously learned field notes retained.

### Ash Tea acceptance

- exact same failed attempt does not create duplicate hint;
- one failed attempt does not grant both water + heat hints simultaneously;
- success persists after relog;
- success reveals linked Ashbloom use.

---

## 8. Water progression

Required entries:

- Foul Water material state;
- Crude Boil — known at start;
- Clean/Drinkable Water result;
- Charcoal Filtration — inferred/locked until Charcoal process knowledge.

The first slice does not need full distillation.

### Required discovery behaviour

Before Charcoal:

```text
Foul Water → Boil → Drinkable Water
Foul Water → [grey process] → ???
```

After Charcoal discovery:

- filtration process can become identifiable/experimentable according to solution matrix;
- unknown branch resolves only after actual discovery.

---

## 9. Charcoal process

Charcoal is included because it is a major tech gate and excellent hint test.

### Initial state

Unknown process.

Deadwood is known as fuel/material.

### Near miss

Burning Deadwood in open fire should teach something like:

> It burned through to ash. Too much air.

Expected persistent hint key from solution canon.

### Success

Correct low-air char process unlocks:

- Charcoal material/process knowledge;
- linked filtration inference;
- future forge branch inference.

Do not implement full metalworking just because Charcoal reveals it.

---

## 10. Medicine: Stitch path

Required known/inferred records:

- Crude Bandage — known at start;
- Stitch Kit — initially inferred after meaningful wound-care knowledge/material contact;
- one cleanliness-related hint;
- one binding/strength-related hint.

The slice only needs enough to prove multiple blockers can exist and precedence chooses one.

Example precedence:

1. dirty material/wound cleanliness blocker;
2. insufficient structural closure;
3. success.

Do not dump both hints at once.

---

## 11. Herbs & fungi: two materials

Implement two contrasting entries:

### Ashbloom

Knowledge progression:

- identified;
- medicinal property inferred/known;
- Ash Tea use becomes known after recipe success.

### Gravecap

Knowledge progression:

- identified;
- property initially unknown;
- poisonous property learned through authored safe/game-specific discovery route;
- one obscured future use silhouette.

Do **not** implement the full poison recipe tree in the slice.

This proves material identity and material property are separate states.

---

## 12. Fishing slice

Implement one method + one catch.

Required:

- Crude Fishing Line / simple rod method;
- one catch, recommended **Eel**;
- Grilled Fish known after simple cook;
- one inferred preservation/use silhouette such as smoked fish or oil.

Acceptance:

- catching Eel identifies the catch;
- catching it does not automatically reveal every use;
- cooking can reveal one use;
- another use remains grey.

---

## 13. Traps/fieldcraft slice

Implement only **Snare** for Journal discovery.

Required states:

- inferred after Cordage knowledge;
- one trigger/anchor near-miss hint;
- successful discovery reveals construction/method.

No need for jaw traps, pits, nets, alarms in first slice.

---

# Gear slice

## 14. Weapon tree

Required nodes:

```text
Crude Dagger
    │
Iron Knife
    │
Steel Blade
   / \
[dual-wield node]   [2H node]
```

Recommended first branch nodes:

- **Paired Daggers** or Fighting Daggers
- **Greatsword** or War Cleaver

Exact player-facing choice should match current `GEAR.md` canon.

---

## 15. Weapon knowledge rules

### Crude Dagger

Known at start.

### Iron Knife

Can become inferred when Forge/iron process becomes available.

### Steel Blade

Locked behind steelworking/process knowledge.

### Branch nodes

At least one should be **diagram-gated**.

This is important: the player may see two grey branch silhouettes, acquire one diagram, and reveal only that side.

Example after diagram:

```text
Steel Blade
   / \
Greatsword   ???
```

The hidden sibling remains unresolved.

---

## 16. Armour tree

First slice needs only enough to prove vertical progression and class inference.

Required:

- Rag Armour — known at start;
- Quilted Coat — discoverable/known;
- Boiled Leather — one leather node;
- one grey heavier branch silhouette.

Do not implement full Mail/Plate recipe content yet unless already trivial.

---

## 17. Tool entry

Implement **Whetstone**.

Why:

- links materials to weapon upkeep;
- simple craft;
- demonstrates tool knowledge page;
- supports blade-maintenance identity.

Required:

- inferred from worn/dull blade context or Rough Stone handling;
- one preparation/material hint;
- successful recipe reveals `Sharpens blades`.

---

## 18. Charm entries

Implement two examples:

- **Stillstone** — aptitude charm;
- **Deep-Lung Token** — passive charm.

This proves active/passive charm presentation.

At least one charm can begin as inferred silhouette before identity/effect is learned.

The slice does not need every charm or charm quality upgrade.

---

# Hint coverage

## 19. Required hint families exercised in slice

The first slice must exercise at least these hint categories:

- liquid cleanliness/quality;
- heat/process;
- air/char process;
- binding/structure;
- cleanliness/contamination;
- trigger/anchor fieldcraft;
- preparation/grinding/shaping;
- diagram gate with **no hint leakage**;
- random-invalid **no useful information**.

This ensures the evaluator is generic rather than hard-coded only for Ash Tea.

---

## 20. Required no-information test

Attempt a nonsense combination of unrelated materials at an inappropriate station.

Expected:

- transient generic failure allowed;
- no inferred recipe node;
- no persistent hint;
- no secret candidate recipe selected;
- no ingredient consumption beyond explicitly designed trivial handling cost.

---

# UI slice

## 21. Required visual components

The first playable UI needs:

- Journal main frame;
- three top-level tabs;
- left navigation pane;
- right detail pane;
- category list for Survival/Gear;
- unknown silhouette row;
- inferred silhouette page;
- known page;
- Field Notes section;
- one gear branch renderer;
- unread ink-dot marker;
- loading/sync state.

No final custom art required.

---

## 22. Temporary assets

Allowed:

- generic creature silhouette;
- generic bottle/pot silhouette;
- generic blade silhouette;
- generic armour silhouette;
- generic charm silhouette.

Requirement: temporary assets must not accidentally reveal hidden identity.

---

# Protocol slice

## 23. Required messages

Minimum semantics:

```text
HELLO / READY
JOURNAL_BEGIN
DISCOVERY records
HINT records
CREATURE records
JOURNAL_END
incremental DISCOVERY/HINT/CREATURE updates
```

Names may differ in code; behaviour must match implementation spec.

---

## 24. Snapshot payload minimum

Must reconstruct:

- born-known recipes;
- learned recipes;
- inferred entries;
- material properties/uses;
- hint flags;
- gear nodes;
- creature tiers;
- observed creature abilities.

Unread UI marker state does not need server persistence.

---

# Persistence slice

## 25. Character isolation

Test with two characters on same account.

Character A discovers Ash Tea.

Character B must not inherit it unless future design explicitly changes discoveries to account-wide.

v1 is character-specific.

---

# Experiment costs

## 26. Failure stakes in slice

At least three failure-consumption classes must be tested:

- `none` — wrong setup caught before commitment;
- `partial` — fuel/common material/time lost;
- `full` — spoiled batch.

Do not introduce `hazard` class into the first slice unless already safe and trivial; it can wait for later poison content.

---

# Debug tooling

## 27. Required dev capabilities

Before content expansion, developers must be able to:

- dump a character's Journal state;
- grant/revoke a discovery;
- grant/revoke a hint;
- reset Journal state;
- force full snapshot;
- inspect experiment evaluator decision/blocker.

Without this, testing will become unnecessarily slow.

---

# End-to-end test scenarios

## 28. Scenario A — fresh Remnant

1. Create fresh character.
2. Open Journal.
3. Verify born-known Survival basics.
4. Verify unknown creature silhouettes.
5. Verify no Ash Tea name appears.
6. Verify Gear shows only appropriate known/inferred nodes.

Pass: no hidden answers leak.

---

## 29. Scenario B — creature learning

1. Sight Ash Sleeper.
2. Journal updates identity/prose.
3. Do not wake it yet.
4. Verify wake ability absent.
5. Wake and survive opener.
6. Verify ability note added.
7. Relog.
8. Verify state persists.

---

## 30. Scenario C — Ash Tea deduction

1. Obtain/identify Ashbloom.
2. Attempt Ashbloom + Foul Water.
3. Receive one water-quality hint.
4. Repeat exact failure.
5. Receive no new hint.
6. Try Ashbloom + Clean Water without proper heat.
7. Receive heat hint.
8. Perform correct process.
9. Ash Tea resolves.
10. `/reload`.
11. Ash Tea remains known with earlier field notes.

---

## 31. Scenario D — random spam resistance

1. Combine unrelated materials.
2. Attempt at wrong station.
3. Verify no persistent hint.
4. Repeat with several random piles.
5. Verify no recipe silhouettes are inferred.

---

## 32. Scenario E — charcoal gate

1. Burn Deadwood openly.
2. Learn air/process hint.
3. Repeat; no duplicate hint.
4. Use correct low-air process.
5. Charcoal unlocks.
6. Filtration becomes inferable.
7. Forge-related future branch may become visible, but not auto-known.

---

## 33. Scenario F — diagram lock

1. Reach Steel Blade branch prerequisite.
2. See two inferred branch silhouettes.
3. Attempt correct-looking materials for diagram-gated branch without diagram.
4. Verify branch does not unlock and no answer-leaking hint appears.
5. Acquire diagram.
6. Branch resolves/recipe becomes available according to canon.
7. Sibling remains obscured.

---

## 34. Scenario G — character isolation

1. Character A learns Ash Tea + one gear node.
2. Character B logs in.
3. Verify B has neither discovery.
4. Character A logs back in.
5. Verify A still has both.

---

# Definition of done

## 35. Technical done

The v1 slice is technically done when:

- all seven scenarios above pass;
- no known persistence bugs;
- no duplicate hint bugs;
- no hidden-name wire/static-data leaks found in review;
- snapshot reliably reconstructs state after `/reload`;
- GM/debug tooling exists;
- experiment evaluator uses generic definitions rather than recipe-specific if/else sprawl.

---

## 36. Design done

The v1 slice is design-successful when playtesting answers **yes** to these:

- Do silhouettes create curiosity rather than annoyance?
- Are hints useful without giving recipes away?
- Does a failed experiment still feel like progress sometimes?
- Is success satisfying because the player reasoned it out?
- Does the Journal feel like learned field knowledge rather than a wiki?
- Does the Gear tree make unknown branches desirable without becoming a checklist?
- Does the player understand why a repeated identical failure stopped teaching them?
- Does the Journal remain readable without showing exact hidden maths?

If not, tune the model before authoring dozens more recipes.

---

## 37. Expansion order after slice approval

Once the slice is stable, expand in this order:

1. remaining current creature roster;
2. full basic Food/Water/Medicine set;
3. herbs/fungi and material-use graph;
4. fishing catalogue;
5. traps/fieldcraft;
6. full weapon/armour tree;
7. charms;
8. fictional poison branch;
9. advanced preservation/distilling/metalwork;
10. bespoke art and polish.

This order grows breadth only after the shared mechanics are proven.

---

## 38. Locked slice decisions

- First implementation is deliberately narrow.
- Ash Tea is the primary experiment/hint proving recipe.
- Charcoal is the primary process-gate proving discovery.
- Four creatures prove sight/engage/ability observation.
- One fishing catch, one trap, one tool and two charms are enough initially.
- Gear must include at least one visible unknown sibling branch and one diagram gate.
- Random spam resistance is an explicit acceptance test.
- Character isolation is explicit.
- Final artwork comes after the loop works.
