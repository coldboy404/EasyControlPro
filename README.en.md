# EasyControlPro

> English README · 中文版见 [README.md](./README.md)

This project is a hard fork based on:
- https://github.com/daitj/Easycontrol
- https://github.com/mingzhixian/Easycontrol

Supports Android 11+ pairing flow (Pair Code) and Android-to-Android remote control.

## What is improved in this fork (vs upstream)

Compared with upstream forks, this repository (`coldboy404/EasyControlPro`) includes:

1. **Unified naming & package namespace**
   - Project name unified to **EasyControlPro**
   - Package/namespace unified to `com.shiyunjin.easycontrolpro.*`
   - Module/resource naming unified (`easycontrolnext` → `easycontrolpro`)

2. **Release build optimizations**
   - Enabled release shrinking/obfuscation: `minifyEnabled=true`, `shrinkResources=true`
   - Switched to optimized ProGuard profile: `proguard-android-optimize.txt`
   - Added keep rules for critical deps (`spake2` / `bouncycastle` / `conscrypt`) for runtime stability

3. **Full ABI compatibility preserved**
   - No ABI trimming; keeps all four ABIs:
     - `arm64-v8a`
     - `armeabi-v7a`
     - `x86`
     - `x86_64`

4. **Download channel cleanup**
   - README download link is unified to this repo’s GitHub Releases
   - IzzyOnDroid entry removed to avoid confusion

## Download

- Latest release:
  - https://github.com/coldboy404/EasyControlPro/releases/latest

## Notes

Tested on Android phones (Android 9+) and Philips Android TV (Android 11 for TV).
On car systems, VR devices (e.g. Quest), or other Android form factors, resolution/screen-timeout behavior may differ.

### Useful recovery commands

Reset resolution:
```bash
adb shell wm size WIDTHxHEIGHT
```

Fix screen timeout:
```bash
adb shell settings put system screen_off_timeout 60
```

Quest 3 default timeout example:
```bash
adb shell settings put system screen_off_timeout 86400000
```

## Build

### Debug

```bash
cd easycontrolpro
./gradlew assembleDebug -p server
./gradlew copyDebug -p server
./gradlew assembleDebug
```

### Release

```bash
cd easycontrolpro
./gradlew assembleRelease -p server
./gradlew copyRelease -p server
./gradlew assembleRelease
```

## Credits

- [ADB protocol description](https://github.com/cstyan/adbDocumentation)
- [libadb-android](https://github.com/MuntashirAkon/libadb-android)
- [Scrcpy](https://github.com/Genymobile/scrcpy)
