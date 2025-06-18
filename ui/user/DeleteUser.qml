pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deletePage;

    required property int user_id;
    required property string name;
    required property string lastname;
    required property string gender;
    required property string nat_id;
    required property string job_position;
    required property string telephone;
    required property bool enabled;
    required property bool admin;
    required property bool superadmin;

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
            horizontalAlignment: Qt.AlignLeft
            text: "حذف کاربر از سامانه"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        Flickable{
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentHeight: centerBox.implicitHeight

            Rectangle
            {
                width: (parent.width > 700)? 700 : parent.width
                height:  centerBox.implicitHeight + 100
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"
                anchors.margins: 10

                Column{
                    id: centerBox
                    width : parent.width
                    anchors.margins: 10

                    Item{
                        width: parent.width
                        height: 64
                        Image {
                            source: "qrc:/assets/images/trash.png"
                            height: 64
                            width: 64
                            anchors.centerIn: parent
                            NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                        }
                    }

                    // superadmin-admin-enabled
                    RowLayout
                    {
                        width: parent.width
                        height: 50

                        //admin
                        Rectangle
                        {
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                            Layout.margins: 0
                            color: "mediumvioletred"
                            visible: (deletePage.superadmin)? true : false;
                            Text {
                                anchors.fill: parent
                                text: "کاربر سوپرادمین"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter
                                font.family: "Kalameh"
                                font.pixelSize: 18
                                font.bold: true
                                color: "white"
                            }
                        }
                        Rectangle
                        {
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                            Layout.margins: 0
                            color: "mediumvioletred"
                            visible: (deletePage.admin)? true : false;
                            Text {
                                anchors.fill: parent
                                text: "کاربر ادمین"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter
                                font.family: "Kalameh"
                                font.pixelSize: 18
                                font.bold: true
                                color: "white"
                            }
                        }
                        Rectangle
                        {
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                            Layout.margins: 0
                            color: (deletePage.enabled)? "forestgreen" : "crimson"
                            Text
                            {
                                anchors.fill: parent
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter
                                font.family: "Kalameh"
                                font.pixelSize: 18
                                color: "white"
                                text: (deletePage.enabled)? "فعال" : "غیرفعال"
                            }
                        }

                    }

                    // name
                    RowLayout
                    {
                        width: parent.width
                        height: 50

                        Text {
                            text: "نام‌کاربر "
                            Layout.preferredWidth: 150
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
                            text: deletePage.name
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }
                    }

                    // lastname
                    RowLayout
                    {
                        width: parent.width
                        height: 50

                        Text {
                            text: "نام‌خانوادگی"
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        Text
                        {
                            text: deletePage.lastname
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }
                    }

                    // gender
                    RowLayout
                    {
                        width: parent.width
                        height: 50

                        Text {
                            text: "جنسیت"
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        Text {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text: deletePage.gender
                        }

                    }

                    // nat_id
                    RowLayout
                    {
                        width: parent.width
                        height: 50

                        Text {
                            text: "کدملی"
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        Text
                        {
                            text: deletePage.nat_id
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }
                    }

                    // job_position
                    RowLayout
                    {
                        width: parent.width
                        height: 50

                        Text {
                            text: "پست کاربر"
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        Text
                        {
                            text: deletePage.job_position
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }
                    }

                    // telephone
                    RowLayout
                    {
                        width: parent.width
                        height: 50
                        Text {
                            text: "شماره تماس"
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        Text
                        {
                            text: deletePage.telephone
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }
                    }


                    Item{
                        width: parent.width
                        height: 20
                    }

                    Button
                    {
                        text: "حذف کاربر"
                        width: 200
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
                        onClicked: userDelDialog.open();
                    }

                    Item{
                        width: parent.width
                        height: 20
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
            if(dbMan.deleteUser(deletePage.user_id))
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
        onDialogAccepted: {
            deletePage.deletedSignal();
            deletePage.popSignal();
        }
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
