import QtQuick
import QtQuick.Layouts

Rectangle {
    id: control

    signal requestTurnOff()
    signal requestTurnOn()

    width: 283 * Global.sizes.scale
    height: 138 * Global.sizes.scale
    color: "#022033"
    radius: 40 * Global.sizes.scale

    FlexboxLayout {
        id: _on
        x: _handle.y
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width - _handle.width - _handle.y * 2
        justifyContent: FlexboxLayout.JustifySpaceAround
        alignItems: FlexboxLayout.AlignCenter

        DxLabel {
            text: "TV\nOFF"
            font.pixelSize: 25 * Global.sizes.scale
        }
    }

    FlexboxLayout {
        id: _turningOff
        x: _handle.y * 2 + _handle.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width - _handle.width - _handle.y * 2
        justifyContent: FlexboxLayout.JustifySpaceAround
        alignItems: FlexboxLayout.AlignCenter
        visible: false
        gap: Global.sizes.defaultSpacing

        Item {
            Layout.fillWidth: true
        }

        DxBusyIndicator {
            width: 50 * Global.sizes.scale
            height: width
        }

        Item {
            Layout.fillWidth: true
        }
    }

    FlexboxLayout {
        id: _off
        x: _handle.y * 2 + _handle.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width - _handle.width - _handle.y * 2
        justifyContent: FlexboxLayout.JustifySpaceAround
        alignItems: FlexboxLayout.AlignCenter
        visible: false

        DxLabel {
            text: "TV\nON"
            font.pixelSize: 30 * Global.sizes.scale
        }
    }

    FlexboxLayout {
        id: _turningOn
        x: _handle.y
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width - _handle.width - _handle.y * 2
        justifyContent: FlexboxLayout.JustifySpaceAround
        alignItems: FlexboxLayout.AlignCenter
        visible: false
        gap: Global.sizes.defaultSpacing

        Item {
            Layout.fillWidth: true
        }

        DxBusyIndicator {
            width: 50 * Global.sizes.scale
            height: width
        }

        Item {
            Layout.fillWidth: true
        }
    }

    Rectangle {
        id: _handle

        property real value: {
            let rightMost = y
            let leftMost = parent.width - width - y
            return 1.0 - (x-rightMost)/(leftMost-rightMost)
        }

        anchors.verticalCenter: parent.verticalCenter
        x: parent.width - width - y
        width: 138 * Global.sizes.scale
        height: 138 * Global.sizes.scale
        radius: 40 * Global.sizes.scale
        color: "#05649F"

        Behavior on x {
            NumberAnimation {
                easing.type: Easing.OutQuart
            }
        }

        DxIconColored {
            source: "images/power_settings_new.svg"
            anchors.fill: parent
            anchors.margins: 20 * Global.sizes.scale
        }
    }

    Timer {
        interval: 3000
        repeat: false
        running: control.state === "TurningOff"
        triggeredOnStart: false
        onTriggered: {
            control.state = "Off"
        }
    }

    MouseArea {
        anchors.fill: parent

        enabled: (control.state === "On") || (control.state === "Off")
        drag.target: _handle
        drag.axis: Drag.XAxis
        drag.minimumX: _handle.y
        drag.maximumX: control.width - _handle.width - _handle.y

        onReleased: {
            let rightMost = _handle.y
            let leftMost = control.width - _handle.width - _handle.y

            if (control.state === "On") {
                if (_handle.value >= 0.7) {
                    _handle.x = rightMost
                    control.state = "TurningOff"
                    control.requestTurnOff()
                    return
                }

                _handle.x = leftMost
            } else if (control.state === "Off") {
                if (_handle.value <= 0.3) {
                    _handle.x = leftMost
                    control.state = "TurningOn"
                    control.requestTurnOn()
                    return
                }

                _handle.x = rightMost
            }
        }
    }

    Timer {
        interval: 3000
        repeat: false
        running: control.state === "TurningOn"
        triggeredOnStart: false
        onTriggered: {
            control.state = "On"
        }
    }

    state: "On"

    states: [
        State {
            name: "On"
        },
        State {
            name: "TurningOff"

            PropertyChanges {
                target: _handle
                color: "#35151b"
            }

            PropertyChanges {
                target: _on
                visible: false
            }

            PropertyChanges {
                target: _turningOff
                visible: true
            }
        },
        State {
            name: "Off"

            PropertyChanges {
                target: _handle
                color: "#710303"
            }

            PropertyChanges {
                target: _on
                visible: false
            }

            PropertyChanges {
                target: _off
                visible: true
            }
        },
        State {
            name: "TurningOn"

            PropertyChanges {
                target: _handle
                color: "#143350"
            }

            PropertyChanges {
                target: _on
                visible: false
            }

            PropertyChanges {
                target: _turningOn
                visible: true
            }
        }
    ]
}
