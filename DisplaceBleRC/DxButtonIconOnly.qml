import QtQuick
import QtQuick.Controls

Item {
    id: control

    signal clicked()

    property alias source: _ico.source
    property alias sourceSize: _ico.sourceSize
    property alias color: _ico.color
    property real padding: 0
    property real insetX: -Math.max(44 - width, 0)
    property real insetY: -Math.max(44 - height, 0)

    property alias rcBk: _rcBk

    width: _ico.width + padding * 2
    height: _ico.height + padding * 2

    Rectangle {
        id: _rcBk
        anchors.fill: parent
        color: "transparent"
    }

    DxIconColored {
        id: _ico
        anchors.centerIn: parent
    }

    Item {
        anchors.fill: parent
        anchors.leftMargin: control.insetX / 2
        anchors.rightMargin: control.insetX / 2
        anchors.topMargin: control.insetY / 2
        anchors.bottomMargin: control.insetY / 2
        // opacity: 0.7

        TapHandler {
            gesturePolicy: TapHandler.WithinBounds
            onTapped: control.clicked()
        }
    }
}
