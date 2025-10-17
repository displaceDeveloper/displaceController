import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: control

    signal sendMsg(var obj)

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            visible: control.enabled

            DxLabel {
                text: "Speed"
            }

            Slider {
                id: _sld
                Layout.fillWidth: true
                from: 100
                to: 900
                value: 400
            }
        }

        Rectangle {
            id: _rc
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: control.enabled ? "gray" : "transparent"

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
                        dx: dx, // * _sld.value,
                        dy: dy // * _sld.value
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
    }
}
