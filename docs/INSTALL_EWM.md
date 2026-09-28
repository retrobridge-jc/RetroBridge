# EWM Build for RetroBridge

RetroBridge does not redistribute EWM. Obtain it from:

https://github.com/st3fan/ewm

The validated clean build used a current Rust toolchain and SDL3 built locally.

## 1. Install Rust

Use the official rustup installer, then confirm `rustc` and `cargo` are available.

## 2. Build SDL3

```bash
cd "${RETROBRIDGE_HOME:-$HOME/retrobridge}/emulators"
git clone https://github.com/libsdl-org/SDL.git SDL3
cd SDL3
git checkout release-3.2.10
mkdir -p build
cd build
cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local
ninja
sudo ninja install
sudo ldconfig
```

## 3. Clone EWM

```bash
cd "${RETROBRIDGE_HOME:-$HOME/retrobridge}/emulators"
git clone https://github.com/st3fan/ewm.git
cd ewm
```

## 4. Apply the RetroBridge 480x320 patches

The current EWM SDL frontend opens Apple-1 and Apple II windows at 3x scale. RetroBridge supplies two small source patches that change only the initial/logical display size to 1x.

```bash
cp ewm/src/one.rs ewm/src/one.rs.orig-retrobridge
cp ewm/src/two.rs ewm/src/two.rs.orig-retrobridge

patch -p0 < /path/to/RetroBridge/patches/ewm-apple1-480x320.patch
patch -p0 < /path/to/RetroBridge/patches/ewm-apple2-480x320.patch
```

If a future EWM update changes the surrounding source enough that the patch no longer applies, inspect the upstream changes rather than forcing it.

## 5. Build

```bash
cargo build --release
```

Validated result:

- Apple-1 fits the 480x320 display;
- Apple II fits the 480x320 display;
- RetroBridge does not redistribute modified EWM source or binaries.
