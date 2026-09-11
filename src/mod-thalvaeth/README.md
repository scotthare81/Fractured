# mod-thalvaeth

The **Thal'vaeth** AzerothCore module — all server code, SQL, config, and the client addon in one place. Symlinked into an AzerothCore checkout's `modules/mod-thalvaeth`. **Not** an AICraft module.

## Layout

| Path | Contents |
|------|----------|
| `src/` | C++ — module systems (survival / Gate / death **stubs**) + content scripts (creature AI, journal, Director, run gates) |
| `data/sql/updates/pending_db_world/` | World SQL — creature catalog, fodder SmartAI, monastery map, run district, run gates, POC spawns |
| `data/sql/updates/pending_db_characters/` | Characters SQL — per-player creature journal |
| `conf/thalvaeth.conf.dist` | Module config |
| `client/ThalvaethUI/` | Journal UI addon |
| `client/mpq/` | MPQ notes (Sleeper recolor) |
| `include.sh` | AC module include hook |

## Registration

Folder `mod-thalvaeth` → loader `Addmod_thalvaethScripts()` (`src/Thalvaeth_loader.cpp`) → `AddThalvaethScripts()` (`src/ThalvaethScripts.cpp`), which wires:

- **Module systems:** `ThalvaethWorldScript`, `ThalvaethPlayerScript`, `ThalvaethGateScript` (stubs).
- **Content:** `AddSC_thalvaeth_creatures()`, `AddSC_thalvaeth_creature_journal()`, `AddSC_thalvaeth_run_gates()`.

## Wire-up

After AzerothCore is cloned under the server tree:

```bash
bash scripts/link-module.sh
```

Never symlink into any `aicraft*` `modules/` directory.

## Status

Design canon: [`../../docs/`](../../docs/). The C++ is early stubs + creature AI; the SQL is the `90001–90010` roster + POC spawns/gates. Survival meters, the real Gate, and the grid inventory aren't built yet — see [`../../docs/TODO.md`](../../docs/TODO.md).

> **SQL note:** the `data/sql/updates/pending_db_*` files are the content DB updates. Confirm the exact AzerothCore module SQL auto-load path (module `data/sql`) when first building, or copy them to the core's `data/sql/updates/pending_db_*`.

## Build

Not buildable standalone — it compiles only when linked into an AzerothCore 3.3.5a checkout (see [`../../docs/DEPLOY.md`](../../docs/DEPLOY.md)).
