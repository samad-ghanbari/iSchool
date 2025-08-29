pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Fusion
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
            width : 280
            height: 280
            border.width: 1
            border.color: "pink"
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
                    if(periodDelegate.boxHovered) return "#fff0f5"; else return "#AAfff0f5";
                }
                else
                {
                    if(periodDelegate.boxHovered) return "snow"; else return "whitesmoke";
                }
            }

            ColumnLayout
            {
                anchors.fill: parent

                spacing: 0
                Row{
                    Layout.preferredHeight:  50
                    Layout.alignment: Qt.AlignHCenter

                Label {
                    text: "سال‌تحصیلی "
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    font.bold: true
                    color: (periodDelegate.boxHovered)? "darkcyan":"black"
                    horizontalAlignment: Label.AlignHCenter
                    height: 50
                    elide: Text.ElideRight
                }
                    Label {
                        text: periodDelegate.model["period_name"]
                        padding: 0
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: (periodDelegate.boxHovered)? "darkcyan":"black"
                        horizontalAlignment: Label.AlignHCenter
                        height: 50
                        elide: Text.ElideRight
                    }
                }
                Label {
                    text: periodDelegate.model['city'] + " - " + periodDelegate.model['branch_name']
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    font.bold: true
                    color: (periodDelegate.boxHovered)? "dodgerblue": "darkslategray"
                    Layout.fillWidth: true
                    Layout.preferredHeight:  50
                    horizontalAlignment: Label.AlignHCenter
                    elide: Text.ElideRight
                }

                Label {
                    text:periodDelegate.model['step_name']
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    font.bold: true
                    color: (periodDelegate.boxHovered)? "darkcyan": "darkslategray"
                    Layout.fillWidth: true
                    Layout.preferredHeight:  50
                    horizontalAlignment: Label.AlignHCenter
                    elide: Text.ElideRight
                }

                Label {
                    text: "نیمسال تابستان"
                    visible: periodDelegate.model['summer']
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 12
                    font.bold: true
                    color: "mediumvioletred"
                    Layout.fillWidth: true
                    Layout.preferredHeight:  40
                    horizontalAlignment: Label.AlignHCenter
                    elide: Text.ElideRight
                }

                Rectangle{Layout.preferredWidth: parent.width/2; Layout.preferredHeight: 4; color: (periodDelegate.boxHovered)? "darkcyan" : "darkgray"; Layout.alignment: Qt.AlignHCenter; }

                Item{Layout.fillHeight: true; Layout.preferredWidth: 1;}

               Row{
                    Layout.preferredWidth:100
                    Layout.preferredHeight:  50
                    Layout.alignment: Qt.AlignRight

                    Button
                    {
                        height: 50
                        width: 50
                        background: Item{}
                        opacity: 0.5
                        hoverEnabled: true
                        onHoveredChanged: opacity = (hovered)? 1 : 0.5
                        icon.source: "qrc:/assets/images/trash.png"
                        icon.width: 32
                        icon.height: 32
                        icon.color:"transparent"
                        onClicked:
                        {
                            periodsPage.appStackView.push(deleteComponent, {
                                                              period_id: periodDelegate.model['period_id'],
                                                              step_id: periodDelegate.model['step_id'],
                                                              step_name: periodDelegate.model['step_name'],
                                                              period_name: periodDelegate.model['period_name'],
                                                              city: periodDelegate.model['city'],
                                                              branch_name: periodDelegate.model['branch_name'],
                                                              passed: periodDelegate.model['passed']                                                          });
                        }
                    }
                    Button
                    {
                        height: 50
                        width: 50
                        background: Item{}
                        hoverEnabled: true
                        opacity : 0.5
                        onHoveredChanged: opacity  = (hovered)? 1 : 0.5;
                        icon.source: "qrc:/assets/images/edit.png"
                        icon.width: 32
                        icon.height: 32
                        icon.color:"transparent"
                        onClicked: periodsPage.appStackView.push(updateComponent, {
                                                                     period_id: periodDelegate.model['period_id'],
                                                                     step_id: periodDelegate.model['step_id'],
                                                                     step_name: periodDelegate.model['step_name'],
                                                                     period_name: periodDelegate.model['period_name'],
                                                                     city: periodDelegate.model['city'],
                                                                     branch_name: periodDelegate.model['branch_name'],
                                                                     passed: periodDelegate.model['passed'],
                                                                     summer: periodDelegate.model['summer'],
                                                                     sort_priority: periodDelegate.model['sort_priority']

                                                                 });

                    }
                }

            }
            Rectangle{width: parent.width/2; height: 2; color:  "deeppink" ;visible:(periodDelegate.boxHovered)? true: false; anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter; }
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
            onUpdatedSignal: Methods.periodsUpdate(stepCB.currentValue)
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
