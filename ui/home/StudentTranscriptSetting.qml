import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts
import QtQuick.Dialogs

import "./../public" as DialogBox

Page {
    id: studentResultSettingPage

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
    required property StackView appStackView;

    property bool infoVisibility : true;

    ColumnLayout{
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: studentResultSettingPage.branch + " - " + studentResultSettingPage.step
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
            visible: studentResultSettingPage.infoVisibility
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight:  100

            Rectangle
            {
                Layout.preferredWidth: 100
                Layout.preferredHeight: 100
                Layout.alignment: Qt.AlignCenter | Qt.AlignVCenter
                radius: studentResultSettingPage.infoVisibility? 20 : 50


                Image {
                    anchors.fill: parent
                    source:studentResultSettingPage.student_photo
                    clip: true
                    //fillMode: Image.PreserveAspectCrop
                }
            }


            Column{
                Layout.fillWidth: true
                Layout.preferredHeight: 100
                //visible: studentResultSettingPage.infoVisibility

                Text {
                    width: parent.width
                    height: 50
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignLeft
                    text: studentResultSettingPage.student
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
                    text: (studentResultSettingPage.field_based) ? studentResultSettingPage.field + " - " + studentResultSettingPage.base :   studentResultSettingPage.base
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
            visible: studentResultSettingPage.infoVisibility

            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: studentResultSettingPage.class_name + " - " + "سال‌تحصیلی "
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: studentResultSettingPage.period
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

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 25
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "کارنامه دانش‌آموز"
            font.family: "Kalameh"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
            visible: studentResultSettingPage.infoVisibility
        }

        TranscriptSetting{
            Layout.fillWidth:  true
            Layout.fillHeight: true

            student_class_transcript: false // false:student   true:class

            onScrolledDownChanged: {
                if(scrolledDown)
                    studentResultSettingPage.infoVisibility = false;
                else
                    studentResultSettingPage.infoVisibility = true;
            }

            branch : studentResultSettingPage.branch
            step : studentResultSettingPage.step
            field: studentResultSettingPage.field
            base: studentResultSettingPage.base
            field_based: studentResultSettingPage.field_based
            period: studentResultSettingPage.period
            class_name: studentResultSettingPage.class_name
            class_id: studentResultSettingPage.class_id
            appStackView: studentResultSettingPage.appStackView

            student_id: studentResultSettingPage.student_id
        }
    }
}
