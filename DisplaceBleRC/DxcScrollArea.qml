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
        width: 100 * Global.sizes.scale
        height: 700 * Global.sizes.scale
        border.width: 1
        border.color: "white"
        color: "transparent"
        radius: width / 2

        DxIconColored {
            id: _btnUp
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/arrow_drop_up.svg"
            sourceSize {
                width: 100 * Global.sizes.scale
                height: 100 * Global.sizes.scale
            }
        }

        Column {
            anchors.top: _btnUp.bottom
            spacing: 30 * Global.sizes.scale
            Repeater {
                model: Math.max(
                   Math.round((_btnDown.y - (_btnUp.y + _btnUp.height)) / (30 * Global.sizes.scale)) - 1,
                   0
                )

                Rectangle {
                    height: 1
                    width: _rc.width
                }
            }
        }

        DxIconColored {
            id: _btnDown
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/arrow_drop_down.svg"
            sourceSize {
                width: 100 * Global.sizes.scale
                height: 100 * Global.sizes.scale
            }
        }
    }
}
