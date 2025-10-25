import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout {
    id: control

    property alias title: _title.text

    component DxcVideoItem: ColumnLayout {
        Image {
            id: _img
            Layout.alignment: Qt.AlignHCenter

            source: "images/sample_video.png"
            sourceSize {
                width: 400 * Global.sizes.scale
                height: 228 * Global.sizes.scale
            }
        }

        DxLabel {
            id: _name
            Layout.preferredWidth: _img.width
            Layout.alignment: Qt.AlignHCenter

            text: "Alice in Borderland - Back to back shows"
            font.pixelSize: 30 * Global.sizes.scale
            wrapMode: DxLabel.WordWrap
        }
    }

    DxLabel {
        id: _title
        text: "Netflix"
        font.pixelSize: 55 * Global.sizes.scale
    }

    ListView {
        Layout.fillWidth: true

        orientation: ListView.Horizontal
        spacing: Global.sizes.defaultSpacing
        model: 10
        delegate: DxcVideoItem {
            Component.onCompleted: {
                if (ListView.view.height < height) {
                    ListView.view.height = height
                }
            }
        }

    }
}
