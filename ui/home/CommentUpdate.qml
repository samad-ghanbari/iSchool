import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: updatePageId

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;
    required property string class_name;
    required property int class_id;
    required property int student_id;
    required property string student;
    required property string student_photo;

    required property int id;
    required property string jDate;
    required property string advisor;
    required property string comment;
    required property int semester;

    signal popSignal();
    signal updatedSignal();

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent


        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: updatePageId.branch + " - " + updatePageId.step
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight:  100

            Image {
                source:updatePageId.student_photo
                Layout.preferredWidth: 100
                Layout.preferredHeight: 100
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }
            Column{
                Layout.fillWidth: true
                Layout.preferredHeight: 100

                Text {
                    width: parent.width
                    height: 50
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignLeft
                    text: updatePageId.student
                    font.family: "Kalameh"
                    font.pixelSize: 20
                    font.bold: true
                    color: "darkmagenta"
                }

                Text {
                    width: parent.width
                    height: 50
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignLeft
                    text: (updatePageId.field_based) ? updatePageId.field + " - " + updatePageId.base :   updatePageId.base
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                }
            }
        }
        Row{
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignHCenter

            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: updatePageId.class_name + " - " + "سال‌تحصیلی "
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: updatePageId.period
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
        }

        Rectangle{
            Layout.preferredHeight: 1
            Layout.fillWidth: true
            //Layout.maximumWidth: 700
            Layout.alignment: Qt.AlignHCenter
            color: "darkgray"
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight:  50
            Layout.alignment: Qt.AlignRight

            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "ویرایش نظر مشاور"
                font.family: "Kalameh"
                font.pixelSize: 20
                font.bold: true
                color: "mediumvioletred"
            }
        }


        Flickable
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            contentHeight: centerBox.height

            Rectangle{
                id: centerBox
                height: centerCol.implicitHeight
                width: (parent.width > 700)? 700 : parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                color: "snow"

                Column{
                    id: centerCol
                    width: parent.width
                    spacing: 10

                    //date-advisor-comment
                    Image {
                        source: "qrc:/assets/images/edit.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                        height:  64
                        width:  64
                        anchors.margins: 20
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }

                    RowLayout{
                        width: parent.width
                        height: 50

                        Text {
                            text: "تاریخ: "
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }

                        TextField
                        {
                            id: dateTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "فرمت تاریخ 1403/12/20"
                            text: updatePageId.jDate

                            property var dateRegex: /^\d{4}\/\d{2}\/\d{2}$/
                            onTextChanged: {
                                if (!dateRegex.test(dateTF.text)) {
                                    dateTF.color = "red"; // Invalid input
                                } else {
                                    dateTF.color = "black"; // Valid input
                                    var sem = dbMan.getDateSemester(dateTF.text);
                                    semesterCB.currentIndex = semesterCB.indexOfValue(sem)
                                }
                            }
                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "نیمسال: "
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }

                        ComboBox
                        {
                            id: semesterCB
                            Layout.preferredHeight:  50
                            Layout.fillWidth: true
                            editable: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ListModel{id: semesterModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                semesterModel.append({"text": "نیمسال اول", "value": 1 });
                                semesterModel.append({"text": "نیمسال دوم", "value": 2 });
                                semesterModel.append({"text": "نیمسال تابستان", "value": 3 });

                                semesterCB.currentIndex = semesterCB.indexOfValue(updatePageId.semester)
                            }
                        }

                    }


                    RowLayout{
                        width: parent.width
                        height: 50

                        Text {
                            text: "مشاور: "
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }

                        TextField
                        {
                            id: advisorTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "نام مشاور"
                            text: updatePageId.advisor;
                        }
                    }

                    Text {
                        text: "نظر مشاور: "
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                    }
                    TextArea{
                        id: commentTA
                        width: parent.width - 100
                        horizontalAlignment: Qt.AlignLeft
                        anchors.right: parent.right
                        height: contentHeight + 100
                        readOnly: false
                        font.pixelSize: 20
                        font.bold: false
                        font.family: "Zar"
                        wrapMode: TextArea.Wrap
                        text: updatePageId.comment
                        background: Rectangle {
                            color: "#f3f3f3"
                            border.width: 1
                            radius: 8
                        }
                    }

                    Item{height: 20; width: parent.width; }

                    RowLayout{

                        width: parent.width
                        height: 50

                        Item{Layout.fillWidth: true;  Layout.preferredHeight: 50; }

                        Button
                        {
                            text: "انصراف"
                            Layout.preferredWidth: 200
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "indianred"}
                            onClicked: updatePageId.popSignal();
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
                            onClicked:{
                                let jdate = dateTF.text;
                                if (!dateTF.dateRegex.test(dateTF.text)) {
                                    dateTF.color = "red"; // Invalid input
                                    return;
                                }

                                let advisor = advisorTF.text;
                                let comment = commentTA.text;

                                let student_id = updatePageId.student_id
                                let class_id = updatePageId.class_id
                                let semester = semesterCB.currentValue

                                if(dbMan.updateComment(id, jdate, semester, advisor, comment))
                                {
                                    updatePageId.updatedSignal();
                                    updatePageId.popSignal();
                                }
                                else
                                    errorDialogId.open();


                            }
                        }
                    }

                    Item{ height: 20; width: parent.width; }
                }


            }
        }
    }


    DialogBox.BaseDialog
    {
        id: errorDialogId
        dialogTitle: "خطا"
        dialogText: "عملیات با خطا مواجه شد."
        dialogSuccess: false
    }
}
