#!/bin/bash
# jso: create a git worktree + branch, then open it in a new Ghostty split
# running Claude Code.
# Usage: spawn-worktree.sh <branch-name> (run from inside the target git repo)
set -euo pipefail

BRANCH="$1"
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")
WT_DIR="$HOME/.jso/worktrees/$REPO_NAME/$BRANCH"

mkdir -p "$(dirname "$WT_DIR")"
git -C "$REPO_ROOT" worktree add "$WT_DIR" -b "$BRANCH"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/new-split.sh" "$WT_DIR"

echo "jso: worktree '$BRANCH' ready at $WT_DIR, opened in a new split"
