import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: control

    property int padding: Global.sizes.defaultPadding
    property bool checked: false
    property string text

    width: _content.width + padding * 2
    height: _content.height + padding * 2

    RowLayout {
        id: _content
        anchors.centerIn: parent

        DxLabel {
            text: control.text
        }

        DxIconColored {
            source: "images/" + (control.checked ? "toggle_on.svg" : "toggle_off.svg")
            sourceSize {
                width: 100 * Global.sizes.scale
                height: 100 * Global.sizes.scale
            }
        }
    }

    TapHandler {
        gesturePolicy: TapHandler.WithinBounds
        onTapped: control.checked = !control.checked
    }
}
