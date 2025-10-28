import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.VirtualKeyboard

ApplicationWindow {
    id: window
    width: Global.sizes.width
    height: Global.sizes.height
    visible: true
    title: qsTr("Remote Control")

    background: Rectangle {
        color: Global.colors.background
    }

    QtObject {
        id: _local

        property var _replaceStack: null
        function replaceStack(comp) {
            if (_replaceStack) {
                _replaceStack(comp)
            }
        }
    }

    Component {
        id: _pgPairing

        PgPairing {
            onFinished: {
                _local.replaceStack(_pgMain)
            }
        }
    }

    Component {
        id: _pgMain

        PgMain {
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
            }

            Item {
                Layout.preferredHeight: 80 * Global.sizes.scale
            }

            StackView {
                id: _stackMain
                Layout.fillWidth: true
                Layout.fillHeight: true

                initialItem: _pgPairing
                // initialItem: _pgMain

                Component.onCompleted: {
                    _local._replaceStack = function(comp) {
                        _stackMain.replace(comp)
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: inputPanel.active ? inputPanel.height : 0

                InputPanel {
                    id: inputPanel
                    width: parent.width
                    visible: active
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
            if (camPermission.status !== Qt.PermissionStatus.Granted)
                return _permission

            if (blePermission.status !== Qt.PermissionStatus.Granted)
                return _permission

            Device.startDeviceDiscovery()

            return _main
        }
    }
}
