import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deleteClassPage

    required property int class_id;
    required property string class_name
    required property string class_desc
    required property bool field_based
    required property string field
    required property string base

    required property string branch;
    required property string step
    required property string period;

    signal deletedSignal();
    signal popStackSignal();

    background: Rectangle{anchors.fill: parent; color: "lavenderblush"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف کلاس"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }


        Flickable
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            anchors.margins: 10
            contentHeight: centerBox.implicitHeight

            Rectangle{
                width:  (parent.width < 700)? parent.width : 700
                height: centerBox.implicitHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color: "ghostwhite"

                Column{
                    id: centerBox
                    width:  parent.width


                    Image {
                        source: "qrc:/assets/images/trash.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                        height:  64
                        width:  64
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }

                    Text {
                        text: "شعبه " + deleteClassPage.branch + " - " + deleteClassPage.step
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }
                    Text {
                        text:{
                            var base = deleteClassPage.base
                            if(!base.includes("پایه")) base = "پایه " + base;

                            if(deleteClassPage.field_based){

                                return "رشته " + deleteClassPage.field + " - " +  base
                            }
                            else{

                                return base;
                            }
                        }
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }
                    Text {
                        text: "سال تحصیلی " +  deleteClassPage.period
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }

                    RowLayout{
                        width: parent.width
                        height: 50

                        Text {
                            text: "نام کلاس"
                            Layout.preferredWidth:  150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Kalameh"
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
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            text: deleteClassPage.class_name
                        }

                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "توضیحات کلاس "
                            Layout.preferredWidth:  150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Kalameh"
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
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            text: deleteClassPage.class_desc
                        }
                    }

                    Item
                    {
                        width: parent.width
                        height: 50
                    }

                    Button
                    {
                        text: "حذف"
                        width: 200
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "mediumvioletred"}
                        onClicked: classDelDialog.open();

                    }

                    Item
                    {
                        width: parent.width
                        height: 50
                    }
                }

            }
        }


    }

    DialogBox.BaseDialog
    {
        id: classDelDialog
        dialogTitle:  "حذف کلاس"
        dialogText: "آیا از حذف کلاس از سامانه مطمئن می‌باشید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: function(){
            if(dbMan.classDelete(deleteClassPage.class_id))
                classSuccessDialogId.open();

            else
                classInfoDialogId.open();
        }
    }
    DialogBox.BaseDialog
    {
        id: classInfoDialogId
        dialogTitle: "خطا"
        dialogText: "حذف کلاس جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: classSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "حذف کلاس با موفقیت انجام شد."
        dialogSuccess: true
        onDialogAccepted: {
            deleteClassPage.popStackSignal();
            deleteClassPage.deletedSignal();
        }

    }
}
