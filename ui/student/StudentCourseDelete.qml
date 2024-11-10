pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Student.js" as Methods

Page {
    id: studentCourseDeletePage

    required property var student;
    required property var registerModel;

    required property string course_name;
    required property string class_name;
    required property string teacher;
    required property int student_course_id;

    signal popStackViewSignal();
    signal deletedSignal();

    property bool isFemale : (studentCourseDeletePage.student.gender === "خانم")? true : false;

    background: Rectangle{anchors.fill: parent; color: "lavenderblush"}

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
            onClicked: studentCourseDeletePage.popStackViewSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف واحد درسی دانش‌آموز"
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
                    source: (studentCourseDeletePage.isFemale)? "qrc:/assets/images/female.png" : "qrc:/assets/images/user.png"
                }
                Column{
                    Layout.fillWidth: true
                    Text {
                        text: studentCourseDeletePage.student["name"] + " " + studentCourseDeletePage.student["lastname"]
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
                        text: "نام پدر" + " : " + studentCourseDeletePage.student["fathername"]
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
                        text: "شعبه " + " : " + studentCourseDeletePage.registerModel.City + " - " + studentCourseDeletePage.registerModel.Branch_name + " - " + studentCourseDeletePage.registerModel.Step_name + " - " + studentCourseDeletePage.registerModel.Study_base
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
                        text:  studentCourseDeletePage.registerModel.Study_period
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
            color: "lavenderblush"

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
                                source: "qrc:/assets/images/trash.png"
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

                                //course
                                Text {
                                    text: "نام درس"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: studentCourseDeletePage.course_name

                                }

                                //class
                                Text {
                                    text: "کلاس"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: studentCourseDeletePage.class_name

                                }

                                //teacher
                                Text {
                                    text: "مدرس"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: studentCourseDeletePage.teacher

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
                                Layout.alignment: Qt.AlignHCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "mediumvioletred"}
                                onClicked: delDialog.open()
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

    //delete
    DialogBox.BaseDialog
    {
        id: delDialog
        dialogTitle:  "حذف واحد درسی"
        dialogText: "آیا از حذف حذف واحد درسی دانش آموز مطمئن می‌باشید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: {
            if(dbMan.deleteStudentCourse(studentCourseDeletePage.student_course_id))
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

    //dialog
    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "حذف واحد درسی با مشکل مواجه شد."
        dialogSuccess: false
    }

    //dialog success
    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "واحد درسی با موفقیت حذف شد."
        dialogSuccess: true
        onDialogAccepted:
        {
            successDialogId.close();
            studentCourseDeletePage.deletedSignal();
            studentCourseDeletePage.popStackViewSignal();
        }
    }
}
