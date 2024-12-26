# developer:    Samad Ghanbari
# Email:        ghanbari.Samad@gmail.com
# Qt Version:   Qt 6.8.0
# Postgresql:   15.10


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
        backend/Backend.h
        backend/Backend.cpp
        lib/database/dbman.h
        lib/database/dbman.cpp
        lib/version.h
        #pdf
        lib/export/jsontable.h
        lib/export/jsontable.cpp
        lib/export/pdfjsontable.h
        lib/export/pdfjsontable.cpp

        #lib/model/studentStatModel.h
        #lib/imageProvider.h

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
        ui/user/User.qml
        ui/user/User.js
        ui/user/ChangePassDialogBox.qml

        ui/user/UserDelete.qml
        ui/user/UserModify.qml
        ui/user/UserModify.js

    #BRANCH
        ui/branch/Branches.qml
        ui/branch/Branches.js
        ui/branch/BranchWidget.qml
        ui/branch/BranchInsert.qml
        ui/branch/BranchDelete.qml
        ui/branch/UpdateBranch.qml

    #STEP
        ui/step/Steps.qml
        ui/step/Step.js
        ui/step/StepWidget.qml
        ui/step/StepInsert.qml
        ui/step/StepUpdate.qml
        ui/step/StepDelete.qml

    # STUDY BASE
        ui/base/Base.qml
        ui/base/Base.js
        ui/base/BaseWidget.qml
        ui/base/BaseInsert.qml
        ui/base/BaseUpdate.qml
        ui/base/BaseDelete.qml

    #STUDY PERIOD
        ui/period/Periods.qml
        ui/period/Period.js
        ui/period/PeriodWidget.qml
        ui/period/PeriodInsert.qml
        ui/period/PeriodUpdate.qml
        ui/period/PeriodDelete.qml

    #Class
        ui/class/Class.qml
        ui/class/Class.js
        ui/class/ClassInsert.qml
        ui/class/ClassDelete.qml
        ui/class/ClassUpdate.qml
        ui/class/ClassDetail.qml
        ui/class/ClassDetailInsert.qml
        ui/class/ClassDetailDelete.qml
        ui/class/ClassDetailUpdate.qml

    # TEACHER
        ui/teacher/Teachers.qml
        ui/teacher/Teachers.js
        ui/teacher/TeacherInsert.qml
        ui/teacher/Teacher.qml
        ui/teacher/TeacherDelete.qml
        ui/teacher/TeacherUpdate.qml

    #STUDENT
        ui/student/Students.qml
        ui/student/Student.qml
        ui/student/Student.js
        ui/student/StudentInsert.qml
        ui/student/StudentDelete.qml
        ui/student/StudentUpdate.qml
        ui/student/Registrations.qml
        ui/student/Register.qml
        ui/student/RegisterDelete.qml

    #COURSES
        ui/course/Courses.qml
        ui/course/Course.js
        ui/course/CourseInsert.qml
        ui/course/CourseUpdate.qml
        ui/course/CourseDelete.qml


    #EVALUATION
        ui/evaluation/EvalCats.qml
        ui/evaluation/EvalCatInsert.qml
        ui/evaluation/EvalCatDelete.qml
        ui/evaluation/EvalCatUpdate.qml


        ui/evaluation/Evals.js
        ui/evaluation/Evals.qml
        ui/evaluation/EvalInsert.qml
        ui/evaluation/EvalDelete.qml
        ui/evaluation/EvalUpdate.qml

        ui/evaluation/EvalStudents.qml


    #STUDENT EVALS
        ui/student_evals/StudentsEvals.qml
        ui/student_evals/StudentsEvals.js
        ui/student/StudentCourses.qml
        ui/student/StudentCourseInsert.qml
        ui/student/StudentCourseDelete.qml
        ui/student/StudentCourseEval.qml
        ui/class/ClassStudents.qml
        ui/class/ClassStudentCourses.qml
        ui/class/ClassSCEval.qml
        ui/class/ClassCSEval.qml
        ui/class/StudentStatDrawer.qml
        ui/class/StudentStatPdfReport.qml


    #About
        ui/about/About.qml

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
        assets/images/refresh.png
        assets/images/info.png
        assets/images/stop.png
        assets/images/stop32.png
        assets/images/reject.png
        assets/images/reject32.png
        assets/images/star.png
        assets/images/certified.png
        assets/images/certified32.png
        assets/images/check.png
        assets/images/check32.png
        assets/images/normalised.png
        assets/images/stat.png


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
        assets/images/folder.png
        assets/images/folders.png

    #BRANCH
        assets/images/branch.png
    #COURSE
        assets/images/course.png
    #STUDY PERIOD
        assets/images/date.png
    #CLASSROOM
        assets/images/classroom.png
        assets/images/classroom2.png
    #EVALUATION
        assets/images/evaluation.png
        assets/images/evalcat.png
    #LOG
        assets/images/log.png
    #REPORT
        assets/images/report.png
        assets/images/pdf.png
        assets/images/excel.png

    #design
    assets/images/design1.png
    assets/images/design2.png
    assets/images/design3.png
    assets/images/bg.png

)

# qt_target_qml_sources(appiSchool
#     PREFIX "/"
#     #QML_FILES     ui/login/LoginWindow.qml

# )

# qt_add_qml_module(appDbManModule
#     URI dbman
#     VERSION 1.0
#     SOURCES
#         lib/database/dbman.h
#         lib/database/dbman.cpp
# )

# database support
find_package(Qt6 REQUIRED COMPONENTS Sql)
target_link_libraries(appiSchool PRIVATE Qt6::Sql)
#target_link_libraries(appDbManModule PRIVATE Qt6::Sql)


# printsupport
find_package(Qt6 REQUIRED COMPONENTS  PrintSupport)
target_link_libraries(appiSchool PRIVATE  Qt6::PrintSupport)

#target_link_libraries(appiSchool PRIVATE Qt6::Widgets)
#find_package(Qt6 REQUIRED COMPONENTS Widgets)

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
