pragma Singleton
import QtQuick
import QtCore
import QtQuick.LocalStorage

Item {
    id: control
    visible: false

    Component.onCompleted: {
        _db.init()
    }

    QtObject {
        id: _settings

        property string deviceName: ""
        property string deviceAddress: ""
        property string tvCode: ""
        property string pairingCode: ""
        property bool isConnected: false
    }
    property alias settings: _settings

    QtObject {
        id: _app
        property bool showHeader: true
    }
    property alias app: _app

    Settings {
        category: "app"
        property alias deviceName: _settings.deviceName
        property alias deviceAddress: _settings.deviceAddress
        property alias tvCode: _settings.tvCode
        property alias pairingCode: _settings.pairingCode
    }

    QtObject {
        id: _colors

        readonly property color background: "black"
        readonly property color text: "white"
        readonly property color textMid: "#6f6f6f"
    }
    property alias colors: _colors

    QtObject {
        id: _sizes

        readonly property real scale: 0.25
        // 0.3 - real phone
        // 0.25 - macos

        readonly property int width: 1474 * scale
        readonly property int height: 3060 * scale

        readonly property int logoWidth: 600 * scale
        readonly property int logoHeight: 38 * scale

        readonly property int defaultMargin: 50 * scale
        readonly property int defaultPadding: 50 * scale
        readonly property int defaultIconSize: 80 * scale
        readonly property int defaultSpacing: 50 * scale
        readonly property real defaultBorderWidth: 0.5
    }
    property alias sizes: _sizes

    QtObject {
        id: _db

        property var inst: null

        function getDb() {
            return LocalStorage.openDatabaseSync("AppDB", "1.0", "Local data", 10*1024*1024)
        }

        function init() {
            _db.inst = getDb();

            _db.inst.transaction(function(tx) {
                tx.executeSql(`CREATE TABLE IF NOT EXISTS tv(
                    id INTEGER PRIMARY KEY,
                    name TEXT,
                    address TEXT,
                    tv_code TEXT,
                    pairing_code TEXT,
                    created_at INTEGER
                )`);
            })
        }

        function insertTv(name, address, tv_code, pairing_code) {
            _db.inst.transaction(function(tx) {
                tx.executeSql(
                    `INSERT INTO tv(
                        name,
                        address,
                        tv_code,
                        pairing_code,
                        created_at
                    ) VALUES (?, ?, ?, ?, ?)`,
                    [
                        name,
                        address,
                        tv_code,
                        pairing_code,
                        Date.now()
                    ]
                )
            })
        }

        function getTvCount() {
            let count = 0;
            _db.inst.readTransaction(function(tx) {
                let rs = tx.executeSql(`SELECT count(*) as c FROM tv`);
                count = Math.floor(rs.rows.item(0)["c"])
            });
            return count;
        }

        function getAllTvs() {
            let results = [];
            _db.inst.readTransaction(function(tx) {
                let rs = tx.executeSql(`SELECT * FROM tv ORDER BY created_at DESC`);
                for (let i = 0; i < rs.rows.length; i++)
                    results.push(rs.rows.item(i));
            });
            return results;
        }

        function checkIfTvPaired(tv_code, address) {
            let isPaired = false
            _db.inst.readTransaction(function(tx) {
                let rs = tx.executeSql(`SELECT * FROM tv WHERE tv_code=? AND address=?`, [tv_code, address])
                if (rs.rows.length > 0) {
                    isPaired = true
                }
            });
            return isPaired
        }

        function removeTv(tvId) {
            _db.inst.transaction(function(tx) {
                tx.executeSql(
                    `DELETE FROM tv WHERE id=?`, [ tvId ]
                )
            })
        }
    }
    property alias db: _db

    QtObject {
        id: _appData

        property bool isConnected: false
        property bool enableAutoConnect: true
        property bool isJustAutoConnected: false

        property string deviceName: ""
        property string deviceAddress: ""
        property string pairingCode: ""
        property string deviceFriendlyName: ""

        property var _replaceStack: null

        function connectToDevice() {
            _appData.isConnected = false

            for (let dev of Device.devicesList) {
                if (dev.deviceName === _appData.deviceName) {
                    _appData.isConnected = true

                    _appData.deviceAddress = dev.deviceAddress
                    Device.scanServices(dev.deviceAddress)
                    break
                }
            }
        }

        function replaceStack(comp) {
            if (_replaceStack) {
                _replaceStack(comp)
            }
        }

        property var connOk: null
        function connectSuccessfully() {
            if (connOk) connOk()
        }
    }

    property alias appData: _appData

    Connections {
        id: _conn
        target: Device

        function onDevicesUpdated() {
            let shouldConnect = false

            for (let dev of Device.devicesList) {
                if (
                    _appData.deviceName.length > 0 &&
                    _appData.isConnected === false &&
                    (dev.deviceName === _appData.deviceName)
                ) {
                    shouldConnect = true
                }
            }

            if (shouldConnect) {
                _appData.connectToDevice()
            } /* else {
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
            } */
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
                    _appData.isConnected = true
                    console.log("Bluetooth CONNECTED")

                    if (_appData.isJustAutoConnected) {
                        Global.settings.deviceName = _appData.deviceFriendlyName
                        Global.settings.deviceAddress = _appData.deviceAddress
                        Global.settings.tvCode = _appData.deviceName
                        Global.settings.pairingCode = _appData.pairingCode

                        // control.finished()
                    } else {
                        // _stack.currentIndex = 3
                        _appData.connectSuccessfully()
                    }
                    break
                }
            }
        }

        function onDisconnected() {
            _appData.isConnected = false
            _swipe.currentIndex = 1
        }
    }
}
