pragma Singleton
import QtQuick
import QtCore

Item {
    id: control
    visible: false

    QtObject {
        id: _colors

        readonly property color background: "black"
        readonly property color text: "white"
        readonly property color textMid: "#6f6f6f"
    }
    property alias colors: _colors

    QtObject {
        id: _sizes

        readonly property real scale: 0.25
        // 0.3 - real phone
        // 0.25 - macos

        readonly property int width: 1474 * scale
        readonly property int height: 3060 * scale

        readonly property int logoWidth: 600 * scale
        readonly property int logoHeight: 38 * scale

        readonly property int defaultMargin: 50 * scale
        readonly property int defaultPadding: 50 * scale
        readonly property int defaultIconSize: 80 * scale
        readonly property int defaultSpacing: 50 * scale
    }
    property alias sizes: _sizes
}
