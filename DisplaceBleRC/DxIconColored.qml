import QtQuick
import QtQuick.Effects

Item {
    id: control

    implicitWidth: _img.width
    implicitHeight: _img.height

    property alias source: _img.source
    property alias sourceSize: _img.sourceSize
    property alias color: _effect.colorizationColor

    Image {
        id: _img
        anchors.centerIn: parent
        visible: false

        sourceSize {
            width: Global.sizes.defaultIconSize
            height: Global.sizes.defaultIconSize
        }
    }

    MultiEffect {
        id: _effect
        anchors.fill: _img
        source: _img
        colorization: 1.0
        colorizationColor: "white"
    }
}
