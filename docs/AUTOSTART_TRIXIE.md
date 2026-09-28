# Trixie/MHS35 Autostart

Validated boot chain:

```text
power on
-> SPI framebuffer
-> spi-display.service
-> startx / Xorg :0
-> LXDE
-> RetroBridge
```

On the validated MHS35/Trixie build, the graphical session is root-owned and is not started by LightDM. RetroBridge therefore starts from the active LXDE session and authorizes the normal RetroBridge user for display `:0`.

Install `system/start-retrobridge-xsession.sh` as:

```text
/usr/local/bin/start-retrobridge-xsession.sh
```

and add:

```text
@/usr/local/bin/start-retrobridge-xsession.sh
```

to:

```text
/etc/xdg/lxsession/rpd-x/autostart
```

The public installer performs this automatically when it detects `spi-display.service`.

## Maintenance escape hatch

```bash
touch "${RETROBRIDGE_HOME:-$HOME/retrobridge}/system/maintenance"
sudo reboot
```

Re-enable appliance mode:

```bash
rm -f "${RETROBRIDGE_HOME:-$HOME/retrobridge}/system/maintenance"
sudo reboot
```
