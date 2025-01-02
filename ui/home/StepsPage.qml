import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: stepPageId

    required property string branch;
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
                onClicked: stepPageId.appStackView.pop();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Text {
                width: parent.width
                height:parent.height
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "شعبه " + stepPageId.branch
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
            text: "دوره مورد نظر خود را انتخاب نمایید"
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
                id: stepGV
                model: ListModel{id: stepModel;}
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
                        height: 150
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        font.bold: true
                        color: "white"
                        text: recdel.model.step_name
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        anchors.top: parent.top
                    }
                    Label{
                        width: parent.width
                        height: 50
                        font.family: "B Yekan"
                        font.pixelSize: 12
                        font.bold: true
                        color: "white"
                        text:{
                            if(recdel.model.field_based)
                            {
                                if(recdel.model.numeric_graded){
                                    return " مبتنی بر رشته " + " - " + " ارزیابی عددی"
                                }
                                else
                                {
                                    return " مبتنی بر رشته "
                                }
                            }
                            else
                            {
                                if(recdel.model.numeric_graded){
                                    return " ارزیابی عددی "
                                }
                                else
                                {
                                    return ""
                                }
                            }
                        }

                        horizontalAlignment: Label.AlignLeft
                        verticalAlignment: Label.AlignVCenter
                        anchors.bottom: parent.bottom
                    }

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "mediumvioletred";
                        onExited: parent.color = "slategray";
                        onClicked: {
                            dbMan.setStep(recdel.model.id);
                            var field_based = recdel.model.field_based;
                            if(field_based)
                            {
                                stepPageId.appStackView.push(fieldComponent,{
                                                                 objectName: "fieldON",
                                                                 step: recdel.model.step_name,
                                                                 branch: stepPageId.branch
                                                             });
                            }
                            else
                            {
                                dbMan.setField(-1);
                                stepPageId.appStackView.push(baseComponent, {
                                                                 objectName:"baseON",
                                                                 step: recdel.model.step_name,
                                                                 branch: stepPageId.branch,
                                                                 field: "",
                                                                 field_based: false
                                                             });
                            }


                        }
                    }
                }

                Component.onCompleted: {
                    var jsondata = dbMan.getSteps();
                    stepModel.clear();
                    //s.id, s.branch_id, s.step_name, b.city, b.branch_name, s.field_based, s.numeric_graded
                    for(var obj of jsondata)
                    {
                        stepModel.append(obj);
                    }
                }
            }

        }

    }

    Component{
        id: fieldComponent
        FieldPage{
            appStackView: stepPageId.appStackView
        }
    }

    Component{
        id: baseComponent
        BasePage{
            appStackView: stepPageId.appStackView
        }
    }
}
