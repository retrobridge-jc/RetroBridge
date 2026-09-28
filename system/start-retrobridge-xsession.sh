#!/bin/bash
set -e

RETRO_HOME="${RETROBRIDGE_HOME:-$HOME/retrobridge}"
TARGET_USER="${RETROBRIDGE_USER:-${SUDO_USER:-jc}}"
TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"
[ -n "$TARGET_HOME" ] || TARGET_HOME="/home/$TARGET_USER"

if [ -z "${RETROBRIDGE_HOME:-}" ]; then
    RETRO_HOME="$TARGET_HOME/retrobridge"
fi

MAINT="$RETRO_HOME/system/maintenance"
[ -f "$MAINT" ] && exit 0

sleep 3
xhost +SI:localuser:"$TARGET_USER" >/dev/null 2>&1 || true

exec sudo -u "$TARGET_USER"     DISPLAY="${DISPLAY:-:0}"     RETROBRIDGE_HOME="$RETRO_HOME"     HOME="$TARGET_HOME"     python3 "$RETRO_HOME/retrobridge_v1.py"
