pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import "./Step.js" as Methods

SwipeDelegate
{
    //s.id, s.branch_id, s.step_name, b.city, b.branch_name
    id: stepDelegate
    required property StackView appStackView
    required property int index

    property int stepId
    property int branchId
    property string stepName
    property string branchCity
    property string branchName
    required property bool numeric_graded
    required property bool field_based


    signal stepDeleted(var index);

    height: 210
    checkable: true
    checked: stepDelegate.swipe.complete
    onCheckedChanged: { if(!stepDelegate.checked) stepDelegate.swipe.close();}
    clip: true

    background: Rectangle{color: (stepDelegate.highlighted)? "snow" : "whitesmoke";}

    contentItem: Rectangle
    {
        color: (stepDelegate.highlighted)? "snow" : "whitesmoke";

        Column
        {
            id: stepDelegateCol
            anchors.fill: parent

            spacing: 0
            Label {
                text: stepDelegate.stepName
                padding: 0
                font.family: "Kalameh"
                font.pixelSize: (stepDelegate.highlighted)? 24 :16
                font.bold: (stepDelegate.highlighted)? true : false
                color: (stepDelegate.highlighted)? "royalblue":"black"
                horizontalAlignment: Label.AlignHCenter
                width: parent.width
                height: 50
                elide: Text.ElideRight
            }
            Label {
                text: stepDelegate.branchCity + " - " + stepDelegate.branchName
                padding: 0
                font.family: "Kalameh"
                font.pixelSize: 14
                font.bold: (stepDelegate.highlighted)? true : false
                color: (stepDelegate.highlighted)? "darkcyan": "black"
                width: parent.width
                height: 50
                horizontalAlignment: Label.AlignHCenter
                elide: Text.ElideRight
            }

            Switch{
                id: numericGradedSW
                height: 50
                text: "ارزیابی مبتنی بر عدد"
                checked: stepDelegate.numeric_graded
                anchors.horizontalCenter: parent.horizontalCenter
                checkable: false
                font.family: "Kalameh"
                font.pixelSize: 16
            }

            Switch{
                id: fielsbasedSW
                height: 50
                text: "دوره مبتنی بر رشته"
                checked: stepDelegate.field_based
                checkable: false
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Kalameh"
                font.pixelSize: 16
            }

            Rectangle{width: 400; height:5; color: (stepDelegate.highlighted)? "mediumvioletred" : "whitesmoke"; anchors.horizontalCenter: parent.horizontalCenter }
        }
    }

    swipe.right: Row{
        width: 150
        height: 210
        anchors.left: parent.left

        Button
        {
            height: 210
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
                if(stepDelegate.swipe.complete)
                stepDelegate.swipe.close();
                var branchText =  stepDelegate.branchCity + " - " + stepDelegate.branchName;
                stepDelegate.appStackView.push(deleteStepComponent, {
                                                   stepId: stepDelegate.stepId,
                                                   stepIndex: stepDelegate.index,
                                                   stepName: stepDelegate.stepName,
                                                   branchText: branchText,
                                                   numeric_graded: stepDelegate.numeric_graded,
                                                   field_based: stepDelegate.field_based

                                               });
            }
        }
        Button
        {
            height: 210
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
                if(stepDelegate.swipe.complete)
                stepDelegate.swipe.close();
                var branchText =  stepDelegate.branchCity + " - " + stepDelegate.branchName;
                stepDelegate.appStackView.push(updateStepComponent, {
                                                   stepId: stepDelegate.stepId,
                                                   step: stepDelegate.stepName,
                                                   branch: branchText,
                                                   numeric_graded: stepDelegate.numeric_graded,
                                                   field_based: stepDelegate.field_based

                                               });
            }
        }
    }

    onClicked: {stepDelegate.swipe.close();}

    Component
    {
        id: updateStepComponent
        StepUpdate{
            appStackView: stepDelegate.appStackView;
            onStepUpdatedSignal: (stepObj) => Methods.updateWidget(stepObj);
        }
    }
    Component
    {
        id: deleteStepComponent
        StepDelete{
            appStackView: stepDelegate.appStackView;
            onStepDeleted: (sIndex)=>{ stepDelegate.stepDeleted(sIndex);}
        }
    }

}
