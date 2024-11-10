pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deleteBranchPage
    property int branchId
    property int branchIndex
    property string branchCity
    property string branchName
    property string branchDescription
    property string branchAddress

    required property StackView appStackView;

    signal branchDeleted(var index);

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    GridLayout
    {
        anchors.fill: parent
        columns:2

        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/arrow-right.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: deleteBranchPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف شعبه"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "lavenderblush"

            ScrollView
            {
                height: parent.height
                width: parent.width
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                Rectangle
                {
                    id: centerBoxBDId
                    color:"snow"
                    width:  (parent.width < 700)? parent.width : 700
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: parent.height

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            id: branchDeleteCL
                            width: parent.width
                            Text
                            {
                                text: "حذف"
                                font.family: "B Yekan"
                                font.pixelSize: 24
                                font.bold: true
                                color: "crimson"
                                Layout.preferredWidth: parent.width
                                Layout.preferredHeight: 50
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                            }
                            Button
                            {
                                background: Item{}
                                icon.source: "qrc:/assets/images/trash3.png"
                                icon.width: 64
                                icon.height: 64
                                Layout.preferredHeight: 64
                                Layout.preferredWidth: 64
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                opacity: 0.5
                                onClicked: branchDelDialog.open();
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

                            GridLayout
                            {
                                id: branchDeleteGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width


                                Text {
                                    text: "شهر"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    id: branchCityTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: deleteBranchPage.branchCity

                                }

                                Text {
                                    text: "شعبه"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    id: branchNameTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: deleteBranchPage.branchName
                                }

                                Text {
                                    text: "آدرس"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    id: branchAddressTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: deleteBranchPage.branchAddress
                                }


                            }

                            Item
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                            }
                        }

                    }
                }
            }
        }

    }

    DialogBox.BaseDialog
    {
        id: branchDelDialog
        dialogTitle:  "حذف شعبه"
        dialogText: "آیا از حذف شعبه از سامانه مطمئن می‌باشید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: function(){
            if(dbMan.deleteBranch(deleteBranchPage.branchId))
                branchSuccessDelDialog.open();
            else
                branchErrorDelDialog.open();
        }
    }

    DialogBox.BaseDialog
    {
        id: branchSuccessDelDialog
        dialogTitle:  "حذف شعبه"
        dialogText: "حذف شعبه با موفقیت صورت پذیرفت"
        acceptVisible: true
        dialogSuccess: true
        onDialogAccepted: function(){
            deleteBranchPage.appStackView.pop();
            deleteBranchPage.branchDeleted(deleteBranchPage.branchIndex);
        }
    }

    DialogBox.BaseDialog
    {
        id: branchErrorDelDialog
        dialogTitle:  "حذف شعبه"
        dialogText: "حذف شعبه با مشکل مواجه شد"
        acceptVisible: true
        dialogSuccess: false
    }
}
