import QtQuick

Rectangle {
    id: control

    signal clicked()

    property alias source: _ico.source
    property alias sourceSize: _ico.sourceSize

    border.width: Math.max(1, 2 * Global.sizes.scale)
    border.color: "white"
    color: "transparent"
    width: 280 * Global.sizes.scale
    height: width
    radius: 90 * Global.sizes.scale

    DxIconColored {
        id: _ico
        anchors.centerIn: parent
        sourceSize {
            width: 140 * Global.sizes.scale
            height: 140 * Global.sizes.scale
        }
    }

    TapHandler {
        gesturePolicy: TapHandler.WithinBounds
        onTapped: control.clicked()
    }
}
