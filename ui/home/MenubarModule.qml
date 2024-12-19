pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import "./../user/" as UserModule
import "./../branch" as BranchModule
import "./../step" as StepModule
import "./../base" as BaseModule
import "./../period" as PeriodModule
import "./../class" as ClassModule
import "./../teacher" as TeacherModule
import "./../student" as StudentModule
import "./../course" as CourseModule
import "./../evaluation" as EvalModule
import "./../about" as AboutModule


MenuBar {
    id: menubarId
    property alias menuSettingTBId: menuSettingTBId
    property bool toolbarView: true
    font.family: "B Yekan"
    font.pixelSize: 16

    required property StackView appStackView;
    required property ToolbarModule toolbarId;

    property bool admin : dbMan.isUserAdmin();

    Connections
    {
        target: menubarId.toolbarId
        function onToolBarShow()
        {
            menubarId.menuSettingTBId.text="حذف نوار‌ابزار";
            menubarId.toolbarView=true
            menubarId.toolbarId.visible=true;
        }

        function onToolBarHide()
        {
            menubarId.menuSettingTBId.text="نمایش نوار‌ابزار";
            menubarId.toolbarView=false
            menubarId.toolbarId.visible=false;
        }
    }

    Menu {
        title: "مدرسه"
        font.family: "B Yekan"
        font.pixelSize: 16
        Action {
            text: "شعبه‌ها";
            onTriggered:
            {
                if(menubarId.appStackView.currentItem.objectName === "branchesON")
                menubarId.appStackView.pop();

                menubarId.appStackView.push(branchesComponent, {objectName: "branchesON"});
            }

            icon.source: "qrc:/assets/images/branch.png"; icon.width: 24;icon.height:24;
        }
        MenuSeparator { }
        Action {
            text: "دوره‌ها";
            onTriggered:
            {
                if(menubarId.appStackView.currentItem.objectName === "stepsON")
                menubarId.appStackView.pop();

                menubarId.appStackView.push(stepsComponent, {objectName: "stepsON"});
            }

            icon.source: "qrc:/assets/images/school.png"; icon.width: 24;icon.height:24;
        }
        MenuSeparator { }
        Action {
            text: "پایه‌های ‌تحصیلی";
            onTriggered:
            {
                if(menubarId.appStackView.currentItem.objectName === "baseON")
                menubarId.appStackView.pop();

                menubarId.appStackView.push(baseComponent, {objectName: "baseON"});
            }

            icon.source: "qrc:/assets/images/school2.png"; icon.width: 24;icon.height:24;
        }
        MenuSeparator { }
        Action {
            text: "سال‌های ‌تحصیلی";
            onTriggered:
            {
                if(menubarId.appStackView.currentItem.objectName === "studyPeriodON")
                menubarId.appStackView.pop();

                menubarId.appStackView.push(studyPeriodComponent, {objectName: "studyPeriodON"});
            }

            icon.source: "qrc:/assets/images/date.png"; icon.width: 24;icon.height:24;
        }
        MenuSeparator { }
        Action {
            text: "کلاس‌ها";
            onTriggered:{
                if(menubarId.appStackView.currentItem.objectName === "classON")
                menubarId.appStackView.pop();

                menubarId.appStackView.push(classComponent, {objectName: "classON"});
            }
            icon.source: "qrc:/assets/images/classroom.png"; icon.width: 24;icon.height:24;
        }
        MenuSeparator { }
        Action {
            text: "درس‌ها";
            onTriggered:
            {
                if(menubarId.appStackView.currentItem.objectName === "courseON")
                menubarId.appStackView.pop();

                menubarId.appStackView.push(coursesComponent, {objectName: "courseON"});
            }
            icon.source: "qrc:/assets/images/course.png";
            icon.width: 24;icon.height:24;
        }
    }

    Menu {
        title: "دبیران"
        font.family: "B Yekan"
        font.pixelSize: 16
        Action {
            text: "دبیران";
            onTriggered:{
                if(menubarId.appStackView.currentItem.objectName === "teachersON")
                menubarId.appStackView.pop();

                menubarId.appStackView.push(teachersComponent, {objectName: "teachersON"});
            }

            icon.source: "qrc:/assets/images/teacher.png"; icon.width: 24;icon.height:24;
        }
    }

    Menu {
        title: "دانش‌آموزان"
        font.family: "B Yekan"
        font.pixelSize: 16
        Action {
            text: "دانش‌آموزان";
            onTriggered:
            {
                if(menubarId.appStackView.currentItem.objectName === "studentsON")
                menubarId.appStackView.pop();

                menubarId.appStackView.push(studentsComponent, {objectName: "studentsON"});
            }
            icon.source: "qrc:/assets/images/student.png";
            icon.width: 24;icon.height:24;
        }
    }

    Menu {
        title: "ارزیابی‌ها"
        font.family: "B Yekan"
        font.pixelSize: 16
        Action {
            text: "ارزیابی‌ها";
            onTriggered:
            {
                if(menubarId.appStackView.currentItem.objectName === "evalsON")
                menubarId.appStackView.pop();

                menubarId.appStackView.push(evalsComponent, {objectName: "evalsON"});
            }
            icon.source: "qrc:/assets/images/evaluation.png";
            icon.width: 24;icon.height:24; }
    }

    Menu {
        id: menuReportId
        title: "گزارشات"
        font.family: "B Yekan"
        font.pixelSize: 16
        Action {
            text: "گزارش آماری";
            onTriggered:
            {
                if(menubarId.appStackView.currentItem.objectName === "listUserON")
                menubarId.appStackView.pop();

                //menubarId.appStackView.push(listUserPageComponent,{objectName: "listUserON"});
            }
            icon.source: "qrc:/assets/images/report.png"; icon.width: 24;icon.height:24;
        }
    }

    Menu {
        id: menuSettingId
        title: "تنظیمات کاربر"
        font.family: "B Yekan"
        font.pixelSize: 16
        Action {
            id:menuSettingTBId;
            icon.source: "qrc:/assets/images/toolbox.png"; icon.width: 24;icon.height:24;
            text: "حذف نوار‌ابزار";
            onTriggered:
            if(menubarId.toolbarView)
            {
                menuSettingTBId.text="نمایش نوار‌ابزار";
                menubarId.toolbarView=false
                menubarId.toolbarId.visible=false;
            }
            else
            {
                menubarId.menuSettingTBId.text="حذف نوار‌ابزار";
                menubarId.toolbarView=true
                menubarId.toolbarId.visible=true;

            }
        }
        Action {
            text: "پروفایل کاربر";
            onTriggered: console.log("profile")
            icon.source: "qrc:/assets/images/user.png"; icon.width: 24;icon.height:24;
        }

    }

    Menu {
        id: menuAdminSettingId
        title: "تنظیمات سامانه"
        font.family: "B Yekan"
        font.pixelSize: 16
        Action {
            text: "لیست کاربران";
            enabled: menubarId.admin

            onTriggered:
            {
                if(menubarId.appStackView.currentItem.objectName === "listUserON")
                menubarId.appStackView.pop();

                menubarId.appStackView.push(listUserPageComponent,{objectName: "listUserON"});
            }
            icon.source: "qrc:/assets/images/users.png"; icon.width: 24;icon.height:24;
        }
    }

    Menu {
        id: menuLogId
        title: "لاگ کاربران"
        font.family: "B Yekan"
        font.pixelSize: 16

        Action {
            text: "مشاهده لاگ‌ها";
            onTriggered:
            {
            }
            icon.source: "qrc:/assets/images/log.png"; icon.width: 24;icon.height:24;
        }
    }

    Menu {
        id: aboutId
        title: "درباره برنامه"
        font.family: "B Yekan"
        font.pixelSize: 16

        Action {
            text: "درباره برنامه";
            onTriggered:
            {
                if(menubarId.appStackView.currentItem.objectName === "aboutON")
                menubarId.appStackView.pop();

                menubarId.appStackView.push(aboutComponent,{objectName: "aboutON"});
            }
            icon.source: "qrc:/assets/images/info.png"; icon.width: 24;icon.height:24;
        }
    }

    Component
    {
        id: listUserPageComponent
        UserModule.ListUser{ appStackView: menubarId.appStackView;}
    }

    Component
    {
        id: branchesComponent
        BranchModule.Branches{ appStackView: menubarId.appStackView;}
    }
    Component
    {
        id: stepsComponent
        StepModule.Steps{
            appStackView : menubarId.appStackView
        }
    }
    Component
    {
        id: baseComponent
        BaseModule.Base{
            appStackView: menubarId.appStackView;
        }
    }
    Component
    {
        id: studyPeriodComponent
        PeriodModule.Periods{appStackView: menubarId.appStackView;}
    }
    Component
    {
        id: classComponent
        ClassModule.Class{appStackView: menubarId.appStackView;}
    }

    //teacher
    Component
    {
        id: teachersComponent
        TeacherModule.Teachers{appStackView: menubarId.appStackView;}
    }

    //student
    Component
    {
        id: studentsComponent
        StudentModule.Students{appStackView: menubarId.appStackView;}
    }

    //Course
    Component
    {
        id: coursesComponent
        CourseModule.Courses{appStackView: menubarId.appStackView;}
    }

    //Evals
    Component
    {
        id: evalsComponent
        EvalModule.EvalCats{appStackView: menubarId.appStackView;}
    }


    //About
    Component
    {
        id: aboutComponent
        AboutModule.About{onPopStackViewSignal: menubarId.appStackView.pop();}
    }
}
