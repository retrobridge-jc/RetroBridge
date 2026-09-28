# Third-Party Components — Obtain from Upstream

RetroBridge is an integration platform, **not a software archive**.

The public RetroBridge repository does not redistribute third-party emulator source trees or binaries, proprietary ROMs, historical operating systems, commercial games, or disk images. Builders obtain dependencies from their original projects or the Raspberry Pi OS/Debian package repositories.

| RetroBridge system | Component | Recommended source | What RetroBridge distributes |
|---|---|---|---|
| Apple-1 (1976) | EWM | https://github.com/st3fan/ewm | Launcher/configuration/patch only |
| TRS-80 Model I (1977) | trs80basic | https://github.com/davidscan/trs80basic | Launcher/configuration only |
| Apple II (1977) | EWM | https://github.com/st3fan/ewm | Launcher/configuration/patch only |
| IBM PC (1981) | DOSBox | https://www.dosbox.com/ or Debian/Raspberry Pi OS package repository | Launcher/configuration only |
| Commodore 64 (1982) | VICE | https://vice-emu.sourceforge.io/ or Debian/Raspberry Pi OS package repository | Launcher/configuration only |
| C64 replacement ROMs | open-roms | Debian/Raspberry Pi OS `open-roms` package | No ROM files |

## Apple-1 and Apple II

Build EWM from its upstream project using `docs/INSTALL_EWM.md`. The Apple-1 public build uses `builtin:apple1`; Apple II uses `builtin:apple2`.

## TRS-80

Obtain `trs80basic` directly from its upstream repository and place/build it at:

```text
$RETROBRIDGE_HOME/emulators/trs80basic
```

The launcher expects an executable named `basic` there.

## IBM PC

DOSBox is the emulator; it does not provide rights to MS-DOS, PC DOS, commercial programs, or games. Supply only software you are entitled to use.

## Commodore 64

RetroBridge may install VICE and Debian `open-roms` from the operating-system package repository. RetroBridge does not include original Commodore ROM dumps, commercial games, or disk images.

Always review each upstream project's current license and documentation before downloading, building, or using it.
