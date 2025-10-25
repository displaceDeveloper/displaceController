import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Flickable {
    id: control

    contentWidth: _content.width // + Global.sizes.defaultMargin * 2
    contentHeight: _content.height
    height: contentHeight
    flickableDirection: Flickable.HorizontalFlick
    clip: true

    component AppButton: DxButtonApp {
        source: "images/tv.svg"
    }

    RowLayout {
        id: _content
        spacing: Global.sizes.defaultSpacing

        AppButton {
            source: "images/app-disney.png"
        }

        AppButton {
            source: "images/app-netflix.png"
        }

        AppButton {
            source: "images/app-youtube.png"
        }

        AppButton {
            source: "images/app-disney.png"
        }

        AppButton {
            source: "images/app-netflix.png"
        }

        AppButton {
            source: "images/app-youtube.png"
        }

        AppButton {
            source: "images/app-disney.png"
        }

        AppButton {
            source: "images/app-netflix.png"
        }

        AppButton {
            source: "images/app-youtube.png"
        }
    }
}
