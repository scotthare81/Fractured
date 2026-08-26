# Fractured — Agent instructions

Read this before touching the repo.

## This is not AICraft

Fractured (`scotthare81/Fractured`) is a separate private project. Do
**not** touch AiCraft-WotLK. Do not add Fractured SQL, scripts, MPQ,
or docs there. Do not mix deploy/ops. Follow `docs/SLICE.md` for when
AzerothCore work is allowed (not during Step 1).

## Do not paste giant handoff blocks

Long chat pastes break files: tables lose columns, code fences snap,
sections truncate. Write files with tools or by editing `bootstrap.sh`.
Never “fix” markdown by copying nested fences out of a conversation.

## Source of truth

| File | Trust it for |
|------|----------------|
| `DESIGN.md` | Systems, locks L1–L15, gate flow, death, survival |
| `WORLD.md` | District network, gates, expedition flow, map IDs |
| `CONTENT.md` | Items, clones, chains, MPQ, implementation notes |
| `docs/TODO.md` | Open work |
| `docs/SLICE.md` | Build sequence; current step |
| `docs/DEPLOY.md` | Server isolation from AICraft |
| `docs/BRAINSTORM.md` | Why decisions happened; not a competing spec |
| `README.md` | Pitch, status, index |
| `src/mod-fractured` | Fractured AC module (stubs until later steps) |

If two files disagree, fix them together and update the heredocs in
`bootstrap.sh` so the next seed cannot resurrect the wrong version.

## Repair

```bash
bash bootstrap.sh
git add -A
git status
# commit only if Scott asked, unless the task explicitly says commit
```

`bootstrap.sh` is idempotent. Re-running overwrites the generated
markdown and `.gitignore` with the heredoc copies. After a bad paste,
run the seeder instead of hand-merging fragments.

If you change design, change the heredocs in `bootstrap.sh` **and**
regenerate, or the next repair will wipe your edit.

## Scope

- Follow `docs/SLICE.md`. Finish the current step before the next.
- Module source lives in `src/mod-fractured`. Server tree is
  `/home/scott/fractured-server` (live + dev). That path may be a
  symlink onto the 2TB USB 3 SSD (`docs/DEPLOY.md`).
  Never AICraft.
- Clone AzerothCore only under `fractured-server/src/azerothcore`.
- TBD only for numbers and IDs not yet decided.
- If you change a generated markdown file, change the heredoc in
  `bootstrap.sh` too.
