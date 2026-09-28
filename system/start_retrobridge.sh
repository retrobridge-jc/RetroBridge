#!/bin/bash
set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RETROBRIDGE_HOME="${RETROBRIDGE_HOME:-$(cd "$SCRIPT_DIR/.." && pwd)}"
MAINT="$RETROBRIDGE_HOME/system/maintenance"
LOG="$RETROBRIDGE_HOME/system/retrobridge.log"

if [ -f "$MAINT" ]; then
    echo "$(date): Maintenance mode active - RetroBridge not started." >> "$LOG"
    exit 0
fi

sleep 3

export DISPLAY="${DISPLAY:-:0}"
export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"
export RETROBRIDGE_HOME

echo "$(date): Starting RetroBridge from $RETROBRIDGE_HOME." >> "$LOG"

cd "$RETROBRIDGE_HOME"
python3 "$RETROBRIDGE_HOME/retrobridge_v1.py" >> "$LOG" 2>&1

echo "$(date): RetroBridge exited." >> "$LOG"
