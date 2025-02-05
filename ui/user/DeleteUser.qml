pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: userDeletePage;

    property var user;

    required property StackView appStackView;

    signal userDeleted();

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    Item{
        anchors.fill: parent
        anchors.margins: 5

        GridLayout
        {
            id: userGridLayout
            anchors.fill: parent
            columns: 2

            Button
            {
                Layout.preferredHeight: 64
                Layout.preferredWidth: 64
                background: Item{}
                icon.source: "qrc:/assets/images/arrow-right.png"
                icon.width: 64
                icon.height: 64
                icon.color:"transparent"
                opacity: 0.5
                onClicked: userDeletePage.appStackView.pop();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Text {
                text: userDeletePage.user["name"] + " " + userDeletePage.user["lastname"]
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.family: "Kalameh"
                font.pixelSize: 24
                font.bold: true
                color: "mediumvioletred"
            }

            ScrollView
            {
                Layout.columnSpan: 2
                Layout.fillHeight: true
                Layout.fillWidth: true
                contentHeight : userListGW.implicitHeight
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                Rectangle
                {

                    height: parent.height
                    width: (parent.width > 700)? 700 : parent.width;
                    color: "white"
                    radius: 5
                    anchors.horizontalCenter: parent.horizontalCenter

                    Item
                    {
                        id: centerBoxRec
                        anchors.fill: parent
                        anchors.margins : 5

                        GridLayout
                        {
                            id: userListGW
                            width : centerBoxRec.width
                            //height : centerBoxRec.height
                            columns: 2
                            rowSpacing: 20
                            columnSpacing: 10

                            Text
                            {
                                Layout.columnSpan: 2
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                text: "حذف کاربر"
                                font.family: "Kalameh"
                                font.pixelSize: 24
                                font.bold: true
                                color: "crimson"
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                            }

                            Button
                            {
                                Layout.columnSpan: 2
                                Layout.preferredWidth: 64
                                Layout.preferredHeight: 64
                                Layout.alignment: Qt.AlignHCenter
                                background: Item{}
                                icon.source: "qrc:/assets/images/trash3.png"
                                icon.width: 64
                                icon.height: 64
                                icon.color:"transparent"
                                opacity: 0.5
                                onClicked: userDelDialog.open();
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



                            //admin
                            Rectangle
                            {
                                Layout.columnSpan: 2
                                Layout.preferredHeight: 50
                                Layout.fillWidth: true
                                color: "mediumvioletred"
                                visible: (userDeletePage.user["admin"])? true : false;
                                Text {
                                    anchors.fill: parent
                                    text: "ادمین شعبه"
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Qt.AlignHCenter
                                    font.family: "Kalameh"
                                    font.pixelSize: 24
                                    font.bold: true
                                    color: "white"
                                }
                            }

                            Text {
                                text: "نام‌کاربر "
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: userNameId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                text: userDeletePage.user["name"]
                            }

                            Text {
                                text: "نام‌خانوادگی"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: userLastNameId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                text: userDeletePage.user["lastname"]
                            }

                            Text {
                                text: "کدملی"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: userNatidId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                text: userDeletePage.user["nat_id"]
                            }

                            Text {
                                text: "جنسیت"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text {
                                id: userGenderId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                text: userDeletePage.user["gender"]
                            }

                            Text {
                                text: "سمت ‌شغلی"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: userPositionId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                text: userDeletePage.user["job_position"]
                            }

                            Text {
                                text: "شماره‌تماس"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: userTelId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                text: userDeletePage.user["telephone"]
                            }

                        }

                        Item
                        {
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                        }
                    }
                }
            }
        }

    }

    DialogBox.BaseDialog
    {
        id: userDelDialog
        dialogTitle:  "حذف کاربر"
        dialogText: "آیا از حذف کاربر از سامانه مطمئن می‌باشید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: function(){
            if(dbMan.deleteUser(userDeletePage.user["id"]))
                userSuccessDelDialog.open();
            else
                userErrorDelDialog.open();
        }
    }

    DialogBox.BaseDialog
    {
        id: userSuccessDelDialog
        dialogTitle:  "حذف کاربر"
        dialogText: "حذف کاربر با موفقیت صورت پذیرفت"
        acceptVisible: true
        dialogSuccess: true
        onDialogAccepted: userDeletePage.userDeleted();
    }

    DialogBox.BaseDialog
    {
        id: userErrorDelDialog
        dialogTitle:  "حذف کاربر"
        dialogText: "حذف کاربر با مشکل مواجه شد"
        acceptVisible: true
        dialogSuccess: false
    }
}
