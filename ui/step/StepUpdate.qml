pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Step.js" as Methods

Page {
    id: updateStepPage
    property int stepId
    property string branch
    property string step
    required property StackView appStackView;
    signal stepUpdatedSignal(var step);

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
            onClicked: updateStepPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
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
