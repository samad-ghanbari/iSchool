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

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "مدیریت سال‌های تحصیلی"
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
                color: "darkcyan"
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

                onActivated: {
                    stepCBoxModel.clear();
                    periodsModel.clear();
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
                font.family: "Kalameh"
                color: "darkcyan"
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
                font.family: "Kalameh"
                font.pixelSize: 16
                model: ListModel{id: stepCBoxModel}
                textRole: "text"
                valueRole: "value"
                Component.onCompleted:
                {
                    stepCB.currentIndex = -1
                }

                onActivated: Methods.periodsUpdate(stepCB.currentValue)
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
                        periodsPage.appStackView.push(insertComponent, {step_id: sid, branch: branchCB.currentText, step: stepCB.currentText });
                        else
                        insertInfoDialogId.open();
                    }
                    hoverEnabled: true
                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                }


                GridView
                {
                    id: periodsGV
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: 10
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    cellWidth: 300
                    cellHeight: 300
                    model: ListModel{id: periodsModel} //Id BranchId periodName BranchName BranchDescription
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
            // p.id, p.step_id, p.period_name, p.passed, s.step_name, s.branch_id, br.city, br.branch_name, s.numeric_graded, s.field_based, p.sort_priority
            id: periodDelegate
            required property var model;
            required property int index

            property bool boxHovered : false

            signal periodDeleted(var index);

            clip: true
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.boxHovered = true;
                onExited: parent.boxHovered = false;
            }

            color: {
                if(periodDelegate.model["passed"])
                {
                    if(periodDelegate.boxHovered) return "lightpink"; else return "lavenderblush";
                }
                else
                {
                    if(periodDelegate.boxHovered) return "snow"; else return "whitesmoke";
                }
            }

            Column
            {
                id: periodDelegateCol
                anchors.fill: parent

                spacing: 0
                Label {
                    text: "سال‌تحصیلی " + periodDelegate.periodModel.period_name
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: (periodDelegate.highlighted)? 20 :16
                    font.bold: (periodDelegate.highlighted)? true : false
                    color: (periodDelegate.highlighted)? "royalblue":"black"
                    horizontalAlignment: Label.AlignHCenter
                    width: parent.width
                    height: 50
                    elide: Text.ElideRight
                }
                Label {
                    text: "شعبه " + periodDelegate.periodModel.city + " - " + periodDelegate.periodModel.branch_name
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    font.bold: (periodDelegate.highlighted)? true : false
                    color: (periodDelegate.highlighted)? "darkcyan": "black"
                    width: parent.width
                    height: 50
                    horizontalAlignment: Label.AlignHCenter
                    elide: Text.ElideRight
                }

                Label {
                    text:{
                        var temp = periodDelegate.periodModel.step_name ;
                        if(temp.includes("دوره"))
                        return temp;
                        else
                        return "دوره " + periodDelegate.periodModel.step_name
                    }
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    font.bold: (periodDelegate.highlighted)? true : false
                    color: (periodDelegate.highlighted)? "darkcyan": "black"
                    width: parent.width
                    height: 50
                    horizontalAlignment: Label.AlignHCenter
                    elide: Text.ElideRight
                }

                Rectangle{width: 400; height:5; color: (periodDelegate.highlighted)? "mediumvioletred" : "whitesmoke"; anchors.horizontalCenter: parent.horizontalCenter }



                Row{
                    width: 150
                    height: 150
                    anchors.left: parent.left

                    Button
                    {
                        height: 150
                        width: 75
                        background: Rectangle{id:trashBtnBg; color: "crimson"}
                        hoverEnabled: true
                        onHoveredChanged: trashBtnBg.color=(hovered)? Qt.darker("crimson", 1.1):"crimson"
                        text: "حذف"
                        font.bold: true
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        palette.buttonText:  "white"
                        icon.source: "qrc:/assets/images/trash.png"
                        icon.width: 32
                        icon.height: 32
                        icon.color:"transparent"
                        display: AbstractButton.TextUnderIcon
                        SwipeDelegate.onClicked:
                        {
                            if(periodDelegate.swipe.complete)
                            periodDelegate.swipe.close();
                            periodDelegate.appStackView.push(deletePeriodComponent, { periodIndex: periodDelegate.index, model: periodDelegate.periodModel});
                        }
                    }
                    Button
                    {
                        height: 150
                        width: 75
                        background:  Rectangle{id:editBtnBg; color: "royalblue"}
                        hoverEnabled: true
                        onHoveredChanged: editBtnBg.color=(hovered)? Qt.darker("royalblue", 1.1):"royalblue"
                        text: "ویرایش"
                        font.bold: true
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        palette.buttonText:  "white"
                        icon.source: "qrc:/assets/images/edit.png"
                        icon.width: 32
                        icon.height: 32
                        icon.color:"transparent"
                        display: AbstractButton.TextUnderIcon
                        SwipeDelegate.onClicked:
                        {
                            if(periodDelegate.swipe.complete)
                            periodDelegate.swipe.close();
                            periodDelegate.appStackView.push(updatePeriodComponent, {model: periodDelegate.periodModel });
                        }
                    }
                }

            }
        }
    }

    Component
    {
        id: insertComponent
        PeriodInsert{
            onPopSignal: periodsPage.appStackView.pop();
            onInsertedSignal: Methods.periodsUpdate(stepCB.currentValue)
        }
    }
    DialogBox.BaseDialog
    {
        id: insertInfoDialogId
        dialogTitle: "خطا"
        dialogText: "شعبه مورد نظر خود را انتخاب نمایید"
        dialogSuccess: false
    }

    Component
    {
        id: updateComponent
        PeriodUpdate{
            onPopSignal: periodsPage.appStackView.pop();
            onPeriodUpdatedSignal: Methods.periodsUpdate(stepCB.currentValue)
        }
    }
    Component
    {
        id: deleteComponent
        PeriodDelete{
            onPopSignal: periodsPage.appStackView.pop();
            onDeletedSignal: Methods.periodsUpdate(stepCB.currentValue)
        }
    }
}
