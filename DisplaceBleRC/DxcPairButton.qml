import QtQuick
import QtQuick.Layouts

Item {
    id: control

    signal clicked()

    property string text: ""
    property string imageSource: ""
    property bool xVisible: false

    width: _unpair.width
    height: _unpair.height

    ColumnLayout {
        id: _unpair
        Item {
            width: 100 * Global.sizes.scale
            height: 100 * Global.sizes.scale

            DxIconColored {
                anchors.centerIn: parent
                source: control.imageSource
                sourceSize {
                    width: 100 * Global.sizes.scale
                    height: 100 * Global.sizes.scale
                }
            }

            DxIconColored {
                anchors.horizontalCenter: parent.horizontalCenter
                visible: control.xVisible
                y: 13 * Global.sizes.scale
                source: "images/close.svg"
                sourceSize {
                    width: 70 * Global.sizes.scale
                    height: 70 * Global.sizes.scale
                }
            }
        }

        DxLabel {
            Layout.alignment: Qt.AlignHCenter
            text: control.text
            font.pixelSize: 20 * Global.sizes.scale
        }
    }

    TapHandler {
        gesturePolicy: TapHandler.WithinBounds
        onTapped: control.clicked()
    }
}
