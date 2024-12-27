import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import "./../public" as DialogBox

Page {
    id: updatePage

    required property var model;
    required property string branchText;

    signal updatedSignal();
    signal popStackSignal();

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
            onClicked: updatePage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ویرایش دانش‌آموز"
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
            color: "mintcream"

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
                            id: periodInsertCL
                            width: parent.width
                            Image {
                                id: userPhoto
                                //source: "qrc:/assets/images/edit.png"
                                source:{
                                    if(updatePage.model.photo == "")
                                    {
                                        if(updatePage.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                                    }
                                    else
                                    {
                                        return "file://"+updatePage.model.photo;
                                    }
                                }
                                Layout.alignment: Qt.AlignHCenter
                                Layout.preferredHeight:  64
                                Layout.preferredWidth:  64
                                Layout.margins: 20
                                NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                            }

                            GridLayout
                            {
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                //branch
                                Text {
                                    Layout.columnSpan: 2
                                    text: "شعبه " + updatePage.branchText
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
                                    text: updatePage.model.name

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
                                    text: updatePage.model.lastname

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
                                    placeholderText: "نام پدر دانش‌آموز"
                                    text: updatePage.model.fathername

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
                                    Component.onCompleted: genderCB.currentIndex = find(updatePage.model.gender)
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
                                    placeholderText: "تاریخ تولد"
                                    text: updatePage.model.birthday
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
                                    checked: updatePage.model.enabled
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
                                    student["id"] = updatePage.model.id;
                                    student["name"] = nameTF.text
                                    student["lastname"] = lastnameTF.text
                                    student["fathername"] = fathernameTF.text
                                    student["gender"] = genderCB.currentText
                                    student["birthday"] = birthdayTF.text
                                    student["enabled"] = enabledSW.checked
                                    student["photo_path"] = photoPath.text


                                    if(dbMan.studentUpdate(student))
                                    {
                                        updatePage.popStackSignal();
                                        updatePage.updatedSignal();
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
        onAccepted:{
            userPhoto.source = selectedFile
            photoPath.text = selectedFile;
        }
        onRejected: photoBrows.close();
        }

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "ویرایش اطلاعات دانش‌آموز با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ویرایش اطلاعات دانش‌آموز با موفقیت انجام شد."
        dialogSuccess: true
        onDialogAccepted: {
            updatePage.popStackSignal();
            updatePage.updatedSignal();
        }

    }
}
