import QtQuick
import QtQuick.Controls

TextField {
    id: control

    color: Global.colors.text
    placeholderTextColor: Global.colors.textMid

    background: Item {
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: Global.colors.textMid
        }
    }
}
