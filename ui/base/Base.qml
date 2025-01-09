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

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "مدیریت پایه‌های تحصیلی"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
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

                onActivated: {
                        stepCBoxModel.clear();
                        baseModel.clear();
                        var jsondata = dbMan.getBranchSteps(branchCB.currentValue);
                        //s.id, s.branch_id, s.step_name, s.field_based, s.numeric_graded, b.city, b.branch_name
                        var temp;
                        for(var obj of jsondata)
                        {
                            temp = obj.step_name;
                            stepCBoxModel.append({ value: obj.id, text: temp })
                        }
                }
            }
        }

        RowLayout{
            Layout.preferredHeight:  50
            Layout.preferredWidth: branchLbl.width + branchCB.width
            Layout.alignment: Qt.AlignHCenter

            Label
            {
                Layout.preferredHeight:  50
                Layout.preferredWidth: 100
                text:" انتخاب دوره"
                font.family: "B Yekan"
                font.pixelSize: 16
                font.bold: true
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
            }
            ComboBox
            {
                id: stepCB
                Layout.preferredHeight:  50
                Layout.fillWidth: true
                Layout.maximumWidth: 400
                editable: false
                font.family: "B Yekan"
                font.pixelSize: 16
                model: ListModel{id: stepCBoxModel}
                textRole: "text"
                valueRole: "value"
                Component.onCompleted:
                {
                    stepCB.currentIndex = -1
                }

                onActivated: Methods.basesUpdate(stepCB.currentValue)
            }
        }

        Rectangle
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"
            ColumnLayout
            {
                anchors.fill: parent

                Button
                {
                    Layout.preferredHeight:   64
                    Layout.preferredWidth: 64
                    Layout.alignment: Qt.AlignRight
                    background: Item{}
                    visible: (stepCB.currentIndex >=0)? true : false;
                    icon.source: "qrc:/assets/images/add.png"
                    icon.width: 64
                    icon.height: 64
                    icon.color:"transparent"
                    opacity: 0.5
                    onClicked:
                    {
                        var sid = stepCB.currentValue;
                        if(sid >= 0)
                        basesPage.appStackView.push(baseInsertComponent, {step_id: sid, branch: branchCB.currentText, step: stepCB.currentText });
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
                        base_model : model
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
            onBaseInsertedSignal: (bId)=> Methods.basesUpdate(bId);
            field_based: dbMan.isStepFieldBased(stepCB.currentValue)
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
