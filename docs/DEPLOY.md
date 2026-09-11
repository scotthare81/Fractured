# Thal'vaeth — Deploy

Own server. Not AICraft. Step 1 isolation is agreed. This file also
holds the **live vs dev** tree and ports (Step 2).

Do not copy modules, conf, or restarters into `/home/scott/aicraft-wotlk`
(or `aicraft`, `aicraft-progression`, `aicraft-wotlk-migrate`).

## Goal

A worldserver that cannot take down, overwrite, or restart AICraft.
Scott can run a **dev** instance without touching the **live** friend
realm. Friends can later have both Thal'vaeth and AICraft; ops stay in
separate folders.

Live and dev share **one Thal'vaeth login** so both realms show on the
same character-select list. They do not share world or characters.

## Workstation

Scott’s desktop is **Linux**. Work there for now.

Clone this git repo, run `scripts/init-server-tree.sh`, clone
AzerothCore under that tree, link the module, compile, localhost
playtest. The game box’s internal disk and AICraft stay untouched.

A desktop worldserver is Scott-only. It is **not** Thal'vaeth Dev
(8087). Live + dev + shared auth on 3724 land on the always-on server
when friends need them.

When that happens: put `thalvaeth-server` on the server’s 2TB USB 3
SSD (see Disk). Rebuild on the server if CPU/OS differ; rsync is fine
if they match. Extract maps once, on the machine that will actually
run worldserver — do not extract twice if you can help it.

## Recommended defaults

| Decision | Default |
|----------|---------|
| Machine | Linux **desktop** for work now. Always-on **server** (USB 3 SSD) when friends need a realm. Same box as AICraft is OK for that later. |
| Git repo | `/home/scott/thalvaeth` (docs + `src/mod-thalvaeth`) — clone on the desktop; on the server keep it on **internal disk** |
| Server tree | Desktop `~/thalvaeth-server` for now. On the game box: `/home/scott/thalvaeth-server` logical path on the **2TB USB 3 SSD** |
| Auth | **One** Thal'vaeth `authserver` on **3724** (stock client port; live + dev in the same realm list) |
| Databases | Shared login DB; live and dev do not share characters/world; **MySQL datadir stays internal** |
| Client extract | Read-only share under `thalvaeth-server/data` |
| Writable data | Never shared with AICraft; live and dev do not share logs/world conf |

## Never

- Put Thal'vaeth worldserver, conf, or modules inside any `aicraft*`
  directory
