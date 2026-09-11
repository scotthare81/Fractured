# Git repository — Thal'vaeth

**Thal'vaeth work belongs in [Thal'vaeth](https://github.com/scotthare81/Thalvaeth), not AiCraft-WotLK.**

AiCraft is the Playerbots / homeserver fork. Thal'vaeth is Scott's custom-content fork.

> Repo renamed **Fractured → Thalvaeth** (GitHub repo names can't hold the apostrophe; the world stays *Thal'vaeth*). GitHub redirects the old URL, so existing clones/remotes keep working.

---

## Canonical remote

| Remote | URL | Use |
|--------|-----|-----|
| `thalvaeth` | `https://github.com/scotthare81/Thalvaeth.git` | **Push all Thal'vaeth work here** |
| `origin` | AiCraft-WotLK | Do not open Thal'vaeth PRs against this repo |

---

## Cloud agent push access

Cursor Cloud pushes as **`wiz-cursor-gh-bot`** (display name: Wiz Cursor Bot). On `scotthare81/Thalvaeth`, add that account as a **collaborator with Write** (Settings → Collaborators), or grant the [Cursor GitHub App](https://github.com/apps/cursor) access to this repo. Making the repo public is not enough.

---

## One-time setup (repo owner)

If `Thalvaeth` does not exist yet on GitHub:

1. Create a **private** repo: `scotthare81/Thalvaeth`
2. Recommended base: fork **AiCraft-WotLK** `main` (or mod-playerbots AzerothCore `Playerbot` branch)
3. Add remote and push:

```bash
git remote add thalvaeth https://github.com/scotthare81/Thalvaeth.git
git push -u thalvaeth <branch>:main
```

4. Open PRs on **Thal'vaeth** only.
5. Close any draft Thal'vaeth PR on AiCraft-WotLK.

---

## Layout

| Path | Contents |
|------|----------|
| `docs/` | Design canon + ops |
| `thalvaeth-agent-handoff/` | Implementation package: pending SQL, C++ stubs, client addon (awaiting integration) |
| `data/sql/updates/pending_db_*` | Where the pending SQL lands on integration |
| `src/server/scripts/Custom/` | Where the C++ lands on integration |

---

## Cloud agents

Point Cursor Cloud Agent runs at **Thal'vaeth**. Do not register Thal'vaeth PRs against AiCraft.

---

## Related

- [HANDOFF.md](../thalvaeth-agent-handoff/HANDOFF.md)
- [AGENT-INSTRUCTIONS.md](AGENT-INSTRUCTIONS.md)
