import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

DxcPage {
    id: control

    ColumnLayout {
        anchors.fill: parent
        spacing: Global.sizes.defaultSpacing

        Item {
            id: _top

            property real preferredHeight: control.height * 0.43

            Layout.fillWidth: true
            Layout.preferredHeight: preferredHeight
            Layout.leftMargin: Global.sizes.defaultMargin
            Layout.rightMargin: Global.sizes.defaultMargin

            Component.onCompleted: {
                let tvs = Global.db.getAllTvs()
                for (let tv of tvs) {
                    if (tv.address === Global.settings.deviceAddress) {
                        continue
                    }

                    _lstTv.append({
                        tvId: tv.id,
                        tvName: tv.name,
                        tvAddress: tv.address,
                        tvCode: tv.tv_code,
                        tvPairingCode: tv.pairing_code
                    })
                }
            }

            ListModel {
                id: _lstTv
            }

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
                    spacing: Global.sizes.defaultSpacing

                    DxButtonIconAndText {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredHeight: 150 * Global.sizes.scale
                        source: "images/add.svg"
                        text: "Pair New TV"
                    }

                    DxcPairedRoomSimplified {
                        id: _currentRoom
                        Layout.fillWidth: true
                        highlight: true
                        text: Global.settings.deviceName || "No name"
                        tvDbId: ""

                        onPowerOffRequested: {
                            console.log("Power Off Request")

                            const now = Date.now()/1000.0
                            control.sendMsg({
                                t: now,
                                type: "poweroff"
                            })
                        }

                        onPowerOnRequested: {
                            console.log("Power On Request")

                            const now = Date.now() / 1000.0
                            control.sendMsg({
                                t: now,
                                type: "poweron"
                            })
                        }
                    }

                    Repeater {
                        model: _lstTv

                        DxcPairedRoomSimplified {
                            Layout.fillWidth: true
                            text: tvName
                            compact: true
                            highlight: false
                            tvDbId: tvId

                            onRemoveClicked: {
                                _lstTv.remove(index)
                            }
                        }
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

                RowLayout {
                    id: _rowTitle
                    anchors.horizontalCenter: parent.horizontalCenter

                    DxIconColored {
                        source: "images/tv.svg"
                        sourceSize {
                            width: 100 * Global.sizes.scale
                            height: 100 * Global.sizes.scale
                        }
                    }

                    DxLabel {
                        text: Global.settings.deviceName
                        font.pixelSize: 55 * Global.sizes.scale
                    }
                }

                DxButtonTextOnly {
                    anchors.right: parent.right
                    anchors.verticalCenter: _rowTitle.verticalCenter
                    text: "DONE"
                    color: "transparent"
                    border.width: 0
                    width: contentWidth
                    textColor: "#269AE2"
                    textFont.pixelSize: 55 * Global.sizes.scale

                    onClicked: control.state = ""
                }

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
            id: _trackpad

            Layout.fillWidth: true
            Layout.fillHeight: true

            onSendMsg: (obj) => {
                control.sendMsg(obj)
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

    onStateChanged: {
        if (state !== "Keyboard") {
            _trackpad.showKeyBoard = false
        }
    }

    states: [
        State {
            name: "Keyboard"

            PropertyChanges {
                target:  _keyboardMode
                visible: true
            }

            PropertyChanges {
                target: _top
                preferredHeight: _rowTitle.height + _typing.height + Global.sizes.defaultSpacing
            }

            PropertyChanges {
                target: _flick
                visible: false

            }

            PropertyChanges {
                target: Global.app
                showHeader: false
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
                            // control.forceActiveFocus()
                        }
                    }
                }
            }
        }
    ]

    function sendMsg(obj) {
        Device.writeData("12345678-1234-5678-1234-56789abcdef0", "12345678-1234-5678-1234-56789abcdef1", obj)
    }
}
