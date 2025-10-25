import QtCore
import QtQuick
import QtMultimedia

Item {
    id: control

    signal valueDetected(string tvCode, string pairCode)

    width: rcBorder.width
    height: rcBorder.height

    CameraPermission {
        id: permission
        onStatusChanged: {
            console.log("onStatusChanged")

            if (permission.status === Qt.PermissionStatus.Denied) {
                console.log("Camera permission required")
            } else if (permission.status === Qt.PermissionStatus.Granted) {
            }
        }

        Component.onCompleted: {
            if (permission.status === Qt.PermissionStatus.Undetermined) {
                permission.request()
            }
        }
    }

    Rectangle {
        id: rcBorder
        anchors.centerIn: parent

        width: 860 * Global.sizes.scale
        height: 800 * Global.sizes.scale
        radius: 60 * Global.sizes.scale

        clip: true
        color: "transparent"

        MediaDevices {
            id: mediaDevices

            onVideoInputsChanged: {
                console.log(videoInputs)
            }
        }
        CaptureSession {
            camera: Camera {
                id: camera
                cameraDevice: mediaDevices.defaultVideoInput
                active: permission.status === Qt.PermissionStatus.Granted
            }
            videoOutput: videoOutput
        }

        VideoOutput {
            id: videoOutput
            anchors.fill: parent
            fillMode: VideoOutput.PreserveAspectCrop
        }

        FrameProcessor {
            id: frameProcessor

            onCodeDetected: (tvCode, pairCode) => {
                                camera.stop()
                                _tmr.stop()

                                control.valueDetected(tvCode, pairCode)
                            }
        }

        Timer {
            id: _tmr
            running: camera.active
            interval: 1000
            repeat: true
            triggeredOnStart: false

            onTriggered: {
                console.log("Process")
                videoOutput.grabToImage(function(result) {
                    frameProcessor.processImage(result.image)
                })
            }
        }
    }

    /* TapHandler {
        gesturePolicy: TapHandler.WithinBounds
        onTapped: {
            control.valueDetected("ABCDEF")
        }
    } */
}
