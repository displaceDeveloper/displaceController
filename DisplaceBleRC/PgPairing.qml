import QtQuick
import QtCore
import QtQuick.Controls
import QtQuick.Layouts

DxcPage {
    id: control

    signal finished()

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

    // Page 0: Scan QR code
    component ScanQrCode: Control {
        property alias cameraActive: _qr.cameraActive

        contentItem: ColumnLayout {
            // property alias cameraActive: _qr.cameraActive

            PairingText {
                Layout.alignment: Qt.AlignHCenter
            }

            DxLabel {
                Layout.alignment: Qt.AlignHCenter
                text: "Scan the QR code displayed on the TV."
                color: Global.colors.textMid
            }

            DxcQrScanner {
                id: _qr

                Layout.leftMargin: Global.sizes.defaultMargin
                Layout.rightMargin: Global.sizes.defaultMargin
                Layout.fillWidth: true
                Layout.preferredHeight: width

                // camera.active: true

                onValueDetected: (tvCode, pairCode) => {
                    _local.deviceName = tvCode
                    _local.pairingCode = pairCode
                    _local.connectToDevice()

                    _stack.currentIndex = 1
                }
            }

            DxLabel {
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Label.AlignHCenter
                text: "Press the button inside the\nright handle of the TV to reveal QR code."
                color: Global.colors.textMid
            }
        }
    }

    // Page 1: Show "Pairing"
    component Pairing: Control {
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

    // Page 2: Pair error
    component PairError: Control {
        background: Rectangle {
            color: "black"
        }

        contentItem: ColumnLayout {
            PairingText {
                Layout.alignment: Qt.AlignHCenter
            }

            Item {
                Layout.fillHeight: true
            }

            DxLabel {
                Layout.alignment: Qt.AlignHCenter
                text: "Could not pair"
            }

            DxButtonTextOnly {
                Layout.alignment: Qt.AlignHCenter
                highlight: true
                text: "Try Again"
                onClicked: _stack.currentIndex = 0
            }
        }
    }

    // Page 3: Successfully Paired
    component SuccessfullyPaired: Control {
        Component.onCompleted: {
            _txtName.forceActiveFocus()
        }

        background: Rectangle {
            color: "black"
        }

        contentItem: ColumnLayout {
            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                DxIconColored {
                    source: "images/check.svg"
                }

                DxLabel {
                    text: "Successfully paired."
                    color: Global.colors.textMid
                }
            }

            DxLabel {
                Layout.alignment: Qt.AlignHCenter
                text: "Let's name this Displace TV."
                color: Global.colors.textMid
            }

            DxTextField {
                id: _txtName
                Layout.alignment: Qt.AlignHCenter
                placeholderText: "Enter a name for this TV"
            }

            DxButtonTextOnly {
                Layout.alignment: Qt.AlignHCenter
                visible: _txtName.text.length > 0
                text: "Done"
                highlight: true

                onClicked: {
                    Global.settings.deviceName = _txtName.text
                    Global.settings.deviceAddress = _local.deviceAddress
                    Global.settings.tvCode = _local.deviceName
                    Global.settings.pairingCode = _local.pairingCode

                    Global.db.insertTv(
                        _txtName.text,
                        _local.deviceAddress,
                        _local.deviceName,
                        _local.pairingCode
                    )

                    control.finished()
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }

    QtObject {
        id: _local

        property bool readyForUse: false
        property bool isConnected: false
        property bool enableAutoConnect: true
        property bool isJustAutoConnected: false

        property string deviceName: ""
        property string deviceAddress: ""
        property string pairingCode: ""
        property string deviceFriendlyName: ""

        function connectToDevice() {
            _local.isConnected = false

            for (let dev of Device.devicesList) {
                if (dev.deviceName === _local.deviceName) {
                    _local.isConnected = true

                    _local.deviceAddress = dev.deviceAddress
                    Device.scanServices(dev.deviceAddress)
                    break
                }
            }
        }
    }

    Connections {
        id: _conn
        target: Device

        function onDevicesUpdated() {
            let shouldConnect = false

            for (let dev of Device.devicesList) {
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
            } else {
                if (_local.enableAutoConnect) {
                    let tvs = Global.db.getAllTvs()
                    let connected = new Set()
                    let autoConnTvCode = ""
                    let autoConnAddress = ""
                    let autoConnName = ""
                    let nameByAddress = {}

                    for (let tv of tvs) {
                        connected.add(tv.address)
                        nameByAddress[tv.address] = tv.name
                    }

                    for (let d of Device.devicesList) {
                        if (connected.has(d.deviceAddress)) {
                            autoConnAddress = d.deviceAddress
                            autoConnTvCode = d.deviceName
                            autoConnName = nameByAddress[d.deviceAddress]
                        }
                    }

                    if (autoConnTvCode) {
                        _local.isJustAutoConnected = true
                        _local.deviceFriendlyName = autoConnName
                        _local.deviceName = autoConnTvCode
                        _local.connectToDevice()
                    }
                }
            }
        }

        function onServicesUpdated() {
            console.log("onServicesUpdated()")

            for (let serv of Device.servicesList) {
                if (serv.serviceUuid === "12345678-1234-5678-1234-56789abcdef0") {
                    console.log("Connect to service")
                    Device.connectToService(serv.serviceUuid)
                    break
                }
            }
        }

        function onCharacteristicsUpdated() {
            console.log("onCharacteristicsUpdated")

            for (let characteristic of Device.characteristicList) {
                if (characteristic.characteristicUuid === "12345678-1234-5678-1234-56789abcdef1") {
                    _local.readyForUse = true
                    console.log("Bluetooth CONNECTED")

                    if (_local.isJustAutoConnected) {
                        Global.settings.deviceName = _local.deviceFriendlyName
                        Global.settings.deviceAddress = _local.deviceAddress
                        Global.settings.tvCode = _local.deviceName
                        Global.settings.pairingCode = _local.pairingCode

                        control.finished()
                    } else {
                        _stack.currentIndex = 3
                    }
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

    SwipeView {
        id: _stack
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        height: control.height * 2 / 3
        interactive: false
        onCurrentIndexChanged: {
            if (currentIndex === 0) {
                _scanQr.cameraActive = true
                _local.deviceName = ""
            }
        }

        ScanQrCode {
            id: _scanQr

            Component.onCompleted: cameraActive = true
        }

        Pairing {
        }

        PairError {
        }

        SuccessfullyPaired {
        }
    }
}
