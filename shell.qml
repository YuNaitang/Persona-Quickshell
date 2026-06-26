//@ pragma QmlImportPath: "."
//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import "./Layers" as Lay
import "./Widgets" as Wid

ShellRoot {
    Variants {
        model: Quickshell.screens
        Scope {
            id: scopeRoot
            required property ShellScreen modelData
            // 网页壁纸方案（见下方说明）
            // 当前 Quickshell 未编译 WebEngine 支持，改用传统壁纸引擎
            Wid.WallpaperEngine {
                modelData: scopeRoot.modelData
            }
            /*
             * === 网页壁纸（WebEngine）使用说明 ===
             *
             * 当前 Quickshell 未链接 Qt WebEngine，无法直接加载 HTML 壁纸。
             * 解决方案：
             *
             * 方案一：使用独立的 Python 壁纸进程（推荐）
             *   1. pip install pywayland pywlr-layer-shell qt6-webengine
             *   2. 创建独立的壁纸加载器
             *
             * 方案二：重新编译 Quickshell 加入 WebEngine 支持
             *   1. 修改 PKGBUILD 在 depends 中添加 qt6-webengine
             *   2. 在 CMakeLists.txt 中启用 WebEngine
             *   3. 重新 makepkg -si
             *
             * 方案三：使用 xwinwrap 方式（临时方案）
             *   xwinwrap -g $(slurp) -- mpv --loop --no-audio html_snapshot.png
             *
             * 壁纸文件已在: Assets/web-wallpaper/ (3650880224/index.html)
             */
        }
    }
    Lay.Capsule {}
    Lay.Clock {}
    Lay.AppDrawer {}
    Lay.VolumeOsd {}
    Lay.BrightnessOsd {}
    Lay.Searchapp {}
}
