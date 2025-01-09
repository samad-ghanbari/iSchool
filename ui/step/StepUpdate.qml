pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Step.js" as Methods

Page {
    id: updateStepPage
    required property int stepId
    required property string branch
    required property string step
    required property bool field_based
    required property bool numeric_graded

    required property StackView appStackView;
    signal stepUpdatedSignal(var step);

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
            font.family: "B Yekan"
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
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    id: branchTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: updateStepPage.branch

                                }

                                Text {
                                    text: "نام دوره "
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                TextField
                                {
                                    id: stepNameTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "دوره"
                                    text: updateStepPage.step
                                }

                                Switch{
                                    id: numericGradedSW
                                    Layout.columnSpan: 2
                                    Layout.preferredHeight:  50
                                    text: "ارزیابی مبتنی بر عدد"
                                    checked: updateStepPage.numeric_graded
                                    Layout.alignment: Qt.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                }

                                Switch{
                                    id: fieldsBasedSW
                                    Layout.preferredHeight:  50
                                    Layout.columnSpan: 2
                                    text: "دوره مبتنی بر رشته"
                                    checked: updateStepPage.field_based
                                    Layout.alignment: Qt.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
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
                                    var step = {};
                                    step["id"] = updateStepPage.stepId;
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
                                        step = dbMan.getStepJson(step["id"]);
                                        updateStepPage.stepUpdatedSignal(step);
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
        onDialogAccepted: function(){stepSuccessDialogId.close(); updateStepPage.appStackView.pop();}
    }
}
