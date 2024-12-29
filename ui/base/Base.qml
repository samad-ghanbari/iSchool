pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox;
import "Base.js" as Methods

Page {
    id: basesPage
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
            onClicked: basesPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "لیست پایه‌های تحصیلی"
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
                    Methods.branchCBUpdate();
                    branchCB.currentIndex = -1
                }

                onActivated: Methods.studyBasesUpdate(branchCB.currentValue)
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
                        basesPage.appStackView.push(baseInsertComponent, {branchId: bid, branchText: branchCB.currentText });
                        else
                        insertInfoDialogId.open();
                    }
                    hoverEnabled: true
                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                }


                ListView
                {
                    id: basesLV
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: 10
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    spacing: 5
                    model: ListModel{id: baseModel}
                    highlight: Item{}
                    delegate: BaseWidget{
                        required property var model;
                        appStackView: basesPage.appStackView
                        index: model.index;

                        width: basesLV.width
                        onPressed: { basesLV.currentIndex = model.index; basesLV.closeSwipeHandler();}
                        highlighted: (model.index === basesLV.currentIndex)? true: false;
                        onBaseDeleted: (sindex)=>{baseModel.remove(sindex);}

                        baseId: model.Id;
                        branchId: model.BranchId;
                        studyBase: model.StudyBase;
                        branchName: model.Branch;
                    }

                    function closeSwipeHandler()
                    {
                        for (var i = 0; i <= basesLV.count; i++)
                        {
                            var item = basesLV.contentItem.children[i];
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
        id: baseInsertComponent
        BaseInsert{
            appStackView: basesPage.appStackView;
            onBaseInsertedSignal: (bId)=> Methods.studyBasesUpdate(bId);
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
