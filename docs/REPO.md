# Git repository — Fractured

**Thal'vaeth work belongs in [Fractured](https://github.com/scotthare81/Fractured), not AiCraft-WotLK.**

AiCraft is the Playerbots / homeserver fork. Fractured is Scott's Thal'vaeth / custom-content fork.

---

## Canonical remote

| Remote | URL | Use |
|--------|-----|-----|
| `fractured` | `https://github.com/scotthare81/Fractured.git` | **Push all Thal'vaeth work here** |
| `origin` | AiCraft-WotLK | Do not open Thal'vaeth PRs against this repo |

---

## Cloud agent push access

Cursor Cloud pushes as **`wiz-cursor-gh-bot`** (display name: Wiz Cursor Bot). On `scotthare81/Fractured`, add that account as a **collaborator with Write** (Settings → Collaborators), or grant the [Cursor GitHub App](https://github.com/apps/cursor) access to this repo. Making the repo public is not enough.

---

## One-time setup (repo owner)

If `Fractured` does not exist yet on GitHub:

1. Create a **private** repo: `scotthare81/Fractured`
2. Recommended base: fork **AiCraft-WotLK** `main` (or mod-playerbots AzerothCore `Playerbot` branch)
3. Add remote and push the Thal'vaeth branch:

```bash
git remote add fractured https://github.com/scotthare81/Fractured.git
git push -u fractured cursor/thalvaeth-implementation-0472:main
# or keep feature branch:
git push -u fractured cursor/thalvaeth-implementation-0472
```

4. Open PRs on **Fractured** only.
5. Close any draft Thal'vaeth PR on AiCraft-WotLK.

Helper script (from repo root): `./thalvaeth-agent-handoff/scripts/push-fractured.sh`

---

## Layout in Fractured

| Path | Contents |
|------|----------|
| `thalvaeth-agent-handoff/` | Design docs, pending SQL, C++ stubs, client addon (this package) |
| `data/sql/updates/pending_db_*` | Applied via `bootstrap.sh` when integrating |
| `src/server/scripts/Custom/` | Applied C++ after bootstrap |

`bootstrap.sh` copies handoff artifacts into a local Fractured tree for build/test.

---

## Cloud agents

Point Cursor Cloud Agent runs at **Fractured**, branch `cursor/*-0472`. Do not register Thal'vaeth PRs against AiCraft.

---

## Related

- [HANDOFF.md](../thalvaeth-agent-handoff/HANDOFF.md)
- [AGENT-INSTRUCTIONS.md](AGENT-INSTRUCTIONS.md)
