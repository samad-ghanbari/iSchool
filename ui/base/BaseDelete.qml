pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: baseDeletePage
    required property int base_id;
    required property string city;
    required property string branch_name;
    required property string step_name;
    required property string field_name;
    required property string base_name;

    signal baseDeleted();
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
            text: "حذف پایه تحصیلی"
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
                contentHeight: centerBoxSDId.height + 100

                Rectangle
                {
                    id: centerBoxSDId
                    color:"snow"
                    width:  (parent.width < 700)? parent.width : 700
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: baseDeleteCL.height + 100

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            id: baseDeleteCL
                            width: parent.width

                            GridLayout
                            {
                                id: baseDeleteGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Text {
                                    text: "شعبه "
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    color: "darkcyan"
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text: baseDeletePage.city + " " + baseDeletePage.branch_name
                                    font.bold: true
                                }



                                Text {
                                    text: "دوره "
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    color: "darkcyan"
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text:baseDeletePage.step_name
                                    font.bold: true
                                }

                                Text {
                                    text: "رشته تحصیلی"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    color: "darkcyan"
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text: baseDeletePage.field_name
                                    font.bold: true
                                }

                                Text {
                                    text: "نام پایه تحصیلی"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    color: "darkcyan"
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text: baseDeletePage.base_name
                                    font.bold: true
                                }
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
                                onClicked: baseDelDialog.open();
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
        id: baseDelDialog
        dialogTitle:  "حذف دوره"
        dialogText: "آیا از حذف دوره از سامانه مطمئن می‌باشید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: function(){
            if(dbMan.deleteBase(baseDeletePage.base_id))
                baseSuccessDelDialog.open();
            else
                baseErrorDelDialog.open();
        }
    }

    DialogBox.BaseDialog
    {
        id: baseSuccessDelDialog
        dialogTitle:  "حذف دوره"
        dialogText: "حذف دوره با موفقیت صورت پذیرفت"
        acceptVisible: true
        dialogSuccess: true
        onDialogAccepted: function(){
            baseDeletePage.baseDeleted();
            baseDeletePage.popSignal();
        }
    }

    DialogBox.BaseDialog
    {
        id: baseErrorDelDialog
        dialogTitle:  "حذف دوره"
        dialogText: "حذف دوره با مشکل مواجه شد"
        acceptVisible: true
        dialogSuccess: false
    }
}
