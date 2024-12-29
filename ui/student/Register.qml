import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Student.js" as Methods
import "./../public" as DialogBox

Page {
    id: registerPage

    required property var student;
    signal popStackSignal();
    signal newRegisterSignal();

    property bool isFemale : (registerPage.student.Gender === "خانم")? true : false;

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
            icon.color:"transparent"
            opacity: 0.5
            onClicked: registerPage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ثبت‌نام جدید دانش‌آموز"
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
                width: (parent.width > 700)? 700 : parent.width
                implicitHeight : centerBox.implicitHeight + 40
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"

                GridLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20
                    columns: 2

                    Image
                    {
                        Layout.columnSpan: 2
                        Layout.preferredWidth: 128
                        Layout.preferredHeight: 128
                        Layout.alignment: Qt.AlignHCenter
                        source:{
                            if(registerPage.student.photo == "")
                            {
                                if(registerPage.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                            }
                            else
                            {
                                return registerPage.student.photo;
                            }
                        }
                    }

                    Text {
                        text: "دانش آموز"
                        Layout.minimumWidth: 200
                        Layout.maximumWidth: 200
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                    }
                    Text
                    {
                        id: nameId
                        text: registerPage.student["name"] + " " + registerPage.student["lastname"]
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true

                    }

                    Text {
                        text: "نام پدر"
                        Layout.minimumWidth: 200
                        Layout.maximumWidth: 200
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                    }
                    Text
                    {
                        id: fathernameId
                        text: registerPage.student["fathername"]
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
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

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 200
                        text:"شعبه"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }
                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        text: registerPage.student.city + " - " + registerPage.student.branch_name
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 200
                        text:"دوره"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: stepCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        Layout.alignment: Qt.AlignLeft
                        editable: false
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        model: ListModel{id: stepCBoxModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted:
                        {
                            Methods.updateStepCB(registerPage.student.branch_id);
                        }
                    }

                    // base
                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 200
                        text:"پایه تحصیلی"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: baseCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        Layout.alignment: Qt.AlignLeft
                        editable: false
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        model: ListModel{id: baseCBoxModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted:
                        {
                            Methods.updateBaseCB(registerPage.student.branch_id);
                        }
                    }

                    // study period
                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 200
                        text:"سال تحصیلی"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: periodCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        Layout.alignment: Qt.AlignLeft
                        editable: false
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true

                        model: ListModel{id: periodCBoxModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted:
                        {
                            Methods.updatePeiodCB(registerPage.student.branch_id);
                        }

                        onActivated : Methods.updateClassCB(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);
                    }

                    // class
                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 200
                        text:"کلاس درس"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: classCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        Layout.alignment: Qt.AlignLeft
                        editable: false
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        model: ListModel{id: classModel;}
                        textRole: "text"
                        valueRole: "value"
                    }




                    Button
                    {
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 60
                        Layout.fillWidth: true
                        Layout.maximumWidth: 500
                        Layout.topMargin: 50
                        Layout.alignment: Qt.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        text: "ثبت نام"
                        enabled: (classCB.currentValue > -1 )? true : false
                        onClicked: confirmDialogId.open();
                        Rectangle{width: parent.width;  height: 4; color:"skyblue"; anchors.bottom: parent.bottom;}
                    }

                    Item{Layout.columnSpan: 2; Layout.preferredHeight: 40; Layout.fillWidth: true;}

                }
            }
        }
    }

    //confirm register
    DialogBox.BaseDialog
    {
        id: confirmDialogId
        dialogTitle: "تایید ثبت نام"
        dialogText: "آیا از ثبت نام جدید دانش‌آموز مطمئن می‌باشید؟"
        dialogSuccess: true
        rejectVisible: true
        onDialogAccepted: {
            var reg = {}
            reg["student_id"] = registerPage.student.id;
            reg["step_id"] = stepCB.currentValue;
            reg["study_base_id"] = baseCB.currentValue;
            reg["study_period_id"] = periodCB.currentValue;
            reg["class_id"] = classCB.currentValue

            if(dbMan.registerStudent(reg))
            {
                // on register > student_courses & student_evals should be inserted too

                // student_courses : student_id, register_id, course_id, teacher_id
                var register_id = dbMan.getLastInsertedId();
                var student_id = registerPage.student.id;
                var class_id = classCB.currentValue; // get course_id & teacher_id of class
                //student_evals : student_id, eval_id
                // class_id > eval_ids

                if(dbMan.registerStudentCourseInsert(student_id, register_id, class_id) )
                {
                    if( dbMan.registerStudentEvalInsert(student_id, class_id) )
                    {
                        successDialogId.dialogText = "ثبت‌نام با موفقیت انجام شد." + "\n" + "دروس و ارزیابی دانش‌آموز بروز گردید."
                        successDialogId.open();
                    }
                    else
                    {
                        successDialogId.dialogText = "ثبت‌نام با موفقیت انجام شد." + "\n" + "دروس دانش‌آموز بروز گردید."
                        successDialogId.open();
                    }

                }
                else
                {
                    successDialogId.dialogText = "ثبت‌نام با موفقیت انجام شد."
                    successDialogId.open();
                }
            }
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

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "ثبت‌نام دانش‌آموز با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ثبت‌نام با موفقیت انجام شد."
        dialogSuccess: true
        onDialogAccepted: {
            registerPage.popStackSignal();
            registerPage.newRegisterSignal();
        }

    }
}
