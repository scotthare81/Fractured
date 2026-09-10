#!/usr/bin/env bash
# Thal'vaeth — copy handoff artifacts into a local AzerothCore fork + client folder
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AC_ROOT="${1:-../Fractured}"
CLIENT_DIR="${2:-$HOME/Wow/Interface/AddOns}"

echo "==> Thal'vaeth bootstrap"
echo "    handoff: $ROOT"
echo "    server:  $AC_ROOT"
echo "    client:  $CLIENT_DIR"

if [[ -d "$AC_ROOT/data/sql/updates/pending_db_world" ]]; then
  cp -v "$ROOT/server/sql/pending_db_world/"*.sql "$AC_ROOT/data/sql/updates/pending_db_world/"
  cp -v "$ROOT/server/sql/pending_db_characters/"*.sql "$AC_ROOT/data/sql/updates/pending_db_characters/"
else
  echo "WARN: server path missing pending_db_* — copy SQL manually"
fi

CUSTOM="$AC_ROOT/src/server/scripts/Custom"
mkdir -p "$CUSTOM"
cp -v "$ROOT/server/scripts/"*.cpp "$ROOT/server/scripts/"*.h "$CUSTOM/" 2>/dev/null || true

mkdir -p "$CLIENT_DIR/ThalvaethUI"
cp -rv "$ROOT/client/addons/ThalvaethUI/"* "$CLIENT_DIR/ThalvaethUI/"

echo "==> Done. Apply world/characters SQL, add AddSC_thalvaeth_all() to Custom loader, rebuild when ready."
