# mod-fractured

AzerothCore module for Fractured. Source of truth is this folder in the
git repo. It is **not** an AICraft module.

## Wire-up

After AzerothCore is cloned under the server tree:

```bash
bash /home/scott/fractured/scripts/link-module.sh
```

That creates:

`/home/scott/fractured-server/src/azerothcore/modules/mod-fractured`
→ `/home/scott/fractured/src/mod-fractured`

Never symlink this into any `aicraft*` `modules/` directory.

## Loader name

AC requires `Addmod_fracturedScripts()` because the folder is
`mod-fractured`.

## Stubs (Step 2)

| Hook | Intent | Now |
|------|--------|-----|
| Player update | Hunger / Thirst / Corruption | Empty |
| Gate gossip `go_fractured_gate` | Open Mouth; block bots | Message only |
| Death / release ghost | Morgue wake | Message only |

Bind `go_fractured_gate` in world SQL in Step 3, when Sanctuary exists.

## Config

`conf/fractured.conf.dist` installs with the worldserver. Copy into
`live/etc` or `dev/etc` as needed. See `docs/DEPLOY.md`.
