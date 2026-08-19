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
git -C "$REPO_ROOT" merge --no-ff "$BRANCH" -m "merge: $BRANCH into $BASE (via jso)"
git -C "$REPO_ROOT" worktree remove "$WT_DIR"
git -C "$REPO_ROOT" branch -d "$BRANCH"

echo "jso: merged '$BRANCH' into '$BASE' and cleaned up the worktree"
