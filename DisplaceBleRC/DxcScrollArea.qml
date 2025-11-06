import QtQuick

Item {
    id: control

    signal valueChanged(int val)

    property bool horizontalScroll: false
    property bool enableAnimation: true

    width: horizontalScroll ? _rc.height : _rc.width
    height: horizontalScroll ? _rc.width : _rc.height

    Rectangle {
        id: _rc
        anchors.centerIn: parent

        rotation: horizontalScroll ? 90 : 0
        width: 130 * Global.sizes.scale
        height: 700 * Global.sizes.scale
        color: "black"
        radius: 40 * Global.sizes.scale

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
                enabled: control.enableAnimation

                NumberAnimation {
                    easing.type: Easing.OutCubic
                }
            }
        }

        Timer {
            id: _tmr

            running: false
            interval: 80
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                control.valueChanged((_rc.height - _rcDrag.height) / 2 - _rcDrag.y)
            }
        }

        MouseArea {
            id: _mouse
            anchors.fill: parent
            anchors.margins: -16 * Global.sizes.scale

            onPressed: (mouse) => {
                control.enableAnimation = false

                let y = Math.max(
                    mouse.y - _rcDrag.height/2,
                    0
                )

                y = Math.min(
                    y,
                    _rc.height - _rcDrag.height - _rcDrag.x
                )

                _rcDrag.y = y

                _tmr.start()
            }

            onPositionChanged: (mouse) => {
                let y = Math.max(
                    mouse.y - _rcDrag.height/2,
                    0
                )

                y = Math.min(
                    y,
                    _rc.height - _rcDrag.height - _rcDrag.x
                )

                _rcDrag.y = y
            }

            onReleased: (mouse) => {
                _tmr.stop()

                control.enableAnimation = true
                _rcDrag.y = (_rc.height - _rcDrag.height) / 2
                control.valueChanged(0)
            }
        }
    }
}
