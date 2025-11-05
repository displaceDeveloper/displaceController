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
                    Global.appData.deviceName = tvCode
                    Global.appData.pairingCode = pairCode
                    Global.appData.connectToDevice()

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
        onVisibleChanged: {
            _txtName.forceActiveFocus(Qt.MouseFocusReason)
        }

        background: Rectangle {
            color: "black"
        }

        contentItem: ColumnLayout {
            spacing: Global.sizes.defaultSpacing * 2

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
                padding: 20 * Global.sizes.scale
                width: contentWidth + padding * 4

                onClicked: {
                    Global.settings.deviceName = _txtName.text
                    Global.settings.deviceAddress = Global.appData.deviceAddress
                    Global.settings.tvCode = Global.appData.deviceName
                    Global.settings.pairingCode = Global.appData.pairingCode

                    Global.db.insertTv(
                        _txtName.text,
                        Global.appData.deviceAddress,
                        Global.appData.deviceName,
                        Global.appData.pairingCode
                    )

                    control.finished()
                }
            }

            Item {
                Layout.fillHeight: true
            }
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
                Global.appData.deviceName = ""
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

    Component.onCompleted: {
        let obj = _stack
        Global.appData.connOk = function() {
            obj.currentIndex = 3
        }
    }
}
