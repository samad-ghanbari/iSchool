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

    signal stepDeleted(var index);

    height: 110
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
                font.family: "B Yekan"
                font.pixelSize: (stepDelegate.highlighted)? 20 :16
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
                font.family: "B Yekan"
                font.pixelSize: 14
                font.bold: (stepDelegate.highlighted)? true : false
                color: (stepDelegate.highlighted)? "darkcyan": "black"
                width: parent.width
                height: 50
                horizontalAlignment: Label.AlignHCenter
                elide: Text.ElideRight
            }

            Rectangle{width: 400; height:5; color: (stepDelegate.highlighted)? "mediumvioletred" : "whitesmoke"; anchors.horizontalCenter: parent.horizontalCenter }
        }
    }

    swipe.right: Row{
        width: 150
        height: 100
        anchors.left: parent.left

        Button
        {
            height: 100
            width: 75
            background: Rectangle{id:trashBtnBg; color: "crimson"}
            hoverEnabled: true
            onHoveredChanged: trashBtnBg.color=(hovered)? Qt.darker("crimson", 1.1):"crimson"
            text: "حذف"
            font.bold: true
            font.family: "B Yekan"
            font.pixelSize: 14
            palette.buttonText:  "white"
            icon.source: "qrc:/assets/images/trash.png"
            icon.width: 32
            icon.height: 32
            display: AbstractButton.TextUnderIcon
            SwipeDelegate.onClicked:
            {
                if(stepDelegate.swipe.complete)
                stepDelegate.swipe.close();
                var branchText =  stepDelegate.branchCity + " - " + stepDelegate.branchName;
                stepDelegate.appStackView.push(deleteStepComponent, {stepId: stepDelegate.stepId, stepIndex: stepDelegate.index,  stepName: stepDelegate.stepName, branchText: branchText});
            }
        }
        Button
        {
            height: 100
            width: 75
            background:  Rectangle{id:editBtnBg; color: "royalblue"}
            hoverEnabled: true
            onHoveredChanged: editBtnBg.color=(hovered)? Qt.darker("royalblue", 1.1):"royalblue"
            text: "ویرایش"
            font.bold: true
            font.family: "B Yekan"
            font.pixelSize: 14
            palette.buttonText:  "white"
            icon.source: "qrc:/assets/images/edit.png"
            icon.width: 32
            icon.height: 32
            display: AbstractButton.TextUnderIcon
            SwipeDelegate.onClicked:
            {
                if(stepDelegate.swipe.complete)
                stepDelegate.swipe.close();
                var branchText =  stepDelegate.branchCity + " - " + stepDelegate.branchName;
                stepDelegate.appStackView.push(updateStepComponent, {stepId: stepDelegate.stepId, step: stepDelegate.stepName, branch: branchText });
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
