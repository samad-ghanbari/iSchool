import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: basePageId

    required property string branch;
    required property string step;
    required property bool field_based;
    required property StackView appStackView;
    required property string field;

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
            //     onClicked: basePageId.appStackView.pop();
            //     hoverEnabled: true
            //     onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            // }
            Text {
                width: parent.width
                height: parent.height
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "شعبه " + basePageId.branch + " - " + basePageId.step
                font.family: "B Yekan"
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
            text: "رشته " + basePageId.field
            font.family: "B Yekan"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
            visible: (basePageId.field_based)? true : false
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
            text: "پایه تحصیلی مورد نظر خود را انتخاب نمایید"
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
                id: baseGV
                model: ListModel{id: baseModel;}
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
                        text: recdel.model.base_name
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
                            dbMan.setBase(recdel.model.id);
                            var base_var = recdel.model.base_name
                            base_var = base_var.replace("پایه", "");
                            basePageId.appStackView.push(periodComponent, {
                                                             objectName:"periodsON",
                                                             base: base_var,
                                                         });
                        }
                    }
                }

                Component.onCompleted: {
                    var jsondata = dbMan.getBases();
                    baseModel.clear();
                    //id, step_id, field_id, base_name
                    for(var obj of jsondata)
                    {
                        baseModel.append(obj);
                    }
                }
            }

        }

    }

    Component{
        id: periodComponent
        PeriodPage{
            appStackView: basePageId.appStackView
            branch: basePageId.branch
            step: basePageId.step
            field : basePageId.field
            field_based: basePageId.field_based
        }
    }
}
