pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts

import "./../public" as DialogBox;
import "Step.js" as Methods

Page {
    id: stepsPage
    required property StackView appStackView;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent


        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "مدیریت دوره‌ها"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        RowLayout{
            Layout.preferredHeight:  50
            Layout.preferredWidth: branchLbl.width + branchCB.width
            Layout.alignment: Qt.AlignHCenter

            Label
            {
                id: branchLbl
                Layout.preferredHeight:  50
                Layout.preferredWidth: 100
                text:" انتخاب شعبه"
                font.family: "Kalameh"
                color:"darkcyan"
                font.pixelSize: 16
                font.bold: true
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
            }
            ComboBox
            {
                id: branchCB
                Layout.preferredHeight:  50
                Layout.fillWidth: true
                Layout.maximumWidth: 400
                editable: false
                font.family: "Kalameh"
                font.pixelSize: 16
                model: ListModel{id: branchCBoxModel}
                textRole: "text"
                valueRole: "value"
                Component.onCompleted:
                {
                    Methods.updateBranchCB();
                    branchCB.currentIndex = -1
                }

                onActivated: Methods.stepsUpdate(branchCB.currentValue)

            }
        }

        Rectangle
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "ghostwhite"
            ColumnLayout
            {
                anchors.fill: parent

                Button
                {
                    Layout.preferredHeight:   64
                    Layout.preferredWidth: 64
                    Layout.alignment: Qt.AlignRight
                    background: Item{}
                    visible: (branchCB.currentIndex >=0)? true : false;
                    icon.source: "qrc:/assets/images/add.png"
                    icon.width: 64
                    icon.height: 64
                    icon.color:"transparent"
                    opacity: 0.5
                    onClicked:
                    {
                        var bid = branchCB.currentValue;
                        if(bid >= 0)
                        stepsPage.appStackView.push(insertComponent, {branchId: bid, branchText: branchCB.currentText });
                        else
                        insertInfoDialogId.open();
                    }
                    hoverEnabled: true
                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                }


                GridView
                {
                    id: stepsGV
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: 10
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    cellWidth: 320
                    cellHeight: 320
                    model: ListModel{id: stepsModel} //Id BranchId StepName BranchName BranchDescription
                    highlight: Item{}
                    delegate: delegateComponent
                }
            }
        }
    }

    Component
    {
        id: delegateComponent
        Rectangle
        {
            //s.id, s.branch_id, s.step_name, b.city, b.branch_name
            id: stepDelegate
            required property var model;
            required property int index
            //property bool boxHovered : false;

            width: 300
            height: 300

            color:  "snow"
            border.width: 1
            border.color: "hotpink"


            ColumnLayout
            {
                anchors.fill: parent

                spacing: 0
                Label {
                    text: stepDelegate.model["step_name"]
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    font.bold: true
                    color: "darkcyan"
                    horizontalAlignment: Label.AlignHCenter
                    Layout.preferredWidth:  parent.width
                    Layout.preferredHeight:  50
                    elide: Text.ElideRight
                }
                Label {
                    text: stepDelegate.model["branch_city"] + " - " + stepDelegate.model["branch_name"]
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    font.bold: false
                    color: "darkcyan"
                    Layout.preferredWidth:  parent.width
                    Layout.preferredHeight:  50
                    horizontalAlignment: Label.AlignHCenter
                    elide: Text.ElideRight
                }

                Switch{
                    id: numericGradedSW
                    Layout.preferredWidth:  parent.width
                    Layout.preferredHeight:  50
                    text: "ارزیابی مبتنی بر عدد"
                    checked: stepDelegate.model["numeric_graded"]
                    onClicked: numericGradedSW.checked = stepDelegate.model["numeric_graded"]
                    checkable: false
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    palette.highlight: "darkcyan"
                    palette.text: "black"
                }

                Switch{
                    id: fielsbasedSW
                    Layout.preferredWidth:  parent.width
                    Layout.preferredHeight:  50
                    text: "دوره مبتنی بر رشته"
                    checked: stepDelegate.model["field_based"]
                    onClicked: fielsbasedSW.checked = stepDelegate.model["field_based"]
                    checkable: false
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    palette.highlight: "darkcyan"
                    palette.text: "black"

                }

                Rectangle{Layout.preferredWidth:  parent.width/2; Layout.preferredHeight: 2; color:  "darkslategray"; Layout.alignment: Qt.AlignHCenter; }



                RowLayout{
                    Layout.preferredWidth:  100
                    Layout.preferredHeight:  50


                    Button
                    {
                        Layout.preferredWidth:  50
                        Layout.preferredHeight:  50
                        background: Item{}
                        hoverEnabled: true
                        opacity : 0.5
                        onHoveredChanged: opacity =(hovered)?1:0.5
                        icon.source: "qrc:/assets/images/trash.png"
                        icon.width: 32
                        icon.height: 32
                        icon.color:"transparent"
                        onClicked:
                        {
                            var branchText =  stepDelegate.model["branch_city"] + " - " + stepDelegate.model["branch_name"];
                            stepsPage.appStackView.push(deleteComponent, {
                                                               stepId: stepDelegate.model["id"],
                                                               stepIndex: stepDelegate.index,
                                                               stepName: stepDelegate.model["step_name"],
                                                               branchText: branchText,
                                                               numeric_graded: stepDelegate.model.numeric_graded,
                                                               field_based: stepDelegate.model.field_based

                                                           });
                        }
                    }
                    Button
                    {
                        Layout.preferredWidth:  50
                        Layout.preferredHeight:  50
                        background:  Item{}
                        hoverEnabled: true
                        opacity : 0.5
                        onHoveredChanged:opacity=(hovered)? 1:0.5
                        icon.source: "qrc:/assets/images/edit.png"
                        icon.width: 32
                        icon.height: 32
                        icon.color:"transparent"
                        onClicked:
                        {
                            var branchText =  stepDelegate.model["branch_city"] + " - " + stepDelegate.model["branch_name"];
                            stepsPage.appStackView.push(updateComponent, {
                                                               stepId: stepDelegate.model["id"],
                                                               step: stepDelegate.model["step"],
                                                               branch: branchText,
                                                               numeric_graded: stepDelegate.model["numeric_graded"],
                                                               field_based: stepDelegate.model["field_based"]

                                                           });
                        }
                    }

                    Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                }
            }
        }
    }

    Component
    {
        id: insertComponent
        StepInsert{
            onPopSignal: stepsPage.appStackView.pop();
            onInsertedSignal: Methods.stepsUpdate(branchCB.currentValue)
        }
    }

    Component
    {
        id: updateComponent
        StepUpdate{
            onPopSignal: stepsPage.appStackView.pop();
            onUpdatedSignal: Methods.stepsUpdate(branchCB.currentValue)
        }
    }

    Component
    {
        id: deleteComponent
        StepDelete{
            onPopSignal: stepsPage.appStackView.pop();
            onDeletedSignal: Methods.stepsUpdate(branchCB.currentValue)
        }
    }

    DialogBox.BaseDialog
    {
        id: insertInfoDialogId
        dialogTitle: "خطا"
        dialogText: "شعبه مورد نظر خود را انتخاب نمایید"
        dialogSuccess: false
    }
}
