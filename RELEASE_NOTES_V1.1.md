# RetroBridge V1.1 — 8-Bit Edition

RetroBridge V1.1 is the first public, clean-build-validated release.

## Highlights

- Five historical computing environments spanning 1976–1982
- Custom 480x320 RetroBridge Time Machine frontend
- Raspberry Pi 5 / Debian 13 Trixie validation
- GeeekPi/52Pi MHS35 touchscreen support documented
- Apple-1 and Apple II via upstream EWM
- TRS-80 Level-II-BASIC-compatible environment
- IBM PC via DOSBox
- Commodore 64 via VICE + Debian open-roms
- 480x320 EWM patch files
- validated DOSBox appliance settings
- boot-to-RetroBridge autostart
- maintenance escape hatch
- full-card recovery test: PASS
- fresh public build test: PASS
- optional 3D-printable enclosure concept artwork

## Distribution model

RetroBridge is an integration platform, not a software archive.

This release does not redistribute third-party emulator source trees, proprietary ROM collections, commercial games, MS-DOS images, or the private full-card recovery image.

Third-party projects are obtained from their official/upstream sources as documented in the repository.

## Validation

A fresh 32 GB microSD running Debian 13 Trixie was built using the public project plus upstream dependencies and successfully reproduced all five systems, touchscreen operation, correct display sizing, and boot-to-RetroBridge behavior.

A separate full-card recovery image was also restored successfully to another microSD.
