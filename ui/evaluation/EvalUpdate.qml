pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: updatePage


    required property int eval_id;
    required property string eval_name;
    required property string eval_time;
    required property double max_grade;

    required property string branch
    required property string step
    required property string base
    required property string period
    required property string course_name
    required property string teacher
    required property string class_name

    required property int    course_id

    signal popStackSignal();
    signal updatedSignal();


    background: Rectangle{anchors.fill: parent; color: "mintcream"}

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
            onClicked: updatePage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ویرایش ارزیابی"
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
                width: (parent.width > 700)? 700 : parent.width
                implicitHeight : centerBox.implicitHeight + 40
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"

                GridLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20
                    columns: 2

                    Image
                    {
                        Layout.columnSpan: 2
                        Layout.preferredWidth: 128
                        Layout.preferredHeight: 128
                        Layout.alignment: Qt.AlignHCenter
                        source:  "qrc:/assets/images/evaluation.png"
                    }

                    // branch
                    Text {
                        text: "شعبه"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: updatePage.branch
                    }
                    //step
                    Text {
                        text: "دوره"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: updatePage.step
                    }

                    //base
                    Text {
                        text: "پایه تحصیلی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                        visible: (updatePage.base == "")? false : true
                    }
                    Text
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: updatePage.base
                        visible: (updatePage.base == "")? false : true
                    }

                    //base
                    Text {
                        text: "سال تحصیلی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: updatePage.period
                    }


                    Label
                    {
                        background: Rectangle{anchors.fill: parent; color:"royalblue"}
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 80
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        color: "white"
                        text: updatePage.course_name + " ( " +  updatePage.teacher + " ) "
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        font.bold: true
                    }

                    //eval name
                    Text {
                        text: "نام ارزیابی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    TextField
                    {
                        id: evalNameTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        placeholderText: "نام ارزیابی"
                        text: updatePage.eval_name
                    }

                    //eval time
                    Text {
                        text: "زمان ارزیابی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    TextField
                    {
                        id: evaltimeTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        placeholderText: "زمان ارزیابی"
                        validator: RegularExpressionValidator
                        {
                            regularExpression: /^\d{4}\/\d{2}\/\d{2}$/
                            // Regex pattern to match date in yyyy/MM/dd format
                        }
                        text: updatePage.eval_time
                    }

                    //max grade
                    Text {
                        text: "بالاترین نمره"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    TextField
                    {
                        id: maxGradeTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                            regularExpression: /^-?\d*\.?\d+$/
                        }
                        text: updatePage.max_grade
                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                    }

                    Button
                    {
                        text: "تایید"
                        Layout.columnSpan: 2
                        Layout.preferredWidth: 200
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                        onClicked:
                        {
                            var Eval = {};
                            Eval["id"] = updatePage.eval_id;
                            Eval["course_id"] = updatePage.course_id
                            Eval["eval_name"] = evalNameTF.text
                            Eval["eval_time"] = evaltimeTF.text

                            Eval["max_grade"] = parseFloat(maxGradeTF.text)


                            if(dbMan.evalUpdate(Eval))
                                successDialogId.open();
                            else
                            {
                                var errorString = dbMan.getLastError();
                                infoDialogId.dialogText = errorString
                                infoDialogId.width = parent.width
                                infoDialogId.height = 500
                                infoDialogId.open();
                            }
                        }
                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                    }


                }
            }
        }
    }

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "ویرایش ارزیابی با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ویرایس ارزیابی با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            updatePage.popStackSignal();
            updatePage.updatedSignal();
        }

    }
}
