# Architecture

RetroBridge is an appliance layer around several historically different computing environments. The frontend owns navigation, history, diagnostics, and lifecycle; each historical environment runs as a separate process.

```text
Raspberry Pi 5
  -> Debian 13 Trixie / X11 / LXDE
  -> RetroBridge V1.1 Tkinter frontend (480x320)
       -> Apple-1: EWM
       -> TRS-80: trs80basic
       -> Apple II: EWM
       -> IBM PC: DOSBox
       -> Commodore 64: VICE + Debian open-roms
```

## Frontend

`retrobridge/retrobridge_v1.py`:

- renders the Time Machine UI;
- provides machine selection and history;
- launches machine-specific shell wrappers;
- withdraws while an external environment is active;
- restores itself when the process exits;
- provides system information and maintenance controls.

## Launcher isolation

Machine-specific behavior stays in:

- `launch_apple1.sh`
- `launch_trs80.sh`
- `launch_apple2.sh`
- `launch_ibmpc.sh`
- `launch_c64.sh`

This keeps emulator integration separate from the touchscreen frontend.

## Validated Trixie / MHS35 boot path

The Debian 13 Trixie reference build with the GeeekPi/MHS35 SPI display uses:

```text
spi-display.service
 -> startx
 -> Xorg :0 using /etc/X11/xorg-spi.conf
 -> LXDE
 -> /usr/local/bin/start-retrobridge-xsession.sh
 -> RetroBridge as the normal user
```

This differs from the older Bookworm/LightDM development path. See `AUTOSTART_TRIXIE.md`.

## Machine notes

### Apple-1
EWM using `builtin:apple1`. RetroBridge applies a small 1x display-size patch before building EWM for the 480x320 screen.

### TRS-80
`trs80basic` in a deliberately sized green-on-black xterm.

### Apple II
EWM using `builtin:apple2`, with the same RetroBridge 1x display-size approach.

### IBM PC
DOSBox with a RetroBridge directory mounted as DOS C: and validated 480x320 fullscreen settings.

### Commodore 64
VICE with Debian `open-roms`; doubled rendering is disabled for the small display.
