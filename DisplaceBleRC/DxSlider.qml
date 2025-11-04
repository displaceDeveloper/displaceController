import QtQuick
import QtQuick.Controls

Slider {
    id: control

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 878 * Global.sizes.scale
        implicitHeight: 1
        width: control.availableWidth
        height: implicitHeight
        color: "#FFFFFF"

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: "#21be2b"
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 65 * Global.sizes.scale
        implicitHeight: 65 * Global.sizes.scale
        radius: width / 2
        color: "#D9D9D9"
    }
}
