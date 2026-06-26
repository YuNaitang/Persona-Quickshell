# Persona-Quickshell — Agent Guide

## 项目概述

基于 **Quickshell** (QML/Qt6) 的 Hyprland 桌面 Shell，主题为《女神异闻录》系列风格。使用 `WlrLayershell` 实现面板组件，通过 Hyprland IPC 进行窗口管理。

## 快速命令

```bash
# 构建/运行 —— 无构建系统，直接运行
quickshell -c /home/master/项目/Persona-Quickshell/shell.qml

# IPC 调用搜索面板
qs -c /home/master/项目/Persona-Quickshell/ ipc call searchapp toggle

# 检查 QML 语法
qmlformat <file.qml>
```

## 安装（已配置）

本主题已在当前系统上安装，配置如下：

| 项目 | 状态 |
|------|------|
| Hyprland | ✅ 已安装 (v0.55.2) |
| Quickshell | ✅ 已安装 (v0.3.0) |
| 显示管理器 | GDM（可从登录界面选择 Hyprland 会话）|

### Hyprland 配置
- 配置文件：`~/.config/hypr/hyprland.conf`
- Quickshell 自动启动：`exec-once = quickshell -c /home/master/项目/Persona-Quickshell/shell.qml`
- 搜索面板快捷键：`SUPER + R` 或 `SUPER + Q`

### 已安装的依赖
- foot（终端）、rofi（应用启动器）、grim+slurp（截图）
- brightnessctl（亮度控制）、playerctl（媒体控制）
- qt6-wayland、qt6-multimedia-gstreamer（Qt6 支持）
- Linux Biolinum、Noto CJK、Material Symbols、Glirock 字体

## 架构

```
shell.qml                  ← 入口文件（主循环 + 组件加载）
Data/                      ← 单例数据源（Colors, Time, Globals, 系统服务）
Layers/                    ← 桌面层面板层组件（Overlay/Bottom 层）
Widgets/                   ← 可复用组件（过渡动画、Marquee、WallpaperEngine 等）
Widgets/Info/              ← 系统信息组件（CPU/内存/网络/蓝牙）
Assets/                    ← 资源文件（图片、视频、字体、着色器）
Assets/shaders/            ← QSB 格式着色器（motion, parallax, ripple, stars）
Assets/ScreenShaders/      ← Hyprland 屏幕着色器（blue light, greyscale, invert）
Tests/                     ← 测试/实验性 QML 文件
```

### Layers（层组件）

每个 Layer 是一个 `Scope`，内含 `PanelWindow`，通过 `WlrLayershell` 定位：

| Layer | 层 | 用途 |
|-------|------|---------|
| `Capsule.qml` | `WlrLayer.Bottom` | 音乐播放器控制（Mpris, 专辑封面） |
| `Clock.qml` | `WlrLayer.Bottom` | 时间/日期/月相显示，波浪动画 |
| `AppDrawer.qml` | `WlrLayer.Overlay` | 应用启动器 + 暂停菜单 + 设置 + 日历 |
| `VolumeOsd.qml` | `WlrLayer.Overlay` | 音量 OSD（Pipewire） |
| `BrightnessOsd.qml` | `WlrLayer.Overlay` | 亮度 OSD（sysfs） |
| `Searchapp.qml` | `WlrLayer.Top` | 应用搜索面板（IPC 控制） |

### Widgets（可复用组件）

- `WallpaperEngine.qml` — 使用着色器的壁纸引擎（parallax, ripple, motion 等）
- `Marquee.qml` — 文本跑马灯组件
- `P3rTransition.qml` / `P3rTransition2.qml` — P3 风格入场过渡动画
- `CavaVisualizer.qml` — 音频可视化（需要 Qt6-Cava-plugin）
- `Info/SysInfo.qml` — CPU/内存/磁盘监控 (Singleton)
- `Info/NetInfo.qml` — WiFi 网络管理 (Singleton)
- `Info/BluetoothInfo.qml` — 蓝牙设备管理 (Singleton)

## QML 编码约定

### 导入模式
```qml
import Quickshell
import Quickshell.Wayland
import QtQuick
import "../Data" as Dat     // 数据层
import "../Widgets" as Wid  // 组件层
```

### 数据层访问
- 颜色：`Dat.Colors.color1`, `Dat.Colors.background` 等
- 时间：`Dat.Time.time`, `Dat.Time.date`, `Dat.Time.weekday`, `Dat.Time.daytime`
- 鼠标位置（用于视差）：`Dat.Globals.mouseOffsetX/Y`

### 组件模式
- Layer: `Scope` + `Variants { model: Quickshell.screens }` + `PanelWindow`
- 属性声明：`required property var modelData` 用于 Variants 模板
- 动画：优先使用 `Behavior on <prop>` + `NumberAnimation` / `ColorAnimation`
- 延迟加载：`LazyLoader { active: true }`

### 颜色主题
使用 `Data/Colors.qml` 中定义的 Pywal16 颜色（material design 风格调色板）。
- `color0`–`color15`：标准 16 色
- `color1`（蓝绿）常用于主强调色
- `color3`（青蓝）常用于次要强调色

### 系统服务
- Hyprland IPC：`Quickshell.Hyprland`
- Pipewire 音频：`Quickshell.Services.Pipewire`
- MPRIS 音乐：`Quickshell.Services.Mpris`
- 蓝牙：`Quickshell.Bluetooth`
- 文件读取：`Quickshell.Io` (FileView)
- 进程管理：`Quickshell.Io` (Process)

## 已知问题与注意事项

1. **Cava 插件**：`CavaVisualizer.qml` 依赖外部 `Qt6-Cava-plugin`，若未安装可安全删除该文件及相关引用。
2. **电源管理**：`P3rpause.qml` 使用 `loginctl` 命令（poweroff/reboot/terminate-session），可根据需要替换。
3. **屏幕着色器**：`OptionsList.qml` 通过 `hyprctl` 动态切换 Hyprland 屏幕着色器（蓝光/灰度/反转）。
4. **字体**：项目中使用了 Glirock、Linux Biolinum、Microsoft Yahei、Bahnschrift 等字体，缺失时可能显示异常。
5. **视差效果**：`Globals.qml` 中的 `mouseOffsetX/Y` 由 `WallpaperEngine` 的 MouseArea 驱动，所有视差动画通过 Behavior 缓动。
6. **IPC 接口**：`Searchapp.qml` 通过 `IpcHandler` 暴露 `toggle`/`open`/`close` 方法，需通过 Hyprland 快捷键调用。
