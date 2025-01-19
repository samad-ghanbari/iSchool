import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: periodPageId

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;

    required property StackView appStackView;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            color:"transparent"
            // Button
            // {
            //     height: 64
            //     width: 64
            //     anchors.left: parent.left
            //     background: Item{}
            //     icon.source: "qrc:/assets/images/arrow-right.png"
            //     icon.width: 64
            //     icon.height: 64
            //     icon.color:"transparent"
            //     opacity: 0.5
            //     onClicked: periodPageId.appStackView.pop();
            //     hoverEnabled: true
            //     onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            // }
            Text {
                width: parent.width
                height: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "شعبه " + periodPageId.branch + " - " + periodPageId.step
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
        }


        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 25
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: (periodPageId.field_based) ? "رشته " + periodPageId.field + " - " + " پایه " + periodPageId.base :  " پایه " + periodPageId.base
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
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
            Layout.preferredHeight: 50
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "سال تحصیلی مورد نظر خود را انتخاب نمایید"
            font.family: "Kalameh"
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
                id: baseGV
                model: ListModel{id: periodModel;}
                anchors.fill: parent
                anchors.topMargin: 20
                clip: true
                flickableDirection: Flickable.AutoFlickDirection
                cellWidth: 350
                cellHeight: 220
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
                        height: 50
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "white"
                        text: "سال تحصیلی"
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        anchors.top: parent.top
                    }
                    Label{
                        width: parent.width
                        height: 150
                        font.family: "Kalameh"
                        font.pixelSize: 20
                        font.bold: true
                        color: "white"
                        text: recdel.model.period_name
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        anchors.bottom: parent.bottom
                    }

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "mediumvioletred";
                        onExited: parent.color = "slategray";
                        onClicked: {
                            dbMan.setPeriod(recdel.model.id);
                            periodPageId.appStackView.push(classComponent, {
                                                             objectName:"classON",
                                                             period: recdel.model.period_name,
                                                         });
                        }
                    }
                }

                Component.onCompleted: {
                    var jsondata = dbMan.getPeriods();
                    periodModel.clear();
                    //id, step_id, period_name
                    for(var obj of jsondata)
                    {
                        periodModel.append(obj);
                    }
                }
            }

        }

    }

    Component{
        id: classComponent
        ClassPage{
            appStackView: periodPageId.appStackView
            branch: periodPageId.branch
            step: periodPageId.step
            base: periodPageId.base
            field : periodPageId.field
            field_based: periodPageId.field_based
        }
    }
}
