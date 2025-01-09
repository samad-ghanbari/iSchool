pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: baseDeletePage
    required property int baseIndex
    required property var model;

    required property StackView appStackView;

    signal baseDeleted(var index);

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
            font.family: "B Yekan"
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
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: "شعبه " + baseDeletePage.model.city + " " + baseDeletePage.model.branch_name
                                    font.bold: true
                                }



                                Text {
                                    text: "دوره "
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text:{
                                        var temp = baseDeletePage.model.step_name;
                                        if(temp.includes("دوره"))
                                        return temp;
                                        else
                                        return "دوره " + temp;
                                    }
                                    font.bold: true
                                }


                                Text {
                                    text: "نام پایه تحصیلی"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                }
                                Text
                                {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: baseDeletePage.model.base_name
                                    font.bold: true
                                }

                                Text {
                                    Layout.columnSpan: 2
                                    text: "رشته " + baseDeletePage.model.field_name
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "royalblue"
                                    visible: baseDeletePage.model.field_based
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
            if(dbMan.deleteBase(baseDeletePage.model.id))
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
            baseDeletePage.baseDeleted(baseDeletePage.baseIndex);
            baseDeletePage.appStackView.pop();
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
