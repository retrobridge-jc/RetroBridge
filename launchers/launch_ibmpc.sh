#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/_common.sh"

mkdir -p "$RETROBRIDGE_HOME/programs/ibmpc/C"
CONF="$RETROBRIDGE_HOME/config/dosbox.conf"
MEDIA="${1:-}"

if [ ! -f "$CONF" ]; then
    echo "DOSBox config not found: $CONF"
    exit 1
fi

if [ -n "$MEDIA" ]; then
    case "${MEDIA,,}" in
        *.img|*.ima)
            exec dosbox -conf "$CONF"                 -c "imgmount a \"$MEDIA\" -t floppy"                 -c "a:"
            ;;
    esac
fi

exec dosbox -conf "$CONF"
