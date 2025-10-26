import QtQuick

Rectangle {
    id: control

    signal clicked()

    property alias text: _lbl.text
    property alias textColor: _lbl.color
    property bool highlight: false
    property real padding: Global.sizes.defaultPadding
    property alias contentWidth: _lbl.width

    color: control.highlight ? "white" : "#1d1d1d"
    border.width: Global.sizes.defaultBorderWidth
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
