pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: insertPage

    signal popStackSignal();
    signal insertedSignal();

    required property int step_id;
    required property int base_id;
    required property int period_id;
    required property bool field_based;

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property string period;

    background: Rectangle{anchors.fill: parent; color: "honeydew"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن ارزیابی جدید"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        Flickable{
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            contentHeight: centerBox.implicitHeight

            Rectangle
            {
                width: (parent.width > 700)? 700 : parent.width
                height:  centerBox.implicitHeight + 100
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"
                anchors.margins: 10

                Column{
                    id: centerBox
                    width : parent.width
                    anchors.margins: 10

                    Image
                    {
                        width: 64
                        height: 64
                        anchors.horizontalCenter: parent.horizontalCenter
                        source:  "qrc:/assets/images/evaluation.png"
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }

                    //branch
                    Text {
                        width: parent.width
                        height: 50
                        text: insertPage.branch + " - " + insertPage.step
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text {
                        text: (insertPage.field_based) ? insertPage.field + " - " +  insertPage.base :  insertPage.base
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Row{
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        text: "سال تحصیلی "
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                        Text {
                            text:  insertPage.period
                            height: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                    }

                    // eval name
                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "نام ارزیابی"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        TextField
                        {
                            id: evalNameTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "نام ارزیابی"
                        }
                    }
                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    // max grade
                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "بیشترین نمره"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        TextField
                        {
                            id: maxGradeTF
                            Layout.fillWidth: true
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text: "20"
                            placeholderText: "بیشترین نمره"
                            validator: RegularExpressionValidator{regularExpression: /^-?\d*\.?\d+$/ }
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    // course flag
                    Switch{
                        id: courseFlagSW
                        width: parent.width
                        height: 50
                        text: "ارزیابی واحد درسی"
                        checked: true
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        onClicked: {
                            if(checked)
                                testFlagSW.checked = false;
                        }
                    }

                    // test flag
                    Switch{
                        id: testFlagSW
                        width: parent.width
                        height: 50
                        text: "ارزیابی واحد تستی"
                        checked: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        onClicked: {
                            if(checked)
                                courseFlagSW.checked = false;
                        }
                    }

                    // final flag
                    Switch{
                        id: finalFlagSW
                        width: parent.width
                        height: 50
                        text: "ارزیابی نهایی "
                        checked: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                    }

                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    // sort priority
                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "اولویت نمایش"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        SpinBox
                        {
                            id: sortSB
                            Layout.fillWidth: true
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            value: dbMan.getEvalMaxSort(insertPage.step_id, insertPage.base_id, insertPage.period_id) + 1;
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    Item{width: parent.width; height: 50;}


                    Button
                    {
                        text: "تایید"
                        width: 200
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                        onClicked:
                        {
                            var eval = {};
                            eval["step_id"] = insertPage.step_id
                            eval["base_id"] = insertPage.base_id
                            eval["period_id"] = insertPage.period_id

                            eval["eval_name"] = evalNameTF.text
                            var grade = maxGradeTF.text
                            eval["max_grade"] = parseFloat(grade)
                            eval["course_flag"] = courseFlagSW.checked
                            eval["test_flag"] = testFlagSW.checked
                            eval["final_flag"] = finalFlagSW.checked
                            eval["sort_priority"] = sortSB.value



                            if(dbMan.insertEval(eval))
                            {
                                insertPage.insertedSignal();
                                successDialogId.open();
                            }
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
                        width: parent.width
                        height: 5
                    }
                }
            }
        }
    }

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن ارزیابی جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ارزیابی جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            insertPage.popStackSignal();
        }

    }
}
