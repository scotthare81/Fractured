# Journal wire protocol

This document pins the server ↔ `ThalvaethUI` message contract for the Journal Record.

The existing addon prefix remains:

```text
THALVAETH
```

Field separator remains:

```text
~
```

The protocol must survive login, `/reload`, dropped incremental updates, and version skew without inventing client-side knowledge.

---

## 1. Principles

1. Server is authoritative.
2. Client begins in **not ready** state after login/reload.
3. Client requests/accepts a complete snapshot before rendering known state as final.
4. Incremental deltas are only trusted after snapshot completion.
5. Unknown protocol versions fail closed: show Journal unavailable/loading, never fabricate state.
6. Messages contain only safe-to-display knowledge.

---

## 2. Protocol version

Initial Journal protocol version:

```text
1
```

Handshake messages carry this version.

Do not overload the addon version (`ThalvaethUI.version`) as the wire version.

---

## 3. Message envelope

Logical message body:

```text
OPCODE~field1~field2~...
```

Transport remains addon whisper under prefix `THALVAETH`.

All fields must be ASCII-safe or escaped/encoded by a single documented rule if free text is ever added. Prefer stable keys over prose on the wire.

Player-facing descriptions should generally live in addon static definitions or safe server definitions, not be repeatedly shipped as arbitrary text.

---

## 4. Handshake

### Server → Client

```text
HELLO~1
```

Meaning: server supports Journal wire protocol v1.

### Client → Server

```text
READY~1
```

Meaning: addon supports v1 and requests authoritative state.

If versions are incompatible, client must not enter ready state.

---

## 5. Full snapshot

Snapshot has explicit boundaries.

### Server → Client

```text
SNAP_BEGIN~1~<snapshot_id>
```

Then zero or more state records, then:

```text
SNAP_END~<snapshot_id>
```

`snapshot_id` only needs to distinguish overlapping/restarted snapshots in one session. It does not need to persist across login.

Client clears/rebuilds its authoritative cache at `SNAP_BEGIN`, stages records, and commits the staged snapshot only after matching `SNAP_END`.

If `SNAP_END` never arrives, previous committed state remains untouched and UI reports loading/retry rather than partially committing.

---

## 6. Generic discovery snapshot record

```text
DISC~<namespace>~<key>~<state>
```

Example:

```text
DISC~recipe~ash_tea~2
DISC~hint~ash_tea.clean_water~2
DISC~material~ashbloom.identity~2
DISC~gear~weapon.steel_blade~1
```

Canonical wire form omits duplicated namespace prefixes from `key`; DB/internal helpers may still represent a full key as `recipe.ash_tea`.

Locked state integers:

```text
1 inferred
2 known
3 observed/deep-known
```

State 0 is represented by absence and is never transmitted.

---

## 7. Creature snapshot records

Creature-specific state remains explicit.

### Tier

```text
CREATURE~<entry>~<tier>
```

Tier values:

```text
sighted
engaged
```

Unknown creatures are represented by absence unless static catalogue topology intentionally exposes their silhouette slot.

### Observed health

```text
CREATURE_HP~<entry>~<observed_max>
```

Only send if engaged and observed.

### Observed ability

```text
CREATURE_ABILITY~<entry>~<ability_key>
```

Example:

```text
CREATURE_ABILITY~90006~hook
```

Never send raw spell IDs or DBC spell names to the addon for presentation.

---

## 8. Snapshot completion

After matching `SNAP_END`, client:

1. atomically replaces its committed cache;
2. marks `journalReady = true`;
3. renders tabs from snapshot state;
4. removes loading mask;
5. does not generate discovery fanfare for snapshot-restored facts.

Restoring old knowledge is not a “new discovery.”

---

## 9. Incremental updates

After ready state, server may push deltas.

### Generic discovery delta

```text
DISC_UP~<namespace>~<key>~<state>~<kind>
```

`kind`:

```text
entry
hint
observation
```

This controls notification strength only.

Example:

```text
DISC_UP~hint~ash_tea.needs_heat~2~hint
```

### Creature tier delta

Retain compatibility with existing concept, but normalise form:

```text
CREATURE_UP~90001~sighted
CREATURE_UP~90001~engaged
```

### Creature ability delta

