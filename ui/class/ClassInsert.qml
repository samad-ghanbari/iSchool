import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: insertPage

    required property int step_id;
    required property int period_id;
    required property bool field_based

    required property string branch;
    required property string step
    required property string period

    signal classInsertedSignal();
    signal popStackSignal();

    background: Rectangle{anchors.fill: parent; color: "honeydew"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن کلاس جدید"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Flickable
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            contentHeight: centerBox.implicitHeight

            Rectangle{
                width:  (parent.width < 700)? parent.width : 700
                height: centerBox.implicitHeight
                anchors.horizontalCenter: parent.horizontalCenter


            Column
            {
                id: centerBox
                anchors.fill: parent
                anchors.margins: 10


                Item{
                    width: parent.width
                    height: 64
                    Image {
                        source: "qrc:/assets/images/add.png"
                        height:  64
                        width:  64
                        anchors.centerIn: parent
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }
                }

                Text {
                    text: "شعبه " + insertPage.branch
                    width: parent.width
                    height: 50
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "royalblue"
                }
                Text {
                    text: insertPage.step
                    width: parent.width
                    height: 50
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "royalblue"
                }

                Text {
                    text: insertPage.period
                    width: parent.width
                    height: 50
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "royalblue"
                }

                RowLayout{
                    width: parent.width
                    height: 50

                    Text {
                        text: "نام کلاس"
                        width: 150
                        Layout.preferredWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                    }
                    TextField
                    {
                        id: classNameTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        placeholderText: "نام کلاس"

                    }
                }

                RowLayout{
                    width: parent.width
                    height: 50
                    visible: insertPage.field_based

                    Text {
                        text: "رشته تحصیلی: "
                        width: 150
                        Layout.preferredWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                    }
                    ComboBox
                    {
                        id: fieldCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        editable: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: fieldModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted:
                        {
                            var jsondata = dbMan.getFields(insertPage.step_id);
                            //id, step_id, field_name
                            fieldModel.clear();
                            for(var obj of jsondata){
                                fieldModel.append({"text": obj.field_name, "value": obj.id });
                            }
                            fieldCB.currentIndex = -1;
                        }

                        onActivated: {
                            var field_id = fieldCB.currentValue;
                            baseModel.clear()
                            var jsondata = dbMan.getFieldBases(field_id, false);
                            //b.id, b.step_id, b.field_id, s.branch_id, b.base_name, b.enabled, s.step_name, s.field_based, s.numeric_graded, f.field_name, br.branch_name, br.city, b.sort_priority
                            baseModel.clear();
                            for(var obj of jsondata){
                                baseModel.append({"text": obj.base_name, "value": obj.id });
                            }
                            baseCB.currentIndex = -1;
                        }
                    }
                }

                RowLayout{
                    id: baseBox
                    width: parent.width
                    height: 50

                    Text {
                        text: "پایه تحصیلی:‌ "
                        width: 150
                        Layout.preferredWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                    }
                    ComboBox
                    {
                        id: baseCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        editable: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: baseModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted:
                        {
                            if(insertPage.field_based === false){
                                var jsondata = dbMan.getStepBases(insertPage.step_id, false);
                                //b.id, b.step_id, b.field_id, s.branch_id, b.base_name, b.enabled, s.step_name, s.field_based, s.numeric_graded, f.field_name, br.branch_name, br.city, b.sort_priority
                                baseModel.clear();
                                for(var obj of jsondata){
                                    baseModel.append({"text": obj.base_name, "value": obj.id });
                                }
                                baseCB.currentIndex = -1;
                            }
                        }

                        onActivated: {
                            var base_id = baseCB.currentValue
                            classSortSB.value = dbMan.getClassMaxSortPriority(base_id, insertPage.period_id,) + 1;
                        }

                    }
                }

                RowLayout{
                    width: parent.width
                    height: 50
                    Text {
                        text: "توضیحات کلاس"
                        Layout.preferredWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                    }
                    TextField
                    {
                        id: classDescTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        placeholderText: "موقعیت کلاس"
                    }
                }

                RowLayout{
                    width: parent.width
                    height: 50
                    Text {
                        text: "اولویت نمایش"
                        Layout.preferredWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                    }
                    SpinBox
                    {
                        id: classSortSB
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignLeft
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        value: 1
                    }
                    Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                }

                Item
                {
                    width: parent.width
                    height: 50
                }

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
                        if(insertPage.field_based === true)
                        {
                            if(fieldCB.currentIndex === -1) return;
                            if(fieldCB.currentText === "") return;
                        }

                        var classObj = {};
                        classObj["base_id"] = baseCB.currentValue
                        classObj["period_id"] = insertPage.period_id;
                        classObj["class_name"] = classNameTF.text;
                        classObj["class_desc"] = classDescTF.text;
                        classObj["sort_priority"] = classSortSB.value;


                        if(dbMan.classInsert(classObj))
                        {
                            insertPage.classInsertedSignal();
                            successDialogId.dialogText = "کلاس جدید با موفقیت افزوده شد.";
                            successDialogId.open();


                            insertPage.classInsertedSignal();

                        }
                        else
                        {
                            var errorString = dbMan.getLastError();
                            classInfoDialogId.dialogText = errorString
                            classInfoDialogId.width = parent.width
                            classInfoDialogId.height = 500
                            classInfoDialogId.dialogSuccess = false

                            classInfoDialogId.open();
                        }
                    }
                }

                Item
                {
                    width: parent.width
                    height: 50
                }

            }

            }
        }
    }

    DialogBox.BaseDialog
    {
        id: classInfoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن کلاس جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "کلاس جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: {
            successDialogId.close();
            insertPage.popStackSignal();
        }

    }
}
