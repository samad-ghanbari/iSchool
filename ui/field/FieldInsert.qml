import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public"

Page {
    id: insertPage

    required property int step_id;
    required property string branch
    required property string step

    required property StackView appStackView
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
            text: "افزودن رشته تحصیلی"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Image {
            source: "qrc:/assets/images/add.png"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight:  64
            Layout.preferredWidth:  64
            Layout.margins: 20
            NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
        }

        Flickable{
            Layout.fillHeight: true
            Layout.fillWidth: true
            contentHeight: centerBox.implicitHeight

            Rectangle
            {
                color:"snow"
                width:  (parent.width < 700)? parent.width : 700
                height: centerBox.implicitHeight + 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 10
                radius: 10
                Column
                {
                    id: centerBox
                    width: parent.width
                    anchors.margins: 10


                    GridLayout
                    {
                        id: baseInsertGL
                        columns: 2
                        rowSpacing: 1
                        width:  parent.width
                        height: 250

                        Text {
                            Layout.columnSpan: 2
                            text: "شعبه " + insertPage.branch + " - " +  insertPage.step
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Kalameh"
                            font.pixelSize: 18
                            font.bold: true
                            color: "royalblue"
                        }

                        Text {
                            text: "نام رشته تحصیلی"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment:  Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        TextField
                        {
                            id: fieldTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "نام رشته تحصیلی"

                        }


                        Switch{
                            id: enabledSW
                            Layout.columnSpan: 2
                            Layout.preferredHeight:  50
                            text: "فعال بودن رشته تحصیلی"
                            checked: true
                            Layout.alignment: Qt.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }

                        Text {
                            text: "اولویت نمایش"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        SpinBox
                        {
                            id: sortSB
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            Layout.maximumWidth: 150
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            value:  dbMan.getFieldSortPriority(insertPage.step_id) + 1;
                        }
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
                            var Field = {};
                            Field["step_id"] = insertPage.step_id
                            Field["field_name"] = fieldTF.text
                            Field["enabled"] = enabledSW.checked
                            Field["sort_priority"] = sortSB.value

                            var check = true
                            // check entries
                            if((insertPage.step_id < 1) || (fieldTF.text === "") )
                            {
                                infoDialogId.open();
                                return;
                            }

                            if(dbMan.insertField(Field))
                            {
                                insertPage.insertedSignal();
                                successDialogId.open();
                            }
                            else
                            {
                                var errorString = dbMan.getLastError();
                                infoDialogId.dialogTitle = "خطا"
                                infoDialogId.dialogText = errorString
                                infoDialogId.width = parent.width
                                infoDialogId.height = 500
                                infoDialogId.dialogSuccess = false
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

    BaseDialog
    {
        id: baseInfoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن رشته جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "رشته جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){successDialogId.close(); insertPage.appStackView.pop();}

    }
}
