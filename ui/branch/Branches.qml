pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
//import Lib.models.BranchModel

import "Branches.js" as BMethods

Page {
    id: branchesPage
    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    required property StackView appStackView;

    GridLayout
    {
        anchors.fill: parent
        columns:3

        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/arrow-right.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: branchesPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "لیست شعبه‌ها"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }
        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/add.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: branchesPage.appStackView.push(branchInsertComponent);
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }

        Rectangle
        {
            Layout.columnSpan: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "ghostwhite"

            ListView
            {
                id: branchesLV
                anchors.fill: parent
                anchors.margins: 10
                flickableDirection: Flickable.AutoFlickDirection
                clip: true
                spacing: 5
                model: ListModel{id: branchesModel;}
                highlight: Item{}
                delegate:
                BranchWidget{
                    id: branchDelegate
                    required property var model;
                    branchId: model.Id;
                    branchCity: model.City;
                    branchName: model.Name;
                    branchAddress: model.Address

                    index : model.index
                    appStackView: branchesPage.appStackView

                    onPressed: { branchesLV.currentIndex = model.index; branchesLV.closeSwipeHandler();}
                    highlighted: (model.index === branchesLV.currentIndex)? true: false;
                    width: branchesLV.width

                    onBranchDeleted: (deleteIndex)=>{
                        branchesModel.remove(deleteIndex);
                    }
                }

                function closeSwipeHandler()
                {
                    for (var i = 0; i <= branchesLV.count; i++)
                    {
                        var item = branchesLV.contentItem.children[i];
                        if(item.swipe)
                        {
                            item.swipe.close();
                            item.checked = false;
                        }
                    }
                }

            }

            Component.onCompleted: BMethods.updateBranches();
        }

    }

    Component
    {
        id: branchInsertComponent
        BranchInsert{
            appStackView: branchesPage.appStackView;
            onBranchInsertedSignal : BMethods.updateBranches();
        }
    }
}
