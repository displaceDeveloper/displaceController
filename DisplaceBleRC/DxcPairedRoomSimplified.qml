import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: control

    signal clicked()
    signal pairClicked()
    signal unpairClicked()
    signal removeClicked()
    signal powerOffRequested()
    signal powerOnRequested()

    property string tvDbId: ""
    property bool compact: false
    property bool highlight: false
    property alias text: _txtName.text

    height: 413 * Global.sizes.scale

    MouseArea {
        anchors.fill: parent
        onPressed: {
            control.clicked()
        }
    }

    Rectangle {
        id: rcBg

        anchors.fill: parent

        color: control.highlight ? "#05649F" : "#201D1D"
        radius: 40 * Global.sizes.scale
    }

    RowLayout {
        id: _buttons
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: Global.sizes.defaultMargin
        spacing: Global.sizes.defaultSpacing * 2

        DxcPairButton {
            visible: !control.highlight
            imageSource: "images/delete.svg"
            text: "REMOVE"
            onClicked: {
                Global.db.removeTv(control.tvDbId)
                control.removeClicked()
            }
        }

        DxcPairButton {
            imageSource: "images/tv.svg"
            text: control.highlight ? "UNPAIR" : "PAIR TV"
            xVisible: text === "UNPAIR"
            onClicked: {
                if (text === "UNPAIR") {
                    control.unpairClicked()
                    return
                }

                control.pairClicked()
            }
        }
    }

    // Main part
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40 * Global.sizes.scale

        RowLayout {
            Layout.fillWidth: true

            DxIconColored {
                Layout.alignment: Qt.AlignVCenter

                source: "images/tv.svg"
                sourceSize {
                    width: 100 * Global.sizes.scale
                    height: 100 * Global.sizes.scale
                }
            }

            ColumnLayout {
                spacing: 0

                RowLayout {
                    DxLabel {
                        id: _txtName
                        text: "Living Room"
                        color: "white"
                        font.pixelSize: 55 * Global.sizes.scale
                    }

                    DxIconColored {
                        source: "images/edit_square.svg"
                        sourceSize {
                            width: _txtName.height * 0.7
                            height: _txtName.height * 0.7
                        }
                    }
                }

                DxLabel {
                    text: "Paired"
                    color: "white"
                    font.pixelSize: 40 * Global.sizes.scale
                    visible: control.highlight
                }
            }
        }

        DxcSlideCtrl {
            id: _sldPower
            Layout.alignment: Qt.AlignLeft

            onRequestTurnOff: {
                control.powerOffRequested()
            }

            onRequestTurnOn: {
                control.powerOnRequested()
            }
        }
    }

    states: [
        State {
            name: "Compact"
            when: control.compact === true

            PropertyChanges {
                target: control
                height: 220 * Global.sizes.scale

            }

            PropertyChanges {
                target: _sldPower
                visible: false
            }

            AnchorChanges {
                target: _buttons
                anchors.bottom: undefined
                anchors.verticalCenter: control.verticalCenter
            }
        }

    ]
}
