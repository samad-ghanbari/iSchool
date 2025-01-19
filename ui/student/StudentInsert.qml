import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: insertPage

    property int step_id;
    property string branch
    property string step

    signal popStackSignal();
    signal insertedSignal();

    background: Rectangle{anchors.fill: parent; color: "honeydew"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن دانش‌آموز جدید"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
        }
        Image {
            source: "qrc:/assets/images/add.png"
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

                    //branch-step
                    Text {
                        text: "شعبه " + insertPage.branch + " - " + insertPage.step
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
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        TextField
                        {
                            id: nameTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "نام دانش‌آموز"

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
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        TextField
                        {
                            id: lastnameTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "نام خانوادگی دانش‌آموز"

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
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        TextField
                        {
                            id: fathernameTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "نام پدر"

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
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        ComboBox
                        {
                            id: genderCB
                            Layout.preferredHeight:  50
                            Layout.fillWidth: true
                            Layout.maximumWidth: 200
                            editable: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ["خانم", "آقا"]
                            //textRole: "text"
                            //valueRole: "value"
                        }

                        Item{Layout.preferredHeight: 1; Layout.fillWidth: true;}
                    }
                    //photo
                    RowLayout{
                        width: parent.width
                        height: 50
                        //photo
                        Button{
                            text: "تصویر"
                            Layout.minimumWidth: 100
                            Layout.maximumWidth: 100
                            Layout.preferredHeight: 40
                            palette.text: "darkcyan"
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            onClicked: photoBrows.open();
                        }
                        Text
                        {
                            id: photoPath
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: false
                            elide: Text.ElideLeft
                        }
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
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        TextField
                        {
                            id: birthdayTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "1380/01/01"
                            validator: RegularExpressionValidator
                            {
                                regularExpression: /^\d{4}\/\d{2}\/\d{2}$/
                                // Regex pattern to match date in yyyy/MM/dd format
                            }
                        }
                    }
                    //enabled
                    RowLayout{
                        width: parent.width
                        height: 50
                        //enabled
                        Text {
                            text: "وضعیت فعال/غیرفعال"
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                            color: "darkcyan"
                        }
                        Switch
                        {
                            id: enabledSW
                            checked: true
                            text: checked? "فعال" : "غیرفعال";
                            font.family: "Kalameh"
                            palette.highlight: "darkcyan"
                            palette.text: "gray"
                        }
                        Item{Layout.preferredHeight: 1; Layout.fillWidth: true;}
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
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                        onClicked:
                        {
                            var student = {};
                            student["step_id"] = insertPage.step_id
                            student["name"] = nameTF.text
                            student["lastname"] = lastnameTF.text
                            student["fathername"] = fathernameTF.text
                            student["gender"] = genderCB.currentText
                            student["birthday"] = birthdayTF.text
                            student["enabled"] = enabledSW.checked
                            student["photo"] = photoPath.text;

                            if(dbMan.studentInsert(student))
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
                        width: parent.width
                        height: 10
                    }

                }
            }
        }
    }


    FileDialog {
        id: photoBrows
        title: "انتخاب تصویر"
        currentFolder: "file:///home/samad/"
        //  currentFolder: "C:/Users/YourUsername/Documents"
        nameFilters: ["Images (*.png *.jpg)"]
        onAccepted: photoPath.text = selectedFile;
        onRejected: photoBrows.close();
        }

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن دانش‌آموز جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "دانش‌آموز جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            insertPage.insertedSignal();
            insertPage.popStackSignal();
        }
    }
}
