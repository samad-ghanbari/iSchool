pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox


Page {
    id: classCCSEPage // class course students evals
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
            onClicked: classCCSEPage.popStackViewSignal();
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
                        text: "شعبه " + classCCSEPage.branch
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
                        text: classCCSEPage.step + " - " + classCCSEPage.base
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
                        text:  classCCSEPage.period
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
                        text: "کلاس " + classCCSEPage.class_name + " - " + classCCSEPage.course_name + "(" + classCCSEPage.teacher+")"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        font.bold: true
                        color: "darkmagenta"
                    }

                    ListView
                    {
                        id: lv
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.margins: 10
                        clip: true
                        model: ListModel{id: lvModel;} // students and evals of this course
                        // row - student_id - student - course_name  - student_evals
                        delegate:Rectangle{
                            id: recdel
                            required property var model;
                            height: 80
                            color : "red"
                            width: ListView.view.width
                            RowLayout{
                                anchors.fill: parent
                            }
                        }

                        Component.onCompleted: {

                            var model = dbMan.getClassCourseStudentsEvals(classCCSEPage.class_id,classCCSEPage.course_id);
                        }
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
