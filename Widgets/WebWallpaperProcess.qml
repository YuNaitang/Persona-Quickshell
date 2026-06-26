import QtQuick
import QtQuick.Window
import QtWebEngine
import QtMultimedia

/**
 * WebWallpaperProcess — 独立运行的网页壁纸进程
 *
 * 此文件由 quickshell 独立启动，作为单独的壁纸进程运行。
 * 不受主 quickshell 的 WebEngine 编译限制影响。
 *
 * 使用方法：
 *   quickshell -p /path/to/WebWallpaperProcess.qml
 *
 * 或在 hyprland.conf 中添加：
 *   exec-once = quickshell -p /path/to/Widgets/WebWallpaperProcess.qml
 */

Window {
    id: root
    visible: true
    color: "#000000"
    title: "BA Web Wallpaper"

    /// 壁纸 index.html 路径
    property string wallpaperPath: Qt.resolvedUrl("../Assets/web-wallpaper/index.html").toString()

    /// 是否启用音频
    property bool enableAudio: true

    Component.onCompleted: {
        // 全屏并置底
        showFullScreen();
        root.requestActivate();
    }

    WebEngineView {
        id: webView
        anchors.fill: parent

        url: root.wallpaperPath
        backgroundColor: Qt.rgba(0, 0, 0, 0)

        settings {
            javascriptEnabled: true
            autoLoadImages: true
            pluginsEnabled: true
            localContentCanAccessFileUrls: true
            localContentCanAccessRemoteUrls: false
            errorPageEnabled: false
            fullScreenSupportEnabled: true
        }

        onLoadingChanged: function(load) {
            if (load.status === WebEngineLoadStatus.LoadSucceededStatus) {
                console.log("[WebWallpaper] 加载成功:", root.wallpaperPath);
                // 注入样式确保全屏
                webView.runJavaScript(`
                    (function() {
                        document.body.style.margin = '0';
                        document.body.style.padding = '0';
                        document.body.style.overflow = 'hidden';
                        document.body.style.width = '100vw';
                        document.body.style.height = '100vh';
                        document.documentElement.style.width = '100%';
                        document.documentElement.style.height = '100%';
                        var meta = document.createElement('meta');
                        meta.name = 'viewport';
                        meta.content = 'width=device-width, initial-scale=1.0';
                        document.head.appendChild(meta);
                    })();
                `);
            } else if (load.status === WebEngineLoadStatus.LoadFailedStatus) {
                console.error("[WebWallpaper] 加载失败:", load.errorString);
            }
        }
    }

    // 壁纸音频（网页自带音频不播放时使用此备用）
    Audio {
        id: bgm
        source: ""
        loops: Audio.Infinite
        volume: 0.5
        autoPlay: false
    }
}
