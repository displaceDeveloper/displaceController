import QtQuick
import QtQuick.Layouts

RowLayout {
    id: control

    Image {
        source: "images/logo.png"
        sourceSize {
            width: Global.sizes.logoWidth
            height: Global.sizes.logoHeight
        }
    }

    Item {
        Layout.fillWidth: true
    }

    DxButtonIconOnly {
        source: "images/settings.svg"
    }

    DxLabel {
        text: "57%"
    }

    DxcBattery {}
}
