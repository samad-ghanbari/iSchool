pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Base.js" as Methods

Page {
    id: updateBasePage
    required property var model

    required property StackView appStackView;
    signal baseUpdatedSignal(var Base);

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    GridLayout
    {
        anchors.fill: parent
        columns:2

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
            onClicked: updateBasePage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ویرایش پایه تحصیلی"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "honeydew"

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
                    implicitHeight: baseUpdateCL.height + 100

                    radius: 10
                    Item{
                        anchors.fill: parent
                        anchors.margins: 10
                        ColumnLayout
                        {
                            id: baseUpdateCL
                            width: parent.width
                            Image {
                                source: "qrc:/assets/images/edit.png"
                                Layout.alignment: Qt.AlignHCenter
                                Layout.preferredHeight:  64
                                Layout.preferredWidth:  64
                                Layout.margins: 20
                                NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                            }

                            GridLayout
                            {
                                id: baseUpdateGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width


                                Text {
                                    text: "شعبه"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    id: branchTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    text: updateBasePage.model.city + " "+ updateBasePage.model.branch_name + " - " + updateBasePage.model.step_name

                                }

                                Text {
                                    text: "نام پایه تحصیلی "
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                TextField
                                {
                                    id: baseTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    Layout.maximumWidth: 400
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "پایه تحصیلی"
                                    text: updateBasePage.model.base_name
                                }

                                Label
                                {
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    text:" انتخاب رشته"
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    color: "royalblue"
                                    font.bold: true
                                    horizontalAlignment: Label.AlignLeft
                                    verticalAlignment: Label.AlignVCenter
                                    visible: updateBasePage.model.field_based
                                }
                                ComboBox
                                {
                                    id: fieldCB
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    Layout.maximumWidth: 400
                                    visible: updateBasePage.model.field_based
                                    editable: false
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    model: ListModel{id: fieldCBoxModel}
                                    textRole: "text"
                                    valueRole: "value"
                                    Component.onCompleted:
                                    {
                                        fieldCBoxModel.clear();
                                        var jsondata = dbMan.getFields(updateBasePage.model.step_id);
                                        //id, field_name
                                        var temp;
                                        for(var obj of jsondata)
                                        {
                                            fieldCBoxModel.append({ value: obj.id, text: obj.field_name })
                                        }

                                        fieldCB.currentIndex = fieldCB.indexOfValue(updateBasePage.model.field_id)
                                    }
                                }


                                Switch{
                                    id: enabledSW
                                    Layout.columnSpan: 2
                                    Layout.preferredHeight:  50
                                    text: "فعال بودن پایه تحصیلی"
                                    checked: updateBasePage.model.enabled
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                }

                                Text {
                                    text: "اولویت نمایش"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
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
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    value:  updateBasePage.model.sort_priority;
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
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                                onClicked:
                                {
                                    var Base = {};
                                    Base["id"] = updateBasePage.model.id;
                                    Base["base_name"] = baseTF.text
                                    Base["field_based"] = updateBasePage.model.field_based
                                    Base["field_id"] = fieldCB.currentValue
                                    Base["enabled"] = enabledSW.checked
                                    Base["sort_priority"] = sortSB.value


                                    var check = true
                                    // check entries
                                    if(!Methods.checkBaseUpdateEntries(Base))
                                    {
                                        baseInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.updateBase(Base))
                                    {
                                        Base = dbMan.getBase(Base["id"]);
                                        updateBasePage.baseUpdatedSignal(Base);
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
        dialogText: "ورود فیلد الزامی می‌باشد"
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: baseSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "اطلاعات دوره با موفقیت بروزرسانی شد"
        dialogSuccess: true
        onDialogAccepted: function(){baseSuccessDialogId.close(); updateBasePage.appStackView.pop();}
    }
}
