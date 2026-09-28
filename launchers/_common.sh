#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RETROBRIDGE_HOME="${RETROBRIDGE_HOME:-$(cd "$SCRIPT_DIR/.." && pwd)}"
export RETROBRIDGE_HOME
