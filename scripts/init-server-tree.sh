#!/usr/bin/env bash
# Create /home/scott/fractured-server live+dev folders. Idempotent.
# Does not clone AzerothCore. Does not touch AICraft.
set -euo pipefail

ROOT="${FRACTURED_SERVER_ROOT:-/home/scott/fractured-server}"

mkdir -p \
  "$ROOT/src" \
  "$ROOT/auth/etc" \
  "$ROOT/auth/logs" \
  "$ROOT/data/maps" \
  "$ROOT/data/dbc" \
  "$ROOT/data/vmaps" \
  "$ROOT/data/mmaps" \
  "$ROOT/live/etc" \
  "$ROOT/live/logs" \
  "$ROOT/live/crashdumps" \
  "$ROOT/dev/etc" \
  "$ROOT/dev/logs" \
  "$ROOT/dev/crashdumps" \
  "$ROOT/build-live" \
  "$ROOT/build-dev"

cat > "$ROOT/README" << 'EOF'
Fractured server tree. Not AICraft.

  src/azerothcore   clone AzerothCore here (later)
  data/             shared 3.3.5a extract (read-only)
  auth/             one login on port 3725 (live + dev realm list)
  live/             friend-facing world (8086)
  dev/              Scott development world (8087)
  build-live/       CMake build (live)
  build-dev/        CMake build (dev)

Module: /home/scott/fractured/src/mod-fractured
Link:   bash /home/scott/fractured/scripts/link-module.sh
Ports:  /home/scott/fractured/docs/DEPLOY.md
EOF

echo "Server tree ready under $ROOT"
find "$ROOT" -maxdepth 2 -type d | sort
