pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import "./Branches.js" as BMethods

SwipeDelegate
{
    //id, city, branch_name, address, description
    id: branchDelegate
    required property int branchId
    required property string branchCity
    required property string branchName
    required property string branchAddress

    required property StackView appStackView;
    required property int index;

    signal branchUpdated(var branchObj);
    onBranchUpdated: (branchObj) => BMethods.updateWidget(branchObj);

    signal branchDeleted(var index);

    height: 110
    checkable: true
    checked: branchDelegate.swipe.complete
    onCheckedChanged: {if(!branchDelegate.checked) branchDelegate.swipe.close();} //branchDelegate.closeAllSwipe();

    clip: true

    background: Rectangle{color: (branchDelegate.highlighted)? "snow" : "whitesmoke";}

    contentItem: Rectangle
    {
        color: (branchDelegate.highlighted)? "snow" : "whitesmoke";

        Column
        {
            id: branchDelegateCol
            anchors.fill: parent

            spacing: 0
            Label {
                text: branchDelegate.branchCity +" - "+ branchDelegate.branchName
                padding: 0
                font.family: "B Yekan"
                font.pixelSize: (branchDelegate.highlighted)? 20 :16
                font.bold: (branchDelegate.highlighted)? true : false
                color: (branchDelegate.highlighted)? "royalblue":"black"
                horizontalAlignment: Label.AlignHCenter
                width: parent.width
                height: 50
                elide: Text.ElideRight
            }
            Label {
                text: branchDelegate.branchAddress
                padding: 0
                font.family: "B Yekan"
                font.pixelSize: 14
                font.bold: (branchDelegate.highlighted)? true : false
                color: (branchDelegate.highlighted)? "darkcyan": "black"
                width: parent.width
                height: 50
                horizontalAlignment: Label.AlignHCenter
                elide: Text.ElideRight
            }

            Rectangle{width: 400; height:5; color: (branchDelegate.highlighted)? "mediumvioletred" : "whitesmoke"; anchors.horizontalCenter: parent.horizontalCenter }
        }
    }

    swipe.right: Row{
        id: swipeId
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
                if(branchDelegate.swipe.complete)
                    branchDelegate.swipe.close();
                branchDelegate.appStackView.push(deleteBranchComponent, {branchId: branchDelegate.branchId, branchIndex: branchDelegate.index,  branchCity: branchDelegate.branchCity, branchName:branchDelegate.branchName, branchAddress: branchDelegate.branchAddress });
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
                if(branchDelegate.swipe.complete)
                    branchDelegate.swipe.close();

                branchDelegate.appStackView.push(updateBranchComponent,
                                     {branchId: branchDelegate.branchId, branchCity: branchDelegate.branchCity,
                                      branchName:branchDelegate.branchName, branchAddress: branchDelegate.branchAddress });
            }
        }

    }

    onClicked: { branchDelegate.swipe.close();}

    Component
    {
        id: updateBranchComponent
        UpdateBranch{ appStackView: branchDelegate.appStackView;}
    }
    Component
    {
        id: deleteBranchComponent
        BranchDelete{
            appStackView: branchDelegate.appStackView;
            onBranchDeleted: (bIndex)=> branchDelegate.branchDeleted(bIndex);
        }
    }

}
