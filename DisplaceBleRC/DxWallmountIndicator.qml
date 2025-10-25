import QtQuick
import QtQuick.Layouts

Item {
    id: control

    width: _content.width
    height: _content.height

    component WallmountCircle: Rectangle {
        width: 30 * Global.sizes.scale
        height: width
        radius: width / 2
        color: "#46F020"
    }

    GridLayout {
        id: _content
        anchors.centerIn: parent

        columns: 2

        WallmountCircle {}
        WallmountCircle {}
        WallmountCircle {}
        WallmountCircle {}
    }
}
