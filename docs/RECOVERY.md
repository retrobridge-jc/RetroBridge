# Full microSD Recovery

A whole-card image preserves more than source code: OS configuration, installed packages, locally built SDL3, EWM, X11 behavior, emulator configuration, autostart, and permissions.

## Reference milestone

The working V1.1 reference card imaged to exactly:

```text
31,719,424,000 bytes
```

The raw image was SHA-256 verified, gzip-compressed, gzip-tested, and the compressed image was SHA-256 verified.

The private compressed image is not part of the public repository.

## Create an image on macOS

Shut down the Pi, insert the card into the Mac, identify it carefully with:

```bash
diskutil list
```

Unmount:

```bash
diskutil unmountDisk /dev/diskX
```

Image the entire physical device:

```bash
sudo dd if=/dev/rdiskX of=/absolute/path/RetroBridge_V1.1_8BIT_Full.img bs=4m status=progress
```

Hash it:

```bash
shasum -a 256 RetroBridge_V1.1_8BIT_Full.img > RetroBridge_V1.1_8BIT_Full.img.sha256
shasum -a 256 -c RetroBridge_V1.1_8BIT_Full.img.sha256
```

Compress and test:

```bash
gzip -9 -c RetroBridge_V1.1_8BIT_Full.img > RetroBridge_V1.1_8BIT_Full.img.gz
gzip -t RetroBridge_V1.1_8BIT_Full.img.gz
```

## Restore

Use a destination card at least as large as the original physical device:

```bash
gunzip -c RetroBridge_V1.1_8BIT_Full.img.gz | sudo dd of=/dev/rdiskX bs=4m status=progress
sync
diskutil eject /dev/diskX
```

Boot the spare and test all five machines, autostart, System Console, maintenance mode, reboot, and shutdown.

## Public release

Do not upload a private full-card image without sanitizing it.
