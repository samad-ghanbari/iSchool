import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deletePage

    required property var student;
    required property int regId;
    required property string regStep;
    required property string regBase;
    required property string regPeriod;
    required property string regClass;

    signal deletedSignal();
    signal popStackSignal();

    property bool isFemale : (deletePage.student.Gender === "خانم")? true : false;

    background: Rectangle{anchors.fill: parent; color: "lavenderblush"}


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
            onClicked: deletePage.popStackSignal()
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف ثبت‌نام دانش‌آموز"
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
                        source: {
                            if(deletePage.student.photo == "")
                            {
                                if(deletePage.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                            }
                            else
                            {
                                return deletePage.student.photo;
                            }
                        }
                    }

                    Text {
                        text: "دانش‌آموز"
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
                        text: deletePage.student["name"] + " " + deletePage.student["lastname"]
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16

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
                        text: deletePage.student["fathername"]
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                    }

                    Rectangle
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 4
                        color: "mediumvioletred"
                        Layout.topMargin: 10
                        Layout.bottomMargin: 10
                    }

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 200
                        text:"شعبه"
                        color: "royalblue"
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
                        text: deletePage.student.city + " - " + deletePage.student.branch_name
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 200
                        text:"دوره"
                        color: "royalblue"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }
                    Label
                    {
                        id: stepCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: deletePage.regStep
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }

                    // base
                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 200
                        text:"پایه تحصیلی"
                        color: "royalblue"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }
                    Label
                    {
                        id: baseCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: deletePage.regBase
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }

                    // study period
                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 200
                        text:"سال تحصیلی"
                        color: "royalblue"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                    }
                    Label
                    {
                        id: periodCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                        text: deletePage.regPeriod
                    }

                    // class
                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 200
                        text:"کلاس "
                        color: "royalblue"
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
                        Layout.maximumWidth: 400
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                        text: deletePage.regClass
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
                        text: "حذف ثبت‌نام"
                        onClicked:
                        {

                            confirmDialogId.open();
                        }
                        Rectangle{width: parent.width;  height: 4; color:"mediumvioletred"; anchors.bottom: parent.bottom;}
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
        dialogTitle: "تایید حذف"
        dialogText: "آیا از حذف ثبت نام دانش‌آموز مطمئن می‌باشید؟"
        dialogSuccess: false
        rejectVisible: true
        onDialogAccepted: {

            if(dbMan.registerDelete(deletePage.regId))
            {
                confirmDialogId.close();
                deletePage.popStackSignal();
                deletePage.deletedSignal();
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
        dialogText: "حذف ثبت ‌نام دانش‌آموز با خطا مواجه شد."
        dialogSuccess: false
    }
}
