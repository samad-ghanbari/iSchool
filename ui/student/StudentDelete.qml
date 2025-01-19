import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deletePage

    property string branch
    property string step

    required property int student_id
    required property string name
    required property string lastname
    required property string fathername
    required property string birthday
    required property string gender
    required property bool enabled
    required property string photo

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
            text: "حذف دانش‌آموز"
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
                        source: deletePage.photo
                        anchors.horizontalCenter: parent.horizontalCenter
                        height:  128
                        width:  128
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }

                    //branch-step
                    Text {
                        text: "شعبه " + deletePage.branch + " - " + deletePage.step
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 18
                        font.bold: true
                        color: "darkcyan"
                    }

                    //name
                    RowLayout{
                        width: parent.width
                        height: 50
                        //name
                        Text {
                            text: "نام دانش‌آموز"
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
                            id: nameTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text: deletePage.name
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    //lastname
                    RowLayout{
                        width: parent.width
                        height: 50
                        //lastname
                        Text {
                            text: "نام خانوادگی"
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
                            id: lastnameTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text: deletePage.lastname
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    //fathername
                    RowLayout{
                        width: parent.width
                        height: 50
                        //fathername
                        Text {
                            text: "نام پدر"
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
                            id: fathernameTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text: deletePage.fathername
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    //gender
                    RowLayout{
                        width: parent.width
                        height: 50
                        //gender
                        Text {
                            text: "جنسیت"
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
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text: deletePage.gender
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        Item{Layout.preferredHeight: 1; Layout.fillWidth: true;}
                    }

                    //birthday
                    RowLayout{
                        width: parent.width
                        height: 50
                        //birthday
                        Text {
                            text: "تاریخ تولد"
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
                            id: birthdayTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text: deletePage.birthday
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
                        text: "حذف دانش‌آموز"
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
                        text: "برای حذف دانش‌آموز لازم است ابتدا ثبت‌نامی‌های دانش‌آموز حذف گردند."
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
        dialogTitle:  "حذف دانش‌آموز"
        dialogText: "آیا از حذف کامل دانش‌آموز مطمئن هستید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: function(){
            if(dbMan.studentDelete(deletePage.student_id)){
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
        dialogText: "انجام عملیات با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "دانش‌آموز با موفقیت حذف شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            deletePage.popStackSignal();
        }
    }
}
