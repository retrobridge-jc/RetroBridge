# Emulator / Environment Notes

## Apple-1 — 1976

Public reference implementation: EWM using:

```bash
ewm one --config builtin:apple1
```

The current EWM frontend defaults to a 3x SDL window. RetroBridge supplies a small 1x sizing patch for the 480x320 appliance display.

At Woz Monitor, type:

```text
E000R
```

to enter Integer BASIC.

## TRS-80 Model I — 1977

Reference implementation: `davidscan/trs80basic`.

This provides a Level-II-BASIC-compatible experience without requiring RetroBridge to ship a proprietary TRS-80/Microsoft ROM set.

## Apple II — 1977

Reference implementation: EWM:

```bash
ewm two --config builtin:apple2
```

RetroBridge applies the corresponding 1x display-size patch before building EWM.

## IBM PC — 1981

Reference implementation: DOSBox.

`programs/ibmpc/C` is mounted as DOS drive C:. The public installer starts from DOSBox's generated configuration and then applies only the validated appliance settings.

## Commodore 64 — 1982

Reference implementation: VICE (`x64sc` preferred) with Debian's open replacement firmware files:

```text
/usr/share/open-roms/C64/kernal
/usr/share/open-roms/C64/basic
/usr/share/open-roms/C64/chargen
```

`+VICIIdsize` and `+VICIIdscan` keep the display within the small screen.
