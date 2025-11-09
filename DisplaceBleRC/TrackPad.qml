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

        property real sendHz: 120 // ~120 FPS

        property double lastSend: 0

        property real   prevX: 0
        property real   prevY: 0

        property bool hasDrag: false

        MouseArea {
            anchors.fill: parent
            preventStealing: true

            onPressed: (mouse) => {
                // console.log(`TRACKPAD Pressed`)

                _rc.prevX = mouse.x
                _rc.prevY = mouse.y

                _rc.hasDrag = false
                _rc.lastSend = Date.now()/1000.0

                // console.log(`TRACKPAD Pressed hasDrag: ${ _rc.hasDrag }`)
            }

            onPositionChanged: (mouse) => {
                // console.log(`TRACKPAD Updated`)

                const now = Date.now()/1000.0
                const dt = now - _rc.lastSend

                if (dt < 1.0/_rc.sendHz)
                    return

                const dx = (mouse.x - _rc.prevX)
                const dy = (mouse.y - _rc.prevY)
                if (dt<0.3 && Math.abs(dx)<1 && Math.abs(dy)<1) {
                    return
                }

                _rc.prevX = mouse.x
                _rc.prevY = mouse.y


                control.sendMsg({
                    type: "move",
                    dx: dx * 3, // * _sld.value,
                    dy: dy * 3 // * _sld.value
                })

                _rc.lastSend = now
                _rc.hasDrag = true

                // console.log(`TRACKPAD Updated hasDrag: ${ _rc.hasDrag }`)
            }

            onReleased: {
                // console.log(`TRACKPAD Released hasDrag: ${ _rc.hasDrag }`)

                if (!_rc.hasDrag) {
                    control.sendMsg({type:"btn", btn:"left", down:true })
                    control.sendMsg({type:"btn", btn:"left", down:false })
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
                control.sendMsg({
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
                    control.sendMsg({
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
                    control.sendMsg({
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
                    control.sendMsg({
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

    // Scroll bars
    DxcScrollArea {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: _scrollBottom.height + Global.sizes.defaultSpacing
        radiusLeft: false
        onValueChanged: (val) => {
                            control.sendMsg({
                                type: "scroll",
                                dwheel: val,
                                hwheel: 0
                            })
                        }
    }

    DxcScrollArea {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: _scrollBottom.height + Global.sizes.defaultSpacing
        onValueChanged: (val) => {
                            control.sendMsg({
                                type: "scroll",
                                dwheel: val,
                                hwheel: 0
                            })
                        }
    }

    DxcScrollArea {
        id: _scrollBottom
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalScroll: true
        onValueChanged: (val) => {
                            control.sendMsg({
                                type: "scroll",
                                dwheel: 0,
                                hwheel: val
                            })
                        }
    }

    DxButtonIconAndTextBellow {
        id: _chkKeyboard

        property bool checked: false

        anchors.right: _scrollBottom.left
        anchors.rightMargin: 40 * Global.sizes.scale
        anchors.bottom: parent.bottom
        padding: 0

        source: checked ? "images/keyboard_down.svg" : "images/keyboard.svg"
        sourceSize {
            width: 100 * Global.sizes.scale
            height: 100 * Global.sizes.scale
        }
        color: checked ? "#65b6f7" : "white"
        text: "keyboard"
        font.pixelSize: 35 * Global.sizes.scale

        onClicked: {
            checked = !checked
            control.requestKeyboard(checked)
        }
    }

    DxButtonIconAndTextBellow {
        id: _btnVoice

        property bool checked: false

        anchors.left: _scrollBottom.right
        anchors.leftMargin: 40 * Global.sizes.scale
        anchors.bottom: parent.bottom
        padding: 0

        source: "images/mic.svg"
        sourceSize {
            width: 100 * Global.sizes.scale
            height: 100 * Global.sizes.scale
        }

        color: checked ? "#65b6f7" : "white"
        text: "voice"
        font.pixelSize: 35 * Global.sizes.scale

        onClicked: {
            checked = !checked
            control.requestKeyboard(checked)
        }
    }
}
