import QtQuick

Rectangle {
    id: control

    signal clicked()

    property real insetX: -Math.max(44 - width, 0)
    property real insetY: -Math.max(44 - height, 0)

    width: 150 * Global.sizes.scale
    height: width
    radius: width / 2
    color: "black"

    property alias source: _ico.source
    property alias sourceSize: _ico.sourceSize
    property alias iconColor: _ico.color

    DxIconColored {
        id: _ico
        anchors.centerIn: parent

        source: "images/search.svg"
    }

    Item {
        anchors.fill: parent
        anchors.leftMargin: control.insetX / 2
        anchors.rightMargin: control.insetX / 2
        anchors.topMargin: control.insetY / 2
        anchors.bottomMargin: control.insetY / 2
        // opacity: 0.75

        TapHandler {
            gesturePolicy: TapHandler.WithinBounds
            onTapped: control.clicked()
        }
    }
}
