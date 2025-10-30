import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: control

    property bool compact: false
    property bool highlight: false
    property alias text: _txtName.text

    // implicitHeight: (control.compact ? 170 : 335) * Global.sizes.scale
    height: (control.compact ? 200 : 335) * Global.sizes.scale

    Rectangle {
        id: rcBg

        anchors.fill: parent

        border.width: 1 // Global.sizes.defaultBorderWidth
        border.color: control.highlight ? "#05649F" : "#808080"
        color: control.highlight ? "#05649F" : "#201D1D"
        radius: 40 * Global.sizes.scale

        Rectangle {
            id: rcRight

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            border.width: 1 // Global.sizes.defaultBorderWidth
            border.color: control.highlight ? "#05649F" : "#808080"
            width: 210 * Global.sizes.scale
            color: control.highlight ? "#022033" : "transparent"

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
            source: control.highlight ? "images/power_settings_new.svg" : "images/delete.svg"
            sourceSize {
                width: 120 * Global.sizes.scale
                height: 120 * Global.sizes.scale
            }

            text: control.compact ? "" : (control.highlight ? "TV POWER" : "REMOVE")
            font.pixelSize: 20 * Global.sizes.scale

            color: "white"
        }
    }

    // Main part
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40 * Global.sizes.scale
        anchors.rightMargin: _layRight.width + 10 * Global.sizes.scale + anchors.margins

        RowLayout {
            Layout.fillWidth: true

            DxIconColored {
                Layout.alignment: Qt.AlignTop

                source: "images/tv.svg"
                sourceSize {
                    width: 100 * Global.sizes.scale
                    height: 100 * Global.sizes.scale
                }
            }

            ColumnLayout {
                spacing: 0

                DxLabel {
                    id: _txtName
                    text: "Living Room"
                    color: "white"
                    font.pixelSize: 55 * Global.sizes.scale
                }

                DxLabel {
                    text: "Paired"
                    color: "white"
                    font.pixelSize: 40 * Global.sizes.scale
                    visible: control.highlight
                }

                Item {
                    Layout.fillHeight: true
                    visible: !control.compact
                }

                RowLayout {
                    visible: !control.compact
                    spacing: Global.sizes.defaultSpacing

                    DxButtonTextOnly {
                        width: 250 * Global.sizes.scale
                        padding: 20 * Global.sizes.scale
                        radius: 20 * Global.sizes.scale
                        color: control.highlight ? "#022033" : "#C6C6C6"
                        textColor: control.highlight ? Global.colors.text : "black"
                        text: control.highlight ? "Unpair" : "Pair TV"
                        border.width: 0
                    }

                    DxButtonTextOnly {
                        width: 250 * Global.sizes.scale
                        padding: 20 * Global.sizes.scale
                        radius: 20 * Global.sizes.scale
                        color: "transparent"
                        border.color: control.highlight ? "#022033" : "#808080"
                        text: "Rename"
                    }
                }
            }
        }
    }
}
