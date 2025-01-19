pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deletePage

    signal popStackSignal();
    signal deletedSignal();

    required property int course_id;
    required property bool field_based;

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property string period;

    required property string course_name;
    required property real final_weight;
    required property real course_coefficient;
    required property real test_coefficient;


    background: Rectangle{anchors.fill: parent; color: "lavenderblush"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف واحد درسی"
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
                        source:  "qrc:/assets/images/trash.png"
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
                        text: (deletePage.field_based) ? "رشته " + deletePage.field + " - " +  deletePage.base :  deletePage.base
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text {
                        text: "سال تحصیلی " + deletePage.period
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }

                    // course name
                    RowLayout{
                        width: parent.width
                        height: 50
                        //Course name
                        Text {
                            text: "نام درس"
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
                            id: courseNameTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            text: deletePage.course_name
                            color: "darkred"
                        }
                    }
                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    // final weight
                    RowLayout{
                        width: parent.width
                        height: 50
                        //final weight
                        Text {
                            text: "وزن ارزیابی نهایی"
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
                            Layout.fillWidth: true
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text : deletePage.final_weight
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            color: "darkred"
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    // course coeff
                    RowLayout{
                        width: parent.width
                        height: 50
                        //Course coef
                        Text {
                            text: "ضریب درس"
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
                            Layout.fillWidth: true
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            text: deletePage.course_coefficient
                            color: "darkred"
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }
                    // test Coeff
                    RowLayout{
                        width: parent.width
                        height: 50
                        //test coefficient
                        Text {
                            text: "ضریب تست"
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
                            id: testCoefTF
                            Layout.fillWidth: true
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            text: deletePage.test_coefficient
                            color: "darkred"
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    Item{width: parent.width; height: 5;}
                    Rectangle{
                        width: parent.width
                        height: 1
                        color: "darkgray"
                    }

                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    Button
                    {
                        text: "تایید"
                        width: 200
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
                        onClicked:
                        {
                            courseDelDialog.width=500
                            courseDelDialog.open();
                        }
                    }

                    Item
                    {
                        width: parent.width
                        height: 10
                    }
                }
            }
        }
    }

    DialogBox.BaseDialog
    {
        id: courseDelDialog
        dialogTitle:  "حذف درس"
        dialogText: "آیا از حذف واحد درسی از زیر مجموعه همه دانش‌آموزان مطمئن می‌باشید؟" + ""
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: function(){
            if(dbMan.courseDelete(deletePage.course_id))
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

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "حذف درس با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "درس با موفقیت حذف شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            deletePage.popStackSignal();
        }

    }
}
