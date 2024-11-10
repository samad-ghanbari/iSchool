pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//import "./../public" as DialogBox
//import "Student.js" as Methods

Page {
    id: studentCourseEvalPage

    required property var student;
    required property var registerModel;
    // r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id,
    // s.branch_id, br.city, br.branch_name, s.name, s.lastname, s.fathername, s.gender, s.enabled
    // st.step_name, sb.study_base, sp.study_period, sp.passed

    required property var studentCourseModel;
    // 0sc.id, sc.student_id, sc.course_id
    // 3co.course_name, co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id
    // 9t.name, t.lastname, cl.class_name

    signal popStackViewSignal();


    property bool isFemale : (studentCourseEvalPage.student.gender === "خانم")? true : false;

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
            onClicked: studentCourseEvalPage.popStackViewSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ارزیابی واحد درسی دانش‌آموز"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"

            ScrollView
            {
                height: parent.height
                width: parent.width
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                Rectangle
                {
                    id: centerBoxId
                    color:"snow"
                    width:  parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: parent.height

                    GridLayout
                    {
                        anchors.fill: parent
                        columns:2

                        //student info
                        Rectangle
                        {
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            implicitHeight: 200
                            RowLayout
                            {
                                anchors.fill: parent
                                Image
                                {
                                    Layout.preferredWidth: 128
                                    Layout.preferredHeight: 128
                                    Layout.alignment: Qt.AlignLeft
                                    source: (studentCourseEvalPage.isFemale)? "qrc:/assets/images/female.png" : "qrc:/assets/images/user.png"
                                }
                                Column{
                                    Layout.fillWidth: true
                                    Text {
                                        text: studentCourseEvalPage.student["name"] + " " + studentCourseEvalPage.student["lastname"]
                                        height: 50
                                        width: parent.width
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        font.family: "B Yekan"
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "royalblue"
                                    }

                                    Text {
                                        text: "نام پدر" + " : " + studentCourseEvalPage.student["fathername"]
                                        height: 50
                                        width: parent.width
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        font.family: "B Yekan"
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "royalblue"
                                    }
                                    // branch step
                                    Text {
                                        text: "شعبه " + " : " + studentCourseEvalPage.registerModel.City + " - " + studentCourseEvalPage.registerModel.Branch_name + " - " + studentCourseEvalPage.registerModel.Step_name + " - " + studentCourseEvalPage.registerModel.Study_base
                                        height: 50
                                        width: parent.width
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        font.family: "B Yekan"
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "royalblue"
                                    }
                                    // base period
                                    Text {
                                        text:  studentCourseEvalPage.registerModel.Study_period
                                        height: 50
                                        width: parent.width
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        font.family: "B Yekan"
                                        font.pixelSize: 20
                                        font.bold: true
                                        color: "darkcyan"
                                    }
                                }
                            }
                        }

                        // course info
                        Rectangle
                        {
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            implicitHeight: 120
                            color: "olivedrab"
                            Layout.topMargin: 10
                            Layout.bottomMargin: 10
                            Text
                            {
                                id: courseNameInfo
                                text: studentCourseEvalPage.studentCourseModel.Course_name
                                height: 50
                                width: parent.width
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "B Yekan"
                                font.pixelSize: 20
                                font.bold: true
                                color: "white"
                            }
                            Text
                            {
                                anchors.top: courseNameInfo.bottom
                                text: studentCourseEvalPage.studentCourseModel.Teacher + "  ( کلاس " + studentCourseEvalPage.studentCourseModel.Class_name + ") "
                                height: 50
                                width: parent.width
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "white"
                            }
                        }

                        Rectangle
                        {
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "snow"
                        }


                    }

                }
            }
        }

    }
}
