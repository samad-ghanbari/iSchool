import QtQuick
import QtQuick.Controls

import "./../user/" as UserModule

// menuBar: MenubarModule{}
MenuBar {
    id: menubarId;
    property alias menuSettingTBId: menuSettingTBId
    property bool toolbarView: true
    font.family: "B Yekan"
    font.pixelSize: 16

    Connections
    {
        target: toolbarId
        function onToolBarShow()
        {
            menubarId.menuSettingTBId.text="حذف نوار‌ابزار";
            menubarId.toolbarView=true
            toolbarId.visible=true;
        }

        function onToolBarHide()
        {
            menubarId.menuSettingTBId.text="نمایش نوار‌ابزار";
            menubarId.toolbarView=false
            toolbarId.visible=false;
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
                if(homeStackViewId.currentItem.objectName === "branchesON")
                    homeStackViewId.pop();

                //homeStackViewId.push(branchesComponent, {objectName: "branchesON"});
            }

            icon.source: "qrc:/assets/images/branch.png"; icon.width: 24;icon.height:24;
        }
        MenuSeparator { }
        Action {
            text: "دوره‌ها";
            onTriggered:
            {
                if(homeStackViewId.currentItem.objectName === "stepsON")
                    homeStackViewId.pop();

                //homeStackViewId.push(stepsComponent, {objectName: "stepsON"});
            }

            icon.source: "qrc:/assets/images/school.png"; icon.width: 24;icon.height:24;
        }
        MenuSeparator { }
        Action {
            text: "پایه‌های ‌تحصیلی";
            onTriggered:
            {
                if(homeStackViewId.currentItem.objectName === "baseON")
                    homeStackViewId.pop();

                //homeStackViewId.push(baseComponent, {objectName: "baseON"});
            }

            icon.source: "qrc:/assets/images/school2.png"; icon.width: 24;icon.height:24;
        }
        MenuSeparator { }
        Action {
            text: "سال‌های ‌تحصیلی";
            onTriggered:
            {
                if(homeStackViewId.currentItem.objectName === "studyPeriodON")
                    homeStackViewId.pop();

                //homeStackViewId.push(studyPeriodComponent, {objectName: "studyPeriodON"});
            }

            icon.source: "qrc:/assets/images/date.png"; icon.width: 24;icon.height:24;
        }
        MenuSeparator { }
        Action { text: "کلاس‌ها"; onTriggered: console.log("users");icon.source: "qrc:/assets/images/classroom.png"; icon.width: 24;icon.height:24; }
        MenuSeparator { }
        Action { text: "درس‌ها"; onTriggered: console.log("users");icon.source: "qrc:/assets/images/course.png"; icon.width: 24;icon.height:24; }
    }

    Menu {
        title: "دبیران"
        font.family: "B Yekan"
        font.pixelSize: 16
        Action { text: "دبیران"; onTriggered: console.log("new user");icon.source: "qrc:/assets/images/teacher.png"; icon.width: 24;icon.height:24; }
    }

    Menu {
        title: "دانش‌آموزان"
        font.family: "B Yekan"
        font.pixelSize: 16
        Action { text: "دانش‌آموزان"; onTriggered: console.log("new user");icon.source: "qrc:/assets/images/student.png"; icon.width: 24;icon.height:24; }
    }

    Menu {
        title: "ارزیابی‌ها"
        font.family: "B Yekan"
        font.pixelSize: 16
        Action { text: "ارزیابی‌ها"; onTriggered: console.log("new user");icon.source: "qrc:/assets/images/evaluation.png"; icon.width: 24;icon.height:24; }
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
                if(homeStackViewId.currentItem.objectName === "listUserON")
                    homeStackViewId.pop();

                homeStackViewId.push(listUserPageComponent,{objectName: "listUserON"});
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
                    toolbarId.visible=false;
                }
                else
                {
                    menubarId.menuSettingTBId.text="حذف نوار‌ابزار";
                    menubarId.toolbarView=true
                    toolbarId.visible=true;

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
            onTriggered:
            {
                if(homeStackViewId.currentItem.objectName === "listUserON")
                    homeStackViewId.pop();

                homeStackViewId.push(listUserPageComponent,{objectName: "listUserON"});
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

    Component
    {
        id: listUserPageComponent
        UserModule.ListUser{}
    }

    // Component
    // {
    //     id: branchesComponent
    //     Branches{}
    // }
    // Component
    // {
    //     id: stepsComponent
    //     Steps{}
    // }
    // Component
    // {
    //     id: baseComponent
    //     Base{}
    // }
    // Component
    // {
    //     id: studyPeriodComponent
    //     StudyPeriods{}
    // }

}
