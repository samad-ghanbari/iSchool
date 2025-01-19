import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deleteRegPage

    property string branch
    property string step

    required property string name
    required property string lastname
    required property string fathername
    required property string photo

    required property int register_id
    required property string period
    required property string class_name
    required property string base
    required property string field
    required property bool field_based

    signal popStackSignal();
    signal deletedSignal();

    background: Rectangle{anchors.fill: parent; color: "lavenderblush"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف ثبت‌نام دانش‌آموز"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
        }
        Image {
            source: "qrc:/assets/images/trash.png"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight:  64
            Layout.preferredWidth:  64
            Layout.margins: 10
            NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
        }

        Flickable{
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentHeight: centerBox.implicitHeight

            Rectangle{
                color:"snow"
                width:  (parent.width < 700)? parent.width : 700
                height: centerBox.implicitHeight + 100
                anchors.horizontalCenter: parent.horizontalCenter

                Column{
                    id: centerBox
                    width: parent.width

                    Image {
                        source: deleteRegPage.photo
                        anchors.horizontalCenter: parent.horizontalCenter
                        height:  128
                        width:  128
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }

                    //branch-step
                    Text {
                        text: "شعبه " + deleteRegPage.branch + " - " + deleteRegPage.step
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 18
                        font.bold: true
                        color: "darkcyan"
                    }
                    Text {
                        text: deleteRegPage.name + " " + deleteRegPage.lastname + " ( " + deleteRegPage.fathername  + " ) "
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 20
                        font.bold: true
                        color: "mediumvioletred"
                    }
                    // period
                    RowLayout{
                        width: parent.width
                        height: 50
                        //birthday
                        Text {
                            text: "سال تحصیلی "
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        Text
                        {
                            text: deleteRegPage.period
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    // field
                    RowLayout{
                        width: parent.width
                        height: 50
                        visible: (deleteRegPage.field_based)? true : false
                        //birthday
                        Text {
                            text: "رشته تحصیلی "
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        Text
                        {
                            text: deleteRegPage.field
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    // base
                    RowLayout{
                        width: parent.width
                        height: 50
                        visible: (deleteRegPage.field_based)? true : false
                        //birthday
                        Text {
                            text: "پایه تحصیلی "
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        Text
                        {
                            text: deleteRegPage.base
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    // class
                    RowLayout{
                        width: parent.width
                        height: 50
                        visible: (deleteRegPage.field_based)? true : false
                        //birthday
                        Text {
                            text: "کلاس "
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        Text
                        {
                            text: deleteRegPage.class_name
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }


                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    Button
                    {
                        text: "حذف ثبت‌نام دانش‌آموز"
                        width: 200
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
                        onClicked: delDialog.open();
                    }

                    Item
                    {
                        width: parent.width
                        height: 20
                    }

                    Text
                    {
                        width: parent.width
                        height: 40
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        text: "با حذف ثبت‌نام دانش‌آموز، تمامی دروس و نمرات دانش‌آموز از سامانه پاک خواهد شد."
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "crimson"
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
        id: delDialog
        dialogTitle:  "حذف ثبت‌نام دانش‌آموز"
        dialogText: "آیا از حذف ثبت‌نام دانش‌آموز مطمئن هستید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: function(){
            if(dbMan.registerDelete(deleteRegPage.register_id)){
                deleteRegPage.deletedSignal();
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
        dialogText: "انجام عملیات با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "عملیات با موفقیت انجام شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            deleteRegPage.popStackSignal();
        }
    }
}
