import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Base.js" as Methods

Page {
    id: insertBasePage

    required property int step_id;
    required property string branch
    required property string step
    required property bool field_based


    required property StackView appStackView
    signal baseInsertedSignal(var step_id);

    background: Rectangle{anchors.fill: parent; color: "honeydew"}

    ColumnLayout
    {
        anchors.fill: parent


        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن پایه تحصیلی"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
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
                    implicitHeight: baseInsertCL.height + 100

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            id: baseInsertCL
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
                                id: baseInsertGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Text {
                                    Layout.columnSpan: 2
                                    text: "شعبه " + insertBasePage.branch + " - " + "دوره " + insertBasePage.step
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }

                                Text {
                                    text: "نام پایه تحصیلی"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment:  Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                TextField
                                {
                                    id: baseTF
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 400
                                    Layout.preferredHeight: 50
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    placeholderText: "نام پایه تحصیلی"

                                }

                                Label
                                {
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    text:" انتخاب رشته"
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                    horizontalAlignment: Label.AlignLeft
                                    verticalAlignment: Label.AlignVCenter
                                    visible: insertBasePage.field_based
                                }
                                ComboBox
                                {
                                    id: fieldCB
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    Layout.maximumWidth: 400
                                    visible: insertBasePage.field_based
                                    editable: false
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    model: ListModel{id: fieldCBoxModel}
                                    textRole: "text"
                                    valueRole: "value"
                                    Component.onCompleted:
                                    {
                                        fieldCBoxModel.clear();
                                        var jsondata = dbMan.getFields(insertBasePage.step_id);
                                        //id, field_name
                                        var temp;
                                        for(var obj of jsondata)
                                        {
                                            fieldCBoxModel.append({ value: obj.id, text: obj.field_name })
                                        }

                                        fieldCB.currentIndex = -1
                                    }
                                }

                                Switch{
                                    id: enabledSW
                                    Layout.columnSpan: 2
                                    Layout.preferredHeight:  50
                                    text: "فعال بودن پایه تحصیلی"
                                    checked: true
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
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
                                    color: "royalblue"
                                }
                                SpinBox
                                {
                                    id: sortSB
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    Layout.maximumWidth: 400
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    value:  1;
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
                                    var Base = {};
                                    Base["step_id"] = insertBasePage.step_id
                                    Base["base_name"] = baseTF.text
                                    Base["field_based"] = insertBasePage.field_based
                                    Base["field_id"] = fieldCB.currentValue
                                    Base["enabled"] = enabledSW.checked
                                    Base["sort_priority"] = sortSB.value

                                    var check = true
                                    // check entries
                                    if(!Methods.checkBaseInsertEntries(Base))
                                    {
                                        baseInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.insertBase(Base))
                                    {
                                        insertBasePage.baseInsertedSignal(insertBasePage.step_id);
                                        baseSuccessDialogId.open();

                                    }
                                    else
                                    {
                                        var errorString = dbMan.getLastError();
                                        baseInfoDialogId.dialogTitle = "خطا"
                                        baseInfoDialogId.dialogText = errorString
                                        baseInfoDialogId.width = parent.width
                                        baseInfoDialogId.height = 500
                                        baseInfoDialogId.dialogSuccess = false
                                        baseInfoDialogId.open();
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
        id: baseInfoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن دوره جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: baseSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "دوره جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){baseSuccessDialogId.close(); insertBasePage.appStackView.pop();}

    }
}
