# Journal implementation test vectors

This document defines deterministic test cases for the first Journal implementation. These are not vague QA ideas; they are expected input/state/output contracts.

Use them for unit tests where practical and for manual server/addon verification where engine hooks are involved.

---

## 1. Discovery persistence

### DV-001 — first grant

Initial state:

```text
recipe.ash_tea absent
```

Action:

```text
GrantDiscovery(recipe.ash_tea, known)
```

Expected:

```text
row inserted
state = 2
changed = true
```

### DV-002 — duplicate grant

Initial:

```text
recipe.ash_tea = 2
```

Action:

```text
GrantDiscovery(recipe.ash_tea, 2)
```

Expected:

```text
no state change
changed = false
no duplicate notification
```

### DV-003 — promotion

Initial:

```text
gear.weapon.steel_blade = 1
```

Action:

```text
GrantDiscovery(..., 2)
```

Expected:

```text
state becomes 2
changed = true
```

### DV-004 — attempted downgrade

Initial:

```text
state = 2
```

Action:

```text
GrantDiscovery(..., 1)
```

Expected:

```text
state remains 2
changed = false
```

---

## 2. Character isolation

### DV-010

Character A knows `recipe.ash_tea`.
Character B on same account does not.

After login:

- A snapshot contains Ash Tea known.
- B snapshot does not.

No account-level bleed is allowed.

---

## 3. Snapshot protocol

### WP-001 — clean snapshot

Server emits:

```text
HELLO~1
SNAP_BEGIN~1~100
DISC~recipe~ash_tea~2
DISC~hint~ash_tea.clean_water~2
SNAP_END~100
```

Expected client:

- stages both records;
- commits on matching end;
- marks ready;
- no “new discovery” notification.

### WP-002 — mismatched end ID

Begin ID 100, end ID 101.

Expected:

- staged snapshot discarded/not committed;
- previous committed snapshot retained;
- client requests resync or remains loading/error-safe.

### WP-003 — missing end

Snapshot begins and records arrive, then transport stops.

Expected:

- no partial commit.

### WP-004 — stale lower-state delta

Committed:

```text
gear.weapon.steel_blade = 2
```

Delta:

```text
DISC_UP~gear~weapon.steel_blade~1~entry
```

Expected:

- ignored;
- no notification.

---

## 4. Creature journal

### CJ-001 — valid sighting

Player mouseovers valid catalog creature within allowed range.
Client sends `SIGHTED`.
Server resolves actual nearby creature.

Expected:

- sighted timestamp inserted once;
- `CREATURE_UP` sent if state changed.

### CJ-002 — invalid sighting request

No catalog creature is valid/nearby.

Expected:

- no journal change.

### CJ-003 — engaged promotion

Sighted creature enters combat with player.

Expected:

- engaged timestamp set;
- observed max HP captured;
- tier becomes engaged;
- never downgrades later.

### CJ-004 — ability observation

Broken Snare uses hook ability on player.

Expected:

- ability key `hook` persisted once;
- delta emitted once;
- raw spell ID never sent to UI.

---

## 5. Ash Tea discovery chain

### AT-001 — random nonsense

Attempt contains unrelated ingredients and no meaningful near-match.

Expected:

- craft fails;
- no persistent hint;
- no inferred Ash Tea entry solely because of spam.

### AT-002 — dirty-water near miss

Attempt meaningfully matches Ash Tea family but uses unsuitable water.

Expected:

- fail reason maps to `hint.ash_tea.clean_water`;
- hint granted if new;
- at most one hint learned this attempt.

### AT-003 — repeat same mistake

Same attempt after hint already known.

Expected:

- no additional discovery;
- no Journal notification.

### AT-004 — correct ingredients, wrong process

Player now uses clean water but misses required heat/process.

Expected:

- `hint.ash_tea.needs_heat` learned if new.

### AT-005 — success

All hard recipe/process rules satisfied.

Expected:

- Ash Tea output created;
- `recipe.ash_tea` promoted to known;
- previous hint history retained;
- hidden quality evaluated after success, not before.

---

## 6. Charcoal discovery chain

### CH-001 — open fire

Correct source wood is simply burned openly.

Expected:

- process does not produce Charcoal;
- ash/byproduct may result according to crafting rules;
- `hint.charcoal.low_air` may be learned;
- `process.charcoal` not granted.

### CH-002 — correct controlled process

Required low-air process and valid source material satisfied.

Expected:

- Charcoal result;
- `process.charcoal = known`;
- material identity granted if appropriate.

### CH-003 — diagram/knowledge gate bypass attempt

If a later process is explicitly fragment/diagram gated, correct ingredients alone must not brute-force it.

