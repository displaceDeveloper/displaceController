import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

DxcPage {
    id: control

    ColumnLayout {
        anchors.fill: parent
        spacing: 80 * Global.sizes.scale

        Item {
            id: _top

            property real preferredHeight: control.height * 0.43

            Layout.fillWidth: true
            Layout.preferredHeight: preferredHeight
            Layout.leftMargin: Global.sizes.defaultMargin
            Layout.rightMargin: Global.sizes.defaultMargin
            /* color: "transparent"
            border.width: 1
            border.color: "red" */

            Flickable {
                id: _flick

                anchors.fill: parent

                clip: true
                contentWidth: _content.width
                contentHeight: _content.height
                visible: opacity > 0

                ColumnLayout {
                    id: _content

                    width: _flick.width
                    spacing: 80 * Global.sizes.scale

                    DxButtonIconAndText {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 150 * Global.sizes.scale
                        source: "images/add.svg"
                        text: "Pair New TV"
                    }

                    DxcPairedRoomSimplified {
                        id: _currentRoom
                        Layout.fillWidth: true
                        highlight: true
                        text: "Living Room"
                    }

                    DxcPairedRoomSimplified {
                        Layout.fillWidth: true
                        text: "Bedroom TV"
                    }
                }
            }

            Item {
                id: _keyboardMode
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                visible: false

                DxTextField {
                    id: _typing

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom

                    anchors.topMargin: Global.sizes.defaultMargin

                    padding: Global.sizes.defaultPadding

                    background: Rectangle {
                        border.width: 5 * Global.sizes.scale
                        border.color: "#585151"
                        color: "transparent"
                        radius: 20 * Global.sizes.scale
                    }
                }
            }
        }

        TrackPad {
            Layout.fillWidth: true
            Layout.fillHeight: true

            onSendMsg: (obj) => {
                           Device.writeData("12345678-1234-5678-1234-56789abcdef0", "12345678-1234-5678-1234-56789abcdef1", obj)
                       }

            onRequestKeyboard: (show) => {
                if (show) {
                    control.state = "Keyboard"
                } else {
                    control.state = ""
                }
            }
        }
    }

    states: [
        State {
            name: "Keyboard"

            PropertyChanges {
                target:  _keyboardMode
                visible: true
                // height: _currentRoom.height + _typing.height + Global.sizes.defaultSpacing
            }

            PropertyChanges {
                target: _top
                preferredHeight: _currentRoom.height + _typing.height + Global.sizes.defaultSpacing
            }

            ParentChange {
                target: _currentRoom
                parent: _keyboardMode
            }

            /* AnchorChanges {
                target:_keyboardMode
                anchors.bottom: undefined
            } */

            AnchorChanges {
                target: _currentRoom
                anchors.left: _keyboardMode.left
                anchors.top: _keyboardMode.top
                anchors.right: _keyboardMode.right
            }

            AnchorChanges {
                target: _typing
                anchors.bottom: undefined
                anchors.top: _currentRoom.bottom
            }

            PropertyChanges {
                target: _flick
                opacity: 0
            }
        }
    ]

    transitions: [
        Transition {
            to: "Keyboard"
            reversible: true

            SequentialAnimation {
                NumberAnimation {
                    properties: "opacity"
                    easing.type: Easing.OutQuad
                }
                AnchorAnimation {
                    easing.type: Easing.OutQuad
                }
                ScriptAction {
                    script: {
                        if (control.state === "Keyboard") {
                            _typing.forceActiveFocus()
                        } else {
                            control.forceActiveFocus()
                        }
                    }
                }
            }
        }
    ]
}
