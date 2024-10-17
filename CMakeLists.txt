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
    RESOURCE_PREFIX "/"
    SOURCES
        backend/Backend.cpp backend/Backend.h
        lib/database/dbman.cpp lib/database/dbman.h
        lib/version.h

    RESOURCES assets.qrc

    QML_FILES
    # LOGIN
        ui/login/LoginWindow.qml
        ui/login/InitialLogin.qml
        ui/login/LoginForm.qml
        ui/login/NewRelease.qml
        ui/login/NoConnection.qml
        ui/login/OnMaintenance.qml
    #PUBLIC
        ui/public/BaseDialog.qml
    #HOME
        ui/home/HomeWindow.qml
        ui/home/HomePage.qml
        ui/home/MenubarModule.qml
        ui/home/ToolbarModule.qml
    #USER
        ui/user/ListUser.qml
        ui/user/ListUser.js
        ui/user/UsersListWidget.qml
        ui/user/NewUser.qml
        ui/user/NewUserJS.js



    #BRANCH
    #STUDY STEP
    #STUDY PERIOD
    #EVALUATION
    #REPORT

)

qt_add_resources(appiSchool "assets"
    PREFIX "/"

    FILES
        assets/font/yekan.ttf
        qmldir
        ui/login/qmldir
        ui/home/qmldir
        ui/user/qmldir

    #BACKGROUND
    FILES
        assets/images/background/back1.jpg
        assets/images/background/back2.jpg
        assets/images/background/back3.jpg
        assets/images/background/back4.jpg
        assets/images/background/back5.jpg
    #PUBLIC
        assets/images/arrow-down.png
        assets/images/arrow-left.png
        assets/images/arrow-right.png
        assets/images/arrow-up.png
        assets/images/add.png
        assets/images/edit.png
        assets/images/cross.png
        assets/images/setting.png
        assets/images/setting2.png
        assets/images/trash.png
        assets/images/trash2.png
        assets/images/trash3.png
        assets/images/search.png
        assets/images/tick.png
        assets/images/home1.png
        assets/images/home2.png
        assets/images/toolbox.png

    #LOGO
    FILES
        assets/images/logo/logo64.png
        assets/images/logo/logo128.png
        assets/images/logo/logo512.png
        assets/images/logo/logo1024.png
    #LOGIN
    FILES
        assets/images/login/disconnection.png
        assets/images/login/maintenance.png
        assets/images/login/release.png
    #USERS
        assets/images/user.png
        assets/images/newUser.png
        assets/images/userLady.png
        assets/images/female.png
        assets/images/users.png
        assets/images/student.png
        assets/images/parents.png
        assets/images/teacher.png
        assets/images/key1.png
        assets/images/key2.png
    #SCHOOL
        assets/images/school.png
        assets/images/school2.png
    #BRANCH
        assets/images/branch.png
    #COURSE
        assets/images/course.png
    #STUDY PERIOD
        assets/images/date.png
    #CLASSROOM
        assets/images/classroom.png
    #EVALUATION
        assets/images/evaluation.png
    #LOG
        assets/images/log.png
    #REPORT
        assets/images/report.png

)

# qt_target_qml_sources(appiSchool
#     PREFIX "/"
#     #QML_FILES     ui/login/LoginWindow.qml

# )



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
