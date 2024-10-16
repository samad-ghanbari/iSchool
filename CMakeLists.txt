# developer:    Samad Ghanbari
# Email:        ghanbari.Samad@gmail.com
# Qt Version:   Qt 6.8.0
# Postgresql:   16.4


cmake_minimum_required(VERSION 3.16)

project(iSchool VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appiSchool
    main.cpp
)


qt_policy(SET QTP0004 NEW)

qt_add_qml_module(appiSchool
    URI iSchool
    VERSION 1.0
    SOURCES
        backend/Backend.cpp backend/Backend.h
        lib/database/dbman.cpp lib/database/dbman.h
        lib/version.h

    RESOURCES qmldir
    #RESOURCES assets.qrc
    RESOURCES assets/images/logo/logo512.png

        #background
        # assets/images/background/back1.jpg
        # assets/images/background/back2.jpg
        # assets/images/background/back3.jpg
        # assets/images/background/back4.jpg
        # assets/images/background/back5.jpg
        # #logo
        # assets/images/logo/logo64.png
        # assets/images/logo/logo128.png
        # assets/images/logo/logo512.png
        # assets/images/logo/logo1024.png




)

qt_target_qml_sources(appiSchool
    QML_FILES     ui/login/LoginWindow.qml
    QML_FILES     ui/login/InitialLogin.qml
    QML_FILES     ui/login/LoginForm.qml
    QML_FILES     ui/login/NewRelease.qml
    QML_FILES     ui/login/NoConnection.qml
    QML_FILES     ui/login/OnMaintenance.qml
)

# database support
find_package(Qt6 REQUIRED COMPONENTS Sql)
target_link_libraries(appiSchool PRIVATE Qt6::Sql)

# printsupport
find_package(Qt6 REQUIRED COMPONENTS PrintSupport)



# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appiSchool PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appiSchool
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appiSchool
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appiSchool
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
