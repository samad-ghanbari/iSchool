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

    ColumnLayout
    {
        anchors.fill: parent

        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            color:"ghostwhite"

            Text {
                width: parent.width
                height: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "مدیریت شعبه‌ها"
                font.family: "Kalameh"
                font.pixelSize: 24
                font.bold: true
                color: "darkcyan"
                style: Text.Outline
                styleColor: "white"
            }

            Button
            {
                width: 64
                height: 64
                background: Item{}
                icon.source: "qrc:/assets/images/add.png"
                icon.width: 64
                icon.height: 64
                icon.color:"transparent"
                opacity: 0.5
                onClicked: branchesPage.appStackView.push(insertComponent);
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
        }



        Rectangle
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"

            GridView
            {
                id: branchesLV
                anchors.fill: parent
                anchors.margins: 10
                flickableDirection: Flickable.AutoFlickDirection
                clip: true
                cellWidth: 420
                cellHeight: 220
                model: ListModel{id: branchesModel;}
                highlight: Item{}
                delegate:delegateComponent

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

            Component.onCompleted:BMethods.updateBranches();
        }

    }

    Component
    {
        id: insertComponent
        BranchInsert{
            onPopSignal:  branchesPage.appStackView.pop();
            onInsertedSignal : BMethods.updateBranches();
        }
    }

    Component
    {
        id: updateComponent
        UpdateBranch{
            onPopSignal: branchesPage.appStackView.pop();
            onUpdatedSignal: BMethods.updateBranches();
        }
    }

    Component
    {
        id: deleteComponent
        BranchDelete{
            onPopSignal: branchesPage.appStackView.pop();
            onDeletedSignal: BMethods.updateBranches();
        }
    }

    Component
    {
        id: delegateComponent
        Rectangle
        {
            //id, city, branch_name, address, description
            id: branchDelegate
            required property var model;
            required property int index;

            property bool hoveredBox : false

            width: 400
            height: 200

            color: {
                if(branchDelegate.hoveredBox) return "lavenderblush";
                if(branchDelegate.index % 2 == 0) return "snow"; else return "whitesmoke";
            }
            border.width: 1
            border.color: "hotpink"

            MouseArea{
                anchors.fill: parent;
                hoverEnabled: true
                onEntered: branchDelegate.hoveredBox = true
                onExited: branchDelegate.hoveredBox = false
            }

            ColumnLayout
            {
                anchors.fill: parent

                spacing: 0
                Label {
                    text: branchDelegate.model["city"] +" - "+ branchDelegate.model["branch_name"]
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    font.bold: (branchDelegate.hoveredBox)? true : false
                    color: (branchDelegate.hoveredBox)? "royalblue":"black"
                    horizontalAlignment: Label.AlignHCenter
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    elide: Text.ElideRight
                }
                Text {
                    text: branchDelegate.model["branch_address"]
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 12
                    font.bold:  false
                    color: (branchDelegate.hoveredBox)? "darkcyan": "darkslategray"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 100
                    horizontalAlignment: Label.AlignHCenter
                    wrapMode: Text.WordWrap
                }

                Item{Layout.preferredWidth: 1; Layout.fillHeight: true;}

                RowLayout{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50

                    Button
                    {
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                        background: Item{}
                        hoverEnabled: true
                        opacity : 0.5
                        onHoveredChanged: opacity=(hovered)? 1:0.5
                        icon.source: "qrc:/assets/images/trash.png"
                        icon.width: 32
                        icon.height: 32
                        icon.color:"transparent"
                        onClicked: branchesPage.appStackView.push(deleteComponent, {
                                                                      branchId: branchDelegate.model["id"],
                                                                      branchIndex: branchDelegate.index,
                                                                      branchCity: branchDelegate.model["city"],
                                                                      branchName:branchDelegate.model["branch_name"],
                                                                      branchAddress: branchDelegate.model["branch_address"]
                                                                  });
                    }
                    Button
                    {
                        Layout.preferredWidth: 50
                        Layout.preferredHeight: 50
                        background:  Item{}
                        hoverEnabled: true
                        onHoveredChanged: opacity=(hovered)? 1:0.5
                        icon.source: "qrc:/assets/images/edit.png"
                        icon.width: 32
                        icon.height: 32
                        icon.color:"transparent"
                        onClicked: branchesPage.appStackView.push(updateComponent, {
                                                                                    branchId: branchDelegate.model["id"],
                                                                                    branchCity: branchDelegate.model["city"],
                                                                                    branchName:branchDelegate.model["branch"],
                                                                                    branchAddress: branchDelegate.model["branch_address"]
                                                                                });
                    }

                    Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}

                }
            }

            Rectangle{width: parent.width/2; height: 4; color: "deeppink"; visible: (branchDelegate.hoveredBox)?true: false; anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter;}
        }
    }
}
