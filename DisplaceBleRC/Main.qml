import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.VirtualKeyboard

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Remote Control")

    StackLayout {
        id: pagesLayout
        anchors.fill: parent
        anchors.margins: 5
        currentIndex: 0

        PairTV {

        }
    }

    /* InputPanel {
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
                y: window.height - inputPanel.height
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
    } */
}
