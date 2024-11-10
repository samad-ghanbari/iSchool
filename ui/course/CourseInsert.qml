pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Course.js" as Methods

Page {
    id: insertPage

    signal popStackSignal();
    signal insertedSignal();

    required property int branch_id;
    required property int step_id;
    required property int base_id;
    required property int period_id;

    required property string branch;
    required property string step;
    required property string base;
    required property string period;


    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    GridLayout
    {
        columns: 2
        anchors.fill: parent

        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/arrow-right.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: insertPage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن درس جدید"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        ScrollView
        {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
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

                        GridLayout
                        {
                            columns: 2
                            rowSpacing: 20
                            columnSpacing: 10
                            Layout.preferredWidth:  parent.width

                            Image
                            {
                                Layout.columnSpan: 2
                                Layout.preferredWidth: 128
                                Layout.preferredHeight: 128
                                Layout.alignment: Qt.AlignHCenter
                                source:  "qrc:/assets/images/course.png"
                            }

                            //branch
                            Text {
                                text: "شعبه"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "black"
                            }
                            Text {
                                text: insertPage.branch
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 18
                                font.bold: true
                                color: "royalblue"
                            }

                            //step
                            Text {
                                text: "دوره"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "black"
                            }
                            Text {
                                text: insertPage.step
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 18
                                font.bold: true
                                color: "royalblue"
                            }

                            //base
                            Text {
                                text: "پایه تحصیلی"
                                visible: (insertPage.base_id > 0)? true : false;
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "black"
                            }
                            Text {
                                text:  insertPage.base
                                visible: (insertPage.base_id > 0)? true : false;
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 18
                                font.bold: true
                                color: "royalblue"
                            }

                            //period
                            Text {
                                text: "سال تحصیلی"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "black"
                            }
                            Text {
                                text:  insertPage.period
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 18
                                font.bold: true
                                color: "royalblue"
                            }

                            //Course name
                            Text {
                                text: "نام درس"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "black"
                            }
                            TextField
                            {
                                id: courseNameTF
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                placeholderText: "نام درس"

                            }

                            //class
                            Text {
                                text: "کلاس درس"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "black"
                            }
                            ComboBox
                            {
                                id: classCB
                                Layout.preferredHeight:  50
                                Layout.fillWidth: true
                                editable: false
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                model: ListModel{id: classModel;}
                                textRole: "text"
                                valueRole: "value"
                                Component.onCompleted: Methods.updateClassCB(insertPage.branch_id);
                            }

                            // teacher
                            Text {
                                text: "مدرس"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "black"
                            }
                            ComboBox
                            {
                                id: teacherCB
                                Layout.preferredHeight:  50
                                Layout.fillWidth: true
                                editable: false
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                model: ListModel{id: teacherModel;}
                                textRole: "text"
                                valueRole: "value"
                                Component.onCompleted: Methods.updateTeacherCB(insertPage.branch_id);
                            }
                        }


                        Item
                        {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                        }

                        Button
                        {
                            text: "تایید"
                            Layout.preferredWidth: 200
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                            onClicked:
                            {
                                var course = {};
                                course["step_id"] = insertPage.step_id
                                course["base_id"] = insertPage.base_id
                                course["period_id"] = insertPage.period_id

                                course["course_name"] = courseNameTF.text
                                course["teacher_id"] = teacherCB.currentValue
                                course["class_id"] = classCB.currentValue


                                if(dbMan.courseInsert(course))
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

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن درس جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "درس جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            insertPage.popStackSignal();
            insertPage.insertedSignal();
        }

    }
}
