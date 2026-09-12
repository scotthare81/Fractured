# Journal implementation specification

This document converts the Journal canon into an implementation contract. It defines ownership, persistence, discovery keys, state transitions, experiment evaluation, synchronisation, and the boundary between server truth and addon presentation.

It does **not** prescribe C++ class names or SQL DDL line-for-line. Those are implementation details. The behavioural contracts below are not.

Related canon:

- [JOURNAL-RECORD.md](JOURNAL-RECORD.md) — player-facing discovery model
- [JOURNAL-CONTENT.md](JOURNAL-CONTENT.md) — concrete v1 knowledge entries
- [JOURNAL-HINTS.md](JOURNAL-HINTS.md) — approved hint copy
- [DISCOVERY-SOLUTIONS.md](DISCOVERY-SOLUTIONS.md) — recipe truth and failure precedence
- [CREATURE-JOURNAL.md](CREATURE-JOURNAL.md) — creature-specific knowledge

---

## 1. Non-negotiable architecture

The server owns Journal truth.

The addon may:

- request state;
- display state;
- send player interaction intents such as sighting or experiment attempts;
- cache state for the current session.

The addon may **not**:

- grant discoveries;
- promote tiers;
- invent hints;
- infer successful recipes by itself;
- treat SavedVariables as authoritative;
- reveal data the server has not marked visible.

A `/reload`, reconnect, UI reinstall, or client-file replacement must not lose or create Journal progress.

---

## 2. Knowledge namespaces

All generic Journal knowledge uses stable internal keys. Player-facing names are content, not identifiers.

Recommended namespaces:

| Namespace | Purpose | Example key |
|---|---|---|
| `creature` | creature discovery tier | `90001` |
| `recipe` | successful learned preparation/process | `ash_tea` |
| `material` | material identity/property knowledge | `ashbloom.property.medicinal` |
| `gear` | upgrade-tree node or diagram knowledge | `weapon.steel_blade` |
| `tool` | tool method/upgrade knowledge | `tool.whetstone` |
| `charm` | charm identity/effect knowledge | `charm.stillstone` |
| `hint` | persistent near-miss knowledge | `ash_tea.clean_water` |
| `process` | milestone capability | `process.charcoal` |
| `fish` | catch identity/use knowledge | `fish.eel` |
| `plant` | plant/fungus identity and tells | `plant.gravecap` |

Keys must be:

- lowercase;
- stable after shipping;
- independent of flavour text;
- independent of database numeric IDs where possible;
- safe to migrate forward.

Renaming *Ash Tea* later must not invalidate `recipe:ash_tea`.

---

## 3. Generic discovery state model

Not every content type needs every state, but the generic backend should support ordered states.

Recommended numeric progression:

| State | Value | Meaning |
|---|---:|---|
| `unknown` | 0 | no persistent record |
| `inferred` | 10 | player knows something exists, identity obscured |
| `identified` | 20 | identity/name known |
| `known` | 30 | function/process/recipe known |
| `observed` | 40 | deeper witnessed information known |
| `mastered` | 50 | reserved; do not use in v1 unless explicitly designed |

Writes are monotonic by default. A state update may promote a row but never silently demote it.

Creature state remains semantically:

`Unknown → Sighted → Engaged`

and can remain in the specialised creature table. The generic service should expose it to the addon through the same sync envelope.

---

## 4. Static definition vs player state

Keep three kinds of data separate.

### Static content definition

Defines what exists:

- stable discovery key;
- tab/category;
- safe unknown silhouette/icon;
- reveal rules;
- prerequisite gates;
- linked recipe/process keys;
- hint mappings;
- final display content.

### Per-character discovery state

Defines what this Remnant knows:

- namespace;
- key;
- state;
- first learned timestamp;
- optional compact payload;
- source metadata when useful for debugging.

### Runtime attempt context

Defines what the player is doing right now:

- selected ingredients;
- prepared/refined states;
- station/process;
- heat/time/input mode;
- relevant unlocked knowledge;
- environmental conditions;
- candidate recipe family.

Runtime attempt context is evaluated and discarded. It must not itself become persistent Journal data unless the evaluator grants a discovery/hint.

---

## 5. Persistence contract