Expected:

- no success;
- no secret answer leaked.

---

## 7. Material layered knowledge

### MK-001 — collect Ashbloom

Expected:

```text
material.ashbloom.identity = known
```

Not automatically:

```text
material.ashbloom.medicinal
material.ashbloom.use.ash_tea
```

### MK-002 — learn Ash Tea

After successful Ash Tea discovery:

Expected:

```text
material.ashbloom.use.ash_tea = known
```

### MK-003 — collect Gravecap

Expected identity only unless identification rules teach more.

Poisonous property is not auto-granted merely from pickup.

---

## 8. Gear tree

### GT-001 — inferred hidden branch

Player knows Steel Blade and topology says two future branches exist.

Expected UI:

- hidden child silhouette(s) visible if intended by static topology;
- no hidden name/effect in tooltip/search/text.

### GT-002 — diagram unlock

Player obtains/learns Greatsword diagram.

Expected:

- diagram fact granted;
- `gear.weapon.greatsword` promoted to known;
- sibling hidden branch remains hidden/inferred.

### GT-003 — ownership != knowledge

Developer gives player a resulting item directly without knowledge grant.

Expected:

- owned item does not necessarily auto-complete gear Journal unless explicit hook says ownership teaches it.

---

## 9. Notifications

### NT-001 — new entry

New recipe/gear identity discovered.

Expected restrained stronger notification kind `entry`.

### NT-002 — hint

New near-miss hint learned.

Expected subtle `hint` notification.

### NT-003 — snapshot restore

Known facts arrive during full snapshot.

Expected no discovery notification.

---

## 10. Reload/login

### RL-001 — `/reload`

Player has several creature, hint, material, recipe and gear records.

After `/reload`:

- client cache starts unready;
- handshake occurs;
- full snapshot reconstructs identical visible Journal;
- no knowledge disappears;
- no false discovery fanfare.

### RL-002 — logout/login

Same expectations as reload, sourced solely from server persistence.

---

## 11. Malformed client input

### SEC-001 — fake discovery opcode

Client attempts unsupported message resembling a grant.

Expected:

- ignored/rejected;
- no state mutation.

### SEC-002 — spoofed creature entry

Client tries to claim a creature entry through sighting payload.

Expected:

- server uses own resolution/range state;
- spoof cannot grant sighting.

### SEC-003 — spam resync

Rapid repeated `RESYNC` calls.

Expected:

- safe/read-only;
- rate limited if necessary;
- never corrupts state.

---

## 12. Failure precedence

### FP-001

Attempt violates two possible recipe constraints.

Expected:

- evaluator selects highest-priority meaningful blocker defined by `DISCOVERY-SOLUTIONS.md`;
- one new hint maximum by default.

### FP-002

Highest-priority blocker’s hint already known, second blocker unknown.

Expected behaviour must follow one chosen policy consistently:

**Recommended:** continue down ordered failures and grant the first *new teachable* hint, while still using the real highest blocker for craft failure.

This should be implemented and tested explicitly rather than left ambiguous.

---

## 13. Failure consumption

For each failure class in solution canon, test:

- no-consume failures;
- partial-consume failures;
- destructive/consumed experiments.

Knowledge result and inventory cost must agree with the canonical solution record.

Repeated retries must not create duplication exploits.

---

## 14. Quality separation

### QL-001

Recipe is valid but poor inputs produce low hidden quality.

Expected:

- craft succeeds;
- recipe remains/gets known;
- output quality is low;
- no “recipe failed” hint.

### QL-002

Recipe is invalid.

Expected:

- no result quality roll treated as successful recipe;
- relevant failure/hint path evaluated instead.

---

## 15. Snapshot leakage audit

For an early character, inspect all addon messages and static Lua data.

Must not reveal:

- undiscovered exact recipe ingredients;
- future hint keys/copy that expose answers;
- hidden gear names where silhouette-only;
- raw spell IDs used as ability identity;
- server-side failure precedence tables.

---

## 16. Manual end-to-end acceptance scenario

A clean test Remnant should be able to:

1. log in and receive a valid empty/born-known snapshot;
2. sight one creature;
3. engage it and observe deeper state;
4. collect Ashbloom without automatically learning Ash Tea;
5. make one meaningful Ash Tea mistake and gain one hint;
6. `/reload` and still have that hint;
7. make the second meaningful mistake and gain the next hint;
8. successfully discover Ash Tea;
9. `/reload` again and see the resolved known entry;
10. discover Charcoal through its process path;
11. unlock one gear node while a sibling remains silhouette-only;
12. log into another character and verify none of the first character's discoveries leaked across.

The Journal v1 backend is not considered ready until this entire scenario works.