# Trixie + GeeekPi/MHS35 480x320 Display

Validated on Raspberry Pi 5 with Debian 13 (Trixie).

The clean Trixie image did not include the older `mhs35.dtbo` overlay used during early Bookworm development. The validated build used the maintained Pi 5/Trixie driver from:

https://github.com/Robinbinu/pi5-mhs35-touchscreen

```bash
cd "$HOME"
git clone https://github.com/Robinbinu/pi5-mhs35-touchscreen.git
cd pi5-mhs35-touchscreen
chmod +x install.sh
./install.sh
sudo reboot
```

Validated results included:

```text
ADS7846 Touchscreen
graphics fb0: fb_ili9486 frame buffer, 480x320
```

Physical checks passed:

- landscape orientation;
- touch response;
- touch-coordinate alignment.

On this build, `spi-display.service` starts a root-owned `startx`/LXDE session rather than LightDM. See `AUTOSTART_TRIXIE.md`.