A practical generic table may resemble:

```text
thalvaeth_player_discovery
- guid
- namespace
- discovery_key
- state
- discovered_at
- updated_at
- payload
```

Recommended primary key:

```text
(guid, namespace, discovery_key)
```

Properties:

- idempotent upsert;
- monotonic state progression;
- no duplicate hint rows;
- stable across login/reload;
- easy to inspect by GM/admin tooling;
- payload optional, not required for simple booleans.

Creature observed HP/abilities can stay specialised if that remains cleaner.

---

## 6. Discovery service contract

The eventual server implementation should expose one conceptual service responsible for generic knowledge.

Required operations:

```text
GetState(player, namespace, key)
HasDiscovery(player, namespace, key, minimumState)
GrantDiscovery(player, namespace, key, state, source)
GrantHint(player, hintKey, source)
GetAllJournalState(player)
GetVisibleLinkedKnowledge(player, namespace, key)
```

`GrantHint()` is a specialised idempotent discovery grant in namespace `hint`.

No gameplay script should write arbitrary Journal rows directly if it can go through the discovery service.

---

## 7. Grant semantics

When granting knowledge:

1. validate player;
2. validate key against static definitions;
3. read existing state;
4. do nothing if existing state is equal/higher;
5. upsert new state;
6. persist before notifying client;
7. send incremental update if the addon is ready;
8. optionally queue a restrained `Journal updated` notification.

Database success comes before client celebration.

---

## 8. Full-sync protocol

Incremental updates are not enough. Login and `/reload` need reconstruction.

Locked requirement:

```text
server: HELLO~<protocol_version>
client: READY~<protocol_version>
server: JOURNAL_BEGIN~<snapshot_version>
server: ... records ...
server: JOURNAL_END~<snapshot_version>
```

Exact opcodes may change, but the semantics may not.

### Snapshot rules

- snapshot is authoritative;
- addon clears/rebuilds its session cache when a full snapshot starts;
- only player-visible state is sent;
- unknown content can live statically in Lua if safe, but hidden names/results must not;
- snapshot completion is explicit;
- partial snapshots must not be rendered as complete state.

### Incremental updates

After initial sync:

```text
DISCOVERY~<namespace>~<key>~<state>~<payload?>
HINT~<hint_key>
CREATURE~<entry>~<tier>~<payload?>
```

Payload format should remain compact and versioned if it becomes structured.

---

## 9. Protocol versioning

The addon and server must agree on a protocol version.

Rules:

- protocol version changes only when wire compatibility breaks;
- addon version and protocol version are separate concepts;
- unknown opcode is ignored safely;
- unsupported newer protocol should fail closed: show Journal unavailable, not corrupt state;
- server logs version mismatches.

---

## 10. Experiment evaluator contract

All experiment attempts use the solution truth in [DISCOVERY-SOLUTIONS.md](DISCOVERY-SOLUTIONS.md).

Evaluation order is deterministic.

Recommended order:

1. **eligibility** — is this family experimentable at all?
2. **knowledge gate** — diagram/keeper/process prerequisite?
3. **core material family** — enough semantic overlap to consider a near miss?
4. **ingredient preparation** — raw vs refined/prepared state;
5. **contamination / invalid base**;
6. **station/process**;
7. **required environment/heat/time**;
8. **structural/binder/preservative requirement**;
9. **quantity/balance band** where relevant;
10. **success**;
11. **quality roll** after recipe success.

Failure precedence is content-specific where the solution matrix overrides this order.

---

## 11. Candidate recipe selection

Random ingredient spam must not cause the evaluator to test every recipe and leak information.

A candidate recipe may be considered only if at least one is true:

- correct core ingredient is present;
- player selected an inferred recipe silhouette;
- station/process narrows to the family and meaningful overlap exists;
- a known linked material use points to the family;
- a recipe fragment/diagram explicitly enables experimentation.

If no meaningful candidate exists:

```text
result = no_useful_information
```

No persistent hint is granted.

---

## 12. One-hint-per-attempt rule

A failed experiment normally teaches at most **one** new persistent hint.

Algorithm:

1. compute ordered blockers;
2. discard blockers whose hints are already known;
3. choose the highest-priority remaining teachable blocker;
4. grant its hint;
5. stop.

