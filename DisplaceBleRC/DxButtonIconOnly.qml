import QtQuick
import QtQuick.Controls

Item {
    id: control

    signal clicked()

    property alias source: _ico.source
    property alias sourceSize: _ico.sourceSize
    property alias color: _ico.color
    property real padding: 0

    width: _ico.width + padding * 2
    height: _ico.height + padding * 2

    DxIconColored {
        id: _ico
        anchors.centerIn: parent
    }

    TapHandler {
        gesturePolicy: TapHandler.WithinBounds
        onTapped: control.clicked()
    }
}
