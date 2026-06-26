<h1 align="center">Persona Quickshell</h1>

<div align="center">

[![QML](https://img.shields.io/badge/QML-Quickshell-7aa2f7?style=for-the-badge&logo=qt&logoColor=white)](https://quickshell.outfoxxed.me)
[![Stars](https://img.shields.io/github/stars/YuNaitang/Persona-Quickshell?style=for-the-badge&color=e0af68&logoColor=white)](https://github.com/YuNaitang/Persona-Quickshell/stargazers)
[![Hyprland](https://img.shields.io/badge/Hyprland-supported-2ac3de?style=for-the-badge&logoColor=white)](https://hyprland.org)
[![Forked from](https://img.shields.io/badge/Forked%20from-Yujonpradhananga-9ece6a?style=for-the-badge&logoColor=white)](https://github.com/Yujonpradhananga/Persona-Quickshell-)

</div>

<https://github.com/user-attachments/assets/7e6fd291-dd28-48fa-83aa-81556558b132>

---

## Dependencies

### Plugins

A custom cava plugin is used here:
**Link:** <https://github.com/Yujonpradhananga/Qt6-Cava-plugin>

You can build the plugin manually or if you don't want to manually build it and go through the installation process, you can delete the `CavaVisualizer.qml` file and delete these lines 171-180 from the `WallpaperEngine.qml` file:

```qml
//delete these
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

### Fonts Used

- Glirock (for the time)
- Montserrat (for UI elements)
- Bebas Neue (for accent text)
- Linux Biolinum (for music player)
- Microsoft Yahei / Noto CJK (for CJK glyphs)
- Material Symbols Rounded (for icons)

---

## Quick Start

### Hyprland Setup

Create `~/.config/hypr/hyprland.conf` with:

```
# Start Persona-Quickshell on login
exec-once = qs -p /path/to/Persona-Quickshell/

# Keybind to open search panel (SUPER+R or SUPER+Q)
bind = SUPER, R, exec, qs -p /path/to/Persona-Quickshell/ ipc call searchapp toggle
bind = SUPER, Q, exec, qs -p /path/to/Persona-Quickshell/ ipc call searchapp toggle
```

Then select **Hyprland** from your display manager login screen.

### Running Without Hyprland

```bash
# From the project directory
qs -p /path/to/Persona-Quickshell/
```

### IPC

```bash
# Toggle the search app panel
qs -p /path/to/Persona-Quickshell/ ipc call searchapp toggle
```

---

## Credits

- Original creator: **[Yujon Pradhananga](https://github.com/Yujonpradhananga)**
- The wallpaper is from: [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3151551777)
- The greyscale shader is from [@snes19xx](https://github.com/snes19xx)'s [surface-dots](https://github.com/snes19xx/surface-dots/blob/main/.config/hypr/shaders/reading_mode.glsl)
- The media player's album art implementation is taken from [Rexcrazy804](https://github.com/Rexcrazy804)'s [Zaphkiel](https://github.com/Rexcrazy804/Zaphkiel)
- Shoutout to [blairxu13](https://github.com/blairxu13)'s [persona3-website](https://github.com/blairxu13/persona3-website)

### Power Menu

The power menu currently uses `loginctl` commands, feel free to change them to your needs.

---

## License

MIT License — feel free to use and modify as needed.

Created by [Yujon Pradhananga](https://github.com/Yujonpradhananga).  
Forked and maintained by [YuNaitang](https://github.com/YuNaitang).
