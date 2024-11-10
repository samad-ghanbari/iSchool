import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Step.js" as Methods

Page {
    id: insertStepPage

    property int branchId;
    property string branchText

    required property StackView appStackView
    signal stepInsertedSignal(var branchId);

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
            onClicked: insertStepPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن دوره"
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
                            id: stepInsertCL
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
                                id: stepInsertGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Text {
                                    Layout.columnSpan: 2
                                    text: "شعبه " + insertStepPage.branchText
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }


                                Text {
                                    text: "نام دوره"
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
                                    placeholderText: "نام دوره"

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
                                    var Step = {};
                                    Step["branch_id"] = insertStepPage.branchId
                                    Step["step_name"] = stepNameTF.text

                                    var check = true
                                    // check entries
                                    if(!Methods.checkStepEntries(Step))
                                    {
                                        stepInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.insertStep(Step))
                                    {
                                        insertStepPage.stepInsertedSignal(insertStepPage.branchId);
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
        dialogText: "افزودن دوره جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: stepSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "دوره جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){stepSuccessDialogId.close(); insertStepPage.appStackView.pop();}

    }
}
