pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deletedPage
    property int branchId
    property int branchIndex
    property string branchCity
    property string branchName
    property string branchDescription
    property string branchAddress

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
            text: "حذف شعبه"
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
                contentHeight: centerBoxBDId.height + 100

                Rectangle
                {
                    id: centerBoxBDId
                    color:"snow"
                    width:  (parent.width < 700)? parent.width : 700
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: branchDeleteCL.height

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            id: branchDeleteCL
                            width: parent.width

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
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "darkcyan"
                                }
                                Text
                                {
                                    id: branchCityTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text: deletedPage.branchCity

                                }

                                Text {
                                    text: "شعبه"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "darkcyan"
                                }
                                Text
                                {
                                    id: branchNameTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text: deletedPage.branchName
                                }

                                Text {
                                    text: "آدرس"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "darkcyan"
                                }
                                Text
                                {
                                    id: branchAddressTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    text: deletedPage.branchAddress
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
                                Layout.preferredWidth: 64
                                Layout.preferredHeight:  64
                                font.pixelSize: 16
                                font.family: "Kalameh"
                                display: AbstractButton.TextUnderIcon
                                icon.source: "qrc:/assets/images/trash3.png"
                                icon.color:"transparent"
                                icon.width: 64
                                icon.height: 64
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
            if(dbMan.deleteBranch(deletedPage.branchId)){
                deletedPage.deletedSignal();
                branchSuccessDelDialog.open();
            }
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
            branchSuccessDelDialog.close();
            deletedPage.popSignal();
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
