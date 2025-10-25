import QtQuick
import QtQuick.Layouts

Item {
    id: control

    signal clicked()

    property alias text: _lbl.text
    property alias font: _lbl.font
    property alias source: _ico.source
    property alias sourceSize: _ico.sourceSize
    property alias color: _lbl.color
    property int padding: Global.sizes.defaultPadding

    width: _content.width + padding * 2
    height: _content.height + padding * 2

    ColumnLayout {
        id: _content
        anchors.centerIn: parent

        DxIconColored {
            id: _ico
            Layout.alignment: Qt.AlignHCenter

            source: "images/power_settings_new.svg"
        }

        DxLabel {
            id: _lbl
            Layout.alignment: Qt.AlignHCenter
        }
    }

    TapHandler {
        gesturePolicy: TapHandler.WithinBounds
        onTapped: control.clicked()
    }
}
