import QtQuick
import QtQuick.Layouts

GridLayout {
    columns: 3
    columnSpacing: 80 * Global.sizes.scale
    rowSpacing: 80 * Global.sizes.scale

    DxButtonFunctional {
        source: "images/power_settings_new.svg"
    }

    DxButtonFunctional {
        source: "images/play_pause.svg"
    }

    DxButtonFunctional {
        source: "images/volume_up.svg"
    }

    DxButtonFunctional {
        source: "images/arrow_back.svg"
    }

    DxButtonFunctional {
        source: "images/home.svg"
    }

    DxButtonFunctional {
        source: "images/displace.png"
    }
}
