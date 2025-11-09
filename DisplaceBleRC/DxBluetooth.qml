pragma Singleton
import QtQuick

Item {
    id: control

    readonly property string serviceUuid: "12345678-1234-5678-1234-56789abcdef0"
    readonly property string rxUuid: "12345678-1234-5678-1234-56789abcdef1"

    function startDeviceDiscovery() {
        Device.startDeviceDiscovery()
    }

    function disconnectFromDevice() {
        Device.disconnectFromDevice()
    }

    function scanServices(uuid) {
        Device.scanServices(uuid)
    }

    function writeData(serviceUuid, rxUuid, obj) {
        Device.writeData(serviceUuid, rxUuid, obj)
    }

    Timer {
        id: _tmrHeartbeat

        interval: 2000
        repeat: true
        triggeredOnStart: false
        running: Global.appData.isConnected

        onTriggered: {
            let obj = {
                type: "heartbeat"
            }

            control.writeData(
                control.serviceUuid,
                control.rxUuid,
                obj
            )
        }
    }
}
