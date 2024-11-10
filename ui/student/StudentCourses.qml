pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Student.js" as Methods

Page {
    id: studentCoursesPage

    required property StackView appStackView;
    required property var student;
    required property var model;
    // r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id,
    // s.branch_id, br.city, br.branch_name, s.name, s.lastname, s.fathername, s.gender, s.enabled
    // st.step_name, sb.study_base, sp.study_period, sp.passed

    property bool isFemale : (studentCoursesPage.student.gender === "خانم")? true : false;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    GridLayout
    {
        anchors.fill: parent
        columns:2

        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/arrow-right.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: studentCoursesPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "انتخاب دروس دانش‌آموز"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }


        //student info

        Image
        {
            Layout.columnSpan: 2
            Layout.preferredWidth: 128
            Layout.preferredHeight: 128
            Layout.alignment: Qt.AlignHCenter
            source: (studentCoursesPage.isFemale)? "qrc:/assets/images/female.png" : "qrc:/assets/images/user.png"
        }

        Text {
            Layout.columnSpan: 2
            text: studentCoursesPage.student["name"] + " " + studentCoursesPage.student["lastname"]
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "B Yekan"
            font.pixelSize: 16
            font.bold: true
            color: "royalblue"
        }

        Text {
            Layout.columnSpan: 2
            text: "نام پدر" + " : " + studentCoursesPage.student["fathername"]
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "B Yekan"
            font.pixelSize: 16
            font.bold: true
            color: "royalblue"
        }
// branch step
        Text {
            Layout.columnSpan: 2
            text: "شعبه " + " : " + studentCoursesPage.model.City + " - " + studentCoursesPage.model.Branch_name + " - " + studentCoursesPage.model.Step_name
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "B Yekan"
            font.pixelSize: 16
            font.bold: true
            color: "royalblue"
        }
// base period
        Text {
            Layout.columnSpan: 2
            text:  studentCoursesPage.model.Study_base + " - " + studentCoursesPage.model.Study_period
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "B Yekan"
            font.pixelSize: 16
            font.bold: true
            color: "royalblue"
        }


        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.preferredHeight: 4
            color: "skyblue"
            Layout.topMargin: 10
            Layout.bottomMargin: 10
        }

        // add course base+step
        Button
        {
            Layout.columnSpan: 2
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            Layout.alignment: Qt.AlignRight
            background: Item{}
            icon.source: "qrc:/assets/images/add.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: studentCoursesPage.appStackView.push(insertStudentCourse)
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }

        GridView
        {
            id: studentCourseGV
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 10
            flickableDirection: Flickable.AutoFlickDirection
            clip: true
            cellWidth: 300
            cellHeight: 250
            model: ListModel{id: scModel}
            highlight: Item{}
            delegate: gvDelegate
            Component.onCompleted: Methods.updateStudentCourses(studentCoursesPage.model.Id);

            function closeSwipeHandler()
            {
                for (var i = 0; i <= studentCourseGV.count; i++)
                {
                    var item = studentCourseGV.contentItem.children[i];
                    if(item.swipe)
                    {
                        item.swipe.close();
                        item.checked = false;
                    }
                }
            }

        }

    }

    // swipe delegate
    Component
    {
        id: gvDelegate
        // 0sc.id, sc.student_id, sc.course_id
        // 3co.course_name, co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id
        // 9t.name, t.lastname, cl.class_name

        SwipeDelegate
        {
            id: recDelt
            required property var model;
            height: 110
            width: studentCourseGV.width
            checkable: true
            checked: recDelt.swipe.complete
            onCheckedChanged: { if(!recDelt.checked) recDelt.swipe.close();}
            clip: true
            swipe.enabled : !recDelt.model.Passed

            background: Rectangle{color: (recDelt.highlighted)? "snow" : "whitesmoke";}

            contentItem: Rectangle
            {
                color: (recDelt.highlighted)? "snow" : "whitesmoke";

                Column
                {
                    id: recDeltCol
                    anchors.fill: parent

                    spacing: 0
                    Label {
                        text: recDelt.model.Course_name
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDelt.highlighted)? 20 :16
                        font.bold: (recDelt.highlighted)? true : false
                        color: (recDelt.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: "مدرس " + recDelt.model.Teacher
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDelt.highlighted)? 20 :16
                        font.bold: (recDelt.highlighted)? true : false
                        color: (recDelt.model.Passed)? "mediumvioletred":"dodgerblue"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: "کلاس " + recDelt.model.Class_name
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDelt.highlighted)? 20 :16
                        font.bold: (recDelt.highlighted)? true : false
                        color: (recDelt.model.Passed)? "mediumvioletred":"dodgerblue"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }

                    Rectangle{width: 400; height:5; color: (recDelt.highlighted)? "mediumvioletred" : "whitesmoke"; anchors.horizontalCenter: parent.horizontalCenter }
                }
            }

            onClicked: {recDelt.swipe.close();}
            onPressed: { studentCourseGV.currentIndex = model.index; studentCourseGV.closeSwipeHandler();}
            highlighted: (model.index === studentCourseGV.currentIndex)? true: false;

            swipe.right: Row{
                width: 150
                height: 100
                anchors.left: parent.left

                Button
                {
                    height: 100
                    width: 75
                    background: Rectangle{id:trashBtnBg; color: "crimson"}
                    hoverEnabled: true
                    onHoveredChanged: trashBtnBg.color=(hovered)? Qt.darker("crimson", 1.1):"crimson"
                    text: "حذف"
                    font.bold: true
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    palette.buttonText:  "white"
                    icon.source: "qrc:/assets/images/trash.png"
                    icon.width: 32
                    icon.height: 32
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(recDelt.swipe.complete)
                            recDelt.swipe.close();

                        //studentCoursesPage.appStackView.push(deleteComponent, {regId: recDelt.model.Id, regStep: recDelt.model.Step_name, regBase: recDelt.model.Study_base, regPeriod: recDelt.model.Study_period });
                    }
                }
            }
        }
    }

    // insert student course
    Component
    {
        id: insertStudentCourse
        Item
        {
        }
    }

}
