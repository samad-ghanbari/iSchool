pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox


Page {
    id: classCSEPage // class course student evals
    required property string class_name;
    required property string course_name;
    required property int class_id;
    required property int course_id;
    required property string branch;
    required property string step;
    required property string base;
    required property string period;
    required property string teacher;
    required property int branch_id;
    required property int step_id;
    required property int base_id;
    required property int period_id;



    signal popStackViewSignal();


    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    GridLayout
    {
        columns: 2
        anchors.fill: parent

        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/arrow-right.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: classCSEPage.popStackViewSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            textFormat: Text.RichText
            text: "ارزیابی واحد درسی کلاس "
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }


        ScrollView
        {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            Rectangle
            {
                width: parent.width
                implicitHeight : centerBox.implicitHeight + 40
                anchors.horizontalCenter : parent.horizontalCenter
                color: "ghostwhite"

                ColumnLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20

                    Text {
                        text: "شعبه " + classCSEPage.branch
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }
                    Text {
                        text: classCSEPage.step + " - " + classCSEPage.base
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }
                    Text {
                        text:  classCSEPage.period
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }

                    //class
                    Text {
                        text: "کلاس " + classCSEPage.class_name + " - " + classCSEPage.course_name + "(" + classCSEPage.teacher+")"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }

                    ListView
                    {
                        id: courseEvalLV
                        Layout.fillHeight: true
                        Layout.preferredHeight: courseEvalLV.contentHeight + 100
                        Layout.fillWidth: true
                        Layout.margins: 10
                        clip: true
                        model: ListModel{id: classSCEModel;}

                        delegate:Column{
                            id: recdel
                            required property var model;
                            height: courseEvalGV.height + 80
                            width: ListView.view.width
                            spacing: 20
                            Label{
                                width: parent.width;
                                height: 80
                                text: ""
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                                font.bold: true
                                font.family: "B Yekan"
                                font.pixelSize: 20
                                color: "mediumvioletred"
                                background:Rectangle{color: "thistle"}

                            }

                            GridView
                            {
                                id: courseEvalGV
                                height: contentHeight + 100
                                width: parent.width

                                flickableDirection: Flickable.AutoFlickDirection
                                clip: true
                                cellWidth: 310
                                cellHeight:310
                                model: recdel.model.evals
                                highlight: Item{}
                                delegate: gvDelegate
                            }
                        }

                        Component.onCompleted: {}
                    }


                }
            }
        }
    }

    //delegate
    Component
    {
        id: gvDelegate
        Rectangle
        {
        }
    }

    //dialog
    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "عملیات با خطا مواجه شد."
        dialogSuccess: false
    }
}
