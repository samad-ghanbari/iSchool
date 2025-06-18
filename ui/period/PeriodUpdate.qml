pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts

import "./../public" as DialogBox
import "Period.js" as Methods

Page {
    id: updatePage
    required property int period_id
    required property int step_id
    required property string step_name
    required property string period_name
    required property string city
    required property string branch_name
    required property bool passed
    required property int sort_priority

    signal popSignal();
    signal updatedSignal();

    background: Rectangle{anchors.fill: parent; color: "honeydew"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ویرایش سال تحصیلی"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
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
                    implicitHeight: periodUpdateCL.height + 100

                    radius: 10
                    Item{
                        anchors.fill: parent
                        anchors.margins: 10
                        ColumnLayout
                        {
                            id: periodUpdateCL
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
                                id: periodUpdateGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width


                                Text {
                                    text: "شعبه"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "darkcyan"
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 400
                                    Layout.preferredHeight: 50
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    text: updatePage.city + " - " + updatePage.branch_name
                                }

                                Text {
                                    text: "دوره"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "darkcyan"
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 400
                                    Layout.preferredHeight: 50
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    text: updatePage.step_name

                                }

                                Text {
                                    text: "سال تحصیلی"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "darkcyan"
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
                                    text: updatePage.period_name
                                }

                                Switch{
                                    id: enabledSW
                                    Layout.columnSpan: 2
                                    Layout.preferredHeight:  50
                                    text: "اتمام سال تحصیلی"
                                    checked: updatePage.passed
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    palette.text: "black"
                                    palette.highlight: "darkcyan"
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
                                    color: "darkcyan"
                                }
                                SpinBox
                                {
                                    id: sortSB
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    Layout.maximumWidth: 400
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    value:  updatePage.sort_priority;
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
                                    period["id"] = updatePage.period_id;
                                    period["period_name"] = periodTF.text;
                                    period["passed"] = enabledSW.checked;
                                    period["sort_priority"] = sortSB.value

                                    var check = true
                                    // check entries
                                    if(!Methods.checkPeriodUpdateEntries(period))
                                    {
                                        periodInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.periodUpdate(period))
                                    {
                                        updatePage.updatedSignal();
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

        DialogBox.BaseDialog
        {
            id: periodInfoDialogId
            dialogTitle: "خطا"
            dialogText: "ورود فیلد الزامی می‌باشد"
            dialogSuccess: false
        }

        DialogBox.BaseDialog
        {
            id: periodSuccessDialogId
            dialogTitle: "عملیات موفق"
            dialogText: "اطلاعات سال تحصیلی با موفقیت بروزرسانی شد"
            dialogSuccess: true
            onDialogAccepted: function(){periodSuccessDialogId.close(); updatePage.popSignal();}
        }
    }
}
