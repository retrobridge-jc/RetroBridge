# Installation

## Publication model

RetroBridge installs its own interface and integration files, then relies on components obtained from their original upstream projects or the Raspberry Pi OS/Debian repositories. The repository is not a mirror of emulator, ROM, DOS, game, or disk-image files.

Read `docs/THIRD_PARTY.md` first.

## 1. Prepare the 480x320 display

For the validated Raspberry Pi 5 + GeeekPi/MHS35 Trixie path, follow:

```text
docs/DISPLAY_TRIXIE.md
```

## 2. Install RetroBridge

```bash
chmod +x install.sh
./install.sh
```

Default target:

```text
$HOME/retrobridge
```

Or choose another target:

```bash
RETROBRIDGE_HOME="$HOME/RetroBridge" ./install.sh
```

The installer copies RetroBridge-authored files, installs normal Debian package dependencies, prepares the validated DOSBox settings, and configures either the Trixie/MHS35 X-session autostart or a conventional LXDE fallback.

## 3. Obtain source-built components from upstream

Follow:

```text
docs/THIRD_PARTY.md
docs/INSTALL_EWM.md
```

EWM serves both Apple-1 and Apple II. `trs80basic` is obtained separately from its upstream repository.

## 4. Verify

```bash
./tools/check_components.sh
```

Do not reboot into appliance mode until the systems you intend to use report ready.

## 5. Reboot

```bash
sudo reboot
```

The validated Trixie/MHS35 build boots into RetroBridge automatically.

## Maintenance mode

```bash
touch "${RETROBRIDGE_HOME:-$HOME/retrobridge}/system/maintenance"
sudo reboot
```

Disable:

```bash
rm -f "${RETROBRIDGE_HOME:-$HOME/retrobridge}/system/maintenance"
sudo reboot
```