```text
CREATURE_ABILITY_UP~90006~hook
```

Client applies delta only if ready and if it is monotonic relative to local committed state.

---

## 10. Sighted request

Client may notify the server that a hostile mouseover/target should be evaluated for sighting:

```text
SIGHTED
```

Do **not** trust a client-supplied entry ID or GUID as authoritative discovery truth.

Server resolves a valid nearby catalog creature using server state and range/LOS rules.

This preserves the existing anti-leak principle.

---

## 11. Experiment/crafting messages

The Journal protocol should not become the crafting authority.

Crafting interactions belong to the server gameplay system. After an attempt resolves, the server emits Journal deltas for newly learned facts.

The addon must never send:

```text
LEARN recipe.ash_tea
GRANT hint...
```

There is no client-authoritative discovery opcode.

---

## 12. Snapshot retry

Client may request resync:

```text
RESYNC~1
```

Use cases:

- `/reload`;
- snapshot timeout;
- detected impossible delta sequence;
- addon UI manually requests repair.

Server responds with a new `SNAP_BEGIN`/`SNAP_END` sequence.

Rate-limit obvious abuse, but resync must remain safe because it is read-only projection.

---

## 13. Unknown opcodes

Both sides ignore unknown opcodes they do not understand unless they are required handshake/version messages.

This permits additive protocol evolution.

Never interpret an unknown opcode as a discovery.

---

## 14. Invalid payload handling

Server rejects/ignores malformed client payloads without crashing or mutating state.

Client ignores malformed server deltas and requests a resync if corruption could affect committed state.

Examples:

- invalid state integer;
- invalid namespace;
- empty key;
- creature entry outside catalog;
- unknown tier;
- snapshot end with wrong ID.

---

## 15. Message ordering

Within a single snapshot, records may arrive in any order between begin/end.

Incremental deltas are expected in server send order but must still be monotonic-safe.

Example: client already has `recipe.ash_tea = 2`; a delayed state 1 delta is ignored.

---

## 16. Payload size / batching

Addon messages have practical size limits. Do not build huge packed JSON snapshots.

Use many compact records inside explicit snapshot boundaries.

For larger future Journals, server can batch over multiple frames/ticks. UI remains loading until `SNAP_END`.

---

## 17. Static definition ownership

Safe static catalogue information may live in Lua:

- tab/category structure;
- icon paths for already-safe slots;
- player-facing text for known states;
- topology of intentionally visible unknown silhouettes.

Secret solution data must not live client-side merely hidden by UI.

Do not ship:

- exact undiscovered recipes;
- hidden ingredient sets;
- failure precedence tables;
- undiscovered hint answers;
- diagram-only solutions.

Those remain server-side.

---

## 18. Example session

```text
S→C HELLO~1
C→S READY~1
S→C SNAP_BEGIN~1~42
S→C CREATURE~90001~sighted
S→C DISC~material~ashbloom.identity~2
S→C DISC~hint~ash_tea.clean_water~2
S→C DISC~recipe~ash_tea~1
S→C SNAP_END~42
```

Later, player succeeds:

```text
S→C DISC_UP~recipe~ash_tea~2~entry
```

UI updates Ash Tea from inferred silhouette to known entry and shows restrained `Journal updated.` notification.

---

## 19. Example creature observation

```text
S→C CREATURE_UP~90006~engaged
S→C CREATURE_ABILITY_UP~90006~hook
```

The addon renders Broken Snare as engaged and reveals the player-facing observation mapped to ability key `hook`.

---

## 20. Version evolution

Protocol v2 may add fields/opcodes, but v1 meanings never silently change.

Breaking changes require:

- new protocol version;
- explicit compatibility decision;
- clear fallback if addon/server versions differ.

---

## 21. Wire acceptance criteria

Implementation passes when:

- fresh login reconstructs Journal entirely from server snapshot;
- `/reload` reconstructs identical state;
- no snapshot fact triggers false “new discovery” notifications;
- an incremental hint grant updates UI immediately;
- duplicate/replayed deltas do not regress state;
- malformed client messages cannot grant knowledge;
- wrong snapshot ID cannot partially commit;
- unsupported protocol leaves Journal safely unavailable rather than corrupt;
- client contains no hidden recipe truth needed to cheat the discovery system.