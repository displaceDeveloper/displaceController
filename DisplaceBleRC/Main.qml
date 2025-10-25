import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.VirtualKeyboard

ApplicationWindow {
    id: window
    width: Global.sizes.width
    height: Global.sizes.height
    visible: true
    title: qsTr("Remote Control")

    background: Rectangle {
        color: Global.colors.background
    }

    Component {
        id: _pgPairing

        PgPairing {
            onFinished: {
                _stackMain.replace(_pgMain)
            }
        }
    }

    Component {
        id: _pgMain

        PgMain {
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        /* Item {
            Layout.preferredHeight: 150 * Global.sizes.scale
        } */

        DxcHeader {
            Layout.fillWidth: true
            Layout.leftMargin: Global.sizes.defaultMargin
            Layout.rightMargin: Global.sizes.defaultMargin
        }

        Item {
            Layout.preferredHeight: 80 * Global.sizes.scale
        }

        StackView {
            id: _stackMain
            Layout.fillWidth: true
            Layout.fillHeight: true

            initialItem: _pgPairing
            // initialItem: _pgMain
        }
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height - inputPanel.height * 2 / 3
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
