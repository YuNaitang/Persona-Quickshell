# Blue Archive（碧蓝档案）主题化进度清单

> 将 Persona-Quickshell 改造为 Blue Archive 风格的一站式跟踪表。
> 素材放入对应路径后，请勾选 ✅ 以追踪进度。

---

## 📁 使用说明

1. 按照下方路径**替换对应素材文件**（保持**相同的文件名和扩展名**）
2. 替换完成后将 `[ ]` 改为 `[x]`
3. 所有素材就位后即可体验完整的 BA 主题

---

## 一、🌅 壁纸与背景图

### 传统图片壁纸

| # | 路径 | 规格要求 | 进度 |
|---|------|----------|------|
| 1 | `Assets/p3r imgs/bg.png` | 3840×2194 PNG，主壁纸背景（学园/天空/都市）| `[ ]` |
| 2 | `Assets/p3r imgs/bars.png` | 3840×2194 PNG，装饰条/光效 | `[ ]` |
| 3 | `Assets/p3r imgs/fg.png` | 3840×2194 PNG，前景层（角色剪影/光环）| `[ ]` |
| 4 | `Assets/Depth masks/cloudmask.png` | 3840×2194 RGBA，云层深度遮罩 | `[ ]` |
| 5 | `Assets/Depth masks/cloudmaskk.png` | 3840×2194 RGBA，备用遮罩 | `[ ]` |
| 6 | `Assets/Depth masks/makotodepth.png` | **960×549 灰度图**，视差深度（黑近白远）| `[ ]` |
| 7 | `Assets/Depth masks/normalmaps/waterripplenormal.png` | **256×256 法线贴图**，波纹效果 | `[ ]` |

### 网页壁纸（Wallpaper Engine 移植）⚡ 新方案

> 使用 Qt WebEngine 加载 HTML 壁纸，无需图片/着色器。
> 对应组件：`Widgets/WebWallpaper.qml`

| # | 路径 | 说明 | 进度 |
|---|------|------|------|
| 🌐 | `Assets/web-wallpaper/index.html` | Wallpaper Engine 导出的网页壁纸入口 | `[ ]` |
| 🌐 | `Assets/web-wallpaper/...` | 配套的 CSS/JS/图片资源 | `[ ]` |

**移植步骤：**
1. 在 Wallpaper Engine 中右键壁纸 → **打开文件位置**
2. 将整个文件夹（含 `index.html` + 资源）复制到 `Assets/web-wallpaper/`
3. 修改 `Widgets/WebWallpaper.qml` 中的 `wallpaperPath` 路径
4. 在 `shell.qml` 中将 `WallpaperEngine` 替换为 `WebWallpaper`

---

## 二、🧑‍🎨 角色立绘

| # | 路径 | 规格要求 | 进度 |
|---|------|----------|------|
| 8 | `Assets/components/mainm.jpeg` | ~1440×2372，着色器1（蓝光滤镜）角色 | `[ ]` |
| 9 | `Assets/components/mainm2.jpeg` | ~1440×2417，着色器2（灰度模式）角色 | `[ ]` |
| 10 | `Assets/components/mainf.jpeg` | ~1440×2388，着色器3（反转色彩）角色 | `[ ]` |
| 11 | `Assets/components/char1.png` | ~1601×685，选项菜单角色头像1 | `[ ]` |
| 12 | `Assets/components/char2.png` | ~1601×685，选项菜单角色头像2 | `[ ]` |
| 13 | `Assets/components/char3.png` | ~1601×685，选项菜单角色头像3 | `[ ]` |

---

## 三、🎵 音乐播放器

| # | 路径 | 规格要求 | 进度 |
|---|------|----------|------|
| 14 | `Assets/components/player.png` | 1280×720 PNG，播放器对话框背景 | `[ ]` |
| 15 | `Assets/components/AlbumCover-by-Squirrel-Modeller.svg` | SVG，专辑封面圆形遮罩 | `[ ]` |

---

## 四、⚡ 电源图标

