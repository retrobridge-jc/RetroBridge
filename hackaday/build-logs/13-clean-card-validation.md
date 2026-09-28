# Build Log - Fresh-Card Reproducibility Test

I wanted to prove that RetroBridge did not depend on the state of my original development card.

A second 32 GB microSD was started from a fresh Raspberry Pi OS / Debian 13 Trixie installation.

The clean build uncovered several real integration details: the MHS35 display needed a Trixie-compatible upstream driver; EWM's current SDL windows defaulted to 3x scale and needed a tiny 1x display patch for 480x320; DOSBox needed appliance-specific fullscreen/scaler settings; and the display driver's `spi-display.service` uses a root-owned `startx` session rather than the older LightDM path.

After applying only documented RetroBridge configuration and upstream dependencies, the fresh card passed:

- Apple-1
- TRS-80 Model I
- Apple II
- IBM PC
- Commodore 64
- 480x320 display
- touch
- boot-to-RetroBridge

This is separate from the earlier full-card recovery test, which also passed on another microSD.

RetroBridge now has both a tested disaster-recovery path and a tested public clean-build path.
