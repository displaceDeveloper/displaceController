import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Flickable {
    id: control

    contentWidth: _content.width // + Global.sizes.defaultMargin * 2
    contentHeight: _content.height
    height: contentHeight
    flickableDirection: Flickable.HorizontalFlick

    component TvButton: DxButtonIconAndText {
        width: contentWidth + padding * 2
        highlightBackgroundColor: "#05649F"
        highlightTextColor: "white"
        padding: 20 * Global.sizes.scale
        source: "images/tv.svg"
    }

    Row {
        id: _content
        spacing: Global.sizes.defaultSpacing
        // x: Global.sizes.defaultMargin

        TvButton {
            source: "images/add.svg"
            text: "Pair TV"
        }

        TvButton {
            source: "images/battery_3_bar.svg"
            text: "Bedroom TV"
            highlight: true
        }

        TvButton {
            text: "Living Room"
        }
    }
}
