import QtQuick
// import QtQuick.Shapes

Item {
    id: control
    width: 144 * Global.sizes.scale
    height: 144 * Global.sizes.scale

    /* Shape {
        id: _shape
        anchors.fill: parent
        smooth: true

        ShapePath {
            fillColor: "black"
            strokeColor: "white"
            strokeWidth: 20 * Global.sizes.scale
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: control.width/2; centerY: control.height/2
                radiusX: control.width/2; radiusY: control.height/2
                startAngle: 90
                sweepAngle: 90 * 3
            }
        }
    } */

    DxIconColored {
        id: _shape
        anchors.centerIn: parent
        source: "images/progress_activity.svg"
        sourceSize {
            width: control.width
            height: control.height
        }
    }

    PropertyAnimation {
        target: _shape
        property: "rotation"
        from: 0
        to: 360
        loops: Animation.Infinite
        duration: 2 * 1000
        running: true
    }
}
