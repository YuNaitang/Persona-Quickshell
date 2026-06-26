#!/usr/bin/python3.14
"""
BA Web Wallpaper — 独立运行的 Blue Archive 网页壁纸进程

原理：
  使用 PyQt6 WebEngine 加载 HTML 壁纸。
  独立于 Quickshell 运行，不受其 WebEngine 编译限制。

使用方法：
  python3 ba-wallpaper.py
  # 或设置开机启动

依赖安装：
  sudo pacman -S python-pyqt6 python-pyqt6-webengine
"""

import sys
import os
import signal

from PyQt6.QtCore import QUrl, Qt
from PyQt6.QtGui import QSurfaceFormat
from PyQt6.QtWidgets import QApplication
from PyQt6.QtWebEngineWidgets import QWebEngineView
from PyQt6.QtWebEngineCore import QWebEngineSettings

# ── 壁纸路径 ─────────────────────────────────────────────────
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
WALLPAPER_URL = QUrl.fromLocalFile(os.path.join(SCRIPT_DIR, "index.html")).toString()
# ──────────────────────────────────────────────────────────────


class WallpaperWindow(QWebEngineView):
    """全屏无边框网页壁纸窗口"""

    def __init__(self):
        super().__init__()

        # 窗口设置：全屏、置底、无边框
        self.setWindowTitle("BA Wallpaper")
        self.setWindowFlags(
            Qt.WindowType.FramelessWindowHint
            | Qt.WindowType.WindowStaysOnBottomHint
            | Qt.WindowType.MaximizeUsingFullscreenGeometryHint
        )
        self.setAttribute(Qt.WidgetAttribute.WA_TranslucentBackground, False)
        self.setAttribute(Qt.WidgetAttribute.WA_X11NetWmWindowTypeDesktop, True)
        self.setCursor(Qt.CursorShape.BlankCursor)

        # WebEngine 设置
        settings = self.settings()
        settings.setAttribute(QWebEngineSettings.WebAttribute.JavascriptEnabled, True)
        settings.setAttribute(QWebEngineSettings.WebAttribute.AutoLoadImages, True)
        settings.setAttribute(QWebEngineSettings.WebAttribute.PluginsEnabled, True)
        settings.setAttribute(QWebEngineSettings.WebAttribute.LocalContentCanAccessFileUrls, True)
        settings.setAttribute(QWebEngineSettings.WebAttribute.FullScreenSupportEnabled, True)
        settings.setAttribute(QWebEngineSettings.WebAttribute.ErrorPageEnabled, False)

        # 加载壁纸
        self.page().setBackgroundColor(Qt.GlobalColor.black)
        self.load(QUrl(WALLPAPER_URL))

        # 加载完成时注入样式
        self.loadFinished.connect(self._on_loaded)

        # 全屏
        self.showFullScreen()

    def _on_loaded(self, ok):
        if ok:
            print(f"[BA壁纸] ✅ 加载成功: {WALLPAPER_URL}")
            self.page().runJavaScript("""
                (function() {
                    document.body.style.margin = '0';
                    document.body.style.padding = '0';
                    document.body.style.overflow = 'hidden';
                    document.body.style.width = '100vw';
                    document.body.style.height = '100vh';
                    document.documentElement.style.width = '100%';
                    document.documentElement.style.height = '100%';
                    // 自动播放音频
                    var videos = document.getElementsByTagName('video');
                    for (var v of videos) { v.muted = false; v.play(); }
                    var audios = document.getElementsByTagName('audio');
                    for (var a of audios) { a.muted = false; a.play(); }
                })();
            """)
        else:
            print(f"[BA壁纸] ❌ 加载失败: {WALLPAPER_URL}")


def main():
    # Qt 高DPI 支持
    QApplication.setHighDpiScaleFactorRoundingPolicy(
        Qt.HighDpiScaleFactorRoundingPolicy.PassThrough
    )

    app = QApplication(sys.argv)
    app.setApplicationName("BA Wallpaper")

    # 创建壁纸窗口
    wallpaper = WallpaperWindow()

    # 处理退出信号
    signal.signal(signal.SIGINT, signal.SIG_DFL)

    sys.exit(app.exec())


if __name__ == "__main__":
    main()
