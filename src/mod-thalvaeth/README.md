# mod-thalvaeth

AzerothCore module for Thalvaeth. Source of truth is this folder in the
git repo. It is **not** an AICraft module.

## Wire-up

After AzerothCore is cloned under the server tree:

```bash
bash /home/scott/thalvaeth/scripts/link-module.sh
```

That creates:

`/home/scott/thalvaeth-server/src/azerothcore/modules/mod-thalvaeth`
→ `/home/scott/thalvaeth/src/mod-thalvaeth`

Never symlink this into any `aicraft*` `modules/` directory.

## Loader name

AC requires `Addmod_thalvaethScripts()` because the folder is
`mod-thalvaeth`.

## Stubs (Step 2)

| Hook | Intent | Now |
|------|--------|-----|
| Player update | Hunger / Thirst / Infection | Empty |
| Gate gossip `go_thalvaeth_gate` | Open Rotwood; block bots | Message only |
| Death / release ghost | Morgue wake | Message only |

Bind `go_thalvaeth_gate` in world SQL in Step 3, when Monastery exists.

## Config

`conf/thalvaeth.conf.dist` installs with the worldserver. Copy into
`live/etc` or `dev/etc` as needed. See `docs/DEPLOY.md`.
