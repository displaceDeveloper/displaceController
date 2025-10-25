import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: control

    implicitHeight: 578 * Global.sizes.scale

    Rectangle {
        id: rcBg

        anchors.fill: parent

        color: "#05649F"
        radius: 40 * Global.sizes.scale

        Rectangle {
            id: rcRight

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 5 * Global.sizes.scale

            width: 210 * Global.sizes.scale
            color: "#022033"

            topRightRadius: rcBg.radius
            bottomRightRadius: rcBg.radius
        }
    }

    // Right side
    ColumnLayout {
        id: _layRight
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 5 * Global.sizes.scale

        width: rcRight.width

        DxButtonIconAndTextBellow {
            Layout.alignment: Qt.AlignHCenter

            padding: 20 * Global.sizes.scale
            source: "images/power_settings_new.svg"
            sourceSize {
                width: 120 * Global.sizes.scale
                height: 120 * Global.sizes.scale
            }

            text: "TV POWER"
            font.pixelSize: 20 * Global.sizes.scale

            color: "white"
        }

        Item {
            Layout.fillHeight: true
        }

        DxButtonIconAndTextBellow {
            Layout.alignment: Qt.AlignHCenter

            padding: 20 * Global.sizes.scale
            source: "images/settings.svg"
            sourceSize {
                width: 120 * Global.sizes.scale
                height: 120 * Global.sizes.scale
            }

            text: "TV SETTINGS"
            font.pixelSize: 20 * Global.sizes.scale

            color: "white"
        }
    }

    // Main part
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Global.sizes.defaultMargin
        anchors.rightMargin: _layRight.width + 10 * Global.sizes.scale + Global.sizes.defaultMargin

        RowLayout {
            Layout.fillWidth: true

            DxIconColored {
                source: "images/tv.svg"
                sourceSize {
                    width: 100 * Global.sizes.scale
                    height: 100 * Global.sizes.scale
                }
            }

            ColumnLayout {
                DxLabel {
                    text: "Living Room"
                    color: "white"
                    font.pixelSize: 55 * Global.sizes.scale
                }

                DxLabel {
                    text: "Paired"
                    color: "white"
                    font.pixelSize: 40 * Global.sizes.scale
                }
            }

            Item {
                Layout.fillWidth: true
            }

            DxIconColored {
                source: "images/electrical_services.svg"
                rotation: -90
            }

            DxcBattery {
                width: 50 * Global.sizes.scale
                horizontal: false
                inActivated: true
            }

            DxcBattery {
                width: 50 * Global.sizes.scale
                horizontal: false
                inActivated: true
            }

            DxcBattery {
                width: 50 * Global.sizes.scale
                horizontal: false
                inActivated: true
            }

            DxcBattery {
                width: 50 * Global.sizes.scale
                horizontal: false
                inActivated: true
            }

            DxIconColored {
                source: "images/wifi.svg"
            }
        }

        DxcSysInfo {
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
        }

        DxcListApp {
            Layout.fillWidth: true
        }
    }
}