| # | 路径 | 规格要求 | 进度 |
|---|------|----------|------|
| 16 | `Assets/iconpack/shutdown.png` | 468×280 PNG，关机（普通）| `[ ]` |
| 17 | `Assets/iconpack/shutdown1.png` | 468×280 PNG，关机（悬停）| `[ ]` |
| 18 | `Assets/iconpack/restart.png` | 468×280 PNG，重启（普通）| `[ ]` |
| 19 | `Assets/iconpack/restart1.png` | 468×280 PNG，重启（悬停）| `[ ]` |
| 20 | `Assets/iconpack/logout.png` | 468×280 PNG，注销（普通）| `[ ]` |
| 21 | `Assets/iconpack/logout1.png` | 468×280 PNG，注销（悬停）| `[ ]` |

---

## 五、🌊 时钟波浪图 ×16

| # | 路径 | 规格要求 | 进度 |
|---|------|----------|------|
| 22 | `Assets/img/wave1.png` ~ `wave16.png` | **全部 500×140** RGBA PNG ×16 张 | `[ ]` |

> 共 16 个文件：`wave1.png` ~ `wave16.png`，尺寸必须完全一致。

---

## 六、🎬 视频素材

| # | 路径 | 规格要求 | 进度 |
|---|------|----------|------|
| 23 | `Assets/videos/Resume.mp4` | **2560×1440**，~10.3s，H.264，循环播放 | `[ ]` |
| 24 | `Assets/videos/Options.mp4` | **1280×720**，~11.2s，H.264，循环播放 | `[ ]` |
| 25 | `Assets/p3r menu/part2.mp4` | **1920×1080**，~4.7s，H.264，过渡动画 | `[ ]` |
| 26 | `Assets/p3r menu/part3.mp4` | **1920×1080**，~6.7s，H.264，循环背景 | `[ ]` |

### PNG 序列帧（电源菜单开场）

| # | 路径 | 进度 |
|---|------|------|
| 27 | `Assets/p3r menu/png/pngseq00.png` | `[ ]` |
| 28 | `Assets/p3r menu/png/pngseq01.png` | `[ ]` |
| 29 | `Assets/p3r menu/png/pngseq02.png` | `[ ]` |
| 30 | `Assets/p3r menu/png/pngseq03.png` | `[ ]` |
| 31 | `Assets/p3r menu/png/pngseq04.png` | `[ ]` |
| 32 | `Assets/p3r menu/png/pngseq05.png` | `[ ]` |
| 33 | `Assets/p3r menu/png/pngseq06.png` | `[ ]` |
| 34 | `Assets/p3r menu/png/pngseq07.png` | `[ ]` |
| 35 | `Assets/p3r menu/png/pngseq08.png` | `[ ]` |
| 36 | `Assets/p3r menu/png/pngseq09.png` | `[ ]` |
| 37 | `Assets/p3r menu/png/pngseq10.png` | `[ ]` |
| 38 | `Assets/p3r menu/png/pngseq11.png` | `[ ]` |

---

## 七、🎨 QML 代码修改

### 7.1 颜色主题（`Data/Colors.qml`）

| # | 修改项 | BA 推荐值 | 进度 |
|---|--------|-----------|------|
| 39 | `background` | `#1a1a2e`（深蓝黑）| `[ ]` |
| 40 | `foreground` | `#e0e0e0`（浅灰）| `[ ]` |
| 41 | `color1`（强调色）| `#6C9BD2`（BA主题蓝）| `[ ]` |
| 42 | `color3`（次要强调）| `#F4D03F`（金色光环）| `[ ]` |
| 43 | `color5`（点缀色）| `#E8A0BF`（BA粉）| `[ ]` |
| 44 | `color6` | `#7EC8E3`（天蓝）| `[ ]` |

### 7.2 文本描述

