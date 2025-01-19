import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: updateClassPage

    property int class_id;
    property string branch_text
    property string step_text
    property string base_text
    property string period_text
    property string class_name;
    property string class_desc;
    property int sort_priority;

    signal classUpdatedSignal();
    signal popStackSignal();

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
            onClicked: updateClassPage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ویرایش کلاس"
            font.family: "Kalameh"
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
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                Rectangle
                {
                    id: centerBoxId
                    color:"snow"
                    width:  (parent.width < 700)? parent.width : 700
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: parent.height

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            id: periodInsertCL
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
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Text {
                                    Layout.columnSpan: 2
                                    text: "شعبه " + updateClassPage.branch_text
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
                                    Layout.columnSpan: 2
                                    text: updateClassPage.step_text + " - " + updateClassPage.base_text
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
                                    Layout.columnSpan: 2
                                    text:  updateClassPage.period_text
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
                                    text: "نام کلاس"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
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
                                    text: updateClassPage.class_name
                                }

                                Text {
                                    text: "توضیحات کلاس"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
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
                                    text: updateClassPage.class_desc
                                }

                                Text {
                                    text: "اولویت نمایش"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
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
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    value: updateClassPage.sort_priority
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
                                    var classObj = {};
                                    classObj["id"] = updateClassPage.class_id;
                                    classObj["class_name"] = classNameTF.text;
                                    classObj["class_desc"] = classDescTF.text;
                                    classObj["sort_priority"] = classSortSB.value;


                                    if(dbMan.classUpdate(classObj))
                                    {
                                        classSuccessDialogId.open();
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
        id: classInfoDialogId
        dialogTitle: "خطا"
        dialogText: "ویرایش اطلاعات کلاس با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: classSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ویرایش اطلاعات کلاس با موفقیت صورت گرفت."
        dialogSuccess: true
        onDialogAccepted: {
            updateClassPage.popStackSignal();
            updateClassPage.classUpdatedSignal();

        }

    }
}
