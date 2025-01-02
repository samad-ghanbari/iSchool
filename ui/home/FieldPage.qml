import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: fieldPageId

    required property string branch;
    required property string step;
    required property StackView appStackView;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent
        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            color:"transparent"
            Button
            {
                height: 64
                width: 64
                anchors.left: parent.left
                background: Item{}
                icon.source: "qrc:/assets/images/arrow-right.png"
                icon.width: 64
                icon.height: 64
                icon.color:"transparent"
                opacity: 0.5
                onClicked: fieldPageId.appStackView.pop();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Text {
                width: parent.width
                height: parent.height
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "شعبه " + fieldPageId.branch + " - " + fieldPageId.step
                font.family: "B Yekan"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
        }



        Rectangle{
            Layout.preferredHeight: 1
            Layout.fillWidth: true
            //Layout.maximumWidth: 700
            Layout.alignment: Qt.AlignHCenter
            color: "darkgray"
        }

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 25
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "لطفا رشته مورد نظر خود را انتخاب نمایید"
            font.family: "B Yekan"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
        }


        Rectangle{
            id: mainBox
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 20
            color: "transparent"

            GridView{
                id: fieldGV
                model: ListModel{id: fieldModel;}
                anchors.fill: parent
                anchors.topMargin: 20
                clip: true
                flickableDirection: Flickable.AutoFlickDirection
                cellWidth: 350
                cellHeight: 250
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                delegate: Rectangle{
                    id: recdel;
                    required property var model;
                    width: 320
                    height: 200
                    border.width: 2
                    border.color: "mediumvioletred"
                    color: "slategray";
                    radius: 5
                    Label{
                        width: parent.width
                        height: 200
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        font.bold: true
                        color: "white"
                        text: "رشته " + recdel.model.field_name
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        anchors.top: parent.top
                    }

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "mediumvioletred";
                        onExited: parent.color = "slategray";
                        onClicked: {
                            dbMan.setField(recdel.model.id);
                            fieldPageId.appStackView.push(baseComponent, {
                                                             objectName:"fieldON",
                                                             field: recdel.model.field_name,
                                                             field_based: true
                                                         });

                        }
                    }
                }

                Component.onCompleted: {
                    var jsondata = dbMan.getFields();
                    // id, step_id, field_name,
                    fieldModel.clear();
                    for(var obj of jsondata)
                    {
                        fieldModel.append(obj);
                    }
                }
            }

        }

    }

    Component{
        id: baseComponent
        BasePage{
            appStackView: stepPageId.appStackView
            step: fieldPageId.step
            branch: fieldPageId.branch
        }
    }
}
