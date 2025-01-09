pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: insertPage

    required property string branch
    required property string step
    required property string base
    required property string period

    required property int    step_id
    required property int    base_id
    required property int    period_id

    signal popStackSignal();
    signal insertedSignal();

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
            icon.color:"transparent"
            opacity: 0.5
            onClicked: insertPage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ثبت دسته ارزیابی جدید"
            font.family: "Kalameh"
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
                        source:  "qrc:/assets/images/evalcat.png"
                    }

                    // branch
                    Text {
                        text: "شعبه: " + insertPage.branch
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                        elide: Text.ElideRight
                    }

                    //step base
                    Text {
                        text:{
                            if(insertPage.base.indexOf("پایه") == -1)
                            return insertPage.step + " - پایه " + insertPage.base;
                            else
                            return insertPage.step + " - " + insertPage.base;
                        }
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }

                    //period
                    Text {
                        text: "سال تحصیلی: " + insertPage.period
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }

                    //eval cat
                    Text {
                        text: "نام دسته ارزیابی"
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
                        id: evalCatTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        placeholderText: "آزمون نهایی نیمسال اول"
                    }


                    //test exam
                    Text {
                        text: "آزمون تستی"
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
                    Switch
                    {
                        id: testSW
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignLeft
                        checked: false
                    }

                    //final exam
                    Text {
                        text: "آزمون نهایی"
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
                    Switch
                    {
                        id: finalSW
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignLeft
                        checked: false
                    }

                    // sort priority
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
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignLeft
                        value: 1
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
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        enabled : (evalCatTF.text == "")? false : true;
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                        onClicked:
                        {
                            var Eval = {};
                            Eval["step_id"] = insertPage.step_id
                            Eval["base_id"] = insertPage.base_id
                            Eval["period_id"] = insertPage.period_id

                            Eval["eval_cat"] = evalCatTF.text
                            Eval["test_flag"] = testSW.checked
                            Eval["final_flag"] = finalSW.checked

                            Eval["sort_priority"] = sortSB.value


                            if(dbMan.evalCatInsert(Eval))
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
        dialogText: "افزودن دسته ارزیابی جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "دسته ارزیابی جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            insertPage.popStackSignal();
            insertPage.insertedSignal();
        }

    }
}
