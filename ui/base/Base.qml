pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox;
import "./Base.js" as Methods

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
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        //branch
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
                font.pixelSize: 16
                font.bold: true
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
                color: "darkcyan"
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
                    Methods.branchCBUpdate();
                    branchCB.currentIndex = -1
                }

                onActivated: {
                    stepCBoxModel.clear();
                    baseModel.clear();
                    var jsondata = dbMan.getBranchSteps(branchCB.currentValue);
                    //s.id, s.branch_id, s.step_name, s.field_based, s.numeric_graded, b.city, b.branch_name
                    for(var obj of jsondata)
                    {
                        stepCBoxModel.append({ value: obj.id, text: obj.step_name, field_based: obj.field_based })
                    }

                    stepCB.currentIndex = -1;
                }
            }
        }
        //step
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
                font.pixelSize: 16
                font.bold: true
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
                color: "darkcyan"
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
                onActivated: {
                    var field_base = stepCBoxModel.get(stepCB.currentIndex)["field_based"];
                    if(field_base)
                    {
                        fieldBox.visible = true;
                        fieldModel.clear();
                        baseModel.clear();
                        let jsondata = dbMan.getFields(stepCB.currentValue);
                        //
                        for(var obj of jsondata)
                        {
                            fieldModel.append({ value: obj.id, text: obj.field_name })
                        }

                        fieldCB.currentIndex = -1;
                    }
                    else
                    {
                        fieldBox.visible = false;
                        Methods.basesUpdate(stepCB.currentValue)
                    }
                }
            }
        }
        // field
        RowLayout{
            id: fieldBox
            visible: false
            Layout.preferredHeight:  50
            Layout.preferredWidth: branchLbl.width + branchCB.width
            Layout.alignment: Qt.AlignHCenter

            Label
            {
                Layout.preferredHeight:  50
                Layout.preferredWidth: 100
                text: "انتخاب رشته"
                font.family: "Kalameh"
                font.pixelSize: 16
                font.bold: true
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
                color: "darkcyan"
            }
            ComboBox
            {
                id: fieldCB
                Layout.preferredHeight:  50
                Layout.fillWidth: true
                Layout.maximumWidth: 400
                editable: false
                font.family: "Kalameh"
                font.pixelSize: 16
                model: ListModel{id: fieldModel}
                textRole: "text"
                valueRole: "value"
                onActivated: Methods.basesUpdateByField(stepCB.currentValue, fieldCB.currentValue)
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


                GridView
                {
                    id: baseGV
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: 10
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    cellWidth: 420
                    cellHeight: 170
                    model: ListModel{id: baseModel}
                    highlight: Item{}
                    delegate: delegateComponent
                }
            }
        }
    }


    Component
    {
        id: baseInsertComponent
        BaseInsert{
            onPopSignal: basesPage.appStackView.pop();
            onInsertedSignal:{
                var field_base = stepCBoxModel.get(stepCB.currentIndex)["field_based"];
                if(field_base)
                    Methods.basesUpdateByField(stepCB.currentValue, fieldCB.currentValue)
                else
                    Methods.basesUpdate(stepCB.currentValue)
            }
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

    Component
    {
        id: delegateComponent
        Rectangle
        {
            id: baseDelegate
            required property int index
            required property var model; // base model
            property color bgColor : {
                if(!baseDelegate.model["enabled"])  return "lavenderblush";
                if(index % 2 == 0) return "snow"; else return "whitesmoke";
            }
            // b.id, b.step_id, b.field_id, b.base_name, b.enabled, s.step_name, s.field_based, s.numeric_graded, f.field_name
            width: 400
            height: 160
            border.width: 1
            border.color: "pink"
            color: baseDelegate.bgColor
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    baseLbl.color = "darkcyan"
                    baseLbl.font.pixelSize = 18
                    baseDelegate.color = "#55ffc0cb"
                }
                onExited:{
                    baseLbl.color = "black"
                    baseLbl.font.pixelSize = 16
                    baseDelegate.color = baseDelegate.bgColor
                }
            }


            ColumnLayout
            {

                anchors.fill: parent
                spacing: 0
                Label {
                    id: baseLbl
                    text:baseDelegate.model["base_name"];
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "black"
                    horizontalAlignment: Label.AlignHCenter
                    Layout.preferredWidth:  parent.width
                    Layout.preferredHeight:  50
                    elide: Text.ElideRight
                }
                Label {
                    text:{
                        var temp = baseDelegate.model["field_based"];
                        var text = baseDelegate.model["field_name"];
                        if(temp)
                        return text;
                        else{
                            temp = baseDelegate.model["step_name"];
                            return temp;
                        }
                    }
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    color: "black"
                    Layout.preferredWidth:  parent.width
                    Layout.preferredHeight:  50
                    horizontalAlignment: Label.AlignHCenter
                    elide: Text.ElideRight
                }

                Item{Layout.preferredWidth: 1; Layout.fillHeight: true;}

                RowLayout{
                    Layout.preferredWidth:  parent.width
                    Layout.preferredHeight:  50

                    Button
                    {
                        Layout.preferredWidth:  50
                        Layout.preferredHeight:  50
                        opacity: 0.5
                        background: Item{}
                        hoverEnabled: true
                        onHoveredChanged: opacity = (hovered)? 1 : 0.5
                        icon.source: "qrc:/assets/images/trash.png"
                        icon.width: 32
                        icon.height: 32
                        icon.color:"transparent"
                        onClicked: basesPage.appStackView.push(deleteBaseComponent, {
                                                                   base_id: baseDelegate.model.id,
                                                                   city: baseDelegate.model.city,
                                                                   branch_name: baseDelegate.model.branch_name,
                                                                   step_name: baseDelegate.model.step_name,
                                                                   field_name: baseDelegate.model.field_name,
                                                                   base_name: baseDelegate.model.base
                                                               });

                    }
                    Button
                    {
                        Layout.preferredWidth:  50
                        Layout.preferredHeight:  50
                        background:  Item{}
                        hoverEnabled: true
                        opacity: 0.5
                        onHoveredChanged: opacity = (hovered)? 1 : 0.5
                        icon.source: "qrc:/assets/images/edit.png"
                        icon.width: 32
                        icon.height: 32
                        icon.color:"transparent"
                        onClicked: basesPage.appStackView.push(updateBaseComponent, {
                                                                   base_id: baseDelegate.model.id,
                                                                   city: baseDelegate.model.city,
                                                                   branch_name: baseDelegate.model.branch_name,
                                                                   step_id: baseDelegate.model.step_id,
                                                                   step_name: baseDelegate.model.step_name,
                                                                   field_based: baseDelegate.model.field_based,
                                                                   field_name: baseDelegate.model.field_name,
                                                                   field_id: baseDelegate.model.field_id,
                                                                   base_name: baseDelegate.model.base_name,
                                                                   enabled: baseDelegate.model.enabled,
                                                                   sort_priority: baseDelegate.model.sort_priority
                                                               });
                    }
                    Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                }
            }
        }
    }

    Component
    {
        id: updateBaseComponent
        BaseUpdate{
            onPopSignal: basesPage.appStackView.pop();
            onUpdatedSignal:{
                var field_base = stepCBoxModel.get(stepCB.currentIndex)["field_based"];
                if(field_base)
                    Methods.basesUpdateByField(stepCB.currentValue, fieldCB.currentValue)
                else
                    Methods.basesUpdate(stepCB.currentValue)
            }
        }
    }
    Component
    {
        id: deleteBaseComponent
        BaseDelete{
            onPopSignal: basesPage.appStackView.pop();
            onBaseDeleted: {
                var field_base = stepCBoxModel.get(stepCB.currentIndex)["field_based"];
                if(field_base)
                    Methods.basesUpdateByField(stepCB.currentValue, fieldCB.currentValue)
                else
                    Methods.basesUpdate(stepCB.currentValue)
            }
        }
    }

}
