import QtCore
import QtQuick
import QtMultimedia

Item {
    id: control

    signal valueDetected(string tvCode, string pairCode)

    // property alias camera: _camera
    property alias cameraActive: _camera.active

    width: 860 * Global.sizes.scale
    height: 800 * Global.sizes.scale

    Rectangle {
        id: rcBorder
        anchors.fill: parent
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
                id: _camera
                cameraDevice: mediaDevices.defaultVideoInput
                // active: true
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
                                _camera.stop()
                                _tmr.stop()

                                control.valueDetected(tvCode, pairCode)
                            }
        }

        Timer {
            id: _tmr
            running: _camera.active
            interval: 1500
            repeat: true
            triggeredOnStart: false

            onTriggered: {
                videoOutput.grabToImage(function(result) {
                    frameProcessor.processImage(result.image)
                })
            }
        }

        PinchArea {
            anchors.fill: parent

            property real currentZoomFactor: 1.0

            onPinchStarted: (pinch) => {
                currentZoomFactor = _camera.zoomFactor
            }

            onPinchUpdated: (pinch) => {
                let offset = (pinch.scale - 1.0)
                if (offset < 0) {
                    offset *= 2
                }

                let newZoom = currentZoomFactor + offset
                newZoom = Math.max(newZoom, _camera.minimumZoomFactor)
                newZoom = Math.min(newZoom, _camera.maximumZoomFactor)

                _camera.zoomFactor = newZoom
            }

            onPinchFinished: (pinch) => {}
        }
    }
}
