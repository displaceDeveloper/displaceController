import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: control

    signal sendMsg(var obj)
    signal requestKeyboard(bool show)

    property alias showKeyBoard: _chkKeyboard.checked

    Rectangle {
        id: _rc
        anchors.fill: parent

        color: control.enabled ? "#201D1D" : "transparent"

        // ====== Config ======
        property real sendHz: 120                     // throttle tối đa ~120 FPS
        // ====================

        // Throttle theo Hz
        property double lastSend: 0

        // Lưu tọa độ touch trước đó
        property bool   hasPrev: false
        property real   prevX: 0
        property real   prevY: 0

        property bool hasDrag: false

        // Khu vực điều khiển: 1 ngón tay để move
        MultiPointTouchArea {
            anchors.fill: parent
            minimumTouchPoints: 1
            maximumTouchPoints: 1

            onPressed: (points) => {
                if (points.length > 0) {
                    const p = points[0]
                    _rc.prevX = p.x
                    _rc.prevY = p.y
                    _rc.hasPrev = true
                }

                _rc.hasDrag = false
                _rc.lastSend = Date.now()/1000.0
            }

            onUpdated: (points) => {
                if (points.length === 0 || !_rc.hasPrev)
                    return

                const now = Date.now()/1000.0
                // Throttle gửi
                if (now - _rc.lastSend < 1.0/_rc.sendHz)
                    return

                const p = points[0]
                // dx, dy theo tỉ lệ kích thước vùng điều khiển (relative, normalized)
                const dx = (p.x - _rc.prevX) // width
                const dy = (p.y - _rc.prevY) // height
                _rc.prevX = p.x
                _rc.prevY = p.y


                control.sendMsg({
                    t: now,
                    type: "move",
                    dx: dx * 3, // * _sld.value,
                    dy: dy * 3 // * _sld.value
                })

                _rc.lastSend = now
                _rc.hasDrag = true
            }

            onReleased: {
                _rc.hasPrev = false

                if (!_rc.hasDrag) {
                    const now = Date.now()/1000.0

                    control.sendMsg({t: now, type:"btn", btn:"left", down:true })
                    control.sendMsg({t: now, type:"btn", btn:"left", down:false })
                }
            }
        }
    }

    Item {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: Global.sizes.defaultMargin
        anchors.leftMargin: Global.sizes.defaultMargin
        anchors.rightMargin: Global.sizes.defaultMargin

        height: 175 * Global.sizes.scale

        DxButtonCircularIcon {
            anchors.left: parent.left
            width: 175 * Global.sizes.scale
            height: width
            source: "images/search.svg"
            onClicked: {
                const now = Date.now()/1000.0
                control.sendMsg({
                    t: now,
                    type: "search"
                })
            }
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            color: "black"
            radius: 40 * Global.sizes.scale
            width: 720 * Global.sizes.scale
            height: 175 * Global.sizes.scale

            DxButtonIconOnly {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: Global.sizes.defaultMargin
                source: "images/arrow_back.svg"
                sourceSize {
                    width: 125 * Global.sizes.scale
                    height: 125 * Global.sizes.scale
                }

                onClicked: {
                    const now = Date.now()/1000.0
                    control.sendMsg({
                        t: now,
                        type: "goback"
                    })
                }
            }

            DxButtonIconOnly {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "images/home.svg"
                sourceSize {
                    width: 125 * Global.sizes.scale
                    height: 125 * Global.sizes.scale
                }
                onClicked: {
                    const now = Date.now()/1000.0
                    control.sendMsg({
                        t: now,
                        type: "home"
                    })
                }
            }

            DxButtonIconOnly {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: Global.sizes.defaultMargin
                source: "images/play_pause.svg"
                sourceSize {
                    width: 125 * Global.sizes.scale
                    height: 125 * Global.sizes.scale
                }
                onClicked: {
                    const now = Date.now()/1000.0
                    control.sendMsg({
                        t: now,
                        type: "play_pause"
                    })
                }
            }
        }

        DxButtonCircularIcon {
            anchors.right: parent.right
            width: 175 * Global.sizes.scale
            height: width
            source: "images/volume_up.svg"
        }
    }

    DxLabel {
        anchors.centerIn: parent
        text: "Trackpad"
        color: Global.colors.textMid
    }

    Rectangle {
        id: _speedUpdater

        anchors.bottomMargin: Global.sizes.defaultMargin
        anchors.bottom: _rcBottomItems.top
        anchors.horizontalCenter: _rcBottomItems.horizontalCenter

        width: 450 * Global.sizes.scale
        height: 85 * Global.sizes.scale
        radius: 40 * Global.sizes.scale
        color: "#000000"
        visible: _btnSpeed.checked

        RowLayout {
            anchors.fill: parent

            DxButtonTextOnly {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "-"
                color: "transparent"
                border.width: 0
            }

            DxLabel {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "1x"
            }

            DxButtonTextOnly {
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "+"
                color: "transparent"
                border.width: 0
            }
        }
    }

    Rectangle {
        id: _rcBottomItems
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Global.sizes.defaultMargin
        color: "black"
        radius: 40 * Global.sizes.scale
        width: 781 * Global.sizes.scale
        height: 150 * Global.sizes.scale

        DxLabel {
            id: _btnSpeed
            property bool checked: false

            anchors.left: parent.left
            anchors.leftMargin: Global.sizes.defaultMargin
            anchors.verticalCenter: parent.verticalCenter
            text: "<strong>1x</strong> speed"
            textFormat: DxLabel.RichText

            TapHandler {
                gesturePolicy: TapHandler.WithinBounds
                onTapped: _btnSpeed.checked = !_btnSpeed.checked
            }
        }

        DxButtonIconOnly {
            id: _chkKeyboard

            property bool checked: false

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "images/keyboard.svg"
            color: checked ? "#65b6f7" : "white"

            onClicked: {
                checked = !checked
                control.requestKeyboard(checked)
            }
        }

        Item {
            id: _rcScroll
            anchors.right: parent.right
            anchors.rightMargin: Global.sizes.defaultMargin

            width: _scroll.width
            height: parent.height

            property bool checked: false

            DxLabel {
                id: _scroll
                anchors.centerIn: parent
                text: "scroll"
                color: _rcScroll.checked ? "#42B8FD" : "white"
            }

            TapHandler {
                gesturePolicy: TapHandler.WithinBounds
                onTapped: {
                    _rcScroll.checked = !_rcScroll.checked
                }
            }
        }
    }

    // Scroll bars
    DxcScrollArea {
        anchors.left: parent.left
        anchors.leftMargin: Global.sizes.defaultMargin
        anchors.verticalCenter: parent.verticalCenter
        visible: _rcScroll.checked
        onValueChanged: (val) => {
                            const now = Date.now()/1000.0
                            control.sendMsg({
                                t: now,
                                type: "scroll",
                                dwheel: val,
                                hwheel: 0
                            })
                        }
    }

    DxcScrollArea {
        anchors.right: parent.right
        anchors.rightMargin: Global.sizes.defaultMargin
        anchors.verticalCenter: parent.verticalCenter
        visible: _rcScroll.checked
        onValueChanged: (val) => {
                            const now = Date.now()/1000.0
                            control.sendMsg({
                                t: now,
                                type: "scroll",
                                dwheel: val,
                                hwheel: 0
                            })
                        }
    }

    DxcScrollArea {
        anchors.bottom: _rcBottomItems.top
        anchors.bottomMargin: Global.sizes.defaultMargin
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalScroll: true
        visible: _rcScroll.checked
        onValueChanged: (val) => {
                            const now = Date.now()/1000.0
                            control.sendMsg({
                                t: now,
                                type: "scroll",
                                dwheel: 0,
                                hwheel: val
                            })
                        }
    }
}
