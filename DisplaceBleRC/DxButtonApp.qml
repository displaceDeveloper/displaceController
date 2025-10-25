import QtQuick
import QtQuick.Effects

Item {
    id: control

    signal clicked()

    property alias source: _ico.source
    property alias sourceSize: _ico.sourceSize

    width: 141 * Global.sizes.scale
    height: width

    Rectangle {
        id: rcIcon

        anchors.fill: parent
        visible: false

        radius: width / 2
        color: "white"

        Image {
            id: _ico
            anchors.fill: parent

            fillMode: Image.PreserveAspectFit

            sourceSize {
                width: _ico.width
                height: _ico.height
            }
        }
    }

    Item {
        id: rcMask

        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
            anchors.fill: parent
            radius: width / 2
            color: "black"
        }
    }

    MultiEffect {
        anchors.fill: parent
        source: rcIcon
        maskEnabled: true
        maskSource: rcMask
    }

    TapHandler {
        gesturePolicy: TapHandler.WithinBounds
        onTapped: control.clicked()
    }
}
