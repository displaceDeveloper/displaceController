import QtQuick

Rectangle {
    id: control

    signal clicked()

    width: 150 * Global.sizes.scale
    height: width
    radius: width / 2
    color: "black"

    property alias source: _ico.source
    property alias sourceSize: _ico.sourceSize

    DxIconColored {
        id: _ico
        anchors.centerIn: parent

        source: "images/search.svg"
    }

    TapHandler {
        gesturePolicy: TapHandler.WithinBounds
        onTapped: control.clicked()
    }
}
