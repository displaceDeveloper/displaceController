import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: control

    implicitWidth: _content.implicitWidth
    implicitHeight: _content.implicitHeight

    component RectSysInfo: Rectangle {
        width: 424 * Global.sizes.scale
        height: 132 * Global.sizes.scale
        radius: 20 * Global.sizes.scale
        color: "#022033"
    }

    RowLayout {
        id: _content
        anchors.centerIn: parent

        RectSysInfo {
            Layout.alignment: Qt.AlignVCenter

            RowLayout {
                anchors.fill: parent

                DxIconColored {
                    source: "images/tv.svg"
                    sourceSize {
                        width: 80 * Global.sizes.scale
                        height: 80 * Global.sizes.scale
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true

                    DxLabel {
                        text: "Screen Time"
                        font.pixelSize: 35 * Global.sizes.scale
                    }

                    DxLabel {
                        text: "6 hrs 20 mins"
                        font.bold: true
                        font.pixelSize: 40 * Global.sizes.scale
                    }
                }
            }
        }

        RectSysInfo {
            Layout.alignment: Qt.AlignVCenter

            RowLayout {
                anchors.fill: parent

                DxWallmountIndicator {}

                ColumnLayout {
                    Layout.fillWidth: true

                    DxLabel {
                        text: "Wall Mount"
                        font.pixelSize: 35 * Global.sizes.scale
                    }

                    DxLabel {
                        text: "4 days 2 hrs"
                        font.bold: true
                        font.pixelSize: 40 * Global.sizes.scale
                    }
                }
            }
        }
    }
}
