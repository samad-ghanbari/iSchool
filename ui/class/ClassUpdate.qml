import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: updateClassPage

    required property int class_id;
    required property string class_name;
    required property string class_desc;
    required property int sort_priority;

    required property string branch
    required property string step

    required property string base
    required property string period
    required property bool field_based
    required property string field;



    signal classUpdatedSignal();
    signal popStackSignal();

    background: Rectangle{anchors.fill: parent; color: "honeydew"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ویرایش کلاس"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
        }

        Flickable{
            Layout.fillHeight: true
            Layout.fillWidth: true
            contentHeight: centerBox.implicitHeight

            Rectangle{
                width:  (parent.width < 700)? parent.width : 700
                height: centerBox.implicitHeight
                anchors.horizontalCenter: parent.horizontalCenter
                color:"ghostwhite"

                Column{
                    id: centerBox
                    width: parent.width
                    anchors.margins: 10

                    Image {
                        source: "qrc:/assets/images/edit.png"
                        height:  64
                        width:  64
                        anchors.margins: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }

                    Text {
                        text: "شعبه " + updateClassPage.branch +" - " + updateClassPage.step
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
                            var base = updateClassPage.base
                            if(!base.includes("پایه")) base = "پایه " + base;

                            if(updateClassPage.field_based){

                                return "رشته " + updateClassPage.field + " - " +  base
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
                        text: "سال تحصیلی " + updateClassPage.period
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
                            width: 150
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        TextField
                        {
                            id: classNameTF
                            text: updateClassPage.class_name
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "نام کلاس"

                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "توضیحات کلاس"
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        TextField
                        {
                            id: classDescTF
                            text: updateClassPage.class_desc
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "موقعیت کلاس"
                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "اولویت نمایش"
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        SpinBox
                        {
                            id: classSortSB
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            value: updateClassPage.sort_priority
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1}
                    }


                    Item
                    {
                        width: parent.width
                        height: 50
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
                            var classObj = {};
                            classObj["id"] = updateClassPage.class_id;
                            classObj["class_name"] = classNameTF.text;
                            classObj["class_desc"] = classDescTF.text;
                            classObj["sort_priority"] = classSortSB.value;


                            if(dbMan.classUpdate(classObj))
                            {
                                classSuccessDialogId.open();
                            }
                            else
                            {
                                var errorString = dbMan.getLastError();
                                classInfoDialogId.dialogText = errorString
                                classInfoDialogId.width = parent.width
                                classInfoDialogId.height = 500
                                classInfoDialogId.dialogSuccess = false

                                classInfoDialogId.open();
                            }
                        }
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
        id: classInfoDialogId
        dialogTitle: "خطا"
        dialogText: "ویرایش اطلاعات کلاس با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: classSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ویرایش اطلاعات کلاس با موفقیت صورت گرفت."
        dialogSuccess: true
        onDialogAccepted: {
            updateClassPage.popStackSignal();
            updateClassPage.classUpdatedSignal();

        }

    }
}
