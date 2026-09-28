#!/bin/bash
set -e
source "$(dirname "$0")/_common.sh"
EWM="$RETROBRIDGE_HOME/emulators/ewm/target/release/ewm"
if [ ! -x "$EWM" ]; then
    zenity --error --text='EWM is not installed. See docs/THIRD_PARTY.md and docs/INSTALL_EWM.md.' 2>/dev/null || true
    exit 1
fi
"$EWM" one --config builtin:apple1 &
PID=$!
sleep 2
DISPLAY=:0 XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}" wmctrl -r "EWM" -e 0,0,0,470,285 2>/dev/null || true
wait "$PID"
