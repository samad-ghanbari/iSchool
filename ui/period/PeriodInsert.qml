import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Period.js" as Methods

Page {
    id: insertPeriodPage

    property int step_id;
    property string branch
    property string step


    required property StackView appStackView
    signal periodInsertedSignal(var step_id);

    background: Rectangle{anchors.fill: parent; color: "honeydew"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن سال تحصیلی"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Rectangle
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"

            ScrollView
            {
                height: parent.height
                width: parent.width
                contentHeight: centerBoxId.height + 100

                Rectangle
                {
                    id: centerBoxId
                    color:"snow"
                    width:  (parent.width < 700)? parent.width : 700
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: periodInsertCL.height

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            id: periodInsertCL
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
                                id: periodInsertGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Text {
                                    Layout.columnSpan: 2
                                    text:{

                                        var temp = insertPeriodPage.step
                                        if(temp.includes("دوره"))
                                            return "شعبه " + insertPeriodPage.branch + " - " + insertPeriodPage.step
                                        else
                                            return "شعبه " + insertPeriodPage.branch + " - "+ "دوره " + insertPeriodPage.step
                                    }
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 400
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }


                                Text {
                                    text: "سال تحصیلی"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                TextField
                                {
                                    id: periodTF
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 400
                                    Layout.preferredHeight: 50
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    placeholderText: "سال تحصیلی"

                                }

                                Switch{
                                    id: enabledSW
                                    Layout.columnSpan: 2
                                    Layout.preferredHeight:  50
                                    text: "اتمام سال تحصیلی"
                                    checked: false
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                }

                                Text {
                                    text: "اولویت نمایش"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
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
                                    Layout.maximumWidth: 400
                                    Layout.preferredHeight: 50
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    value:  1;
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
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                                onClicked:
                                {
                                    var period = {};
                                    period["step_id"] = insertPeriodPage.step_id
                                    period["period_name"] = periodTF.text
                                    period["passed"] = enabledSW.checked
                                    period["sort_priority"] = sortSB.value


                                    var check = true
                                    // check entries
                                    if(!Methods.checkPeriodInsertEntries(period))
                                    {
                                        periodInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.periodInsert(period))
                                    {
                                        insertPeriodPage.periodInsertedSignal(insertPeriodPage.step_id);
                                        periodSuccessDialogId.open();

                                    }
                                    else
                                    {
                                        var errorString = dbMan.getLastError();
                                        periodInfoDialogId.dialogTitle = "خطا"
                                        periodInfoDialogId.dialogText = errorString
                                        periodInfoDialogId.width = parent.width
                                        periodInfoDialogId.height = 500
                                        periodInfoDialogId.dialogSuccess = false
                                        periodInfoDialogId.open();
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
        id: periodInfoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن سال تحصیلی با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: periodSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "سال تحصیلی جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){periodSuccessDialogId.close(); insertPeriodPage.appStackView.pop();}

    }
}
