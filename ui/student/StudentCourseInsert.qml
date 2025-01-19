pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Student.js" as Methods

Page {
    id: insertPage

    required property var student;
    required property var registerModel;
    // r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id,
    // s.branch_id, br.city, br.branch_name, s.name, s.lastname, s.fathername, s.gender, s.enabled
    // st.step_name, sb.study_base, sp.study_period, sp.passed

    signal popStackViewSignal();
    signal insertedSignal();

    property bool isFemale : (insertPage.student.gender === "خانم")? true : false;

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
            icon.color:"transparent"
            opacity: 0.5
            onClicked: insertPage.popStackViewSignal();
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
            font.family: "Kalameh"
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
            implicitHeight: 250
            RowLayout
            {
                anchors.fill: parent
                spacing: 10
                Image
                {
                    Layout.preferredWidth: 128
                    Layout.preferredHeight: 128
                    Layout.alignment: Qt.AlignLeft
                    source:{
                        if(insertPage.student.photo == "")
                        {
                            if(insertPage.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                        }
                        else
                        {
                            return insertPage.student.photo;
                        }
                    }
                }
                Column{
                    Layout.fillWidth: true
                    Text {
                        text: insertPage.student["name"] + " " + insertPage.student["lastname"]
                        height: 50
                        width: parent.width
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                    }

                    Text {
                        text: "نام پدر" + " : " + insertPage.student["fathername"]
                        height: 50
                        width: parent.width
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                    }
                    // branch step
                    Text {
                        text: "شعبه " + " : " + insertPage.registerModel.City + " - " + insertPage.registerModel.Branch_name + " - " + insertPage.registerModel.Step_name + " - " + insertPage.registerModel.Study_base
                        height: 50
                        width: parent.width
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                    }
                    // class
                    Text {
                        text: "کلاس " + " : " + insertPage.registerModel.Class_name
                        height: 50
                        width: parent.width
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                    }
                    Text {
                        text: "سال تحصیلی " + " : " + insertPage.registerModel.Study_period
                        height: 50
                        width: parent.width
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
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
                                    font.family: "Kalameh"
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
                                    font.family: "Kalameh"
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
                                        var student_id = insertPage.student.id;
                                        var register_id = insertPage.registerModel.Id;
                                        var base_course = (courseTypeCB.currentValue == 1)? true : false;

                                        Methods.updateCourseCB(register_id, base_course);
                                        courseCB.currentIndex - 1;
                                        confirmBtn.enabled = false

                                        // teacher visibility
                                        if(base_course)
                                        {
                                            teacherLabel.visible = false;
                                            teacherCB.visible = false;
                                        }
                                        else
                                        {
                                            teacherLabel.visible = true;
                                            teacherCB.visible = true;
                                        }

                                    }
                                }


                                //course
                                Text {
                                    text: "درس"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Kalameh"
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
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    model: ListModel{id: courseCBModel;}
                                    valueRole: "value"
                                    textRole: "text"
                                    onActivated: {
                                        teacherCB.currentIndex = -1;
                                        confirmBtn.enabled = (courseTypeCB.currentValue == 1)? true : false;

                                    }
                                }

                                //teacher
                                Text {
                                    id: teacherLabel
                                    text: "دبیر"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                ComboBox
                                {
                                    id: teacherCB
                                    Layout.preferredHeight:  50
                                    Layout.fillWidth: true
                                    editable: false
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    model: ListModel{id: teacherCBoxModel;}
                                    valueRole: "value"
                                    textRole: "text"
                                    Component.onCompleted:
                                    {
                                        var branch_id = insertPage.registerModel.Branch_id;
                                        Methods.updateTeacherCB(branch_id);
                                    }
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
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                                onClicked:
                                {
                                    var student_id = insertPage.student.id;
                                    var register_id = insertPage.registerModel.Id;
                                    var course_id = courseCB.currentValue;
                                    var teacher_id = teacherCB.currentValue;
                                    var base_course = (courseTypeCB.currentValue == 1)? true : false;
                                    if(base_course) teacher_id = -1;

                                    if(dbMan.insertStudentCourse(student_id, register_id, course_id, teacher_id))
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
            insertPage.insertedSignal();
            insertPage.popStackViewSignal();
        }
    }
}
