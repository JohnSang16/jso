#!/bin/bash
# jso: merge a worktree branch back into base and remove the worktree.
# Usage: merge-worktree.sh <branch> [base=main]
set -euo pipefail

BRANCH="$1"
BASE="${2:-main}"
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")
WT_DIR="$HOME/.jso/worktrees/$REPO_NAME/$BRANCH"

git -C "$REPO_ROOT" checkout "$BASE"

if ! git -C "$REPO_ROOT" merge --no-ff "$BRANCH" -m "merge: $BRANCH into $BASE (via jso)"; then
  git -C "$REPO_ROOT" merge --abort
  echo "jso: merge conflict between '$BRANCH' and '$BASE'. Aborted cleanly, nothing left half-merged." >&2
  echo "jso: worktree and branch left intact at $WT_DIR, resolve manually or ask the orchestrator how you want to proceed." >&2
  exit 1
fi

git -C "$REPO_ROOT" worktree remove "$WT_DIR"
git -C "$REPO_ROOT" branch -d "$BRANCH"

echo "jso: merged '$BRANCH' into '$BASE' and cleaned up the worktree"
