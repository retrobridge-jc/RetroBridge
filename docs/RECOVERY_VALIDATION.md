# Recovery and Clean-Build Validation

## Full-card recovery — PASS

A known-good RetroBridge V1.1 image was restored to a second 32 GB microSD card and reproduced the working appliance.

## Fresh public build — PASS

A separate 32 GB card was built from fresh Raspberry Pi OS / Debian 13 Trixie.

Validated:

- fresh OS and SSH;
- MHS35/GeeekPi 480x320 display from upstream driver;
- ADS7846 touch and correct alignment;
- public RetroBridge installer;
- Python/Tkinter;
- DOSBox + config;
- VICE + Debian open-roms;
- TRS-80 BASIC from upstream;
- Rust + SDL3;
- EWM from upstream;
- RetroBridge EWM 1x patches;
- Apple-1;
- TRS-80;
- Apple II;
- IBM PC;
- Commodore 64;
- Trixie/MHS35 boot-to-RetroBridge autostart.

Final result:

**PASS — fresh OS to functional five-system RetroBridge appliance.**
