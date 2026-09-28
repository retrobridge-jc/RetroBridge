#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/_common.sh"

MEDIA="${1:-}"
EMU="$(command -v x64sc || command -v x64 || true)"

if [ -z "$EMU" ]; then
    zenity --error --text='VICE is not installed.' 2>/dev/null || true
    exit 1
fi

for ROM in     /usr/share/open-roms/C64/kernal     /usr/share/open-roms/C64/basic     /usr/share/open-roms/C64/chargen
do
    if [ ! -f "$ROM" ]; then
        echo "Required open C64 ROM not found: $ROM"
        exit 1
    fi
done

ARGS=(
    -kernal /usr/share/open-roms/C64/kernal
    -basic /usr/share/open-roms/C64/basic
    -chargen /usr/share/open-roms/C64/chargen
    +VICIIdsize
    +VICIIdscan
    -windowxpos 0
    -windowypos 0
)

if [ -n "$MEDIA" ]; then
    ARGS+=("$MEDIA")
fi

exec "$EMU" "${ARGS[@]}"
