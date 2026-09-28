# Launcher Documentation

RetroBridge isolates machine-specific command lines in shell scripts.

## Apple-1

Starts the upstream-built EWM release binary with `builtin:apple1`. The validated build uses the RetroBridge 1x EWM patch, so runtime window-manager resizing is not required for correct fit.

## TRS-80

- enters `emulators/trs80basic`;
- sets ASCII graphics and 1.77408 MHz;
- starts `./basic`;
- wraps it in a 64x20 green-on-black xterm.

## Apple II

- starts the EWM release binary;
- selects `builtin:apple2`;
- optionally assigns media to slot 6, drive 1;
- waits for EWM to exit.

The validated build uses the RetroBridge 1x EWM patch.

## IBM PC

- ensures the emulated C: directory exists;
- starts DOSBox with `config/dosbox.conf`;
- can optionally mount a user-supplied floppy image as A:.

## C64

- locates `x64sc` or `x64`;
- points VICE to Debian open C64 firmware replacements;
- disables doubled rendering;
- optionally passes user-supplied media.

## Frontend contract

The frontend withdraws, runs the launcher synchronously, then restores itself. Launchers therefore remain attached to their emulator process rather than immediately returning.
