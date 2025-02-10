pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Step.js" as Methods

Page {
    id: updatePage
    required property int stepId
    required property string branch
    required property string step
    required property bool field_based
    required property bool numeric_graded

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
            text: "ویرایش دوره"
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
                    implicitHeight: stepUpdateCL.height

                    radius: 10
                    Item{
                        anchors.fill: parent
                        anchors.margins: 10
                        ColumnLayout
                        {
                            id: stepUpdateCL
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
                                id: stepUpdateGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width


                                Text {
                                    text: "شعبه"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "darkcyan"
                                }
                                Text
                                {
                                    id: branchTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text: updatePage.branch

                                }

                                Text {
                                    text: "نام دوره "
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "darkcyan"
                                }
                                TextField
                                {
                                    id: stepNameTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    placeholderText: "دوره"
                                    text: updatePage.step
                                }

                                Switch{
                                    id: numericGradedSW
                                    Layout.columnSpan: 2
                                    Layout.preferredHeight:  50
                                    text: "ارزیابی مبتنی بر عدد"
                                    checked: updatePage.numeric_graded
                                    Layout.alignment: Qt.AlignHCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    palette.highlight: "darkcyan"
                                    palette.text: "black"
                                }

                                Switch{
                                    id: fieldsBasedSW
                                    Layout.preferredHeight:  50
                                    Layout.columnSpan: 2
                                    text: "دوره مبتنی بر رشته"
                                    checked: updatePage.field_based
                                    Layout.alignment: Qt.AlignHCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    palette.highlight: "darkcyan"
                                    palette.text: "black"
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
                                    var step = {};
                                    step["id"] = updatePage.stepId;
                                    step["step_name"] = stepNameTF.text;
                                    step["field_based"] = fieldsBasedSW.checked;
                                    step["numeric_graded"] = numericGradedSW.checked;

                                    var check = true
                                    // check entries
                                    if(!Methods.checkStepUpdateEntries(step))
                                    {
                                        stepInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.updateStep(step))
                                    {

                                        updatePage.updatedSignal();
                                        stepSuccessDialogId.open();

                                    }
                                    else
                                    {
                                        var errorString = dbMan.getLastError();
                                        stepInfoDialogId.dialogTitle = "خطا"
                                        stepInfoDialogId.dialogText = errorString
                                        stepInfoDialogId.width = parent.width
                                        stepInfoDialogId.height = 500
                                        stepInfoDialogId.dialogSuccess = false
                                        stepInfoDialogId.open();
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
        id: stepInfoDialogId
        dialogTitle: "خطا"
        dialogText: "ورود فیلد الزامی می‌باشد"
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: stepSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "اطلاعات دوره با موفقیت بروزرسانی شد"
        dialogSuccess: true
        onDialogAccepted: function(){stepSuccessDialogId.close(); updatePage.popSignal();}
    }
}
