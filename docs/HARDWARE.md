# Hardware / Bill of Materials

| Component | Reference build | Purpose |
|---|---|---|
| SBC | Raspberry Pi 5 Model B, 8 GB | Host |
| Display | GeeekPi/52Pi 3.5-inch touchscreen/case | 480x320 UI |
| Touch | ADS7846-compatible controller | Touch input |
| Storage | ~32 GB microSD | OS and project |
| Cooling | Official Raspberry Pi 5 Active Cooler | Thermal management |
| Input | USB keyboard | Historical computer interaction |
| Network | Pi 5 Ethernet/Wi-Fi | Setup and SSH maintenance |
| Power | Pi 5-appropriate USB-C supply | Power |

## Validated software platform

- Raspberry Pi 5 Model B Rev 1.1
- Raspberry Pi OS / Debian 13 Trixie
- X11 / LXDE
- MHS35-compatible SPI display path
- Python/Tkinter

## Why 480x320?

The small screen is part of the design. It forced RetroBridge to behave like a dedicated appliance rather than a desktop with emulator icons.

- Apple-1 and Apple II use RetroBridge EWM 1x display patches.
- TRS-80 uses a deliberately sized terminal.
- DOSBox uses validated fullscreen 480x320-friendly settings.
- VICE doubled rendering is disabled.
- The Time Machine uses large touch targets.
