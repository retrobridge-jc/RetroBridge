#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/_common.sh"

EMU="$RETROBRIDGE_HOME/emulators/trs80basic"
PROGRAM="${1:-}"

if [ ! -x "$EMU/basic" ]; then
    echo "TRS-80 BASIC environment not found at: $EMU"
    exit 1
fi

CMD="cd '$EMU' && export TRS80_GFX=ascii && export TRS80_MHZ=1.77408 && ./basic"

if [ -n "$PROGRAM" ]; then
    CMD="$CMD '$PROGRAM'"
fi

exec xterm     -geometry 64x20+0+0     -fa "DejaVu Sans Mono"     -fs 8     -bg black     -fg green     -title "TRS-80 MODEL I - 1977"     -e bash -lc "$CMD"