| # | 文件 | 修改内容 | 进度 |
|---|------|----------|------|
| 45 | `Data/Time.qml` | 将 `"Dark Hour"`、月相名等改为 BA 风格 | `[ ]` |
| 46 | `Layers/Options.qml` | 着色器模式标签 → BA 风格名称 | `[ ]` |
| 47 | `Layers/OptionsList.qml` | 着色器描述 → BA 风格 | `[ ]` |
| 48 | `Layers/Resume.qml` | 菜单标题/卡片标签 → BA 风格 | `[ ]` |
| 49 | `Layers/AppDrawer.qml` | 侧边栏按钮标签 → BA 风格 | `[ ]` |
| 50 | `Layers/Searchapp.qml` | 搜索面板文字 → BA 风格 | `[ ]` |
| 51 | `README.md` | 项目说明改为 BA 主题 | `[ ]` |
| 52 | `Widgets/WebWallpaper.qml` | **新建** — 使用 WebEngine 加载网页壁纸 | `[ ]` |
| 53 | `shell.qml` | 将 `WallpaperEngine` 替换为 `WebWallpaper` | `[ ]` |

### 7.3 命名空间

| # | 文件 | 当前值 | 改为 | 进度 |
|---|------|--------|------|------|
| 55 | `Capsule.qml` | `"music-player-interactive"` | `"ba.music"` | `[ ]` |
| 56 | `Clock.qml` | `"persona.clock"` | `"ba.clock"` | `[ ]` |
| 57 | `Searchapp.qml` | `"searchapp"` / `target:"searchapp"` | `"ba.search"` | `[ ]` |
| 58 | `WebWallpaper.qml` | `"wallpaper.engine"` | `"ba.wallpaper"` | `[ ]` |

---

## 八、🔤 字体（可选）

| # | 当前字体 | 用途 | BA 替代建议 | 进度 |
|---|---------|------|------------|------|
| 56 | `"Glirock"` | 时间显示 | BA 风格手写体 | `[ ]` |
| 57 | `"Bahnschrift Condensed"` | 星期标签 | 可保持或替换 | `[ ]` |
| 58 | `"Linux Biolinum"` | 音乐播放器 | BA 风格字体 | `[ ]` |
| 59 | `"ProggyCleanTT"` | 菜单标题 | BA 风格像素体 | `[ ]` |
| 60 | `"SimHei"` | 月相名称 | 可保持 | `[ ]` |

---

## 九、📦 可选删除

| # | 文件 | 说明 | 进度 |
|---|------|------|------|
| 61 | `Widgets/CavaVisualizer.qml` | 音频可视化（依赖三方插件）| `[ ]` |
| 62 | `Assets/shaders/` 全部 | 壁纸着色器（可保留或替换）| `[ ]` |

---

## 进度统计

```
素材替换:  0/40  ░░░░░░░░░░░░   0%   (38 传统 + 2 网页壁纸)
代码修改:  0/20  ░░░░░░░░░░░░   0%   (含 WebWallpaper 新建组件)
字体修改:  0/5   ░░░░░░░░░░░░   0%
------------------------------------------------
总计:      0/65  ░░░░░░░░░░░░   0%
```

> 每次勾选后，手动更新上方的进度数字和进度条即可。

---

## BA 主题配色速查

```qml
// Data/Colors.qml 推荐值
background: "#1a1a2e"      // 主背景 - 深蓝黑
foreground: "#e0e0e0"      // 主文字 - 浅灰

color1:     "#6C9BD2"      // BA主题蓝（主色调）
color2:     "#A8D5BA"      // 柔和绿
color3:     "#F4D03F"      // 金色光环（强调色）
color4:     "#7EC8E3"      // 天蓝
color5:     "#E8A0BF"      // BA粉（点缀色）
color6:     "#D4A5E5"      // 淡紫
color7:     "#e0e0e0"      // 浅灰（文字色）

// 硬编码颜色替换建议
蓝色调:     "#1a4fa8" → "#2B5FBA"  // BA 标准蓝
金色:       "#ffe700" → "#F4D03F"  // BA 光环金
白色:       "#ffffff" → "#F5F5F5"  // 柔和白
透明黑:     "#0b113d" → "#1a1a2e"  // 深色背景
亮蓝:       "#8ef5ff" → "#A8D8EA"  // 淡蓝高光
红色:       "#c4001a" → "#E74C3C"  // 警告红
```
