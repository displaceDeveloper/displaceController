import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
// import QtQuick.VirtualKeyboard

ApplicationWindow {
    id: window
    width: Global.sizes.width
    height: Global.sizes.height
    visible: true
    title: qsTr("Remote Control")
    visibility: Utils.isAndroid ? Window.FullScreen : Window.Windowed

    background: Rectangle {
        color: Global.colors.background
    }

    Component {
        id: _pgPairing

        PgPairing {
            onFinished: {
                Global.appData.replaceStack(_pgMain)
            }
        }
    }

    Component {
        id: _pgMain

        PgMain {
        }
    }

    Component {
        id: _pgDebug

        Item {
            Component.onCompleted: {
                let tvs = Global.db.getAllTvs()
                _txtLogs.text = JSON.stringify(tvs, null, 2)
            }

            TextArea {
                id: _txtLogs
                anchors.fill: parent
            }
        }
    }

    Component {
        id: _pairingState

        Control {
            component PairingText: RowLayout {
                DxIconColored {
                    source: "images/tv.svg"
                }

                DxLabel {
                    text: "Pair this controller with Displace TV"
                }
            }

            component PairingBusyIndicator: ColumnLayout {
                DxBusyIndicator {
                    Layout.alignment: Qt.AlignHCenter
                }
                DxLabel {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Paring ..."
                }
            }

            background: Rectangle {
                color: "black"
            }

            contentItem: ColumnLayout {
                PairingText {
                    Layout.alignment: Qt.AlignHCenter
                }

                PairingBusyIndicator {
                    Layout.alignment: Qt.AlignHCenter
                }

                DxButtonTextOnly {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Cancel"
                    onClicked: _stack.currentIndex = 0
                }
            }
        }
    }

    Component {
        id: _pgInit

        Item {
            Timer {
                interval: 100
                repeat: false
                running: true
                triggeredOnStart: false
                onTriggered: {
                    let count = Global.db.getTvCount()

                    if (count > 0) {
                        Global.appData.replaceStack(_pgMain)
                        return
                    }

                    Global.appData.replaceStack(_pgPairing)
                }
            }
        }
    }

    Connections {
        target: Global.appData

        function onIsConnectedChanged() {
            console.log("onIsConnectedChanged get called")

            if (Global.appData.isJustAutoConnected) {
                Global.appData.replaceStack(_pgMain)
            }
        }
    }

    Component {
        id: _main

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            DxcHeader {
                Layout.fillWidth: true
                Layout.leftMargin: Global.sizes.defaultMargin
                Layout.rightMargin: Global.sizes.defaultMargin
                visible: Global.app.showHeader
            }

            Item {
                Layout.preferredHeight: 80 * Global.sizes.scale
            }

            StackView {
                id: _stackMain
                Layout.fillWidth: true
                Layout.fillHeight: true

                initialItem: _pgInit

                // initialItem: _pgMain
                // initialItem: _pgListTv
                // initialItem: _pgDebug

                Component.onCompleted: {
                    Global.appData._replaceStack = function(comp) {
                        _stackMain.replace(comp)
                    }
                }
            }
        }
    }

    CameraPermission {
        id: camPermission
    }

    BluetoothPermission {
        id: blePermission
        communicationModes: BluetoothPermission.Access
    }

    Component {
        id: _permission

        Item {
            ColumnLayout {
                anchors.centerIn: parent
                spacing: Global.sizes.defaultSpacing

                Item {
                    width: _btnReqCam.width
                    height: _btnReqCam.height

                    DxLabel {
                        anchors.centerIn: parent
                        text: "Camera permission granted"
                        visible: !_btnReqCam.visible
                    }

                    DxButtonTextOnly {
                        id: _btnReqCam
                        anchors.centerIn: parent
                        text: "Request Camera Permission"
                        visible: camPermission.status !== Qt.PermissionStatus.Granted
                        onClicked: camPermission.request()
                    }
                }

                Item {
                    width: _btnReqBle.width
                    height: _btnReqBle.height

                    DxLabel {
                        anchors.centerIn: parent
                        text: "BLE permission granted"
                        visible: !_btnReqBle.visible
                    }

                    DxButtonTextOnly {
                        id: _btnReqBle
                        width: _btnReqCam.width
                        text: "Request BLE Permission"
                        visible: blePermission.status !== Qt.PermissionStatus.Granted
                        onClicked: blePermission.request()
                    }
                }
            }
        }
    }

    Loader {
        anchors.fill: parent

        sourceComponent: {
            if (!Utils.isAndroid) {
                return _main
            }

            if (camPermission.status !== Qt.PermissionStatus.Granted)
                return _permission

            if (blePermission.status !== Qt.PermissionStatus.Granted)
                return _permission

            DxBluetooth.startDeviceDiscovery()

            return _main
        }
    }

    Component.onCompleted: {
        let _pairing = _pgPairing
        Global.appData._gotoPairingScreen = function() {
            Global.appData.replaceStack(_pairing)
        }
    }
}
