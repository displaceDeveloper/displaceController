import QtQuick

Rectangle {
    id: control

    signal clicked()

    property alias text: _lbl.text
    property bool highlight: false
    property real padding: Global.sizes.defaultPadding

    color: control.highlight ? "white" : "#1d1d1d"
    border.width: 1
    border.color: "#d9d9d9"
    radius: 40 * Global.sizes.scale

    width: Math.max(
        _lbl.width + control.padding * 2,
        600 * Global.sizes.scale
    )

    height: _lbl.height + control.padding * 2

    DxLabel {
        id: _lbl
        anchors.centerIn: parent
        color: control.highlight ? "black" : "white"
    }

    TapHandler {
        gesturePolicy: TapHandler.WithinBounds
        onTapped: control.clicked()
    }
}
