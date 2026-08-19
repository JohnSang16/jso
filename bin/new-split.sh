#!/bin/bash
# jso: open a Ghostty split running Claude Code in a given directory.
# Always splits from the registered "home" pane (see register-home.sh), not
# whatever pane happens to have OS focus.
# Usage: new-split.sh <working-dir> [direction: right|left|up|down]
set -euo pipefail

DIR="$1"
DIRECTION="${2:-right}"

case "$DIRECTION" in
  right|left|up|down) ;;
  *) echo "jso: direction must be right, left, up, or down" >&2; exit 1 ;;
esac

STATE_DIR="$HOME/.jso"
ID_FILE="$STATE_DIR/home-terminal-id"

if [ ! -f "$ID_FILE" ]; then
  echo "jso: no home pane registered. Run scripts/register-home.sh from the pane you're working in first." >&2
  exit 1
fi
HOME_ID=$(cat "$ID_FILE")

# command execs directly (no shell, no rc files), so a multi-statement string
# breaks it and a bare "claude" won't be on PATH. Point it at a real launcher
# script with claude's absolute path baked in.
CLAUDE_BIN=$(command -v claude)
LAUNCHER=$(mktemp "${TMPDIR:-/tmp}/jso-launch.XXXXXX")
printf '#!/bin/sh\nexec "%s"\n' "$CLAUDE_BIN" > "$LAUNCHER"
chmod +x "$LAUNCHER"

osascript <<APPLESCRIPT
tell application "Ghostty"
  set cfg to new surface configuration
  set initial working directory of cfg to "$DIR"
  set command of cfg to "$LAUNCHER"
  set targetTerminal to missing value
  repeat with t in terminals
    if id of t is "$HOME_ID" then
      set targetTerminal to t
      exit repeat
    end if
  end repeat
  if targetTerminal is missing value then
    error "jso: home pane not found, was it closed? Re-run register-home.sh"
  end if
  split targetTerminal direction $DIRECTION with configuration cfg
end tell
APPLESCRIPT
