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
    }
    property alias settings: _settings

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

        readonly property real scale: 0.3
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
    }
    property alias db: _db
}
