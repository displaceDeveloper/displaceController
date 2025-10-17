cmake_minimum_required(VERSION 3.16)

project(DisplaceBleRC VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Bluetooth)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appDisplaceBleRC
    main.cpp
)

qt_add_qml_module(appDisplaceBleRC
    URI DisplaceBleRC
    VERSION 1.0
    QML_FILES
        Main.qml
        PairTV.qml
        DxLabel.qml
        DxTextField.qml
    SOURCES
        characteristicinfo.h characteristicinfo.cpp
        deviceinfo.h deviceinfo.cpp
        serviceinfo.h serviceinfo.cpp
        device.h device.cpp
        QML_FILES DxButton.qml
        QML_FILES TrackPad.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appDisplaceBleRC PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appDisplaceBleRC
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_SOURCE_DIR}/android
)

target_link_libraries(appDisplaceBleRC
    PRIVATE
        Qt6::Quick
        Qt6::Bluetooth
)

include(GNUInstallDirs)
install(TARGETS appDisplaceBleRC
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