If every meaningful blocker is already known, the player may receive a transient failure line but no new Journal knowledge.

This prevents one failed attempt from dumping an entire recipe.

---

## 13. Hint strength progression

Hints may have levels:

- `weak` — property observation;
- `medium` — process direction;
- `strong` — close corrective inference.

A stronger hint may require:

- the weaker hint already learned;
- a closer recipe attempt;
- relevant process/material knowledge;
- repeated meaningful experimentation using different valid approaches.

Do not unlock stronger hints by simply repeating the identical failed attempt.

---

## 14. Failure consumption

Experimentation must have stakes, but not every failure should destroy everything.

Each solution record defines a consumption class.

Recommended classes:

| Class | Behaviour |
|---|---|
| `none` | no inputs consumed; setup failed before commitment |
| `partial` | some common inputs/time/fuel consumed |
| `full` | batch consumed/spoiled |
| `damaging` | batch consumed plus item/tool condition loss |
| `hazard` | batch consumed plus in-game negative effect |

Use this to prevent both consequence-free brute force and punishing every exploratory click.

---

## 15. Success contract

On success:

1. validate recipe gate;
2. consume required inputs;
3. produce result;
4. perform hidden quality roll where applicable;
5. grant recipe/process discovery if new;
6. grant material/use links that logically become known;
7. update inferred silhouette to real entry;
8. send Journal update;
9. retain earlier hints as field-note history where the UI spec calls for it.

A poor-quality successful craft is still a discovered recipe.

---

## 16. Quality is separate from recipe truth

Quality is evaluated **after** a valid recipe succeeds.

Do not report a low-quality result as:

```text
recipe failed
```

Instead, success unlocks the recipe while the result's hidden quality affects flavour/effect.

The Journal may learn qualitative observations such as:

- inputs were poor;
- preparation was rough;
- result was thin/weak;

but must not expose hidden rarity percentages.

---

## 17. Diagram- and fragment-gated content

Some knowledge must not be discoverable through brute force.

### Diagram-only

If a gear upgrade is diagram-gated:

- silhouette may be visible/inferred;
- experimentation cannot resolve it;
- no combination of correct materials silently unlocks it;
- acquiring/reading the diagram grants the knowledge gate.

### Fragment-hinted

A recipe fragment may:

- infer a recipe node;
- reveal one process clue;
- allow experimentation that was previously ineligible;
- grant a stronger hint tier.

### Keeper-taught

Keeper teaching may grant:

- a single recipe;
- a process branch;
- a material property;
- a milestone capability.

All use the same discovery service.

---

## 18. Material knowledge

Material knowledge is layered.

Example: Gravecap.

```text
unknown
→ identified: "Gravecap"
→ property known: poisonous
→ use inferred: blade preparation exists
→ use known: specific fictional poison recipe discovered
```

Picking up an item should not automatically reveal every use.

Material pages query linked knowledge from the discovery service and show only unlocked links/inferred silhouettes.

---

## 19. Creature integration

Creature journal remains specialised but should share transport and UI shell.

Server responsibilities:

- sighting validation;
- engagement capture;
- observed ability capture;
- observed vitality data;
- full-state snapshot on login/reload.

Client responsibilities:

- mouseover/target sighting intent;
- render Unknown/Sighted/Engaged;
- never infer ability knowledge locally.

The existing `SIGHTED` flow should eventually be folded into the versioned Journal protocol rather than remain an isolated subsystem forever.

---

## 20. Ability observation

When a catalogue creature uses a journalable ability:

1. resolve creature entry;
2. map internal spell/action to stable ability key;
3. confirm the player actually witnessed/was affected according to that ability's rule;
4. append ability key idempotently;
5. persist;
6. send incremental creature update.

Internal DBC names are never sent as player-facing text.

---

## 21. Security and information leakage

The Journal is a discovery system, so accidental information leakage is a functional bug.

Do not send hidden:

- recipe names;
- required ingredient IDs;
- undiscovered gear names;
- poison effects;
- creature abilities;
- upgrade branch labels;
- exact hidden quality;

merely because the addon needs silhouettes.

Safe unknown definitions should contain only:

