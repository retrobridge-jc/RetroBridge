#!/bin/bash
set -u
TARGET="${RETROBRIDGE_HOME:-$HOME/retrobridge}"
ok() { printf "%-24s %s\n" "$1" "OK"; }
warn() { printf "%-24s %s\n" "$1" "MISSING"; }
echo "RetroBridge component check"
echo "Target: $TARGET"
echo
command -v python3 >/dev/null && ok "Python" || warn "Python"
python3 - <<'PY' >/dev/null 2>&1 && ok "Tkinter" || warn "Tkinter"
import tkinter
PY
command -v dosbox >/dev/null && ok "DOSBox" || warn "DOSBox"
(command -v x64sc >/dev/null || command -v x64 >/dev/null) && ok "VICE" || warn "VICE"
command -v xterm >/dev/null && ok "xterm" || warn "xterm"
command -v wmctrl >/dev/null && ok "wmctrl" || warn "wmctrl"
[ -x "$TARGET/emulators/trs80basic/basic" ] && ok "TRS-80 BASIC" || warn "TRS-80 BASIC"
[ -x "$TARGET/emulators/ewm/target/release/ewm" ] && ok "EWM Apple-1/II" || warn "EWM Apple-1/II"
[ -f "$TARGET/config/dosbox.conf" ] && ok "DOSBox config" || warn "DOSBox config"
[ -x "$TARGET/launchers/launch_apple1.sh" ] && ok "Apple-1 launcher" || warn "Apple-1 launcher"
for R in kernal basic chargen; do
    [ -f "/usr/share/open-roms/C64/$R" ] && ok "C64 open-rom $R" || warn "C64 open-rom $R"
done
