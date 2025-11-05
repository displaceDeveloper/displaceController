import QtQuick

Item {
    id: control

    signal clicked()

    property alias text: _lbl.text
    property alias font: _lbl.font
    property alias color: _lbl.color
    property alias textFormat: _lbl.textFormat

    property real insetX: -Math.max(44 - width, 0)
    property real insetY: -Math.max(44 - height, 0)

    width: _lbl.width
    height: _lbl.height

    DxLabel {
        id: _lbl
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
