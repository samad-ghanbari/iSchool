pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//import "./../user"
//import "./../branch"
//import "./../step"
//import "./../base"
import "./../period" as PeriodModule;
//import "./../teacher" as TeacherModule;
import "./../class" as ClassModule
import "./../student" as StudentModule;
import "./../course" as CourseModule
import "./../evaluation" as EvalModule


ToolBar {
    id:toolbarId;
    property alias toolbarSwitchId : toolbarSwitchId
    position: ToolBar.Header
    width: parent.width
    onWidthChanged: appWidthChanged();

    required property StackView appStackView;
    required property ApplicationWindow app;

    function menuHoverAction(id)
    {
        id.font.bold=(id.hovered)? true : false;
    }
    function appWidthChanged()
    {
        var w = toolbarId.app.width

        if(w < 1000)
        {
            menuHomeId.icon.width=1
            //s.icon.width=1
            menuCourseId.icon.width=1
            menuClassId.icon.width=1
            menuStudentId.icon.width=1
            menuEvalId.icon.width=1
            menuRepId.icon.width=1

            menuHomeId.font.pixelSize=14
            //menuPeriodId.font.pixelSize=14
            menuCourseId.font.pixelSize=14
            menuClassId.font.pixelSize=14
            menuStudentId.font.pixelSize=14
            menuEvalId.font.pixelSize=14
            menuRepId.font.pixelSize=14


        }
        else
        {
            menuHomeId.icon.width=32
            //menuPeriodId.icon.width=32
            menuCourseId.icon.width=32
            menuClassId.icon.width=32
            menuStudentId.icon.width=32
            menuEvalId.icon.width=32
            menuRepId.icon.width=32

            menuHomeId.font.pixelSize=16
            //menuPeriodId.font.pixelSize=16
            menuCourseId.font.pixelSize=16
            menuClassId.font.pixelSize=16
            menuStudentId.font.pixelSize=16
            menuEvalId.font.pixelSize=16
            menuRepId.font.pixelSize=16
        }
    }

    signal toolBarShow
    signal toolBarHide

    onToolBarShow:
    {
        toolbarId.visible=true
    }

    onToolBarHide:
    {
        toolbarId.visible=false
    }

    RowLayout {
        anchors.fill: parent

        ToolButton {
            id: menuHomeId
            text: "صفحه‌اصلی"
            font.family: "B Yekan"
            font.pixelSize: 16
            onClicked:
            {
                toolbarId.appStackView.pop(null);
            }
            icon.source: "qrc:/assets/images/home2.png"
            icon.width: 32
            icon.height: 32
            hoverEnabled: true
            onHoveredChanged: toolbarId.menuHoverAction(menuHomeId)
        }

        // ToolButton {
        //     id: menuPeriodId
        //     text: "سال‌های ‌تحصیلی"
        //     font.family: "B Yekan"
        //     font.pixelSize: 16
        //     icon.source: "qrc:/assets/images/date.png"
        //     icon.width: 32
        //     icon.height: 32
        //     onClicked:
        //     {
        //         if(toolbarId.appStackView.currentItem.objectName === "studyPeriodON")
        //             toolbarId.appStackView.pop();

        //         toolbarId.appStackView.push(studyPeriodComponent, {objectName: "studyPeriodON"});
        //     }

        //     hoverEnabled: true
        //     onHoveredChanged: toolbarId.menuHoverAction(menuPeriodId)
        // }


        ToolButton {
            id: menuCourseId
            text: "درس‌ها"
            font.family: "B Yekan"
            font.pixelSize: 16
            icon.source: "qrc:/assets/images/course.png"
            icon.width: 32
            icon.height: 32
            onClicked:
            {
                if(toolbarId.appStackView.currentItem.objectName === "courseON")
                    toolbarId.appStackView.pop();

                toolbarId.appStackView.push(coursesComponent, {objectName: "courseON"});
            }
            hoverEnabled: true
            onHoveredChanged: toolbarId.menuHoverAction(menuCourseId)
        }

        ToolButton {
            id: menuClassId
            text: "کلاس‌ها"
            font.family: "B Yekan"
            font.pixelSize: 16
            icon.source: "qrc:/assets/images/classroom.png"
            icon.width: 32
            icon.height: 32
            onClicked:
            {
                if(toolbarId.appStackView.currentItem.objectName === "classON")
                    toolbarId.appStackView.pop();

                toolbarId.appStackView.push(classComponent, {objectName: "classON"});
            }
            hoverEnabled: true
            onHoveredChanged: toolbarId.menuHoverAction(menuClassId)
        }

        // ToolButton {
        //     id: menuTeacherId
        //     text: "دبیران"
        //     font.family: "B Yekan"
        //     font.pixelSize: 16
        //     icon.source: "qrc:/assets/images/teacher.png"
        //     icon.width: 32
        //     icon.height: 32
        //     onClicked:
        //     {
        //         if(toolbarId.appStackView.currentItem.objectName === "teachersON")
        //             toolbarId.appStackView.pop();

        //         toolbarId.appStackView.push(teachersComponent, {objectName: "teachersON"});
        //     }
        //     hoverEnabled: true
        //     onHoveredChanged: toolbarId.menuHoverAction(menuTeacherId)
        // }

        ToolButton {
            id: menuStudentId
            text: "دانش‌آموزان"
            font.family: "B Yekan"
            font.pixelSize: 16
            icon.source: "qrc:/assets/images/student.png"
            icon.width: 32
            icon.height: 32
            onClicked:
            {
                if(toolbarId.appStackView.currentItem.objectName === "studentsON")
                    toolbarId.appStackView.pop();

                toolbarId.appStackView.push(studentsComponent, {objectName: "studentsON"});
            }
            hoverEnabled: true
            onHoveredChanged: toolbarId.menuHoverAction(menuStudentId)
        }

        ToolButton {
            id: menuEvalId
            text: "ارزیابی‌ها"
            font.family: "B Yekan"
            font.pixelSize: 16
            icon.source: "qrc:/assets/images/evaluation.png"
            icon.width: 32
            icon.height: 32
            onClicked:
            {
                if(toolbarId.appStackView.currentItem.objectName === "evalsON")
                    toolbarId.appStackView.pop();

                toolbarId.appStackView.push(evalsComponent, {objectName: "evalsON"});
            }
            hoverEnabled: true
            onHoveredChanged: toolbarId.menuHoverAction(menuEvalId)
        }

        ToolButton {
            id: menuRepId
            text: "گزارشات"
            font.family: "B Yekan"
            font.pixelSize: 16
            icon.source: "qrc:/assets/images/report.png"
            icon.width: 32
            icon.height: 32
            onClicked: console.log("567")
            hoverEnabled: true
            onHoveredChanged: toolbarId.menuHoverAction(menuEvalId)
        }

        Item{Layout.fillWidth: true;}
        Switch
        {
            id: toolbarSwitchId
            checked: true
            onClicked: {
                if(checked)
                {
                    toolbarId.toolBarShow()
                }
                else
                {
                    toolbarId.toolBarHide()
                    toolbarSwitchId.checked=true
                }

            }
        }
    }

    Component
    {
        id: studyPeriodComponent
        PeriodModule.Periods{appStackView: toolbarId.appStackView;}
    }


    Component
    {
        id: classComponent
        ClassModule.Class{appStackView: menubarId.appStackView;}
    }

    //student
    Component
    {
        id: studentsComponent
        StudentModule.Students{appStackView: toolbarId.appStackView;}
    }

    //Course
    Component
    {
        id: coursesComponent
        CourseModule.Courses{appStackView: toolbarId.appStackView;}
    }

    //Evals
    Component
    {
        id: evalsComponent
        EvalModule.EvalCats{appStackView: toolbarId.appStackView;}
    }




}

