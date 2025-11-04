import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

DxcPage {
    id: control

    Component.onCompleted: {
        control.refreshTvList()

        if (Global.appData.isConnected) {
            _drawer.open()
        }
    }

    function refreshTvList() {
        let tvs = Global.db.getAllTvs()
        console.log(`Tv count: ${ tvs.length }`)

        _lstTv.clear()

        for (let tv of tvs) {
            if (Global.appData.isConnected && tv.address === Global.settings.deviceAddress) {
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

    Connections {
        target: Global.appData

        function onIsConnectedChanged() {
            control.refreshTvList()

            if (Global.appData.isConnected) {
                _drawer.open()
            }
        }
    }

    ListModel {
        id: _lstTv
    }

    Drawer {
        id: _drawer
        width: 1077 * Global.sizes.scale
        height: window.height
        edge: Qt.LeftEdge
        interactive: Global.appData.isConnected

        background: Rectangle {
            color: "#201D1D"
            topRightRadius: 120 * Global.sizes.scale
            bottomRightRadius: 120 * Global.sizes.scale
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Global.sizes.defaultMargin

            DxLabel {
                text: "Controller"
                font.pixelSize: 60 * Global.sizes.scale
            }

            DxPane {
                Layout.fillWidth: true

                background: Rectangle {
                    color: "black"
                    radius: 40 * Global.sizes.scale
                    border.width: 0.5
                    border.color: "#464646"
                }

                ColumnLayout {
                    width: parent.width

                    RowLayout {
                        Layout.fillWidth: true

                        ColumnLayout {
                            Layout.fillWidth: true

                            DxLabel {
                                text: "CONTROLLER NAME"
                                font.pixelSize: 30 * Global.sizes.scale
                            }

                            DxLabel {
                                Layout.fillWidth: true
                                text: "My Controller"
                                font.pixelSize: 55 * Global.sizes.scale
                            }
                        }

                        DxButtonIconAndTextBellow {
                            source: "images/edit_square.svg"
                            sourceSize {
                                width: 60 * Global.sizes.scale
                                height: 60 * Global.sizes.scale
                            }

                            text: "RENAME"
                            font.pixelSize: 30 * Global.sizes.scale
                        }
                    }

                    DxHr {
                        Layout.fillWidth: true
                    }

                    DxLabel {
                        text: "SCREEN BRIGHTNESS"
                        font.pixelSize: 30 * Global.sizes.scale
                    }

                    DxSlider {
                        Layout.fillWidth: true
                    }

                    DxHr {
                        Layout.fillWidth: true
                    }

                    DxLabel {
                        text: "Version"
                        font.pixelSize: 30 * Global.sizes.scale
                    }

                    DxLabel {
                        text: "0.0.18"
                    }
                }
            }

            DxLabel {
                text: "My TVs"
                font.pixelSize: 60 * Global.sizes.scale
            }

            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true

                clip: true
                contentWidth: width
                contentHeight: _content.height
                flickableDirection: Flickable.VerticalFlick

                ColumnLayout {
                    id: _content
                    width: parent.width
                    spacing: Global.sizes.defaultSpacing

                    DxcPairedRoom {
                        Layout.fillWidth: true
                        highlight: true
                        visible: Global.appData.isConnected
                        text: Global.settings.deviceName

                        onUnpairRequested: {
                            Device.disconnectFromDevice()
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true

                        color: "transparent"
                        radius: 40 * Global.sizes.scale
                        border.width: 0.5
                        border.color: "#808080"
                        height: 176 * Global.sizes.scale


                        RowLayout {
                            id: _c
                            anchors.left: parent.left
                            anchors.leftMargin: Global.sizes.defaultMargin
                            anchors.right: parent.right
                            anchors.rightMargin: Global.sizes.defaultMargin
                            anchors.verticalCenter: parent.verticalCenter

                            DxIconColored {
                                source: "images/add.svg"
                                sourceSize {
                                    width: 100 * Global.sizes.scale
                                    height: 100 * Global.sizes.scale
                                }
                            }

                            DxLabel {
                                Layout.fillWidth: true
                                text: "Pair New TV"
                                font.pixelSize: 55 * Global.sizes.scale
                            }

                            DxIconColored {
                                source: "images/keyboard_arrow_right.svg"
                                sourceSize {
                                    width: 96 * Global.sizes.scale
                                    height: 96 * Global.sizes.scale
                                }
                            }
                        }

                        TapHandler {
                            gesturePolicy: TapHandler.WithinBounds
                            onTapped: {
                                if (Global.appData.isConnected) {
                                    Device.disconnectFromDevice()
                                }

                                Global.appData.gotoPairingScreen()
                            }
                        }
                    }

                    Repeater {
                        model: _lstTv

                        DxcPairedRoom {
                            Layout.fillWidth: true
                            text: tvName

                            onPairRequested: {
                                isConnecting = true
                                Device.scanServices(tvAddress)
                            }
                        }
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                visible: !Global.appData.isConnected

                DxIconColored {
                    source: "images/pan_tool_alt.svg"
                    sourceSize {
                        width: 144 * Global.sizes.scale
                        height: 144 * Global.sizes.scale
                    }
                    color: "#7e7979"
                }

                DxLabel {
                    text: "Pair this controller\nwith a Displace TV"
                    font.pixelSize: 55 * Global.sizes.scale
                    color: "#7e7979"
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: Global.sizes.defaultSpacing

        Item {
            id: _top

            property real preferredHeight: control.height * 0.43

            Layout.fillWidth: true
            Layout.preferredHeight: preferredHeight
            /* Layout.leftMargin: Global.sizes.defaultMargin
            Layout.rightMargin: Global.sizes.defaultMargin */

            ColumnLayout {
                id: _newContent
                anchors.fill: parent

                DxcMainTitle {
                    Layout.fillWidth: true

                    onToggleDrawer: _drawer.open()
                }

                Item {
                    Layout.fillHeight: true
                }
            }

            /*
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
            } */

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

        Item {
            Layout.fillHeight: true
            visible: !Global.appData.isConnected
        }

        TrackPad {
            id: _trackpad

            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: Global.appData.isConnected

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
                target: _newContent
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
