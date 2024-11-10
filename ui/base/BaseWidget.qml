pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import "./Base.js" as Methods

SwipeDelegate
{
    //s.id, s.branch_id, s.Base_name, b.city, b.branch_name
    id: baseDelegate
    required property StackView appStackView
    required property int index

    property int baseId
    property int branchId
    property string studyBase
    property string city
    property string branchName

    signal baseDeleted(var index);

    height: 110
    checkable: true
    checked: baseDelegate.swipe.complete
    onCheckedChanged: { if(!baseDelegate.checked) baseDelegate.swipe.close();}
    clip: true

    background: Rectangle{color: (baseDelegate.highlighted)? "snow" : "whitesmoke";}

    contentItem: Rectangle
    {
        color: (baseDelegate.highlighted)? "snow" : "whitesmoke";

        Column
        {
            id: baseDelegateCol
            anchors.fill: parent

            spacing: 0
            Label {
                text: baseDelegate.studyBase
                padding: 0
                font.family: "B Yekan"
                font.pixelSize: (baseDelegate.highlighted)? 20 :16
                font.bold: (baseDelegate.highlighted)? true : false
                color: (baseDelegate.highlighted)? "royalblue":"black"
                horizontalAlignment: Label.AlignHCenter
                width: parent.width
                height: 50
                elide: Text.ElideRight
            }
            Label {
                text: baseDelegate.city + " - " + baseDelegate.branchName
                padding: 0
                font.family: "B Yekan"
                font.pixelSize: 14
                font.bold: (baseDelegate.highlighted)? true : false
                color: (baseDelegate.highlighted)? "darkcyan": "black"
                width: parent.width
                height: 50
                horizontalAlignment: Label.AlignHCenter
                elide: Text.ElideRight
            }

            Rectangle{width: 400; height:5; color: (baseDelegate.highlighted)? "mediumvioletred" : "whitesmoke"; anchors.horizontalCenter: parent.horizontalCenter }
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
                if(baseDelegate.swipe.complete)
                    baseDelegate.swipe.close();

                var branchText =  baseDelegate.city + " - " + baseDelegate.branchName;
                baseDelegate.appStackView.push(deleteBaseComponent, {baseId: baseDelegate.baseId, baseIndex: baseDelegate.index,  studyBase: baseDelegate.studyBase, branchText: branchText});
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
                if(baseDelegate.swipe.complete)
                    baseDelegate.swipe.close();

                var branchText =  baseDelegate.city + " - " + baseDelegate.branchName;
                baseDelegate.appStackView.push(updateBaseComponent, {baseId: baseDelegate.baseId, studyBase: baseDelegate.studyBase, branch: branchText });
            }
        }
    }

    onClicked: {baseDelegate.swipe.close();}

    Component
    {
        id: updateBaseComponent
        BaseUpdate{
            appStackView: baseDelegate.appStackView;
            onBaseUpdatedSignal: (BaseObj) => Methods.baseUpdate(BaseObj);
        }
    }
    Component
    {
        id: deleteBaseComponent
        BaseDelete{
            appStackView: baseDelegate.appStackView;
            onBaseDeleted: (sIndex)=>{ baseDelegate.baseDeleted(sIndex);}
        }
    }

}
