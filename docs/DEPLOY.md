# Fractured — Deploy (Step 1)

Own server. Not AICraft. This step is **isolation**, not a compile.

Do not clone AzerothCore, do not run CMake, and do not copy modules
into `/home/scott/aicraft-wotlk` (or `aicraft`, `aicraft-progression`,
`aicraft-wotlk-migrate`). Sign off the defaults below, then Step 2
can introduce a module skeleton.

## Goal

A worldserver that cannot take down, overwrite, or restart AICraft.
Friends can later have both realms; ops must never be one folder.

## Recommended defaults

Say yes to these or change one line. Do not invent a third tree.

| Decision | Default |
|----------|---------|
| Machine | Same box as AICraft is OK |
| Git repo | `/home/scott/fractured` (docs + later modules) |
| Server tree | `/home/scott/fractured-server` (binaries, conf, logs) |
| Auth | **Separate** `authserver` (own login port) |
| Databases | Own MySQL *names* on the existing MySQL; own user |
| Client extract | Read-only share of 3.3.5a maps/dbc later is OK |
| Writable data | Never shared with AICraft |

Separate auth is the boring kind of isolation: Fractured realm ID can
be 1 on its own auth. Sharing AICraft’s auth is nicer for friends
later and is a **later** change, not Step 1.

## Never

- Put Fractured worldserver, conf, or modules inside any `aicraft*`
  directory
- Share `characters` or `world` databases with AICraft
- Share a restarter, systemd unit, or `screen` session with AICraft
- Symlink this repo into an AICraft `modules/` folder
- Restart AICraft to “just test” Fractured
- Commit server binaries, `data/`, or MPQ blobs into this git repo

## Paths

```
/home/scott/fractured              git repo (this project)
/home/scott/fractured-server       server tree (not git)
/home/scott/aicraft-wotlk          AICraft — do not touch
```

`fractured-server` is allowed to exist as an empty directory in Step
1. AzerothCore source and build dirs go *under it* in a later step,
not under `/home/scott/fractured` until we choose a modules layout
in Step 2.

## Ports

If AICraft uses AzerothCore defaults, Fractured uses the next ports
so both can run at once. If AICraft already took a port, pick another
and write it here — do not steal AICraft’s.

| Service | AICraft typical | Fractured |
|---------|-----------------|-----------|
| authserver | 3724 | 3725 |
| worldserver | 8085 | 8086 |
| SOAP | 7878 | 7879 |
| MySQL | 3306 (shared daemon) | 3306 (same daemon, different DB names) |

Client `realmlist.wtf` for Fractured will point at the Fractured
auth port (3725 in this table), not at AICraft’s.

## Databases

Same MySQL daemon is fine. Names and user are not.

| Database | Name |
|----------|------|
| Login | `fractured_auth` |
| Characters | `fractured_characters` |
| World | `fractured_world` |
| MySQL user | `fractured` |

Passwords stay out of git (see `.gitignore`). Put them in
`/home/scott/fractured-server` conf later, never in this repo.

## Realm

| Field | Value |
|-------|-------|
| Realm name | Fractured |
| Realm ID | 1 (own auth) |
| Address | TBD when we bind a host (localhost is enough for Scott-only) |

Player-facing realm name is original IP. Do not call it a WoW realm
pun.

## Restarter

Fractured gets its own start/stop habit: own systemd unit **or** own
script in `/home/scott/fractured-server`, not an extra line in an
AICraft script. Write the actual unit in a later step, after a binary
exists.

## What “Step 1 done” means

- [x] Isolation spec written (this file)
- [x] Scott agrees the defaults (or writes the diffs)
- [x] `/home/scott/fractured-server` exists and is not an AICraft path
- [x] No AzerothCore clone/build has started for Fractured

When those are true, go to **Step 2** in `docs/SLICE.md`.
