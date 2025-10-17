import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: control

    QtObject {
        id: _local

        property bool readyForUse: false
        property bool isConnected: false
        property string deviceName: ""

        function connectToDevice() {
            _local.isConnected = false

            for (let dev of Device.devicesList) {
                if (dev.deviceName === _local.deviceName) {
                    _local.isConnected = true

                    _msgConnecting.text = `Connecting to ${ dev.deviceAddress } ...`
                    Device.scanServices(dev.deviceAddress)
                    break
                }
            }
        }
    }

    BluetoothPermission {
        id: permission
        communicationModes: BluetoothPermission.Access
        onStatusChanged: {
            if (permission.status === Qt.PermissionStatus.Denied) {
                console.log("Bluetooth permission required")
            } else if (permission.status === Qt.PermissionStatus.Granted) {
                console.log("Start discovery ...")
                Device.useRandomAddress = true
                Device.startDeviceDiscovery()
            }
        }

        Component.onCompleted: {
            if (permission.status === Qt.PermissionStatus.Undetermined) {
                permission.request()
            }
        }
    }

    Connections {
        target: Device

        function onDevicesUpdated() {
            let shouldConnect = false

            console.log("Device list:")
            for (let dev of Device.devicesList) {
                console.log("- Device: " + JSON.stringify(dev))

                if (
                    _local.deviceName.length > 0 &&
                    _local.isConnected === false &&
                    (dev.deviceName === _local.deviceName)
                ) {
                    shouldConnect = true
                }
            }

            if (shouldConnect) {
                _local.connectToDevice()
            }
        }

        function onServicesUpdated() {
            // console.log("Service list:")
            for (let serv of Device.servicesList) {
                console.log("- Service: " + JSON.stringify(serv))

                if (serv.serviceUuid === "12345678-1234-5678-1234-56789abcdef0") {
                    console.log("Connect to service")
                    Device.connectToService(serv.serviceUuid)
                    break
                }
            }
        }

        function onCharacteristicsUpdated() {
            // console.log("Characteristic list:")
            for (let characteristic of Device.characteristicList) {
                console.log("- Characteristic: " + JSON.stringify(characteristic))

                if (characteristic.characteristicUuid === "12345678-1234-5678-1234-56789abcdef1") {
                    _local.readyForUse = true
                    _swipe.currentIndex = 2
                    _msg.text = `Connected`
                    break
                }
            }
        }

        function onDisconnected() {
            _local.readyForUse = false
            _local.isConnected = false
            _swipe.currentIndex = 1
        }
    }

    ColumnLayout {
        anchors.fill: parent

        SwipeView {
            id: _swipe
            Layout.fillWidth: true
            Layout.preferredHeight: control.height / 4.0
            currentIndex: 0
            interactive: false

            Item {
                ColumnLayout {
                    anchors.fill: parent

                    DxLabel {
                        text: "Pair TV"
                    }

                    DxTextField {
                        id: _txtTvCode
                        Layout.fillWidth: true
                        inputMethodHints: Qt.ImhPreferUppercase

                        text: "ABCDEF"
                    }

                    DxButton {
                        text: "Connect device"
                        onClicked: {
                            _swipe.currentIndex = 1
                            _local.deviceName = _txtTvCode.text
                            _local.connectToDevice()
                        }
                    }
                }
            }

            Item {
                ColumnLayout {
                    anchors.centerIn: parent

                    DxLabel {
                        id: _msgConnecting
                        Layout.alignment: Qt.AlignHCenter
                        text: "Connecting ..."
                    }

                    DxButton {
                        Layout.alignment: Qt.AlignHCenter
                        text: "Cancel"
                        onClicked: {
                            _local.deviceName = ""
                            _local.readyForUse = false
                            _local.isConnected = false

                            _swipe.currentIndex = 0
                        }
                    }
                }
            }

            Item {
                DxLabel {
                    id: _msg
                    anchors.centerIn: parent
                }
            }
        }

        TrackPad {
            enabled: _local.readyForUse
            Layout.fillWidth: true
            Layout.fillHeight: true

            onSendMsg: (obj) => {
                Device.writeData("12345678-1234-5678-1234-56789abcdef0", "12345678-1234-5678-1234-56789abcdef1", obj)
            }
        }
    }
}
