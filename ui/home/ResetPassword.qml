pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: resetPage
    required property var user;

    signal homeSignal();

    background: Rectangle{anchors.fill: parent; color: "mistyrose"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignLeft
            text: "بازنشانی رمز عبور"
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

                Column{
                    id: centerBox
                    width: parent.width - 20
                    x: 10
                    anchors.margins: 10
                    spacing: 10

                    Item{
                        width: parent.width
                        height: 64
                        Image {
                            source: "qrc:/assets/images/key2.png"
                            height: 64
                            width: 64
                            anchors.centerIn: parent
                            NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                        }
                    }

                    Text {
                        text: resetPage.user["lastname"] + " عزیز لطفا به‌منظور ملاحضات امنیتی رمز‌عبور خود را تغییر دهید.";
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        font.bold: true
                        color: "darkcyan"
                    }


                    // password
                    RowLayout
                    {
                        width: parent.width
                        height: 50

                        Text {
                            text: "رمز عبور کاربر"
                            Layout.preferredWidth:  150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        TextField
                        {
                            id: passwordTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "رمز عبور"
                            echoMode: TextField.Password
                        }
                    }

                    // confirm password
                    RowLayout
                    {
                        width: parent.width
                        height: 50

                        Text {
                            text: "تکرار رمز عبور"
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        TextField
                        {
                            id: confirmTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "تکرار رمز عبور"
                            echoMode: TextField.Password
                        }
                    }

                    Item{
                        width: parent.width
                        height: 20
                    }

                    Button
                    {
                        text: "تایید"
                        width: 200
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                        onClicked:
                        {
                            var user_id = resetPage.user["id"];
                            var password = passwordTF.text;
                            var confirm = confirmTF.text;


                            if(password === confirm)
                            {

                                if(dbMan.changeUserPassword(resetPage.user["id"], password, false)){
                                    successDialogId.open();
                                }
                                else
                                {
                                    var errorString = dbMan.getLastError();
                                    infoDialogId.dialogTitle = "خطا"
                                    infoDialogId.dialogText = errorString
                                    infoDialogId.width = parent.width
                                    infoDialogId.height = 500
                                    infoDialogId.dialogSuccess = false
                                    infoDialogId.open();
                                }

                            }
                            else
                            {
                                infoDialogId.open();
                                return;
                            }
                        }
                    }
                }
            }
        }
    }

    DialogBox.BaseDialog
    {
        id:infoDialogId
        dialogTitle: "خطا"
        dialogText: "عدم تطابق رمز عبور"
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "رمز عبور شما با موفقیت تغییر یافت."
        dialogSuccess: true
        onDialogAccepted: {resetPage.homeSignal();}

    }

}
