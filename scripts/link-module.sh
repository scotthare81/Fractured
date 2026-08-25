#!/usr/bin/env bash
# Symlink the Fractured git module into the Fractured AzerothCore tree.
# Never run this against AICraft.
set -euo pipefail

REPO="${FRACTURED_REPO:-/home/scott/fractured}"
AC="${FRACTURED_AC:-/home/scott/fractured-server/src/azerothcore}"
MOD_SRC="$REPO/src/mod-fractured"
MOD_DST="$AC/modules/mod-fractured"

if [[ "$AC" == *aicraft* ]]; then
  echo "Refusing to link into an AICraft path: $AC" >&2
  exit 1
fi

if [[ ! -d "$MOD_SRC/src" ]]; then
  echo "Module missing: $MOD_SRC" >&2
  exit 1
fi

if [[ ! -d "$AC/modules" ]]; then
  echo "Clone AzerothCore into $AC first (modules/ not found)." >&2
  exit 1
fi

ln -sfn "$MOD_SRC" "$MOD_DST"
echo "Linked $MOD_DST -> $MOD_SRC"
