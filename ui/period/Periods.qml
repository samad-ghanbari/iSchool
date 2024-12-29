pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox;
import "Period.js" as Methods

Page {
    id: periodsPage
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
            onClicked: periodsPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "لیست سال‌های تحصیلی"
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

                onActivated: Methods.periodsUpdate(branchCB.currentValue)

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
                        periodsPage.appStackView.push(periodInsertComponent, {branchId: bid, branchText: branchCB.currentText });
                        else
                        insertInfoDialogId.open();
                    }
                    hoverEnabled: true
                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                }


                ListView
                {
                    id: periodsLV
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: 10
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    spacing: 5
                    model: ListModel{id: periodsModel} //Id BranchId periodName BranchName BranchDescription
                    highlight: Item{}
                    delegate: PeriodWidget{
                        required property var model;
                        appStackView: periodsPage.appStackView
                        index: model.index;

                        width: periodsLV.width
                        onPressed: { periodsLV.currentIndex = model.index; periodsLV.closeSwipeHandler();}
                        highlighted: (model.index === periodsLV.currentIndex)? true: false;
                        onPeriodDeleted: (pindex)=>{periodsModel.remove(pindex);}

                        periodId: model.Id;
                        branchId: model.BranchId;
                        studyPeriod: model.StudyPeriod;
                        passed: model.Passed
                        city: model.City;
                        branchName: model.BranchName;
                    }

                    function closeSwipeHandler()
                    {
                        for (var i = 0; i <= periodsLV.count; i++)
                        {
                            var item = periodsLV.contentItem.children[i];
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
        id: periodInsertComponent
        PeriodInsert{
            appStackView: periodsPage.appStackView;
            onPeriodInsertedSignal: (bId)=> Methods.periodsUpdate(bId);
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
