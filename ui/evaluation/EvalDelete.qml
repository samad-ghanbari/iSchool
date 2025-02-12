pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deletePage

    signal popStackSignal();
    signal deletedSignal();

    required property int base_id;
    required property bool field_based;

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property string period;

    required property int id;
    required property string eval_name;
    required property real max_grade;
    required property bool course_flag;
    required property bool test_flag;
    required property bool final_flag;

    background: Rectangle{anchors.fill: parent; color: "lavenderblush"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف ارزیابی"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        Flickable{
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            contentHeight: centerBox.implicitHeight

            Rectangle
            {
                width: (parent.width > 700)? 700 : parent.width
                height:  centerBox.implicitHeight + 100
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"
                anchors.margins: 10

                Column{
                    id: centerBox
                    width : parent.width
                    anchors.margins: 10

                    Image
                    {
                        width: 64
                        height: 64
                        anchors.horizontalCenter: parent.horizontalCenter
                        source:  "qrc:/assets/images/evaluation.png"
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }

                    //branch
                    Text {
                        width: parent.width
                        height: 50
                        text: "شعبه " + deletePage.branch + " - " + deletePage.step
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text {
                        text: (deletePage.field_based) ?  deletePage.field + "  " +  deletePage.base :  deletePage.base
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Row{
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text {
                            text: "سال تحصیلی "
                            height: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        Text {
                            text: deletePage.period
                            height: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                    }
                    // eval name
                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "نام ارزیابی"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        Text
                        {
                            id: evalNameTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text: deletePage.eval_name
                        }
                    }
                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    // max grade
                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "بیشترین نمره"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        Text
                        {
                            id: maxGradeTF
                            Layout.fillWidth: true
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text: deletePage.max_grade
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    // course flag
                    Switch{
                        id: courseFlagSW
                        width: parent.width
                        height: 50
                        text: "ارزیابی واحد درسی"
                        checked: deletePage.course_flag
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        onClicked: courseFlagSW.checked = deletePage.course_flag
                    }

                    // test flag
                    Switch{
                        id: testFlagSW
                        width: parent.width
                        height: 50
                        text: "ارزیابی واحد تستی"
                        checked: deletePage.test_flag
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        onClicked: testFlagSW.checked = deletePage.test_flag
                    }

                    // final flag
                    Switch{
                        id: finalFlagSW
                        width: parent.width
                        height: 50
                        text: "ارزیابی نهایی "
                        checked: deletePage.final_flag
                        onClicked: finalFlagSW.checked = deletePage.final_flag
                        font.family: "Kalameh"
                        font.pixelSize: 16
                    }

                    Item{width: parent.width; height: 50;}

                    Button
                    {
                        text: "تایید"
                        width: 200
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                        onClicked:
                        {
                            var id = deletePage.id

                            if(dbMan.deleteEval(id))
                            {
                                deletePage.deletedSignal();
                                successDialogId.open();
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

                    Item
                    {
                        width: parent.width
                        height: 5
                    }
                }
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
        }

    }
}