- opaque slot key;
- category/location in UI;
- silhouette asset ID;
- topology relationship if intentionally visible.

---

## 22. Addon cache model

Session cache should be structured conceptually as:

```text
Journal.state[namespace][key] = {
  state = ...,
  payload = ...
}

Journal.hints[hintKey] = true
Journal.snapshotComplete = false/true
```

Static safe display definitions live separately from player state.

Do not persist authoritative discovery into SavedVariables.

---

## 23. Notifications

The server sends an update event; the addon decides presentation strength from update type.

Suggested classes:

- `discovery_major` — new recipe/gear/creature identity;
- `discovery_minor` — new material use/property;
- `hint` — new near-miss note;
- `observation` — creature ability or deeper fact.

Player-facing default remains restrained:

> Journal updated.

No quest-complete fanfare.

---

## 24. Logging and diagnostics

Development builds should log:

- discovery grants;
- ignored duplicate grants;
- experiment candidate chosen;
- blocker selected;
- hint awarded;
- no-useful-information outcomes;
- protocol mismatch;
- snapshot size/time;
- invalid client opcodes.

Logs use internal keys, not only flavour text.

---

## 25. GM/debug commands

Implementation should eventually provide safe GM tooling for testing:

```text
.thal journal dump
.thal journal grant <namespace> <key> <state>
.thal journal revoke <namespace> <key>
.thal journal reset
.thal hint grant <key>
.thal hint reset
```

Names are illustrative. The requirement is the capability.

Testing discovery without database surgery will save substantial time.

---

## 26. Migration rules

When definitions change:

- never silently reuse an old key for a different concept;
- deprecated keys may map forward during migration;
- deleted content should remain safely ignorable;
- snapshot builder skips unknown/deprecated state the current client cannot render;
- protocol changes are versioned.

---

## 27. Performance constraints

The system is small in v1, but design for growth.

- full snapshot: one bounded query per relevant table, not N queries per entry;
- experiment evaluation: narrow candidate family first;
- static definitions loaded once at startup;
- hint lookups by stable key;
- incremental messages preferred after initial snapshot;
- no per-frame server requests from the UI.

Mouseover sighting intents should be throttled client-side and validated server-side.

---

## 28. Implementation boundaries

Recommended server components, conceptually:

```text
DiscoveryStore
DiscoveryService
JournalSnapshotBuilder
ExperimentEvaluator
RecipeDefinitionRegistry
HintDefinitionRegistry
CreatureObservationBridge
JournalAddonProtocol
```

Recommended addon components:

```text
Core.lua            -- transport/session
JournalModel.lua    -- cache/state
JournalFrame.lua    -- shell/tabs
CreatureTab.lua
SurvivalTab.lua
GearTab.lua
JournalData.lua     -- safe static unknown definitions
```

Exact filenames may differ; separation of responsibilities should remain.

---

## 29. Acceptance tests for the backend contract

Before polished UI work, all of these must pass:

1. Grant a recipe discovery; relog; it remains.
2. `/reload`; full snapshot reconstructs it.
3. Send duplicate grant; no duplicate row/notification.
4. Fail a near-miss; exactly one new hint is stored.
5. Repeat identical failure; no new hint.
6. Make a closer attempt; stronger/new hint may unlock.
7. Random unrelated ingredients; no useful hint.
8. Diagram-only gear node cannot be brute-forced.
9. Successful low-quality craft still grants recipe.
10. Unknown recipe name never appears in wire traffic intended for the addon.
11. Creature observed ability persists and returns after relog.
12. Old addon protocol version fails safely.
13. Snapshot interruption does not leave a false complete UI state.
14. One Remnant's discoveries never leak to another character.

---

## 30. Locked implementation decisions

- Server authority is mandatory.
- Full snapshot after login/reload is mandatory.
- Generic discovery keys are stable and content-name independent.
- One failed experiment normally teaches at most one new persistent hint.
- Random invalid combinations teach nothing useful.
- Recipe success and quality result are separate evaluations.
- Diagram-only knowledge cannot be brute-forced.
- Hidden answers must not leak through protocol or static addon data.
- Creature, Survival and Gear use one Journal transport/session model.
- Implementation must provide debug tooling before large content authoring begins.
