#!/usr/bin/env bash
# Create Thalvaeth live+dev folders. Idempotent.
# Default logical path is /home/scott/thalvaeth-server (may be a
# symlink onto the always-on external disk; see docs/DEPLOY.md).
# Does not clone AzerothCore. Does not touch AICraft.
set -euo pipefail

ROOT="${FRACTURED_SERVER_ROOT:-/home/scott/thalvaeth-server}"

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
Thalvaeth server tree. Not AICraft.

  Logical path: /home/scott/thalvaeth-server
  Real tree may live on the 2TB USB 3 SSD (symlink).

  src/azerothcore   clone AzerothCore here (later)
  data/             shared 3.3.5a extract (read-only)
  auth/             one login on port 3724 (live + dev realm list)
  live/             friend-facing world (8086)
  dev/              Scott development world (8087)
  build-live/       CMake build (live)
  build-dev/        CMake build (dev)

Module: /home/scott/thalvaeth/src/mod-thalvaeth
Link:   bash /home/scott/thalvaeth/scripts/link-module.sh
Ports:  /home/scott/thalvaeth/docs/DEPLOY.md
Disk:   /home/scott/thalvaeth/docs/DEPLOY.md (2TB USB 3 SSD)
EOF

echo "Server tree ready under $ROOT"
find "$ROOT" -maxdepth 2 -type d | sort