- Share `auth`, `characters`, or `world` databases with AICraft
- Share live and dev `characters` / `world` databases with each other
  (they **do** share Thal'vaeth `auth` so both realms show in one list)
- Share a restarter, systemd unit, or `screen` session with AICraft
- Symlink this repo into an AICraft `modules/` folder
- Restart AICraft to “just test” Thal'vaeth
- Commit server binaries, `data/` extracts, or MPQ blobs into this git
  repo
- Put the Thal'vaeth MySQL datadir on the USB / external disk
- Let a dead USB hang boot so AICraft cannot start

## Disk (external drive)

**On the game server: put `thalvaeth-server` on the USB 3 SSD. Do
not put the git repo or MySQL there.**

The internal disk already hosts AICraft. Thal'vaeth’s space hit is the
ops tree: AzerothCore clone, two CMake builds, and the 3.3.5a extract.
That is tens of gigabytes once compile + extract land. The git repo is
small. When this tree **first lands on the game server**, put it on
the USB 3 SSD **before** cloning AC there. Until then, the Linux
desktop is the right place to compile.

Keep the **logical** path `/home/scott/thalvaeth-server` so scripts do
not bake in a USB mount. Put the real tree on the always-on disk and
symlink. Isolation is still path-based: the symlink must not land
under any `aicraft*` directory.

| What | External disk? | Why |
|------|----------------|-----|
| `/home/scott/thalvaeth` | No | Tiny; git, editors, agents |
| `/home/scott/thalvaeth-server` (whole tree) | **Yes** | Clone, `build-live/`, `build-dev/`, `data/` |
| Thal'vaeth MySQL datadir (port 3306) | No | Latency and crash safety |
| AICraft paths | Do not touch | Isolation. Do not also *depend* on this USB |

The disk is Scott’s **2TB USB 3 SSD**, always plugged in. That is
the comfortable case: 2TB dwarfs clone + dual builds + extract.
Friend-facing ping and combat are unchanged (MySQL stays internal).
Worldserver start and first zone load may be a hair slower than
internal NVMe because USB is still a slower bus; after maps are in
RAM cache it will not hitch like a USB HDD would. Compiles are a
bit slower than on the internal SSD. Not a reason to stay on the
internal disk.

Mount by UUID in fstab with `nofail` so a missing disk does not hang
boot and take AICraft down. Thal'vaeth restarters must
`RequiresMountsFor=` that mount. Disable USB autosuspend for the
device.

Do not create `thalvaeth-server` on the empty mountpoint while the
disk is unplugged: writes would land on the internal disk and vanish
when the real filesystem mounts. Leave the unmounted mountpoint
root-owned so that cannot happen by accident.

`init-server-tree.sh` honors `FRACTURED_SERVER_ROOT` if you would
rather point at the real path. The default logical path stays
`/home/scott/thalvaeth-server`.

Example (Scott fills in the mount):

```bash
# External disk already mounted at /mnt/<disk> (UUID in fstab, nofail)
sudo mkdir -p /mnt/<disk>/thalvaeth-server
sudo chown scott:scott /mnt/<disk>/thalvaeth-server

# If the empty internal tree already exists, replace it with a symlink
rsync -aH /home/scott/thalvaeth-server/ /mnt/<disk>/thalvaeth-server/
mv /home/scott/thalvaeth-server /home/scott/thalvaeth-server.bak
ln -s /mnt/<disk>/thalvaeth-server /home/scott/thalvaeth-server

bash /home/scott/thalvaeth/scripts/init-server-tree.sh
# After a sanity check: rm -rf /home/scott/thalvaeth-server.bak
```

## Folder structure

```
/home/scott/thalvaeth                    git repo (internal disk)
  src/mod-thalvaeth                      AC module (this project)
  scripts/init-server-tree.sh
  scripts/link-module.sh

/home/scott/thalvaeth-server             ops root — symlink onto external disk
  → /mnt/<disk>/thalvaeth-server
  src/azerothcore                        clone AC here (not yet)
  data/                                  shared 3.3.5a extract (read-only)
    maps/  dbc/  vmaps/  mmaps/
  auth/                                  one Thal'vaeth login (port 3724)
    etc/  logs/
  live/                                  friend-facing world (port 8086)
    etc/  logs/  crashdumps/
  dev/                                   Scott development world (port 8087)
    etc/  logs/  crashdumps/
  build-live/                            CMake out-of-tree (later)
  build-dev/                             CMake out-of-tree (later)

/home/scott/aicraft-wotlk                AICraft — do not touch
```

Create the empty tree (through the symlink, after the disk is mounted):

```bash
bash /home/scott/thalvaeth/scripts/init-server-tree.sh
```

After AC is cloned into `src/azerothcore`:

```bash
bash /home/scott/thalvaeth/scripts/link-module.sh
```

That symlink is the only legal module wire-up. AzerothCore source and
build dirs stay under `thalvaeth-server`, not under the git repo.

## Ports

On this box AICraft auth is **3734**. Thal'vaeth takes the stock client
port **3724** so an unpatched 3.3.5 client can log in. Do not steal
AICraft’s 3734.

| Service | AICraft on this box | Thal'vaeth live | Thal'vaeth dev |
|---------|---------------------|----------------|---------------|
| authserver | 3734 | **3724** (shared) | **3724** (same process) |
| worldserver | (AICraft world, not 8086) | 8086 | 8087 |
| SOAP | — | 7879 | 7880 |
| HTTP tools | — | — | **8780** |
| MySQL | 127.0.0.1:3307 | 3306 (Thal'vaeth daemon) | 3306 (same daemon) |

- **One Thal'vaeth auth** on **3724** (stock 3.3.5 client port). Client
  `realmlist.wtf` points at the hostname only; the client always uses
  3724. After login, **Thal'vaeth** and **Thal'vaeth Dev** both appear
  on the realm list.
- **Live** world is 8086. **Dev** world is 8087. Two worldservers,
  one Thal'vaeth login. Not AICraft’s auth (3734).
- **8780** is the Thal'vaeth **dev HTTP** port: local tools, later
  Journal mock, anything that is not auth/world/SOAP. Do not bind
  worldserver there.

## Databases

Same MySQL daemon is fine. Names are not. Live and dev **share
login**. They do not share characters or world, so a bad SQL on dev
cannot wipe friend characters.

| Role | Live | Dev |
|------|------|-----|
| Login | `thalvaeth_auth` (shared) | `thalvaeth_auth` (same) |
| Characters | `thalvaeth_characters` | `thalvaeth_dev_characters` |
| World | `thalvaeth_world` | `thalvaeth_dev_world` |
| MySQL user | `thalvaeth` | `thalvaeth` (same user is fine) |

Passwords stay out of git. Auth conf lives in `auth/etc`. World conf
lives in `live/etc` and `dev/etc`.

## Realms

Two rows in the same `auth.realmlist` table. One `authserver`.

| Field | Live | Dev |
|-------|------|-----|
| Realm name | Thal'vaeth | Thal'vaeth Dev |
| Realm ID | 1 | 2 |
| Address | TBD (localhost is enough for Scott-only) | 127.0.0.1 |
| World port | 8086 | 8087 |

Player-facing names stay original IP. Do not use a WoW realm pun.

## Restarter

One restarter for Thal'vaeth **auth**, plus one each for live and dev
**world**. All under `thalvaeth-server`, not an extra line in an
AICraft script. Write the units after binaries exist. Those units
must `RequiresMountsFor=` the external disk mount.

## Module

Source: `/home/scott/thalvaeth/src/mod-thalvaeth`
Stubs: survival tick, `go_thalvaeth_gate`, death → morgue messages.
Compile happens when AC is cloned and linked. That is still Step 2;
the skeleton is in git now.

## Step 1 (done)

- [x] Isolation spec written
- [x] Scott agrees the defaults
- [x] `/home/scott/thalvaeth-server` exists and is not an AICraft path
- [x] No AzerothCore clone/build had started during Step 1
- [ ] Real ops tree on the game box lives on the 2TB USB 3 SSD
      (symlink the logical path; MySQL and git stay internal). Not
      required while Scott is compiling on the Linux desktop.
