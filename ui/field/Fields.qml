pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox;

Page {
    id: fieldsPage
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
            text: "مدیریت رشته‌های تحصیلی"
            font.family: "Kalameh"
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
                font.family: "Kalameh"
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
                    branchCBoxModel.clear();
                    var jsondata = dbMan.getBranches();
                    //id, city, branch_name, address
                    var temp;
                    for(var obj of jsondata)
                    {
                        temp = obj.city + " - "+ obj.branch_name;
                        branchCBoxModel.append({ value: obj.id, text: temp })
                    }
                    branchCB.currentIndex = -1
                }

                onActivated: {
                    stepCBoxModel.clear();
                    var jsondata = dbMan.getBranchSteps(branchCB.currentValue);
                    //s.id, s.branch_id, s.step_name, s.field_based, s.numeric_graded, b.city, b.branch_name
                    var temp;
                    for(var obj of jsondata)
                    {
                        temp = obj.step_name;
                        if(obj.field_based === true)
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

                onActivated:{
                    var jsondata = dbMan.getFields(stepCB.currentValue);
                    //// id, step_id, field_name,
                    fieldModel.clear();
                    for(var obj of jsondata){
                        fieldModel.append(obj);
                    }
                }
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
                            fieldsPage.appStackView.push(insertComponent);
                        else
                        infoDialogId.open();
                    }
                    hoverEnabled: true
                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                }


                GridView
                {
                    id: fieldsGV
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: 10
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    cellWidth: 320
                    cellHeight: 170
                    model: ListModel{id: fieldModel}
                    highlight: Item{}
                    delegate: Rectangle{
                        id: rec
                        required property var model;
                        property bool highlighted : (fieldsGV.currentIndex === rec.model.index)? true : false;
                        width: 300
                        height: 150
                        color: (fieldsGV.highlighted)? "snow" : "whitesmoke";
                        MouseArea{
                            anchors.fill: parent
                            onClicked: fieldsGV.currentIndex = rec.model.index
                        }
                        ColumnLayout
                        {
                            anchors.fill: parent
                            spacing: 0
                            Label {
                                text: "رشته " + rec.model.field_name
                                padding: 0
                                font.family: "Kalameh"
                                font.pixelSize: (rec.highlighted)? 20 :16
                                font.bold: (rec.highlighted)? true : false
                                color: (rec.highlighted)? "royalblue":"black"
                                horizontalAlignment: Label.AlignHCenter
                                Layout.preferredWidth: parent.width
                                Layout.preferredHeight:  50
                                Layout.alignment: Qt.AlignHCenter
                                elide: Text.ElideRight
                            }
                            Item{Layout.fillHeight: true; Layout.preferredWidth: 1;}
                            Row{
                                Layout.preferredHeight: 50
                                Layout.preferredWidth: 100
                                Layout.alignment: Qt.AlignHCenter
                                Button
                                {
                                    width: 50
                                    height: 50
                                    background: Item{}
                                    icon.source: "qrc:/assets/images/trash.png"
                                    icon.width: 32
                                    icon.height: 32
                                    icon.color:"transparent"
                                    opacity: 0.5
                                    onClicked: {
                                        fieldsPage.appStackView.push(deleteComponent, {
                                                                         id: rec.model.id,
                                                                         field_name: rec.model.field_name,
                                                                         sort_priority: rec.model.sort_priority,
                                                                         //enabled: rec.model.enabled
                                                                     });
                                    }
                                    hoverEnabled: true
                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                }
                                Button
                                {
                                    width: 50
                                    height: 50
                                    background: Item{}
                                    icon.source: "qrc:/assets/images/edit.png"
                                    icon.width: 32
                                    icon.height: 32
                                    icon.color:"transparent"
                                    opacity: 0.5
                                    onClicked: {

                                        fieldsPage.appStackView.push(updateComponent, {
                                                                         id: rec.model.id,
                                                                         field_name: rec.model.field_name,
                                                                         sort_priority: rec.model.sort_priority,
                                                                         enabled: rec.model.enabled
                                                                     });
                                    }
                                    hoverEnabled: true
                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                }
                            }

                            Rectangle{width: parent.width; height:4; color: (rec.highlighted)? "mediumvioletred" : "whitesmoke";}
                        }


                    }
                }
            }
        }
    }

    Component
    {
        id: insertComponent
        FieldInsert{

            appStackView : fieldsPage.appStackView
            onInsertedSignal: {
                var jsondata = dbMan.getFields(stepCB.currentValue);
                //// id, step_id, field_name,
                fieldModel.clear();
                for(var obj of jsondata){
                    fieldModel.append(obj);
                }
            }

            branch: branchCB.currentText
            step : stepCB.currentText
            step_id: stepCB.currentValue

        }
    }


    // update
    Component
    {
        id: updateComponent
        FieldUpdate{

            appStackView : fieldsPage.appStackView
            onUpdatedSignal: {
                var jsondata = dbMan.getFields(stepCB.currentValue);
                //// id, step_id, field_name,
                fieldModel.clear();
                for(var obj of jsondata){
                    fieldModel.append(obj);
                }
            }

            branch: branchCB.currentText
            step : stepCB.currentText

        }
    }

    // delete
    Component
    {
        id: deleteComponent
        FieldDelete{

            appStackView : fieldsPage.appStackView
            onDeletedSignal: {
                var jsondata = dbMan.getFields(stepCB.currentValue);
                //// id, step_id, field_name,
                fieldModel.clear();
                for(var obj of jsondata){
                    fieldModel.append(obj);
                }
            }

            branch: branchCB.currentText
            step : stepCB.currentText

        }
    }



    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "انجام عملیات با خطا مواجه شد."
        dialogSuccess: false
    }
}
