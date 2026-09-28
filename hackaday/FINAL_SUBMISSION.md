# RetroBridge: Five Computers. Six Years. One Computing Time Machine.

## Short description

A Raspberry Pi 5 appliance that turns a 3.5-inch touchscreen into an interactive trip through five formative personal computers from 1976 to 1982.

## Project links

- **GitHub:** https://github.com/retrobridge-jc/RetroBridge
- **Release:** https://github.com/retrobridge-jc/RetroBridge/releases/tag/v1.1

## The idea

What if learning the history of personal computing did not mean looking at old computers behind glass?

RetroBridge is a hands-on computing time machine built around a Raspberry Pi 5 and a 3.5-inch 480x320 touchscreen. Power it on and, instead of seeing Linux or a normal desktop, you enter a custom 8-bit interface that moves chronologically through five computers that helped define personal computing:

- **1976 — Apple-1**
- **1977 — TRS-80 Model I**
- **1977 — Apple II**
- **1981 — IBM PC**
- **1982 — Commodore 64**

These are not static screenshots. They are usable computing environments.

The Apple-1 takes you into Woz Monitor and Integer BASIC. The TRS-80 provides a Level-II-BASIC-compatible programming environment. The Apple II runs through EWM. The IBM PC drops into a DOS environment. The Commodore 64 completes the timeline with a VICE-based C64 environment using Debian open replacement ROMs.

## Main image

**Use:** `images/RetroBridge.png`

**Supporting enclosure image:** `images/RetroBridge-Enclosure-Concept.png`

**Caption:**

> RetroBridge V1.1 with a period-inspired 3D-printable enclosure concept. The validated reference appliance uses an off-the-shelf GeeekPi/52Pi 3.5-inch touchscreen enclosure; the rendered enclosure is a design target for future printable CAD/STL work.

The enclosure rendering is a concept, not yet an engineering-validated printable package.

## Why I built it

The project started with a simple goal: run old BASIC programs on modern hardware while retaining something of the original machine experience.

That became more interesting as the systems accumulated.

The Apple-1 expects you to think about memory addresses. The TRS-80 makes BASIC the environment. The Apple II feels like a complete consumer computer. The IBM PC introduces the DOS/filesystem model that shaped an industry. The Commodore 64 combines programming with the home-computer culture of graphics, sound, and games.

Those differences tell the story of personal computing better than a static timeline.

RetroBridge makes that timeline interactive.

## Hardware

The validated reference build uses:

- Raspberry Pi 5 Model B, 8 GB
- GeeekPi / 52Pi KZ-0060 3.5-inch touchscreen/case kit
- 480x320 landscape display
- ADS7846 resistive touch
- Raspberry Pi 5 active cooling
- 32 GB microSD
- USB keyboard
- Raspberry Pi OS / Debian 13 Trixie

The project also includes a matched period-inspired enclosure concept for future 3D-print/CAD development. The concept is not yet a validated printable enclosure.

## Software architecture

RetroBridge provides the interface and integration layer. It is intentionally **not a software archive**.

The public repository contains RetroBridge code, configuration, launchers, documentation, patches, artwork, and original sample programs. Third-party emulators and historical software are obtained from their official/upstream sources.

Reference environment:

- **Apple-1:** EWM, obtained upstream
- **TRS-80:** open `trs80basic` implementation, obtained upstream
- **Apple II:** EWM, obtained upstream
- **IBM PC:** DOSBox from Debian/Raspberry Pi OS
- **Commodore 64:** VICE + Debian `open-roms`

RetroBridge does not distribute commercial games, MS-DOS images, proprietary ROM collections, or third-party emulator source trees.

## The 480x320 challenge

The tiny display turned out to be one of the defining engineering constraints.

The current EWM SDL frontend opens Apple-1 and Apple II windows at a 3x scale, which is larger than the physical RetroBridge display. The repository therefore supplies two small patch files that change only the window/logical display scale to 1x before EWM is compiled.

DOSBox is configured for fullscreen desktop resolution with nearest-neighbor OpenGL rendering and no 2x scaler.

TRS-80 runs in a deliberately sized terminal.

VICE uses its non-doubled display modes.

The result is that all five environments fit the same 480x320 appliance screen.

## Trixie display integration

A clean Raspberry Pi OS Trixie install did not contain the older MHS35 overlay used by the original development card.

The validated public build instead obtains a Raspberry Pi 5/Trixie MHS35 driver from its upstream project.

After installation, the clean system reported:

```text
ADS7846 Touchscreen
graphics fb0: fb_ili9486 frame buffer, 480x320
```

The physical screen passed orientation, touch-response, and coordinate-alignment checks.

The driver also creates a different graphical startup path from the older build:

```text
power on
 -> SPI framebuffer
 -> spi-display.service
 -> startx / Xorg :0
 -> LXDE
 -> RetroBridge
```

RetroBridge documents that startup path and includes a maintenance escape hatch.

## Recovery and reproducibility

RetroBridge has now passed **two separate validation tests**.

### Full-card recovery — PASS

The known-good V1.1 microSD was imaged, SHA-256 verified, gzip tested, and restored to a second 32 GB card.

The restored card booted and behaved like the original appliance.

### Fresh public build — PASS

A different 32 GB microSD was started from a clean Raspberry Pi OS / Debian 13 Trixie installation.

Using the public RetroBridge package plus third-party components obtained from upstream sources, the clean card successfully reproduced:

- 480x320 display
- touch input
- Apple-1
- TRS-80 Model I
- Apple II
- IBM PC
- Commodore 64
- boot-to-RetroBridge behavior

That test matters because it proves the project is not merely recoverable from a private image — it is reproducible from the public build documentation.

## The five stops

### 1976 — Apple-1

Start close to the metal. Enter Woz Monitor and launch Integer BASIC.

### 1977 — TRS-80 Model I

A Level-II-BASIC-compatible programming environment gives the project a reproducible TRS-80 experience without bundling a proprietary ROM set.

### 1977 — Apple II

EWM provides the Apple II environment, patched only for RetroBridge's tiny display scale.

### 1981 — IBM PC

DOSBox mounts RetroBridge's PC program directory as drive C: and presents a usable DOS environment.

### 1982 — Commodore 64

VICE provides the final stop in the current RetroBridge timeline using Debian open replacement ROMs.

## What I learned

The interesting problems were rarely "how do I launch an emulator?"

They were the boundaries:

- firmware and redistribution
- upstream dependencies
- tiny display geometry
- X11 authorization
- different graphical boot models
- Rust/SDL3 build dependencies
- DOSBox behavior
- window scaling
- touchscreen configuration
- recovery
- clean-build reproducibility

That became part of the point of RetroBridge.

It is not just a frontend for old software. It is an exploration of what it takes to make several generations of personal-computing history live together as one physical appliance.

## Closing

RetroBridge is not meant to replace original vintage hardware.

It is a small interactive exhibit that makes the transition from hobbyist board computers to mass-market personal computing tangible.

Turn it on. Pick a year. Use the machine.

**Five Computers. Six Years. One Computing Time Machine.**
