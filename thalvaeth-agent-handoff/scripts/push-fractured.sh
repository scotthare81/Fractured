#!/usr/bin/env bash
# Push current branch to Fractured (not AiCraft).
set -euo pipefail

FRACTURED_URL="${FRACTURED_URL:-https://github.com/scotthare81/Fractured.git}"
BRANCH="${1:-$(git branch --show-current)}"
REMOTE="${FRACTURED_REMOTE:-fractured}"

if ! git remote get-url "$REMOTE" &>/dev/null; then
  echo "==> Adding remote '$REMOTE' -> $FRACTURED_URL"
  git remote add "$REMOTE" "$FRACTURED_URL"
fi

echo "==> Pushing $BRANCH to $REMOTE"
git push -u "$REMOTE" "$BRANCH"
