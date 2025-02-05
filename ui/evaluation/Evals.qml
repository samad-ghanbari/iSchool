pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Evals.js" as Methods


Page {
    id: evalsPage

    required property StackView appStackView;
    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    property bool admin : dbMan.isUserAdmin();

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignLeft
            text: "مدیریت ارزیابی‌ها"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        Flickable{
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            contentHeight: centerBox.implicitHeight

            Column
            {
                id: centerBox
                width: parent.width

                // branch
                RowLayout
                {
                    width: 400
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"شعبه: "
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                        horizontalAlignment: Label.AlignRight
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: branchCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        editable: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: branchModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted:
                        {
                            Methods.updateBranchCB();
                            branchCB.currentIndex = -1
                        }

                        onActivated: Methods.updateStepCB(branchCB.currentValue)
                    }
                }

                // step
                RowLayout
                {
                    width: 400
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"دوره: "
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                        horizontalAlignment: Label.AlignRight
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: stepCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        editable: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: stepModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted: stepCB.currentIndex = -1

                        onActivated: {
                            var field_based = stepModel.get(stepCB.currentIndex)["field_based"];
                            fieldBox.visible = field_based;
                            if(field_based)
                            Methods.updateFieldCB(stepCB.currentValue)
                            else
                            Methods.updateBaseCB(stepCB.currentValue)
                        }
                    }
                }

                // field
                RowLayout
                {
                    id: fieldBox
                    width: 400
                    height: 50
                    visible: false
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"رشته: "
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                        horizontalAlignment: Label.AlignRight
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: fieldCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        editable: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: fieldModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted: stepCB.currentIndex = -1

                        onActivated: Methods.updateFieldBaseCB(fieldCB.currentValue)
                    }
                }

                // base
                RowLayout
                {
                    width: 400
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"پایه تحصیلی: "
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                        horizontalAlignment: Label.AlignRight
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: baseCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        editable: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: baseModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted:
                        {
                            baseCB.currentIndex = -1
                        }

                        onActivated: Methods.updatePeriodCB(stepCB.currentValue);
                    }
                }

                // period
                RowLayout
                {
                    width: 400
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"سال‌تحصیلی: "
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                        horizontalAlignment: Label.AlignRight
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: periodCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        editable: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: periodModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted: stepCB.currentIndex = -1

                        onActivated: Methods.updateEvals(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);
                    }
                }

                Item{height: 10; width: parent.width}

                Rectangle
                {
                    width: parent.width
                    height: 1
                    color: "darkgray"
                    anchors.topMargin: 10
                    anchors.bottomMargin: 10
                }

                Item{
                    width: parent.width
                    height: 64
                    Button
                    {
                        width: 64
                        height: 64
                        anchors.right: parent.right
                        visible: ( (periodCB.currentValue > -1) && (evalsPage.admin) )? true : false;
                        background: Item{}
                        icon.source: "qrc:/assets/images/add.png"
                        icon.width: 64
                        icon.height: 64
                        opacity: 0.5
                        onClicked: evalsPage.appStackView.push(insertComponent);
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        enabled: evalsPage.admin
                    }
                }

                GridView
                {
                    id: evalsGV
                    height: evalsGV.contentHeight
                    width: parent.width
                    anchors.margins: 20
                    flickableDirection: Flickable.AutoFlickDirection
                    cellWidth: 350  // 20 spacing
                    cellHeight: 220
                    clip: true
                    model: ListModel{id: evalsModel}
                    highlight: Item{}
                    delegate: Rectangle{
                        //e.id, e.eval_name, e.step_id, e.base_id, e.period_id, e.course_flag, e.test_flag, e.final_flag, e.max_grade, e.sort_priority

                        id: recdel;
                        required property var model;
                        width: 320
                        height: 200
                        border.width: 2
                        border.color: "darkcyan"
                        color: "slategray";
                        radius: 5
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: parent.color = "darkcyan";
                            onExited: parent.color = "slategray";
                        }
                        ColumnLayout{
                            width: parent.width
                            height: parent.height
                            anchors.margins: 5

                            Label{
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "Kalameh"
                                font.pixelSize: 20
                                font.bold: true
                                color: "white"
                                text: recdel.model.eval_name
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                            }

                            Item{Layout.fillHeight: true; Layout.preferredWidth: 1;}

                            Label{
                                Layout.fillWidth: true
                                Layout.preferredHeight: 20
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                font.bold: true
                                color: "lightgray"
                                text: "ارزیابی واحد درسی"
                                visible: recdel.model.course_flag
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                            }
                            Label{
                                Layout.fillWidth: true
                                Layout.preferredHeight: 20
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                font.bold: true
                                color: "lightgray"
                                text: "ارزیابی واحد تستی"
                                visible: recdel.model.test_flag
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                            }
                            Label{
                                Layout.fillWidth: true
                                Layout.preferredHeight:  20
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                font.bold: true
                                color: "lightgray"
                                text: "ارزیابی نهایی"
                                visible: recdel.model.final_flag
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                            }
                            Label{
                                Layout.fillWidth: true
                                Layout.preferredHeight:  20
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                font.bold: true
                                color: "lightgray"
                                text: "بیشترین نمره: " + recdel.model.max_grade
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                            }

                            Item{Layout.preferredHeight: 5; Layout.preferredWidth: 1;}
                            Row{
                                Layout.preferredHeight: 40
                                Layout.preferredWidth: 80
                                Layout.alignment: Qt.AlignRight
                                Button
                                {
                                    width: 40
                                    height: 40
                                    background: Item{}
                                    icon.source: "qrc:/assets/images/trash.png"
                                    icon.width: 32
                                    icon.height: 32
                                    icon.color:"transparent"
                                    opacity: 0.5
                                    onClicked: {

                                        evalsPage.appStackView.push(deleteComponent, {
                                                                        id: recdel.model.id,
                                                                        eval_name: recdel.model.eval_name,
                                                                        max_grade: recdel.model.max_grade,
                                                                        course_flag: recdel.model.course_flag,
                                                                        test_flag: recdel.model.test_flag,
                                                                        final_flag: recdel.model.final_flag
                                                                    });
                                    }
                                    hoverEnabled: true
                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                }
                                Button
                                {
                                    width: 40
                                    height: 40
                                    background: Item{}
                                    icon.source: "qrc:/assets/images/edit.png"
                                    icon.width: 32
                                    icon.height: 32
                                    icon.color:"transparent"
                                    opacity: 0.5
                                    onClicked: {
                                        evalsPage.appStackView.push(updateComponent, {
                                                                        id: recdel.model.id,
                                                                        eval_name: recdel.model.eval_name,
                                                                        max_grade: recdel.model.max_grade,
                                                                        course_flag: recdel.model.course_flag,
                                                                        test_flag: recdel.model.test_flag,
                                                                        final_flag: recdel.model.final_flag,
                                                                        sort_priority: recdel.model.sort_priority
                                                                    });
                                    }
                                    hoverEnabled: true
                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                }
                            }

                        }


                    }
                }
            }
        }

    }

    // insert
    Component
    {
        id: insertComponent
        EvalInsert{
            onPopStackSignal: evalsPage.appStackView.pop();
            onInsertedSignal: Methods.updateEvals(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);

            step_id: stepCB.currentValue
            base_id: baseCB.currentValue
            period_id: periodCB.currentValue

            branch: branchCB.currentText
            step: stepCB.currentText
            field_based: stepModel.get(stepCB.currentIndex)["field_based"];
            field: fieldCB.currentText
            base: (base_id > 0)? baseCB.currentText : "";
            period: periodCB.currentText
        }
    }

    // delete
    Component
    {
        id: deleteComponent
        EvalDelete{
            onPopStackSignal: evalsPage.appStackView.pop();
            onDeletedSignal: Methods.updateEvals(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);

            base_id: baseCB.currentValue

            branch: branchCB.currentText
            step: stepCB.currentText
            field_based: stepModel.get(stepCB.currentIndex)["field_based"];
            field: fieldCB.currentText
            base: (base_id > 0)? baseCB.currentText : "";
            period: periodCB.currentText
        }
    }

    //update
    Component
    {
        id: updateComponent
        EvalUpdate{
            onPopStackSignal: evalsPage.appStackView.pop();
            onUpdatedSignal: Methods.updateEvals(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);

            step_id: stepCB.currentValue
            base_id: baseCB.currentValue
            period_id: periodCB.currentValue

            branch: branchCB.currentText
            step: stepCB.currentText
            field_based: stepModel.get(stepCB.currentIndex)["field_based"];
            field: fieldCB.currentText
            base: (base_id > 0)? baseCB.currentText : "";
            period: periodCB.currentText
        }
    }
}
