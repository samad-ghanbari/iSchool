import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: insertPage

    property int branchId;
    property string branchText

    signal popStackSignal();
    signal insertedSignal();

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
            onClicked: insertPage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن دانش‌آموز جدید"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "honeydew"

            ScrollView
            {
                height: parent.height
                width: parent.width
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                Rectangle
                {
                    id: centerBoxId
                    color:"snow"
                    width:  (parent.width < 700)? parent.width : 700
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: parent.height

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            width: parent.width
                            Image {
                                source: "qrc:/assets/images/add.png"
                                Layout.alignment: Qt.AlignHCenter
                                Layout.preferredHeight:  64
                                Layout.preferredWidth:  64
                                Layout.margins: 20
                                NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                            }

                            GridLayout
                            {
                                columns: 2
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width
                                //branch
                                Text {
                                    Layout.columnSpan: 2
                                    text: "شعبه " + insertPage.branchText
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }

                                //name
                                Text {
                                    text: "نام دانش‌آموز"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                TextField
                                {
                                    id: nameTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "نام دانش‌آموز"

                                }
                                //lastname
                                Text {
                                    text: "نام خانوادگی"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                TextField
                                {
                                    id: lastnameTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "نام خانوادگی دانش‌آموز"

                                }
                                //fathername
                                Text {
                                    text: "نام پدر"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                TextField
                                {
                                    id: fathernameTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "نام پدر"

                                }
                                //gender
                                Text {
                                    text: "جنسیت"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                ComboBox
                                {
                                    id: genderCB
                                    Layout.preferredHeight:  50
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 200
                                    editable: false
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    model: ["خانم", "آقا"]
                                    //textRole: "text"
                                    //valueRole: "value"
                                }

                                //photo
                                Button{
                                    text: "تصویر"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 40
                                    palette.text: "royalblue"
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    onClicked: photoBrows.open();
                                }
                                Text
                                {
                                    id: photoPath
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    elide: Text.ElideLeft
                                }

                                //birthday
                                Text {
                                    text: "تاریخ تولد"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                TextField
                                {
                                    id: birthdayTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "1380/01/01"
                                    validator: RegularExpressionValidator
                                    {
                                        regularExpression: /^\d{4}\/\d{2}\/\d{2}$/
                                        // Regex pattern to match date in yyyy/MM/dd format
                                    }
                                }
                                //enabled
                                Text {
                                    text: "وضعیت فعال/غیرفعال"
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Switch
                                {
                                    id: enabledSW
                                    checked: true
                                    text: checked? "فعال" : "غیرفعال";
                                    font.family: "B Yekan"
                                    palette.highlight: "royalblue"
                                    palette.text: "gray"
                                }
                            }


                            Item
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                            }

                            Button
                            {
                                text: "تایید"
                                Layout.preferredWidth: 200
                                Layout.preferredHeight: 50
                                Layout.alignment: Qt.AlignHCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                                onClicked:
                                {
                                    var student = {};
                                    student["branch_id"] = insertPage.branchId
                                    student["name"] = nameTF.text
                                    student["lastname"] = lastnameTF.text
                                    student["fathername"] = fathernameTF.text
                                    student["gender"] = genderCB.currentText
                                    student["birthday"] = birthdayTF.text
                                    student["enabled"] = enabledSW.checked
                                    student["photo_path"] = photoPath.text;

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
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                            }
                        }
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
            insertPage.popStackSignal();
            insertPage.insertedSignal();
        }

    }
}
