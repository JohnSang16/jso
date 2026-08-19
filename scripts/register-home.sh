#!/bin/bash
# jso: record the current Ghostty pane as "home" so new-split.sh always splits
# from here, regardless of whatever pane the user's OS focus is on later.
# Run this once from the pane you're actually working in.
set -euo pipefail

STATE_DIR="$HOME/.jso"
mkdir -p "$STATE_DIR"

ID=$(osascript -e 'tell application "Ghostty" to id of (focused terminal of (selected tab of front window))')
echo "$ID" > "$STATE_DIR/home-terminal-id"
echo "jso: home pane registered ($ID)"
