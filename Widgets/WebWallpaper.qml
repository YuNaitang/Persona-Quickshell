import QtQuick
import QtWebEngine
import Quickshell
import Quickshell.Wayland
import qs.Data as Dat

/**
 * WebWallpaper — 使用 Qt WebEngine 加载网页壁纸（如 Wallpaper Engine 的 web 壁纸）
 *
 * 使用方法：
 *   1. 将 Wallpaper Engine 导出的 web 壁纸文件夹放入 Assets/web-wallpaper/
 *   2. 修改下方 wallpaperPath 为 index.html 路径
 *   3. 在 shell.qml 中将 WallpaperEngine 替换为 WebWallpaper
 *
 * 素材要求：
 *   - 一个包含 index.html + CSS/JS/图片的文件夹
 *   - 所有文件必须是本地文件（不需要网络）
 *   - 推荐 Wallpaper Engine 导出时选择 "Web" 类型
 *
 * 注意：
 *   - 网页壁纸性能开销比着色器大，请确保硬件够用
 *   - 如壁纸包含音频，可通过 volume 属性调节
 */

WlrLayershell {
    id: root

    required property ShellScreen modelData

    /// 网页壁纸的 index.html 路径（相对于项目根目录）
    property string wallpaperPath: Qt.resolvedUrl("../Assets/web-wallpaper/index.html").toString()

    /// 是否启用音频（网页壁纸自带 BGM）
    property bool enableAudio: true

    /// 壁纸音量 (0.0 ~ 1.0)
    property real audioVolume: 0.5

    /// 背景音乐文件路径（为空则使用壁纸自带的音频）
    property string bgmSource: ""

    /// 是否启用鼠标交互（建议 false，让点击穿透到桌面）
    property bool interactive: false

    /// 背景色（网页加载前显示）
    property color loadingColor: "#1a1a2e"

    anchors.top: true
    anchors.left: true
    anchors.right: true
    anchors.bottom: true
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    focusable: false
    layer: WlrLayer.Bottom
    namespace: "web.wallpaper"
    screen: modelData

    // ── 加载中背景 ──
    Rectangle {
        id: loadingBg
        anchors.fill: parent
        color: root.loadingColor
        z: 0
    }

    // ── 网页壁纸引擎 ──
    WebEngineView {
        id: webView
        anchors.fill: parent
        z: 1

        // 加载本地 HTML 壁纸
        url: root.wallpaperPath

        // 背景透明（如果网页壁纸有透明区域）
        backgroundColor: Qt.rgba(0, 0, 0, 0)

        // 初始缩放
        zoomFactor: 1.0

        // 加载设置（仅支持 Qt6 WebEngine 实际存在的属性）
        settings {
            localContentCanAccessRemoteUrls: false
            localContentCanAccessFileUrls: true
            javascriptEnabled: true
            autoLoadImages: true
            pluginsEnabled: true
            errorPageEnabled: false
            fullScreenSupportEnabled: true
        }

        // ── 加载完成时 ──
        onLoadingChanged: function(load) {
            if (load.status === WebEngineLoadStatus.LoadSucceededStatus) {
                console.log("[WebWallpaper] 壁纸加载成功:", root.wallpaperPath);
                loadingBg.visible = false;

                // 注入样式确保壁纸全屏且无滚动
                webView.runJavaScript(`
                    (function() {
                        document.body.style.margin = '0';
                        document.body.style.padding = '0';
                        document.body.style.overflow = 'hidden';
                        document.body.style.width = '100vw';
                        document.body.style.height = '100vh';
                        var meta = document.createElement('meta');
                        meta.name = 'viewport';
                        meta.content = 'width=device-width, initial-scale=1.0';
                        document.head.appendChild(meta);
                    })();
                `);
            } else if (load.status === WebEngineLoadStatus.LoadFailedStatus) {
                console.error("[WebWallpaper] 壁纸加载失败:", load.errorString);
            }
        }

        // ── JavaScript 控制台输出 ──
        onJavaScriptConsoleMessage: function(message) {
            console.log("[WebWallpaper:JS]", message);
        }
    }

    // ── 加载状态提示（可选） ──
    Text {
        anchors.centerIn: parent
        z: 2
        text: "载入壁纸中..."
        color: "#888888"
        font.pixelSize: 16
        visible: loadingBg.visible
    }
}
