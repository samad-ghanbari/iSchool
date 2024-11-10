import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
            text: "ویرایش دبیر شعبه"
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
                                source: "qrc:/assets/images/edit.png"
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
                                    text: "نام دبیر"
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
                                    placeholderText: "نام دبیر محترم"
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
                                    placeholderText: "نام خانوادگی دبیر"
                                    text: updatePage.model.lastname

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

                                //study degree
                                Text {
                                    text: "سطح تحصیلات"
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
                                    id: studyDegreeTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "سطح تحصیلات"
                                    text: updatePage.model.study_degree
                                }
                                //study degree
                                Text {
                                    text: "رشته تحصیلی"
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
                                    id: studyFieldTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "رشته تحصیلی"
                                    text: updatePage.model.study_field
                                }
                                //telephone
                                Text {
                                    text: "شماره تماس"
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
                                    id: telephoneTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "شماره تماس"
                                    text: updatePage.model.telephone
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
                                    var teacher = {};
                                    teacher["id"] = updatePage.model.id;
                                    teacher["name"] = nameTF.text
                                    teacher["lastname"] = lastnameTF.text
                                    teacher["gender"] = genderCB.currentText
                                    teacher["study_field"] = studyFieldTF.text
                                    teacher["study_degree"] = studyDegreeTF.text
                                    teacher["telephone"] = telephoneTF.text
                                    teacher["enabled"] = enabledSW.checked


                                    if(dbMan.teacherUpdate(teacher))
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

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "ویرایش اطلاعات دبیر با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ویرایش اطلاعات دیبر با موفقیت انجام شد."
        dialogSuccess: true
        onDialogAccepted: {
            updatePage.popStackSignal();
            updatePage.updatedSignal();
        }

    }
}
