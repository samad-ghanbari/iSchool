pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: periodDeletePage

    property int periodIndex
    property var model

    required property StackView appStackView;

    signal periodDeleted(var index);

    background: Rectangle{anchors.fill: parent; color: "lavenderblush"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف سال تحصیلی"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
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
                contentHeight: centerBoxSDId.height + 100

                Rectangle
                {
                    id: centerBoxSDId
                    color:"snow"
                    width:  (parent.width < 700)? parent.width : 700
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: periodDeleteCL.height + 100

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            id: periodDeleteCL
                            width: parent.width

                            GridLayout
                            {
                                id: periodDeleteGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Text {
                                    text: "شعبه"
                                    Layout.minimumWidth: 200
                                    Layout.maximumWidth: 200
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text: periodDeletePage.model.city + " - " + periodDeletePage.model.branch_name
                                    font.bold: true
                                }

                                Text {
                                    text: "دوره "
                                    Layout.minimumWidth: 200
                                    Layout.maximumWidth: 200
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text: periodDeletePage.model.step_name
                                    font.bold: true
                                }


                                Text {
                                    text: "سال تحصیلی"
                                    Layout.minimumWidth: 200
                                    Layout.maximumWidth: 200
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text: periodDeletePage.model.period_name
                                    font.bold: true
                                }

                                Text {
                                    text: "وضعیت سال تحصیلی"
                                    Layout.minimumWidth: 200
                                    Layout.maximumWidth: 200
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text: (periodDeletePage.model.passed)? "سال تحصیلی مختومه" : "سال تحصیلی جاری"
                                    font.bold: true
                                }

                            }

                            Item
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
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
                                onClicked: periodDelDialog.open();
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
        id: periodDelDialog
        dialogTitle:  "حذف دوره"
        dialogText: "آیا از حذف دوره از سامانه مطمئن می‌باشید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: function(){
            if(dbMan.periodDelete(periodDeletePage.model.period_id))
                periodSuccessDelDialog.open();
            else
                periodErrorDelDialog.open();
        }
    }

    DialogBox.BaseDialog
    {
        id: periodSuccessDelDialog
        dialogTitle:  "حذف دوره"
        dialogText: "حذف دوره با موفقیت صورت پذیرفت"
        acceptVisible: true
        dialogSuccess: true
        onDialogAccepted: function(){
            periodDeletePage.periodDeleted(periodDeletePage.periodIndex);
            periodDeletePage.appStackView.pop();
        }
    }

    DialogBox.BaseDialog
    {
        id: periodErrorDelDialog
        dialogTitle:  "خطا"
        dialogText: "حذف سال تحصیلی با مشکل مواجه شد"
        acceptVisible: true
        dialogSuccess: false
    }
}
