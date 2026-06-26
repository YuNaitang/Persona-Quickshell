#!/bin/bash
# BA 网页壁纸启动器 — 由 Hyprland exec-once 自动调用
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland
exec /usr/bin/python3.14 "$(dirname "$0")/ba-wallpaper.py"

