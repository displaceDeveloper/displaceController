cmake_minimum_required(VERSION 3.16)

project(DisplaceBleRC VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Multimedia Bluetooth Sql)

set(BUILD_SHARED_LIBS OFF)
set(ZXING_EXAMPLES OFF)
add_subdirectory(zxing-cpp)

qt_standard_project_setup(REQUIRES 6.9)

qt_add_executable(appDisplaceBleRC main.cpp)

set_source_files_properties(Global.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(appDisplaceBleRC
    URI DisplaceBleRC
    VERSION 1.0
    QML_FILES
        Global.qml
        Main.qml
        DxLabel.qml
        DxTextField.qml
        DxButton.qml
        DxButtonIconOnly.qml
        DxButtonTextOnly.qml
        DxButtonIconAndText.qml
        DxButtonIconAndTextBellow.qml
        DxButtonFunctional.qml
        DxButtonApp.qml
        DxButtonCircularIcon.qml
        DxIconColored.qml
        DxBusyIndicator.qml
        DxcBattery.qml
        DxSwitch.qml
        DxcHeader.qml
        DxcPage.qml
        DxWallmountIndicator.qml
        DxPane.qml
        DxHr.qml
        DxSlider.qml
        DxcQrScanner.qml
        DxcListPairedTv.qml
        DxcListFunctionalButton.qml
        DxcListApp.qml
        DxcListVideo.qml
        DxcScrollArea.qml
        # DxcPairedRoom.qml
        DxcPairedRoom.qml
        DxcPairedRoomSimplified.qml
        DxcMainTitle.qml
        DxcSysInfo.qml
        DxcSlideCtrl.qml
        DxcSlideCtrlMini.qml
        DxcPairButton.qml
        TrackPad.qml
        PgPairing.qml
        PgMain.qml
        PgListTv.qml
    SOURCES
        frameprocessor.h        frameprocessor.cpp
        characteristicinfo.h    characteristicinfo.cpp
        deviceinfo.h            deviceinfo.cpp
        serviceinfo.h           serviceinfo.cpp
        device.h                device.cpp
    RESOURCES
        images/logo.png
        images/settings.svg
        images/tv.svg
        images/tv-x.svg
        images/progress_activity.svg
        images/check.svg
        images/add.svg
        images/battery_3_bar.svg
        images/keyboard.svg
        images/app-disney.png
        images/app-netflix.png
        images/app-youtube.png
        images/toggle_on.svg
        images/toggle_off.svg
        images/arrow_drop_up.svg
        images/arrow_drop_down.svg
        images/home.svg
        images/arrow_back.svg
        images/play_pause.svg
        images/power_settings_new.svg
        images/volume_up.svg
        images/displace.png
        images/electrical_services.svg
        images/wifi.svg
        images/sample_video.png
        images/search.svg
        images/delete.svg
        images/keyboard_double_arrow_down.svg
        images/keyboard_double_arrow_up.svg
        images/edit_square.svg
        images/close.svg
        images/keyboard_double_arrow_left.svg
        images/keyboard_double_arrow_right.svg
        images/pan_tool_alt.svg
        images/menu.svg
        images/keyboard_arrow_right.svg
)

qt_add_resources(appDisplaceBleRC "qtquickcontrols2"
    PREFIX "/"
    FILES qtquickcontrols2.conf
)

set_target_properties(appDisplaceBleRC
    PROPERTIES
        # MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appDisplaceBleRC
        MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
        MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        MACOSX_BUNDLE TRUE
        WIN32_EXECUTABLE TRUE
        QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_SOURCE_DIR}/android
        QT_ANDROID_MIN_SDK_VERSION 27
)

target_link_libraries(appDisplaceBleRC
    PRIVATE
        Qt6::Core
        Qt6::Quick
        Qt6::Multimedia
        Qt6::Bluetooth
        Qt6::Sql
        ZXing
)

if(ANDROID)
endif()

include(GNUInstallDirs)
install(TARGETS appDisplaceBleRC
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
