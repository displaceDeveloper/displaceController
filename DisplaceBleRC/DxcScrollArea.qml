import QtQuick

Item {
    id: control

    signal valueChanged(int val)

    property bool horizontalScroll: false
    property bool enableAnimation: true
    property bool radiusLeft: true


    width: horizontalScroll ? _rc.height : _rc.width
    height: horizontalScroll ? _rc.width : _rc.height

    Rectangle {
        id: _rc
        anchors.centerIn: parent

        rotation: horizontalScroll ? 90 : 0
        width: 150 * Global.sizes.scale
        height: 700 * Global.sizes.scale
        color: "black"

        topLeftRadius: control.radiusLeft ? 40 * Global.sizes.scale : 0
        bottomLeftRadius: topLeftRadius

        topRightRadius: control.radiusLeft ? 0 : 40 * Global.sizes.scale
        bottomRightRadius: control.radiusLeft ? 0 : 40 * Global.sizes.scale


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
            width: 93 * Global.sizes.scale
            height: 140 * Global.sizes.scale
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

            running: _mouse.drag.active
            interval: 5
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                let val = _mouse.centerY - _rcDrag.y
                control.valueChanged(val * 0.5)
            }
        }

        Item {
            id: _rcDbg
            anchors.fill: parent
            anchors.margins: -16 * Global.sizes.scale
            /* border.width: 1
            border.color: "red"
            color: "transparent" */

            MouseArea {
                id: _mouse
                anchors.fill: parent

                readonly property real offsetY: _rcDrag.height / 2 + _rcDbg.anchors.margins
                readonly property real minY: _rcDrag.x
                readonly property real maxY: _rc.height - _rcDrag.height - minY
                readonly property real centerY: _rc.height / 2 - offsetY

                drag.target: _rcDrag
                drag.axis: Drag.YAxis
                drag.minimumY: minY
                drag.maximumY: maxY
                drag.onActiveChanged: {
                    if (!drag.active) {
                        _rcDrag.y = centerY
                    }
                }
            }
        }
    }
}
