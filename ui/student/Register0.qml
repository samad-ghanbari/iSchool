pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Student.js" as Methods
import "./../public" as DialogBox


Page {
    id: registerPage

    signal popStackSignal();
    required property var student;
    property bool isFemale : (registerPage.student.Gender === "خانم")? true : false;

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
            onClicked: registerPage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ثبت نام جدید"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }


        ScrollView{
            id: sv
            Layout.columnSpan: 2
            Layout.fillWidth: true;
            Layout.fillHeight: true;
            contentHeight : centerBox.height

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff


                      GridLayout
                    {
                    id: centerBoxGL
                        width: parent.width
                        anchors.margins: 10
                        columns:2

                        Image
                        {
                            Layout.columnSpan: 2
                            Layout.preferredWidth: 128
                            Layout.preferredHeight: 128
                            Layout.alignment: Qt.AlignHCenter
                            source: (registerPage.isFemale)? "qrc:/assets/images/female.png" : "qrc:/assets/images/user.png"
                        }

                        Text {
                            text: "نام دانش‌آموز "
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
                            text: registerPage.student["name"]
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            font.bold: true

                        }

                        Text {
                            text: "نام خانوادگی"
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
                            id: lastnameId
                            text: registerPage.student["lastname"]
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
                            Layout.columnSpan: 2
                            Layout.preferredHeight:  50
                            Layout.fillWidth: true
                            text:"شعبه " + registerPage.student.city + " - " + registerPage.student.branch_name
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            horizontalAlignment: Label.AlignHCenter
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
                        }

                        Button
                        {
                            Layout.columnSpan: 2
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                            Layout.topMargin: 50
                            Layout.alignment: Qt.AlignHCenter
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            text: "ثبت نام"
                            onClicked: confirmDialogId.open();
                            Rectangle{width: parent.width;  height: 4; color:"skyblue"; anchors.bottom: parent.bottom;}
                        }

                        Item{Layout.columnSpan: 2; Layout.preferredHeight: 40; Layout.fillWidth: true;}

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
        onDialogAccepted: {
            // register
        }
    }
}
