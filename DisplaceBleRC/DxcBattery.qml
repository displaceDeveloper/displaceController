import QtQuick

Item {
    id: control

    property bool horizontal: true
    property bool inActivated: false

    width: horizontal ? _local.w : _local.h
    height: horizontal ? _local.h : _local.w

    QtObject {
        id: _local

        property real w: 100 * Global.sizes.scale
        property real h: 60 * Global.sizes.scale
    }

    Item {
        anchors.fill: parent

        Rectangle {
            id: _rcBody
            anchors.fill: parent
            anchors.rightMargin: control.horizontal ? _nub.width : 0
            anchors.topMargin: control.horizontal ? 0 : _nub.height

            border.width: 5 * Global.sizes.scale
            border.color: control.inActivated ? "#434141" : "#d9d9d9"
            radius: 7 * Global.sizes.scale
            color: "transparent"
        }

        Rectangle {
            id: _nub

            anchors.right: control.horizontal ? parent.right : undefined
            anchors.top: control.horizontal ? undefined : parent.top
            anchors.verticalCenter: control.horizontal ? parent.verticalCenter : undefined
            anchors.horizontalCenter: control.horizontal ? undefined : parent.horizontalCenter

            width: control.horizontal ? _rcBody.border.width * 2 : _rcBody.width * 0.5
            height: control.horizontal ? _rcBody.height * 0.5 : _rcBody.border.width * 2
            color: control.inActivated ? "#434141" : "#d9d9d9"
        }
    }

    /* Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.width: 1
        border.color: "white"
    } */
}
