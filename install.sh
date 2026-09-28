#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${RETROBRIDGE_HOME:-$HOME/retrobridge}"
USER_HOME="$HOME"
LXDE_DIR="$USER_HOME/.config/lxsession/LXDE-pi"

echo "=== RetroBridge V1.1 installer ==="
echo "Source : $REPO_DIR"
echo "Target : $TARGET"
echo

if [ "$EUID" -eq 0 ]; then
    echo "Please run this installer as your normal desktop user, not root."
    exit 1
fi

echo "[1/8] Installing packaged dependencies..."
sudo apt update
sudo apt install -y     python3-tk     dosbox     vice     zenity     open-roms     wmctrl     xterm     gawk     git     cmake     build-essential     ninja-build     curl     patch

echo "[2/8] Creating RetroBridge directory tree..."
mkdir -p "$TARGET"
mkdir -p     "$TARGET/launchers"     "$TARGET/system"     "$TARGET/config"     "$TARGET/programs/apple1"     "$TARGET/programs/ibmpc/C"     "$TARGET/emulators"

echo "[3/8] Installing RetroBridge files..."
cp -a "$REPO_DIR/retrobridge/." "$TARGET/"
cp -a "$REPO_DIR/launchers/." "$TARGET/launchers/"
cp -a "$REPO_DIR/system/." "$TARGET/system/"
cp -a "$REPO_DIR/programs/." "$TARGET/programs/"

chmod +x "$TARGET/retrobridge_v1.py"
chmod +x "$TARGET/launchers/"*.sh
chmod +x "$TARGET/system/start_retrobridge.sh"

echo "[4/8] Preparing DOSBox config..."
dosbox -userconf >/dev/null 2>&1 || true

DOSBOX_CONF="$(find "$HOME/.dosbox" -maxdepth 1 -type f -name 'dosbox-*.conf' | sort | tail -1 || true)"
if [ -n "$DOSBOX_CONF" ] && [ -f "$DOSBOX_CONF" ]; then
    cp "$DOSBOX_CONF" "$TARGET/config/dosbox.conf"
    sed -i '/^\[autoexec\]/,$d' "$TARGET/config/dosbox.conf"
    cat >> "$TARGET/config/dosbox.conf" <<EOF

[autoexec]
mount c "$TARGET/programs/ibmpc/C"
c:
cls
echo RETROBRIDGE IBM PC - 1981
echo.
echo DOS ENVIRONMENT READY
echo.
EOF
    echo "DOSBox configuration prepared."
else
    echo "WARNING: DOSBox user config was not found."
    echo "Run 'dosbox -userconf' and create $TARGET/config/dosbox.conf manually."
fi

# RetroBridge 480x320 DOSBox defaults validated on clean Trixie build.
if [ -f "$TARGET/config/dosbox.conf" ]; then
    sed -i         -e 's/^fullscreen=.*/fullscreen=true/'         -e 's/^fullresolution=.*/fullresolution=desktop/'         -e 's/^output=.*/output=openglnb/'         -e 's/^aspect=.*/aspect=true/'         -e 's/^scaler=.*/scaler=none/'         "$TARGET/config/dosbox.conf"
fi

echo "[5/8] Third-party source check..."
if [ ! -x "$TARGET/emulators/trs80basic/basic" ]; then
    echo "TRS-80 BASIC is not installed. Follow docs/THIRD_PARTY.md."
fi

echo "[6/8] Checking EWM..."
if [ ! -x "$TARGET/emulators/ewm/target/release/ewm" ]; then
    cat <<EOF

EWM (Apple-1 / Apple II) is not built yet.

RetroBridge's public installer intentionally does not silently build Rust/SDL
components. Follow:

    $REPO_DIR/docs/INSTALL_EWM.md

Then re-run the component check:

    $REPO_DIR/tools/check_components.sh

EOF
fi

echo "[7/8] Configuring autostart..."

if [ -f /etc/xdg/lxsession/rpd-x/autostart ] && systemctl list-unit-files 2>/dev/null | grep -q '^spi-display.service'; then
    sudo cp "$TARGET/system/start-retrobridge-xsession.sh" /usr/local/bin/start-retrobridge-xsession.sh
    sudo chmod +x /usr/local/bin/start-retrobridge-xsession.sh

    if [ ! -f /etc/xdg/lxsession/rpd-x/autostart.before-retrobridge ]; then
        sudo cp /etc/xdg/lxsession/rpd-x/autostart /etc/xdg/lxsession/rpd-x/autostart.before-retrobridge
    fi

    sudo grep -qxF '@/usr/local/bin/start-retrobridge-xsession.sh' /etc/xdg/lxsession/rpd-x/autostart 2>/dev/null ||         echo '@/usr/local/bin/start-retrobridge-xsession.sh' | sudo tee -a /etc/xdg/lxsession/rpd-x/autostart >/dev/null
else
    mkdir -p "$LXDE_DIR"
    AUTOSTART="$LXDE_DIR/autostart"

    if [ -f "$AUTOSTART" ] && [ ! -f "$AUTOSTART.pre-retrobridge" ]; then
        cp "$AUTOSTART" "$AUTOSTART.pre-retrobridge"
    fi

    START_CMD="@$TARGET/system/start_retrobridge.sh"
    grep -qxF "$START_CMD" "$AUTOSTART" 2>/dev/null || echo "$START_CMD" >> "$AUTOSTART"
fi

rm -f "$TARGET/system/maintenance"

echo "[8/8] Installation complete."
echo
echo "RetroBridge target: $TARGET"
echo
echo "Before rebooting, run:"
echo "  $REPO_DIR/tools/check_components.sh"
echo
echo "Manual launch varies by display/X-session configuration; see docs/AUTOSTART_TRIXIE.md and docs/INSTALL.md."
echo
echo "Maintenance escape hatch:"
echo "  touch $TARGET/system/maintenance"
echo "  sudo reboot"
echo
echo "To disable maintenance mode:"
echo "  rm -f $TARGET/system/maintenance"
