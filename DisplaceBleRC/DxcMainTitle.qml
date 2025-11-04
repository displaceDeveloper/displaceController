import QtQuick
import QtQuick.Layouts

Rectangle {
    id: control

    signal toggleDrawer()

    color: "#201D1D"
    height: _content.height + Global.sizes.defaultPadding * 2

    RowLayout {
        id: _content
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 30 * Global.sizes.scale
        anchors.verticalCenter: parent.verticalCenter

        DxButtonIconOnly {
            source: "images/menu.svg"
            sourceSize {
                width: 100 * Global.sizes.scale
                height: 100 * Global.sizes.scale
            }
            padding: Global.sizes.defaultPadding

            onClicked: control.toggleDrawer()
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {
                anchors.centerIn: parent

                DxIconColored {
                    source: "images/tv.svg"
                    sourceSize {
                        width: 100 * Global.sizes.scale
                        height: 100 * Global.sizes.scale
                    }
                }

                DxLabel {
                    text: Global.settings.deviceName || "No name"
                }
            }
        }

        DxcSlideCtrlMini {
        }
    }
}
