pragma Singleton
import QtQuick

Item {
    id: control

    CppUtils {
        id: _cpp
    }

    readonly property bool isAndroid: _cpp.isAndroid
    readonly property string appVersion: _cpp.appVersion
}
