import QtQuick

Item {
    id: control

    implicitWidth: _img.width
    implicitHeight: _img.height

    property alias source: _img.source
    property alias sourceSize: _img.sourceSize

    Image {
        id: _img
        anchors.centerIn: parent

        sourceSize {
            width: Global.sizes.defaultIconSize
            height: Global.sizes.defaultIconSize
        }
    }
}
