#!/bin/bash
# jso: print a worktree branch's diff stat + full diff against its base, for
# the orchestrator to read and narrate at whichever detail level was asked for.
# Usage: diff-worktree.sh <branch> [base=main]
set -euo pipefail

BRANCH="$1"
BASE="${2:-main}"
REPO_ROOT=$(git rev-parse --show-toplevel)

echo "--- stat ---"
git -C "$REPO_ROOT" diff "$BASE...$BRANCH" --stat
echo "--- full diff ---"
git -C "$REPO_ROOT" diff "$BASE...$BRANCH"
