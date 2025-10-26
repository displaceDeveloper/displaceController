import QtQuick

Item {
    id: control

    property bool horizontalScroll: false

    width: horizontalScroll ? _rc.height : _rc.width
    height: horizontalScroll ? _rc.width : _rc.height

    Rectangle {
        id: _rc
        anchors.centerIn: parent

        rotation: horizontalScroll ? 90 : 0
        width: 85 * Global.sizes.scale
        height: 615 * Global.sizes.scale
        color: "black"
        radius: width / 2

        DxIconColored {
            id: _btnUp
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/keyboard_double_arrow_up.svg"
            sourceSize {
                width: 80 * Global.sizes.scale
                height: 80 * Global.sizes.scale
            }
            color: "#3f3a3a"
        }

        DxIconColored {
            id: _btnDown
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/keyboard_double_arrow_down.svg"
            sourceSize {
                width: 80 * Global.sizes.scale
                height: 80 * Global.sizes.scale
            }
            color: "#3f3a3a"
        }

        Rectangle {
            id: _rcDrag
            anchors.horizontalCenter: parent.horizontalCenter
            y: (parent.height - height) / 2
            width: 70 * Global.sizes.scale
            height: 130 * Global.sizes.scale
            radius: 40 * Global.sizes.scale
            color: "#201D1D"

            Behavior on y {
                NumberAnimation {
                    easing.type: Easing.OutCubic
                }
            }

            MouseArea {
                id: _mouse
                anchors.fill: parent
                anchors.margins: -16 * Global.sizes.scale

                drag.target: parent
                drag.axis: Drag.YAxis
                drag.minimumY: _btnUp.y + _btnUp.height
                drag.maximumY: _btnDown.y - height
            }

            property bool isDragging: _mouse.drag.active
            onIsDraggingChanged: {
                if (!isDragging) {
                    y = (parent.height - height) / 2
                }
            }
        }
    }
}
