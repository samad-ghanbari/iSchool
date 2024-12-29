pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox;
import "Step.js" as Methods

Page {
    id: stepsPage
    required property StackView appStackView;

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
            icon.color:"transparent"
            opacity: 0.5
            onClicked: stepsPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "لیست دوره‌ها"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        RowLayout{
            Layout.columnSpan: 2
            Layout.preferredHeight:  50
            Layout.preferredWidth: branchLbl.width + branchCB.width
            Layout.alignment: Qt.AlignHCenter

            Label
            {
                id: branchLbl
                Layout.preferredHeight:  50
                Layout.preferredWidth: 100
                text:" انتخاب شعبه"
                font.family: "B Yekan"
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
                font.family: "B Yekan"
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
            Layout.columnSpan: 2
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
                        stepsPage.appStackView.push(stepInsertComponent, {branchId: bid, branchText: branchCB.currentText });
                        else
                        insertInfoDialogId.open();
                    }
                    hoverEnabled: true
                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                }


                ListView
                {
                    id: stepsLV
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: 10
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    spacing: 5
                    model: ListModel{id: stepsModel} //Id BranchId StepName BranchName BranchDescription
                    highlight: Item{}
                    delegate: StepWidget{
                        required property var model;
                        appStackView: stepsPage.appStackView
                        index: model.index;

                        width: stepsLV.width
                        onPressed: { stepsLV.currentIndex = model.index; stepsLV.closeSwipeHandler();}
                        highlighted: (model.index === stepsLV.currentIndex)? true: false;
                        onStepDeleted: (sindex)=>{stepsModel.remove(sindex);}

                        stepId: model.Id;
                        branchId: model.BranchId;
                        stepName: model.StepName;
                        branchCity: model.BranchCity;
                        branchName: model.BranchName;
                    }

                    function closeSwipeHandler()
                    {
                        for (var i = 0; i <= stepsLV.count; i++)
                        {
                            var item = stepsLV.contentItem.children[i];
                            if(item.swipe)
                            {
                                item.swipe.close();
                                item.checked = false;
                            }
                        }
                    }

                }
            }
        }
    }

    Component
    {
        id: stepInsertComponent
        StepInsert{
            appStackView: stepsPage.appStackView;
            onStepInsertedSignal: (bId)=> Methods.stepsUpdate(bId);
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
