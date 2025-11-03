import QtQuick
import QtQuick.Controls

Control {
    id: control

    signal clicked()

    property alias source: _ico.source
    property alias sourceSize: _ico.sourceSize
    property alias color: _ico.color

    background: Item {
        TapHandler {
            gesturePolicy: TapHandler.WithinBounds
            onTapped: control.clicked()
        }
    }

    contentItem: DxIconColored {
        id: _ico
    }
}
