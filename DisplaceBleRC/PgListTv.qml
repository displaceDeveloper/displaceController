import QtQuick
import QtQuick.Layouts

DxcPage {
    id: control

    signal openMainView()

    Component.onCompleted: {
        /* Global.db.insertTv(
            "Test Inactivate TV",
            "Nothing",
            "Nothing",
            "Nothing"
        ) */

        let tvs = Global.db.getAllTvs()
        for (let tv of tvs) {
            console.log(JSON.stringify(tv, null, 2))

            _lstTv.append({
                tvId: tv.id,
                tvName: tv.name,
                tvAddress: tv.address,
                tvCode: tv.tv_code,
                tvPairingCode: tv.pairing_code
            })
        }
    }

    QtObject {
        id: _localData

        property string deviceName: ""
        property string deviceAddress: ""
        property string pairingCode: ""
        property string tvCode: ""
    }

    /* Connections {
        id: _conn
        target: Device

        function onServicesUpdated() {
            for (let serv of Device.servicesList) {
                if (serv.serviceUuid === "12345678-1234-5678-1234-56789abcdef0") {
                    console.log("Connect to service")
                    Device.connectToService(serv.serviceUuid)
                    break
                }
            }
        }

        function onCharacteristicsUpdated() {
            for (let characteristic of Device.characteristicList) {
                if (characteristic.characteristicUuid === "12345678-1234-5678-1234-56789abcdef1") {
                    console.log("Bluetooth CONNECTED")

                    Global.settings.deviceName = _localData.deviceName
                    Global.settings.deviceAddress = _localData.deviceAddress
                    Global.settings.tvCode = _localData.tvCode
                    Global.settings.pairingCode = _localData.pairingCode

                    control.openMainView()
                    break
                }
            }
        }
    } */

    ColumnLayout {
        anchors.fill: parent

        ListModel {
            id: _lstTv
        }

        Flickable {
            id: _flick

            Layout.fillWidth: true
            Layout.fillHeight: true

            clip: true
            contentWidth: _content.width
            contentHeight: _content.height
            flickableDirection: Flickable.VerticalFlick

            ColumnLayout {
                id: _content

                x: Global.sizes.defaultMargin
                width: _flick.width - Global.sizes.defaultMargin * 2
                spacing: 80 * Global.sizes.scale

                Repeater {
                    model: _lstTv

                    DxcPairedRoomSimplified {
                        Layout.fillWidth: true
                        text: tvName
                        compact: true
                        highlight: false // tvAddress === Global.settings.deviceAddress
                        tvDbId: tvId

                        /* Component.onCompleted: {
                            if (tvAddress === Global.settings.deviceAddress) {
                                console.log("PAIR")
                                Device.scanServices(tvAddress)
                            }
                        } */

                        onRemoveClicked: {
                            _lstTv.remove(index)
                        }

                        onPairClicked: {
                            _localData.deviceName = tvName
                            _localData.deviceAddress = tvAddress
                            _localData.pairingCode = tvPairingCode
                            _localData.tvCode = tvCode

                            Device.scanServices(tvAddress)

                            Global.appData.isJustAutoConnected = true
                            Global.appData.replaceStack(_pairingState)
                        }

                        onClicked: {
                            // control.openMainView()
                        }
                    }
                }
            }
        }

        DxIconColored {
            Layout.alignment: Qt.AlignHCenter
            source: "images/pan_tool_alt.svg"
            sourceSize {
                width: 144 * Global.sizes.scale
                height: 144 * Global.sizes.scale
            }
        }

        DxLabel {
            Layout.alignment: Qt.AlignHCenter
            horizontalAlignment: DxLabel.AlignHCenter
            text: "Pair this controller\nwith a Displace TV"
            color: "#736f6f"
            font.pixelSize: 65 * Global.sizes.scale
        }
    }
}
