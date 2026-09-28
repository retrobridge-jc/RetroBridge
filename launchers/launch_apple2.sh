#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/_common.sh"

EWM="$RETROBRIDGE_HOME/emulators/ewm/target/release/ewm"
MEDIA="${1:-}"

if [ ! -x "$EWM" ]; then
    echo "EWM binary not found at: $EWM"
    exit 1
fi

ARGS=(two --config builtin:apple2)

if [ -n "$MEDIA" ]; then
    ARGS+=(--set "machine:slots:6:drive1=$MEDIA")
fi

"$EWM" "${ARGS[@]}" &
PID=$!

sleep 2

DISPLAY="${DISPLAY:-:0}" XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}" wmctrl -r "EWM - Apple ][" -e 0,0,0,470,285 || true

wait "$PID"
