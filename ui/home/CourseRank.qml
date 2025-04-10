import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import "./../public" as DialogBox

Page {
    id: courseRankPage

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;

    required property int class_id;
    required property string class_name;

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
            text: courseRankPage.branch + " - " + courseRankPage.step
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
                text: (courseRankPage.field_based) ?  courseRankPage.field + " - " + " سال‌تحصیلی "  :  " سال‌تحصیلی "
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: courseRankPage.period
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
            text: (courseRankPage.class_id > 0)? "رتبه‌بندی مبتنی بر دروس دانش‌آموزان " + courseRankPage.base + " - " + courseRankPage.class_name : "رتبه‌بندی مبتنی بر دروس دانش‌آموزان " + courseRankPage.base
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

                CourseRankModule
                {
                    id: centerBox
                    width: parent.width

                    onPopSignal: courseRankPage.popSignal()

                    branch: courseRankPage.branch
                    step: courseRankPage.step
                    base: courseRankPage.base
                    field: courseRankPage.field
                    field_based: courseRankPage.field_based
                    period: courseRankPage.period

                    class_id: courseRankPage.class_id
                    class_name: courseRankPage.class_name
                }
            }
       }
    }
}
