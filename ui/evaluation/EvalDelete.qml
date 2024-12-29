pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deletePage

    required property string branch
    required property string step
    required property string base
    required property string period

    required property string course_name
    required property string eval_cat;
    required property int eval_id;
    required property string eval_time;
    required property double max_grade;
    required property bool test_flag;
    required property bool final_flag;
    required property bool included;


    signal popStackSignal();
    signal deletedSignal();


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
            onClicked: deletePage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف ارزیابی"
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
                        source:  "qrc:/assets/images/evaluation.png"
                    }

                    // branch
                    Text {
                        text: "شعبه" + " " + deletePage.branch
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }

                    //step base
                    Text {
                        text: {
                            if(deletePage.base.indexOf("پایه") == -1)
                            return deletePage.step + " - پایه " + deletePage.base;
                            else
                            return deletePage.step + " - " + deletePage.base;
                        }
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }


                   //period
                    Text {
                        text: "سال تحصیلی" + " " + deletePage.period
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }

                    // eval cat
                    Text {
                        text: "دسته ارزیابی"
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
                    Text
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: deletePage.eval_cat
                    }

                    //course
                     Text {
                         text: "عنوان درس"
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
                     Text
                     {
                         Layout.fillWidth: true
                         Layout.preferredHeight: 50
                         verticalAlignment: Text.AlignVCenter
                         horizontalAlignment: Text.AlignLeft
                         font.family: "B Yekan"
                         font.pixelSize: 16
                         text: deletePage.course_name
                     }


                   //eval time
                    Text {
                        text: "زمان ارزیابی"
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
                    Text
                    {
                        id: evaltimeTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: deletePage.eval_time
                    }

                    //max grade
                    Text {
                        text: "بالاترین نمره"
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
                    Text
                    {
                        id: maxGradeTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: deletePage.max_grade
                    }


                    //test
                    Text {
                        text: "آزمون تستی"
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
                    Switch
                    {
                        enabled: false
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignLeft
                        checked: deletePage.test_flag
                    }

                    //final
                    Text {
                        text: "آزمون نهایی"
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
                    Switch
                    {
                        enabled: false
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignLeft
                        checked: deletePage.final_flag
                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                    }

                    Button
                    {
                        text: "تایید"
                        Layout.columnSpan: 2
                        Layout.preferredWidth: 200
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "mediumvioletred"}
                        onClicked: delDialog.open();
                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                    }


                }
            }
        }
    }

    DialogBox.BaseDialog
    {
        id: delDialog
        dialogTitle:  "حذف ارزیابی"
        dialogText: "آیا از حذف ارزیابی مطمئن می‌باشید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: {
            if(dbMan.evalDelete(deletePage.eval_id))
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

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "حذف ارزیابی با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ارزیابی با موفقیت حذف شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            deletePage.popStackSignal();
            deletePage.deletedSignal();
        }

    }
}
