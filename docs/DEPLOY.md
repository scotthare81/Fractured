# Fractured — Deploy

Own server. Not AICraft. Step 1 isolation is agreed. This file also
holds the **live vs dev** tree and ports (Step 2).

Do not copy modules, conf, or restarters into `/home/scott/aicraft-wotlk`
(or `aicraft`, `aicraft-progression`, `aicraft-wotlk-migrate`).

## Goal

A worldserver that cannot take down, overwrite, or restart AICraft.
Scott can run a **dev** instance without touching the **live** friend
realm. Friends can later have both Fractured and AICraft; ops stay in
separate folders.

## Recommended defaults

| Decision | Default |
|----------|---------|
| Machine | Same box as AICraft is OK |
| Git repo | `/home/scott/fractured` (docs + `src/mod-fractured`) |
| Server tree | `/home/scott/fractured-server` |
| Auth | **Separate** `authserver` per Fractured instance (live and dev) |
| Databases | Own MySQL names; live and dev do not share characters/world |
| Client extract | Read-only share under `fractured-server/data` |
| Writable data | Never shared with AICraft; live and dev do not share logs/conf |

## Never

- Put Fractured worldserver, conf, or modules inside any `aicraft*`
  directory
- Share `characters` or `world` databases with AICraft
- Share live and dev `characters` / `world` databases with each other
- Share a restarter, systemd unit, or `screen` session with AICraft
- Symlink this repo into an AICraft `modules/` folder
- Restart AICraft to “just test” Fractured
- Commit server binaries, `data/` extracts, or MPQ blobs into this git
  repo

## Folder structure

```
/home/scott/fractured                    git repo
  src/mod-fractured                      AC module (this project)
  scripts/init-server-tree.sh
  scripts/link-module.sh

/home/scott/fractured-server             ops root (not git)
  src/azerothcore                        clone AC here (not yet)
  data/                                  shared 3.3.5a extract (read-only)
    maps/  dbc/  vmaps/  mmaps/
  live/                                  friend-facing run dir
    etc/  logs/  crashdumps/
  dev/                                   Scott development run dir
    etc/  logs/  crashdumps/
  build-live/                            CMake out-of-tree (later)
  build-dev/                             CMake out-of-tree (later)

/home/scott/aicraft-wotlk                AICraft — do not touch
```

Create the empty tree:

```bash
bash /home/scott/fractured/scripts/init-server-tree.sh
```

After AC is cloned into `src/azerothcore`:

```bash
bash /home/scott/fractured/scripts/link-module.sh
```

That symlink is the only legal module wire-up. AzerothCore source and
build dirs stay under `fractured-server`, not under the git repo.

## Ports

If AICraft uses AzerothCore defaults, Fractured uses the next ports so
all three can run at once. If a port is taken, pick another and write
it here — do not steal AICraft’s.

| Service | AICraft typical | Fractured live | Fractured dev |
|---------|-----------------|----------------|---------------|
| authserver | 3724 | 3725 | 3726 |
| worldserver | 8085 | 8086 | 8087 |
| SOAP | 7878 | 7879 | 7880 |
| HTTP tools | — | — | **8780** |
| MySQL | 3306 | 3306 (same daemon) | 3306 (same daemon) |

- **Live** (3725 / 8086) is the friend realm. Client `realmlist.wtf`
  for friends points at **3725**.
- **Dev** (3726 / 8087) is Scott’s instance. Own realmlist or a second
  realm line pointing at **3726**.
- **8780** is the Fractured **dev HTTP** port: local tools, later
  Journal mock, anything that is not auth/world/SOAP. Do not bind
  worldserver there.

## Databases

Same MySQL daemon is fine. Names and user are not. Live and dev are
separate so a bad SQL on dev cannot wipe friends.

| Role | Live | Dev |
|------|------|-----|
| Login | `fractured_auth` | `fractured_dev_auth` |
| Characters | `fractured_characters` | `fractured_dev_characters` |
| World | `fractured_world` | `fractured_dev_world` |
| MySQL user | `fractured` | `fractured_dev` |

Passwords stay out of git. Put them in `live/etc` and `dev/etc`, never
in this repo.

## Realms

| Field | Live | Dev |
|-------|------|-----|
| Realm name | Fractured | Fractured Dev |
| Realm ID | 1 (own auth) | 1 (own auth) |
| Address | TBD (localhost is enough for Scott-only) | 127.0.0.1 |

Player-facing names stay original IP. Do not use a WoW realm pun.

## Restarter

Live and dev each get their own start/stop habit under
`fractured-server`, not an extra line in an AICraft script. Write the
units after binaries exist.

## Module

Source: `/home/scott/fractured/src/mod-fractured`
Stubs: survival tick, `go_fractured_gate`, death → morgue messages.
Compile happens when AC is cloned and linked. That is still Step 2;
the skeleton is in git now.

## Step 1 (done)

- [x] Isolation spec written
- [x] Scott agrees the defaults
- [x] `/home/scott/fractured-server` exists and is not an AICraft path
- [x] No AzerothCore clone/build had started during Step 1
