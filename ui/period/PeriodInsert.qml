import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Period.js" as Methods

Page {
    id: insertPage

    property int step_id;
    property string branch
    property string step


    signal popSignal();
    signal insertedSignal();

    background: Rectangle{anchors.fill: parent; color: "honeydew"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن سال تحصیلی"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        Rectangle
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"

            ScrollView
            {
                height: parent.height
                width: parent.width
                contentHeight: centerBoxId.height + 100

                Rectangle
                {
                    id: centerBoxId
                    color:"snow"
                    width:  (parent.width < 700)? parent.width : 700
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: periodInsertCL.height

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            id: periodInsertCL
                            width: parent.width
                            Image {
                                source: "qrc:/assets/images/add.png"
                                Layout.alignment: Qt.AlignHCenter
                                Layout.preferredHeight:  64
                                Layout.preferredWidth:  64
                                Layout.margins: 20
                                NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                            }

                            GridLayout
                            {
                                id: periodInsertGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Text {
                                    Layout.columnSpan: 2
                                    text:{

                                        var temp = insertPage.step
                                        if(temp.includes("دوره"))
                                            return "شعبه " + insertPage.branch + " - " + insertPage.step
                                        else
                                            return "شعبه " + insertPage.branch + " - "+ "دوره " + insertPage.step
                                    }
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 400
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "darkcyan"
                                }


                                Text {
                                    text: "سال تحصیلی"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "darkcyan"
                                }
                                TextField
                                {
                                    id: periodTF
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 400
                                    Layout.preferredHeight: 50
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    placeholderText: "سال تحصیلی"

                                }

                                Switch{
                                    id: enabledSW
                                    Layout.columnSpan: 2
                                    Layout.preferredHeight:  50
                                    text: "اتمام سال تحصیلی"
                                    checked: false
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    palette.text: "black"
                                    palette.highlight: "darkcyan"
                                }

                                Text {
                                    text: "اولویت نمایش"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "darkcyan"
                                }
                                SpinBox
                                {
                                    id: sortSB
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 400
                                    Layout.preferredHeight: 50
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    value:  dbMan.getPeriodMaxSortPriority(insertPage.step_id)+1;
                                }

                                // pattern
                                Text {
                                    text: "الگو"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "darkcyan"
                                }
                                ComboBox
                                {
                                    id: patternCB
                                    Layout.preferredHeight:  50
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 400
                                    editable: false
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    model: ListModel{id: patternModel}
                                    textRole: "text"
                                    valueRole: "value"
                                    Component.onCompleted:
                                    {
                                        var jsondata = dbMan.getStepPeriods(insertPage.step_id, true);
                                        // p.id, p.step_id, p.period_name, p.passed, s.step_name, s.branch_id, br.city, br.branch_name, s.numeric_graded, s.field_based, p.sort_priority
                                        patternModel.clear();
                                        patternModel.append({"text": "سال‌تحصیلی خالی", "value": 0 });
                                        for(var obj of jsondata){
                                            patternModel.append({"text": obj.period_name, "value": obj.period_id });
                                        }
                                        patternCB.currentIndex = 0;
                                    }
                                }


                            }

                            Item
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                            }

                            Button
                            {
                                text: "تایید"
                                Layout.preferredWidth: 200
                                Layout.preferredHeight: 50
                                Layout.alignment: Qt.AlignHCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                                onClicked:
                                {
                                    var period = {};
                                    period["step_id"] = insertPage.step_id
                                    period["period_name"] = periodTF.text
                                    period["passed"] = enabledSW.checked
                                    period["pattern"] = patternCB.currentValue;
                                    period["sort_priority"] = sortSB.value


                                    var check = true
                                    // check entries
                                    if(!Methods.checkPeriodInsertEntries(period))
                                    {
                                        periodInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.periodInsert(period))
                                    {
                                        insertPage.insertedSignal();
                                        periodSuccessDialogId.open();

                                    }
                                    else
                                    {
                                        var errorString = dbMan.getLastError();
                                        periodInfoDialogId.dialogTitle = "خطا"
                                        periodInfoDialogId.dialogText = errorString
                                        periodInfoDialogId.width = parent.width
                                        periodInfoDialogId.height = 500
                                        periodInfoDialogId.dialogSuccess = false
                                        periodInfoDialogId.open();
                                    }
                                }
                            }

                            Item
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                            }
                        }
                    }
                }
            }
        }

    }

    DialogBox.BaseDialog
    {
        id: periodInfoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن سال تحصیلی با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: periodSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "سال تحصیلی جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){periodSuccessDialogId.close(); insertPage.popSignal();}

    }
}
