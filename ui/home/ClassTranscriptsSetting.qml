import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import "./../public" as DialogBox

Page {
    id: classTranscriptsSettingPage

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;
    required property string class_name;
    required property int class_id;
    required property StackView appStackView;

    ColumnLayout
    {
        anchors.fill: parent


        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text:  classTranscriptsSettingPage.branch + " - " + classTranscriptsSettingPage.step
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
        }


        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: (classTranscriptsSettingPage.field_based) ?  classTranscriptsSettingPage.field + " - " +  classTranscriptsSettingPage.base :   classTranscriptsSettingPage.base
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
        }

        Row{
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignHCenter
            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: " سال تحصیلی "
                font.family: "Kalameh"
                font.pixelSize: 20
                font.bold: true
                color: "darkmagenta"
            }
            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: classTranscriptsSettingPage.period
                font.family: "Kalameh"
                font.pixelSize: 20
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
            text: "کارنامه دانش‌آموزان "  + classTranscriptsSettingPage.class_name
            font.family: "Kalameh"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
        }

        TranscriptSetting{
            Layout.fillWidth:  true
            Layout.fillHeight: true

            student_class_transcript: true // false:student   true:class

            branch : classTranscriptsSettingPage.branch
            step : classTranscriptsSettingPage.step
            field: classTranscriptsSettingPage.field
            base: classTranscriptsSettingPage.base
            field_based: classTranscriptsSettingPage.field_based
            period: classTranscriptsSettingPage.period
            class_name: classTranscriptsSettingPage.class_name
            class_id: classTranscriptsSettingPage.class_id
            appStackView: classTranscriptsSettingPage.appStackView

            student_id: -1
        }
    }

}
