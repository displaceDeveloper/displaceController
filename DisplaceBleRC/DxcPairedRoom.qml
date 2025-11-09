import QtQuick
import QtQuick.Layouts

Rectangle {
    id: control

    signal pairRequested()
    signal unpairRequested()
    signal removeClicked()

    property alias text: _txtName.text
    property bool highlight: false
    property bool isConnecting: false

    width: 986 * Global.sizes.scale
    height: _content.height
    color: control.highlight ? "#000000" : "transparent"
    radius: 40 * Global.sizes.scale
    border.width: 0.5
    border.color: "#464646"

    RowLayout {
        id: _content
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: Global.sizes.defaultMargin

        DxIconColored {
            source: "images/tv.svg"
            sourceSize {
                width: 100 * Global.sizes.scale
                height: 100 * Global.sizes.scale
            }
        }

        ColumnLayout {
            Layout.fillWidth: true

            DxLabel {
                id: _txtName
                Layout.fillWidth: true
                text: "Living Room"
                font.pixelSize: 55 * Global.sizes.scale
                elide: DxLabel.ElideRight
            }

            DxLabel {
                visible: control.highlight || control.isConnecting
                text: control.isConnecting ? "Connecting ..." : "Paired"
                font.pixelSize: 30 * Global.sizes.scale
            }
        }

        DxButtonIconAndTextBellow {
            visible: !control.highlight
            width: contentWidth
            source: "images/delete.svg"
            sourceSize {
                width: 60 * Global.sizes.scale
                height: 60 * Global.sizes.scale
            }

            text: "REMOVE"
            font.pixelSize: 30 * Global.sizes.scale

            onClicked: control.removeClicked()
        }

        Item {
            Layout.preferredWidth: Global.sizes.defaultSpacing
        }

        DxButtonIconAndTextBellow {
            width: contentWidth
            source: control.highlight ? "images/tv-x.svg" : "images/tv.svg"
            sourceSize {
                width: 60 * Global.sizes.scale
                height: 60 * Global.sizes.scale
            }

            text: control.highlight ? "UNPAIR" : "PAIR TV"
            font.pixelSize: 30 * Global.sizes.scale

            onClicked: {
                if (control.highlight) {
                    control.unpairRequested()
                } else {
                    control.pairRequested()
                }
            }
        }
    }
}
