import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts
import QtQuick.Dialogs

import "./../public" as DialogBox

Page {
    id: rankPage

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;
    required property bool summer_semester;

    signal popSignal();
    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: rankPage.branch + " - " + rankPage.step
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
                text: (rankPage.field_based) ?  rankPage.field + " - " + " سال‌تحصیلی "  :  " سال‌تحصیلی "
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: rankPage.period
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
            text: "رتبه‌بندی مبتنی بر معدل دانش‌آموزان " + rankPage.base
            font.family: "Kalameh"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
        }

        Flickable{
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentHeight: centerBox.height
            clip: true

            Rectangle{
                width: (parent.width > 700)? 700 : parent.width
                height: centerBox.height + 100
                anchors.horizontalCenter: parent.horizontalCenter
                color: "snow"

                AverageReportModule
                {
                    id: centerBox
                    width: parent.width
                    onPopSignal: rankPage.popSignal();

                    class_base_report: "base"
                    branch: rankPage.branch
                    step: rankPage.step
                    field: rankPage.field
                    base: rankPage.base
                    field_based: rankPage.field_based
                    period: rankPage.period
                    summer_semester: rankPage.summer_semester

                    class_name: ""
                    class_id: -1
                }

            }
        }
    }
}
