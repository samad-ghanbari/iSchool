pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Student.js" as Methods

Page {
    id: studentCourseInsertPage

    required property var student;
    required property var registerModel;
    // r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id,
    // s.branch_id, br.city, br.branch_name, s.name, s.lastname, s.fathername, s.gender, s.enabled
    // st.step_name, sb.study_base, sp.study_period, sp.passed

    signal popStackViewSignal();
    signal insertedSignal();

    property bool isFemale : (studentCourseInsertPage.student.gender === "خانم")? true : false;

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
            onClicked: studentCourseInsertPage.popStackViewSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن واحد درسی دانش‌آموز"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }


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
                    source: (studentCourseInsertPage.isFemale)? "qrc:/assets/images/female.png" : "qrc:/assets/images/user.png"
                }
                Column{
                    Layout.fillWidth: true
                    Text {
                        text: studentCourseInsertPage.student["name"] + " " + studentCourseInsertPage.student["lastname"]
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
                        text: "نام پدر" + " : " + studentCourseInsertPage.student["fathername"]
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
                        text: "شعبه " + " : " + studentCourseInsertPage.registerModel.City + " - " + studentCourseInsertPage.registerModel.Branch_name + " - " + studentCourseInsertPage.registerModel.Step_name + " - " + studentCourseInsertPage.registerModel.Study_base
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
                        text:  studentCourseInsertPage.registerModel.Study_period
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


        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.preferredHeight: 4
            color: "skyblue"
            Layout.topMargin: 10
            Layout.bottomMargin: 10
        }

        //form
        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "honeydew"

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
                    width:  (parent.width < 700)? parent.width : 700
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: parent.height

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            width: parent.width
                            Image {
                                source: "qrc:/assets/images/add.png"
                                Layout.alignment: Qt.AlignHCenter
                                Layout.preferredHeight:  64
                                Layout.preferredWidth:  64
                                Layout.margins: 20
                                NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                            }

                            GridLayout
                            {
                                columns: 2
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                //step base
                                Text {
                                    text: "دسته‌بندی"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                ComboBox
                                {
                                    id: courseTypeCB
                                    Layout.preferredHeight:  50
                                    Layout.fillWidth: true

                                    editable: false
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    model: ListModel{
                                        ListElement{ID: 1; TEXT: "دروس پایه" }
                                        ListElement{ID: 2; TEXT: "دروس دوره" }
                                    }
                                    valueRole: "ID"
                                    textRole: "TEXT"
                                    Component.onCompleted: courseTypeCB.currentIndex = -1
                                    onActivated:
                                    {
                                        var student_id = studentCourseInsertPage.student.id;
                                        var step_id = studentCourseInsertPage.registerModel.Step_id;
                                        var base_id = (courseTypeCB.currentValue == 1)? courseTypeCB.currentValue : -1;
                                        var period_id = studentCourseInsertPage.registerModel.Study_period_id;

                                        Methods.updateCourseCB(student_id, step_id, base_id, period_id);
                                        courseCB.currentIndex - 1;
                                        confirmBtn.enabled = false

                                    }
                                }


                                //course
                                Text {
                                    text: "درس"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                ComboBox
                                {
                                    id: courseCB
                                    Layout.preferredHeight:  50
                                    Layout.fillWidth: true
                                    editable: false
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    model: ListModel{id: courseCBModel;}
                                    valueRole: "value"
                                    textRole: "text"
                                    onActivated: confirmBtn.enabled = true
                                }


                            }


                            Item
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                            }

                            Button
                            {
                                id: confirmBtn
                                text: "تایید"
                                Layout.preferredWidth: 200
                                Layout.preferredHeight: 50
                                enabled: false
                                Layout.alignment: Qt.AlignHCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                                onClicked:
                                {
                                    var student_id = studentCourseInsertPage.student.id
                                    var course_id = courseCB.currentValue;

                                    if(dbMan.insertStudentCourse(student_id, course_id))
                                        successDialogId.open();
                                    else
                                    {
                                        var errorString = dbMan.getLastError();
                                        infoDialogId.dialogText = errorString
                                        infoDialogId.width = parent.width
                                        infoDialogId.height = 500
                                        infoDialogId.open();
                                    }
                                }
                            }

                            Item
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                            }
                        }
                    }
                }
            }
        }
    }


    //dialog
    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن واحد درسی با مشکل مواجه شد."
        dialogSuccess: false
    }

    //dialog success
    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "واحد درسی با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted:
        {
            successDialogId.close();
            studentCourseInsertPage.insertedSignal();
            studentCourseInsertPage.popStackViewSignal();
        }
    }
}
