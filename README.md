<h1 align="center">Persona Quickshell</h1>

<div align="center">

[![QML](https://img.shields.io/badge/QML-Quickshell-7aa2f7?style=for-the-badge&logo=qt&logoColor=white)](https://quickshell.outfoxxed.me)
[![Stars](https://img.shields.io/github/stars/YuNaitang/Persona-Quickshell?style=for-the-badge&color=e0af68&logoColor=white)](https://github.com/YuNaitang/Persona-Quickshell/stargazers)
[![Hyprland](https://img.shields.io/badge/Hyprland-%E5%B7%B2%E6%94%AF%E6%8C%81-2ac3de?style=for-the-badge&logoColor=white)](https://hyprland.org)
[![Forked from](https://img.shields.io/badge/%E8%A1%8D%E7%94%9F%E8%87%AA-Yujonpradhananga-9ece6a?style=for-the-badge&logoColor=white)](https://github.com/Yujonpradhananga/Persona-Quickshell-)

</div>

<https://github.com/user-attachments/assets/7e6fd291-dd28-48fa-83aa-81556558b132>

---

## 依赖安装

### 插件

使用自定义 Cava 音频可视化插件：
**链接：** <https://github.com/Yujonpradhananga/Qt6-Cava-plugin>

你可以手动构建该插件，也可以直接删除 `CavaVisualizer.qml` 文件以及 `WallpaperEngine.qml` 中的相关代码（第 171-180 行）：

```qml
// 删除这些代码
CavaVisualizer {
  id: s1_cava
  anchors {
    left: parent.left
    right: parent.right
    top: parent.top
    topMargin: 0
  }
  height: 555
}
```

### 使用字体

- Glirock（时间显示）
- Montserrat（UI 元素）
- Bebas Neue（强调文本）
- Linux Biolinum（音乐播放器）
- Microsoft Yahei / Noto CJK（中文字形）
- Material Symbols Rounded（图标）
- ProggyCleanTT（菜单标题）

---

## 快速开始

### Hyprland 配置

创建 `~/.config/hypr/hyprland.conf`，添加以下内容：

```
# 登录时自动启动
exec-once = qs -p /path/to/Persona-Quickshell/

# 快捷键打开搜索面板
bind = SUPER, R, exec, qs -p /path/to/Persona-Quickshell/ ipc call searchapp toggle
bind = SUPER, Q, exec, qs -p /path/to/Persona-Quickshell/ ipc call searchapp toggle
```

然后在登录管理器中选择 **Hyprland** 会话即可。

### 直接运行

```bash
# 在项目目录中运行
qs -p /path/to/Persona-Quickshell/
```

### IPC 控制

```bash
# 开关搜索面板
qs -p /path/to/Persona-Quickshell/ ipc call searchapp toggle
```

---

## 致谢

- 原作者：**[Yujon Pradhananga](https://github.com/YujonPradhananga)**
- 壁纸来源：[Steam 创意工坊](https://steamcommunity.com/sharedfiles/filedetails/?id=3151551777)
- 灰度着色器来自 [@snes19xx](https://github.com/snes19xx) 的 [surface-dots](https://github.com/snes19xx/surface-dots/blob/main/.config/hypr/shaders/reading_mode.glsl)
- 音乐播放器封面实现参考 [Rexcrazy804](https://github.com/Rexcrazy804) 的 [Zaphkiel](https://github.com/Rexcrazy804/Zaphkiel)
- 感谢 [blairxu13](https://github.com/blairxu13) 的 [persona3-website](https://github.com/blairxu13/persona3-website)

### 电源菜单

电源菜单使用 `loginctl` 命令（关机/重启/注销），可根据需要自行替换。

---

## 许可证

MIT License — 可自由使用和修改。

原作者：[Yujon Pradhananga](https://github.com/YujonPradhananga)  
Fork 维护：[YuNaitang](https://github.com/YuNaitang)
