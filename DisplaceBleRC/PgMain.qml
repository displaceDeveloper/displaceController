import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

DxcPage {
    id: control

    ColumnLayout {
        anchors.fill: parent
        spacing: 80 * Global.sizes.scale

        Flickable {
            id: _flick

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: Global.sizes.defaultMargin
            Layout.rightMargin: Global.sizes.defaultMargin

            clip: true
            contentWidth: _content.width
            contentHeight: _content.height

            ColumnLayout {
                id: _content

                width: _flick.width
                spacing: 80 * Global.sizes.scale

                DxcListPairedTv {
                    Layout.fillWidth: true
                }

                DxcPairedRoom {
                    Layout.fillWidth: true
                    // Layout.leftMargin: Global.sizes.defaultMargin
                    // Layout.rightMargin: Global.sizes.defaultMargin
                }

                DxcListVideo {
                    title: "Netflix"
                }

                DxcListVideo {
                    title: "Youtube"
                }

                DxcListVideo {
                    title: "Disney Plus"
                }
            }
        }

        TrackPad {
            Layout.fillWidth: true
            Layout.fillHeight: true

            onSendMsg: (obj) => {
                           Device.writeData("12345678-1234-5678-1234-56789abcdef0", "12345678-1234-5678-1234-56789abcdef1", obj)
                       }
        }
    }
}
