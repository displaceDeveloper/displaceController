import QtQuick
import QtQuick.Layouts

Rectangle {
    id: control

    signal clicked()

    property alias source: _ico.source
    property alias sourceSize: _ico.sourceSize
    property alias text: _lbl.text

    property bool highlight: false
    property bool flat: false

    property real padding: Global.sizes.defaultPadding

    property color highlightBackgroundColor: "white"
    property color highlightTextColor: "black"

    readonly property real contentWidth: _content.width

    color: {
        if (control.flat) {
            return "transparent"
        }

        if (control.highlight) {
            return control.highlightBackgroundColor
        }

        return "#1d1d1d"
    }

    border.width: control.flat ? 0 : 1
    border.color: "#d9d9d9"
    radius: 40 * Global.sizes.scale

    width: Math.max(
        _content.width + control.padding * 2,
        600 * Global.sizes.scale
    )

    height: _content.height + control.padding * 2

    RowLayout {
        id: _content
        anchors.centerIn: parent

        DxIconColored {
            id: _ico
        }

        DxLabel {
            id: _lbl
            color: control.highlight ? control.highlightTextColor : "white"
        }
    }

    TapHandler {
        gesturePolicy: TapHandler.WithinBounds
        onTapped: control.clicked()
    }
}
