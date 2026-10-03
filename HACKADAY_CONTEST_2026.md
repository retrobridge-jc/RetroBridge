# Hackaday Retrocomputing Contest 2026

## RetroBridge: Five Computers. Six Years. One Computing Time Machine.

RetroBridge is a Raspberry Pi 5 appliance that turns a 3.5-inch 480x320
touchscreen into a chronological, hands-on tour through five formative
personal computers:

- 1976 — Apple-1
- 1977 — TRS-80 Model I
- 1977 — Apple II
- 1981 — IBM PC
- 1982 — Commodore 64

## Why it fits "Modern Retro"

RetroBridge uses modern hardware to recreate the interaction style and
software experience of historical computers while keeping the project
reproducible and legally conservative.

The project is more than a launcher: it provides a purpose-built Time Machine
UI, system-specific integration, display scaling, boot-to-appliance behavior,
maintenance controls, documentation, recovery procedures, and a clean-build
validation path.

## What is proven

The validated reference appliance and an independent clean-build card both
demonstrated:

- 480x320 display and touch
- Apple-1
- TRS-80 Model I
- Apple II
- IBM PC
- Commodore 64
- boot-to-RetroBridge behavior

A separate full-card recovery image was also restored successfully to another
microSD.

## What is published

The repository publishes RetroBridge-authored source, launchers, configuration
guidance, patches, documentation, sample programs, and project artwork.

It intentionally does **not** redistribute proprietary ROMs, commercial
operating systems, games, disk images, or third-party emulator trees/binaries.

See:

- `README.md`
- `docs/INSTALL.md`
- `docs/RECOVERY_VALIDATION.md`
- `docs/THIRD_PARTY.md`
- `NOTICE.md`
- `hackaday/FINAL_SUBMISSION.md`

## Enclosure status

The period-inspired enclosure artwork is a design target/concept. The
software/hardware appliance is validated using the off-the-shelf reference
touchscreen enclosure; printable CAD/STL files will not be labeled validated
until they have been physically built and checked for fit, thermals, ports,
fasteners, and tolerances.

## Build guide

Instructables:
https://www.instructables.com/RetroBridge-Build-a-Raspberry-Pi-5-Computing-Time-/

## Source

https://github.com/retrobridge-jc/RetroBridge
