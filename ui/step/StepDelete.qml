pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deletePage
    required property int stepId
    required property int stepIndex
    required property string stepName
    required property string branchText
    required property bool field_based
    required property bool numeric_graded

    signal deletedSignal();
    signal popSignal();

    background: Rectangle{anchors.fill: parent; color: "lavenderblush"}

    ColumnLayout
    {
        anchors.fill: parent


        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف دوره"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        Rectangle
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"

            ScrollView
            {
                height: parent.height
                width: parent.width
                contentHeight: stepDeleteCL.height + 100

                Rectangle
                {
                    id: centerBoxSDId
                    color:"snow"
                    width:  (parent.width < 700)? parent.width : 700
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: stepDeleteCL.height + 100

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            id: stepDeleteCL
                            width: parent.width

                            GridLayout
                            {
                                id: stepDeleteGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Text {
                                    Layout.columnSpan: 2
                                    text: "شعبه " + deletePage.branchText
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "darkcyan"
                                }


                                Text {
                                    text: "نام دوره"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    color:"darkcyan"
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text: deletePage.stepName
                                    font.bold: true
                                }
                            }

                            Switch{
                                id: numericGradedSW
                                Layout.preferredHeight:  50
                                text: "ارزیابی مبتنی بر عدد"
                                checked: deletePage.numeric_graded
                                onClicked: checked = deletePage.numeric_graded
                                Layout.alignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                checkable: false
                                font.pixelSize: 16
                                palette.highlight: "darkcyan"
                                palette.text: "black"
                            }

                            Switch{
                                id: fieldsBasedSW
                                Layout.preferredHeight:  50
                                text: "دوره مبتنی بر رشته"
                                checked: deletePage.field_based
                                onClicked: checked = deletePage.field_based
                                Layout.alignment: Qt.AlignLeft
                                palette.highlight: "darkcyan"
                                palette.text: "black"
                                checkable: false
                                font.family: "Kalameh"
                                font.pixelSize: 16
                            }

                            Item
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                            }

                            Button
                            {
                                background: Item{}
                                icon.source: "qrc:/assets/images/trash3.png"
                                icon.width: 64
                                icon.height: 64
                                icon.color:"transparent"
                                Layout.preferredHeight: 64
                                Layout.preferredWidth: 64
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                opacity: 0.5
                                onClicked: stepDelDialog.open();
                                hoverEnabled: true
                                onHoveredChanged:
                                {
                                    if(hovered)
                                    {
                                        this.opacity = 1
                                        this.scale = 1.1
                                    }
                                    else
                                    {
                                        this.opacity = 0.8
                                        this.scale = 1
                                    }
                                }
                            }

                        }

                    }
                }
            }
        }

    }

    DialogBox.BaseDialog
    {
        id: stepDelDialog
        dialogTitle:  "حذف دوره"
        dialogText: "آیا از حذف دوره از سامانه مطمئن می‌باشید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: function(){
            if(dbMan.deleteStep(deletePage.stepId)){
                deletePage.deletedSignal();
                stepSuccessDelDialog.open();
            }
            else
                stepErrorDelDialog.open();
        }
    }

    DialogBox.BaseDialog
    {
        id: stepSuccessDelDialog
        dialogTitle:  "حذف دوره"
        dialogText: "حذف دوره با موفقیت صورت پذیرفت"
        acceptVisible: true
        dialogSuccess: true
        onDialogAccepted: function(){
            stepSuccessDelDialog.close();
            deletePage.popSignal();
        }
    }

    DialogBox.BaseDialog
    {
        id: stepErrorDelDialog
        dialogTitle:  "حذف دوره"
        dialogText: "حذف دوره با مشکل مواجه شد"
        acceptVisible: true
        dialogSuccess: false
    }
}
