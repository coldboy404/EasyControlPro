# EasyControlPro

本项目是基于以下仓库的硬分叉（Hard Fork）：
- https://github.com/daitj/Easycontrol
- https://github.com/mingzhixian/Easycontrol

支持 Android 11+ 配对流程（Pair Code）与安卓设备间远程控制。

## 相较上游 Fork 的更新与优化

本仓库（`coldboy404/EasyControlPro`）相较上游，主要做了这些更新：

1. **项目命名与包名统一**
   - 项目名称统一为 **EasyControlPro**
   - 包名/命名空间统一为：`com.shiyunjin.easycontrolpro.*`
   - 对应模块目录与资源命名也做了统一替换（`easycontrolnext` → `easycontrolpro`）

2. **Release 构建优化**
   - 开启 release 混淆与资源压缩：`minifyEnabled=true`、`shrinkResources=true`
   - 使用优化版 ProGuard 配置：`proguard-android-optimize.txt`
   - 针对关键依赖补充 keep 规则（`spake2` / `bouncycastle` / `conscrypt`），降低混淆后运行风险

3. **兼容性策略保持不变（全 ABI）**
   - 保留四架构支持，不做 ABI 裁剪：
     - `arm64-v8a`
     - `armeabi-v7a`
     - `x86`
     - `x86_64`

4. **下载渠道收敛**
   - README 下载地址统一为本项目 GitHub Releases
   - 移除 IzzyOnDroid 下载入口，避免用户下载路径混乱

## 下载

- 最新版本（本项目）：
  - https://github.com/coldboy404/EasyControlPro/releases/latest

## 使用说明与风险提示

已在 Android 手机（Android 9+）与 Philips Android TV（Android 11 for TV）上验证。
在车机、VR 设备（如 Quest）或其他特殊安卓形态上，分辨率/息屏时间行为可能与手机不同，请谨慎使用。

### 常用恢复命令

恢复分辨率：
```bash
adb shell wm size 宽x高
```

修复息屏时间：
```bash
adb shell settings put system screen_off_timeout 60
```

Quest 3 默认息屏时间示例：
```bash
adb shell settings put system screen_off_timeout 86400000
```

## 审计摘要（原代码行为）

应用会使用到的 ADB 指令包括：
- 保持设备常亮：`settings put system screen_off_timeout 600000000`
- 修改分辨率：`wm size`
- 查询锁屏/设备状态：`dumpsys deviceidle`
- 获取显示参数：`dumpsys display`

服务端启动流程：
- 删除旧临时文件：`/data/local/tmp/easycontrolpro_*`
- 推送服务端载荷：`/data/local/tmp/easycontrolpro_server.jar`
- 使用 `app_process` 启动：

```bash
app_process -Djava.class.path=" + serverName + " / com.shiyunjin.easycontrolpro.server.Server"
      + " serverPort=" + device.serverPort
      + " listenClip=" + (device.listenClip ? 1 : 0)
      + " isAudio=" + (device.isAudio ? 1 : 0)
      + " maxSize=" + device.maxSize
      + " maxFps=" + device.maxFps
      + " maxVideoBit=" + device.maxVideoBit
      + " keepAwake=" + (device.keepWakeOnRunning ? 1 : 0)
      + " supportH265=" + ((device.useH265 && supportH265) ? 1 : 0)
      + " supportOpus=" + (supportOpus ? 1 : 0)
      + " startApp=" + device.startApp + " \n").getBytes()));
```

仅启动指定 App 时会额外使用：

```bash
monkey -p " + Options.startApp + " -c android.intent.category.LAUNCHER 1
am display move-stack " + appStackId + " " + displayId
```

## 构建

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

## 致谢

- [ADB protocol description](https://github.com/cstyan/adbDocumentation)
- [libadb-android](https://github.com/MuntashirAkon/libadb-android)
- [Scrcpy](https://github.com/Genymobile/scrcpy)
