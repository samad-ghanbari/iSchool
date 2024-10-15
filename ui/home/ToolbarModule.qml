import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../user"
//import "./../branch"
//import "./../step"
//import "./../base"
//import "./../studyPeriod"

ToolBar {
    id:toolbarId;
    property alias toolbarSwitchId : toolbarSwitchId
    position: ToolBar.Header
    width: parent.width
    onWidthChanged: appWidthChanged();

    function menuHoverAction(id)
    {
        id.font.bold=(id.hovered)? true : false;
    }
    function appWidthChanged()
    {
        var w = appWindowId.width;

        if(w < 1000)
        {
            menuHomeId.icon.width=1
            menuPeriodId.icon.width=1
            menuCourseId.icon.width=1
            menuTeacherId.icon.width=1
            menuStudentId.icon.width=1
            menuEvalId.icon.width=1
            menuRepId.icon.width=1

            menuHomeId.font.pixelSize=14
            menuPeriodId.font.pixelSize=14
            menuCourseId.font.pixelSize=14
            menuTeacherId.font.pixelSize=14
            menuStudentId.font.pixelSize=14
            menuEvalId.font.pixelSize=14
            menuRepId.font.pixelSize=14


        }
        else
        {
            menuHomeId.icon.width=32
            menuPeriodId.icon.width=32
            menuCourseId.icon.width=32
            menuTeacherId.icon.width=32
            menuStudentId.icon.width=32
            menuEvalId.icon.width=32
            menuRepId.icon.width=32

            menuHomeId.font.pixelSize=16
            menuPeriodId.font.pixelSize=16
            menuCourseId.font.pixelSize=16
            menuTeacherId.font.pixelSize=16
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
            font.family: yekanFont.font.family
            font.pixelSize: 16
            onClicked:
            {
                homeStackViewId.pop(null);
            }
            icon.source: "qrc:/Assets/images/home2.png"
            icon.width: 32
            icon.height: 32
            hoverEnabled: true
            onHoveredChanged: menuHoverAction(menuHomeId)
        }

        ToolButton {
            id: menuPeriodId
            text: "سال‌های ‌تحصیلی"
            font.family: yekanFont.font.family
            font.pixelSize: 16
            icon.source: "qrc:/Assets/images/date.png"
            icon.width: 32
            icon.height: 32
            onClicked:
            {
                if(homeStackViewId.currentItem.objectName === "studyPeriodON")
                    homeStackViewId.pop();

                //homeStackViewId.push(studyPeriodComponent, {objectName: "studyPeriodON"})
            }
            hoverEnabled: true
            onHoveredChanged: menuHoverAction(menuPeriodId)
        }


        ToolButton {
            id: menuCourseId
            text: "درس‌ها"
            font.family: yekanFont.font.family
            font.pixelSize: 16
            icon.source: "qrc:/Assets/images/course.png"
            icon.width: 32
            icon.height: 32
            onClicked: console.log("567")
            hoverEnabled: true
            onHoveredChanged: menuHoverAction(menuCourseId)
        }

        ToolButton {
            id: menuTeacherId
            text: "دبیران"
            font.family: yekanFont.font.family
            font.pixelSize: 16
            icon.source: "qrc:/Assets/images/teacher.png"
            icon.width: 32
            icon.height: 32
            onClicked: console.log("567")
            hoverEnabled: true
            onHoveredChanged: menuHoverAction(menuTeacherId)
        }

        ToolButton {
            id: menuStudentId
            text: "دانش‌آموزان"
            font.family: yekanFont.font.family
            font.pixelSize: 16
            icon.source: "qrc:/Assets/images/student.png"
            icon.width: 32
            icon.height: 32
            onClicked: console.log("567")
            hoverEnabled: true
            onHoveredChanged: menuHoverAction(menuStudentId)
        }

        ToolButton {
            id: menuEvalId
            text: "ارزیابی‌ها"
            font.family: yekanFont.font.family
            font.pixelSize: 16
            icon.source: "qrc:/Assets/images/evaluation.png"
            icon.width: 32
            icon.height: 32
            onClicked: console.log("567")
            hoverEnabled: true
            onHoveredChanged: menuHoverAction(menuEvalId)
        }

        ToolButton {
            id: menuRepId
            text: "گزارشات"
            font.family: yekanFont.font.family
            font.pixelSize: 16
            icon.source: "qrc:/Assets/images/report.png"
            icon.width: 32
            icon.height: 32
            onClicked: console.log("567")
            hoverEnabled: true
            onHoveredChanged: menuHoverAction(menuEvalId)
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
        id: listUserPageComponent
        ListUser{}
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

