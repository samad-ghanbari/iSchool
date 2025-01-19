pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public"

Page {
    id: deletePage
    required property int id;
    required property string branch
    required property string step
    required property StackView appStackView

    required property string field_name
    required property int sort_priority


    signal deletedSignal();


    background: Rectangle{anchors.fill: parent; color: "lavenderblush"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف رشته تحصیلی"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Image {
            source: "qrc:/assets/images/trash.png"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight:  64
            Layout.preferredWidth:  64
            Layout.margins: 20
            NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
        }

        Flickable{
            Layout.fillHeight: true
            Layout.fillWidth: true
            contentHeight: centerBox.implicitHeight

            Rectangle
            {
                color:"snow"
                width:  (parent.width < 700)? parent.width : 700
                height: centerBox.implicitHeight + 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: 10
                radius: 10
                Column
                {
                    id: centerBox
                    width: parent.width
                    anchors.margins: 10


                    GridLayout
                    {
                        columns: 2
                        rowSpacing: 1
                        width:  parent.width
                        height: 250

                        Text {
                            Layout.columnSpan: 2
                            text: "شعبه " + deletePage.branch + " - " +  deletePage.step
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
                            text: "نام رشته تحصیلی"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        Text
                        {
                            id: fieldTF
                            text: deletePage.field_name
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }



                        Text {
                            text: "اولویت نمایش"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        Text
                        {
                            id: sortSB
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50

                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:  deletePage.sort_priority
                        }
                    }

                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    Button
                    {
                        text: "تایید"
                        width: 200
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
                        onClicked:
                        {
                            delDialog.open();
                        }
                    }

                    Item
                    {
                        width: parent.width
                        height: 10
                    }
                }
            }
        }


    }


    BaseDialog
    {
        id: delDialog
        dialogTitle:  "حذف رشته"
        dialogText: "آیا از حذف رشته از سامانه مطمئن می‌باشید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: function(){
            if(dbMan.deleteField(deletePage.id)){
                delDialog.close();
                successDelDialog.open();
            }
            else{
                delDialog.close();
                infoDialog.open();
            }
        }
    }

    BaseDialog
    {
        id: successDelDialog
        dialogTitle:  "موفق"
        dialogText: "عملیات با موفقیت انجام شد."
        acceptVisible: true
        dialogSuccess: true
        onDialogAccepted: function(){
            successDelDialog.close();
            deletePage.deletedSignal();
            deletePage.appStackView.pop();
        }
    }

    BaseDialog
    {
        id: infoDialog
        dialogTitle:  "خطا"
        dialogText: "انجام عملیات با مشکل مواجه شد."
        acceptVisible: true
        dialogSuccess: false
    }
}
