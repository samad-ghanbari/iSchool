import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Class.js" as Methods

Page {
    id: updatePage

    required property int branch_id;
    required property int step_id;
    required property int base_id;
    required property int period_id;
    required property int class_id;
    required property int class_detail_id;
    required property int course_id;
    required property int teacher_id;
    required property string branch_text
    required property string step_text
    required property string base_text
    required property string period_text
    required property string class_name
    required property string class_desc



    signal updatedSignal();
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
            onClicked: updatePage.popStackSignal(); //updatePage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ویرایش اطلاعات کلاس"
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
                                id: classInsertGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Text {
                                    Layout.columnSpan: 2
                                    text: "شعبه " + updatePage.branch_text
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
                                    Layout.columnSpan: 2
                                    text:  updatePage.step_text + " - " + updatePage.base_text
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    elide: Text.ElideRight
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text {
                                    Layout.columnSpan: 2
                                    text: updatePage.period_text
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
                                    Layout.columnSpan: 2
                                    text: "کلاس " + updatePage.class_name + " - " + updatePage.class_desc
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    elide: Text.ElideRight
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }

                                Text {
                                    text: "عنوان درس"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                ComboBox
                                {
                                    id: courseCB
                                    Layout.preferredHeight:  50
                                    Layout.fillWidth: true
                                    editable: false
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    model: ListModel{id: courseCBoxModel}
                                    textRole: "text"
                                    valueRole: "value"
                                    Component.onCompleted:
                                    {
                                        Methods.updateCourseCB(updatePage.step_id, updatePage.base_id, updatePage.period_id);
                                        courseCB.currentIndex = courseCB.indexOfValue(updatePage.course_id)
                                    }
                                }

                                Text {
                                    text: "دبیر "
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                ComboBox
                                {
                                    id: teacherCB
                                    Layout.preferredHeight:  50
                                    Layout.fillWidth: true
                                    editable: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    model: ListModel{id: teacherCBoxModel}
                                    textRole: "text"
                                    valueRole: "value"
                                    Component.onCompleted:
                                    {
                                        Methods.updateTeacherCB(updatePage.branch_id);
                                        teacherCB.currentIndex = teacherCB.indexOfValue(updatePage.teacher_id)
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
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                                onClicked:
                                {
                                    var cdObj = {};
                                    cdObj["id"] = updatePage.class_detail_id;
                                    cdObj["course_id"] = courseCB.currentValue
                                    cdObj["teacher_id"] = teacherCB.currentValue;


                                    if(dbMan.classDetailUpdate(cdObj))
                                    {
                                        successDialogId.open();
                                        updatePage.updatedSignal();

                                    }
                                    else
                                    {
                                        var errorString = dbMan.getLastError();
                                        infoDialogId.dialogText = errorString
                                        infoDialogId.width = parent.width
                                        infoDialogId.height = 500
                                        infoDialogId.dialogSuccess = false

                                        infoDialogId.open();
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
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "ویرایش اطلاعات کلاس با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ویرایش اطلاعات کلاس با موفقیت صورت گرفت."
        dialogSuccess: true
        onDialogAccepted: {
            updatePage.popStackSignal();
            updatePage.updatedSignal();

        }

    }
}
