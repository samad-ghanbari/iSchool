pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public"  as DialogBox

import "User.js" as UserMethods

Page {
    id: userPage
    property var userId;
    property var user: dbMan.getUser(userPage.userId)

    required property StackView appStackView;

    signal userDeleted();
    signal userUpdated();

    function updateUser(User)
    {
        user = User;
        // permissions
        UserMethods.updateReadStepModel();
        UserMethods.updateReadStudyBaseModel();
        UserMethods.updateWriteStepModel();
        UserMethods.updateWriteStudyBaseModel();
    }

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
                id: userListBackBtnId
                Layout.preferredHeight: 64
                Layout.preferredWidth: 64
                background: Item{}
                icon.source: "qrc:/assets/images/arrow-right.png"
                icon.width: 64
                icon.height: 64
                opacity: 0.5
                onClicked: userPage.appStackView.pop();
                hoverEnabled: true
                onHoveredChanged: userListBackBtnId.opacity=(hovered)? 1 : 0.5;
            }
            Text {
                id: userListTitle
                text: "کاربر سامانه"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.family: "B Yekan"
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

                            RowLayout
                            {
                                Layout.columnSpan: 2
                                Layout.preferredHeight: 64

                                Button
                                {
                                    background: Item{}
                                    icon.source: "qrc:/assets/images/edit.png"
                                    icon.width: 64
                                    icon.height: 64
                                    opacity: 0.5
                                    onClicked: userPage.appStackView.push(userModifyComponent, {user: userPage.user})
                                    hoverEnabled: true
                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                }
                                Button
                                {
                                    background: Item{}
                                    icon.source: "qrc:/assets/images/key1.png"
                                    icon.width: 64
                                    icon.height: 64
                                    opacity: 0.5
                                    onClicked:
                                    {
                                        changePasswordInitialDialog.textFieldValue = ""
                                        changePasswordInitialDialog.open();
                                    }
                                    hoverEnabled: true
                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                }
                                Item
                                {
                                    Layout.fillWidth: true
                                }
                                Button
                                {
                                    background: Item{}
                                    icon.source: "qrc:/assets/images/trash.png"
                                    icon.width: 64
                                    icon.height: 64
                                    opacity: 0.5
                                    onClicked: userPage.appStackView.push(userDeleteComponent, {user: userPage.user})
                                    hoverEnabled: true
                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                }
                            }

                            //admin
                            Rectangle
                            {
                                Layout.preferredHeight: 50
                                Layout.columnSpan: 2
                                Layout.fillWidth: true
                                Layout.margins: 0
                                color: "mediumvioletred"
                                visible: (userPage.user["admin"])? true : false;
                                Text {
                                    anchors.fill: parent
                                    text: "ادمین سامانه"
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Qt.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 24
                                    font.bold: true
                                    color: "white"
                                }
                            }
                            Rectangle
                            {
                                Layout.preferredHeight: 50
                                Layout.columnSpan: 2
                                Layout.fillWidth: true
                                Layout.margins: 0
                                color: (userPage.user["enabled"])? "forestgreen" : "crimson"
                                Text
                                {
                                    anchors.fill: parent
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Qt.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 24
                                    color: "white"
                                    text: (userPage.user["enabled"])? "فعال" : "غیرفعال"
                                }
                            }




                            Text {
                                text: "نام‌کاربر "
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: userNameId
                                text: userPage.user["name"]
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16

                            }

                            Text {
                                text: "نام‌خانوادگی"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: userLastNameId
                                text: userPage.user["lastname"]
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16
                            }

                            Text {
                                text: "جنسیت"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
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
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                text: userPage.user["gender"]
                            }


                            Text {
                                text: "کدملی"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: userNatidId
                                text: userPage.user["nat_id"]
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16
                            }

                            Text {
                                text: "پست کاربر"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: userPositionId
                                text: userPage.user["job_position"]
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16
                            }

                            Text {
                                text: "شماره تماس"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: userTelId
                                text: userPage.user["telephone"]
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16
                            }


                            //PERMISSION
                            GridLayout
                            {
                                id: userpermid
                                Layout.columnSpan: 2
                                Layout.fillWidth: true
                                columns: 2
                                rows: 11
                                rowSpacing: 20
                                columnSpacing: 10

                                // READ
                                Text {
                                    text: "دسترسی‌های مشاهده"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 24
                                    font.bold: true
                                    color: "royalblue"
                                }

                                Rectangle
                                {
                                    Layout.columnSpan: 2
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 1
                                    color: "dodgerblue"
                                }

                                Text {
                                    text: "دوره"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 24
                                    font.bold: true
                                    color: "royalblue"
                                }
                                ListView
                                {
                                    id: userReadStepLV
                                    spacing: 20
                                    Layout.columnSpan: 2
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: userReadStepLV.count*60
                                    model: ListModel{id: readStepModel;}
                                    delegate:
                                    Rectangle
                                    {
                                        id: recDelegate
                                        required property var model;
                                        width: userReadStepLV.width;
                                        height: 40;
                                        color: "white"
                                        Text
                                        {
                                            anchors.fill: parent
                                            anchors.leftMargin: 40
                                            text: recDelegate.model.City +" - "+  recDelegate.model.Branch_name + " - " + recDelegate.model.Step_name
                                            font.family: "B Yekan"
                                            font.pixelSize: 16
                                        }
                                    }

                                    Component.onCompleted:
                                    {
                                        UserMethods.updateReadStepModel();
                                    }
                                }

                                Text {
                                    text: "پایه تحصیلی"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 24
                                    font.bold: true
                                    color: "royalblue"
                                }
                                ListView
                                {
                                    id: userReadStudyBaseLV
                                    spacing: 20
                                    Layout.columnSpan: 2
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: userReadStudyBaseLV.count*60
                                    model: ListModel{id: readStudyBaseModel;}
                                    delegate:
                                    Rectangle
                                    {
                                        id: recBaseDelegate
                                        required property var model;
                                        width: userReadStudyBaseLV.width;
                                        height: 40;
                                        color: "white"
                                        Text
                                        {

                                            anchors.fill: parent
                                            anchors.leftMargin: 40
                                            text:  recBaseDelegate.model.City + " - " + recBaseDelegate.model.Branch_name +" - "+ recBaseDelegate.model.Study_base
                                            font.family: "B Yekan"
                                            font.pixelSize: 16
                                        }
                                    }

                                    Component.onCompleted:
                                    {
                                        UserMethods.updateReadStudyBaseModel();
                                    }
                                }


                                //write
                                Text {
                                    text: "دسترسی‌های ویرایش"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 24
                                    font.bold: true
                                    color: "royalblue"
                                }

                                Rectangle
                                {
                                    Layout.columnSpan: 2
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 1
                                    color: "dodgerblue"
                                }

                                Text {
                                    text: "دوره"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 24
                                    font.bold: true
                                    color: "royalblue"
                                }
                                ListView
                                {
                                    id: userWriteStepLV
                                    spacing: 20
                                    Layout.columnSpan: 2
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: userWriteStepLV.count*60
                                    model: ListModel{id: writeStepModel;}
                                    delegate:
                                    Rectangle
                                    {
                                        id: recWrDelegate
                                        required property var model;
                                        width: userWriteStepLV.width;
                                        height: 40;
                                        color: "white"
                                        Text
                                        {
                                            anchors.fill: parent
                                            anchors.leftMargin: 40
                                            text: recWrDelegate.model.City +" - "+  recWrDelegate.model.Branch_name + " - " + recWrDelegate.model.Step_name
                                            font.family: "B Yekan"
                                            font.pixelSize: 16
                                        }
                                    }

                                    Component.onCompleted:
                                    {
                                        UserMethods.updateWriteStepModel();
                                    }
                                }

                                Text {
                                    text: "پایه تحصیلی"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 24
                                    font.bold: true
                                    color: "royalblue"
                                }
                                ListView
                                {
                                    id: userWriteStudyBaseLV
                                    spacing: 20
                                    Layout.columnSpan: 2
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: (userWriteStudyBaseLV.count)*60
                                    model: ListModel{id: writeStudyBaseModel;}
                                    delegate:
                                    Rectangle
                                    {
                                        id: recWrBaseDel
                                        required property var model;
                                        width: userWriteStudyBaseLV.width;
                                        height: 40;
                                        color: "white"
                                        Text
                                        {
                                            anchors.fill: parent
                                            anchors.leftMargin: 40
                                            text:  recWrBaseDel.model.City + " - " + recWrBaseDel.model.Branch_name +" - "+ recWrBaseDel.model.Study_base
                                            font.family: "B Yekan"
                                            font.pixelSize: 16
                                        }
                                    }

                                    Component.onCompleted:
                                    {
                                        UserMethods.updateWriteStudyBaseModel();
                                    }
                                }




                            }

                        }

                    }
                }
            }
        }
    }

    //password
    DialogBox.BaseDialog {
        id: changePasswordInitialDialog
        dialogTitle: "رمز عبور";
        dialogText: "برای ادامه فرآیند رمز عبور خود را وارد نمایید."
        acceptVisible: true
        rejectVisible: true
        textFieldVisible: true
        dialogSuccess : true;
        textFieldEcho : TextField.Password
        textFieldValue: "";
        onDialogAccepted : {
            var userPass = changePasswordInitialDialog.textFieldValue;
            if(dbMan.verifyUserPassword(userPass))
            {
                changePasswordDialog.open();
                changePasswordDialog.textField1Value = ""
                changePasswordDialog.textField2Value = ""
            }
            else
            {
                changePasswordErrorDialog.open();
            }
        }
    }
    DialogBox.BaseDialog {
        id: changePasswordErrorDialog
        dialogTitle: "رمز عبور";
        dialogText: "تغییر رمز عبور کاربر با مشکل مواجه شد."
        acceptVisible: true
        rejectVisible: false
        textFieldVisible: false
        dialogSuccess : false;
    }
    DialogBox.BaseDialog {
        id: changePasswordSuccessDialog
        dialogTitle: "رمز عبور";
        dialogText: "تغییر رمز عبور کاربر با موفقیت انجام شد."
        acceptVisible: true
        rejectVisible: false
        textFieldVisible: false
        dialogSuccess : true;
        onDialogAccepted: changePasswordSuccessDialog.close();
    }
    ChangePassDialogBox {
        id: changePasswordDialog
        textField1Value: ""
        textField2Value: ""

        onDialogAccepted: {
            var password = changePasswordDialog.textField1Value;
            var confirmPassword = changePasswordDialog.textField2Value;
            var ok = false
            if(password === confirmPassword)
            {
                if(dbMan.changeUserPassword(userPage.user["id"], password))
                    ok = true
                else
                    ok = false;
            }

            if(ok)
                changePasswordSuccessDialog.open();
            else
                changePasswordErrorDialog.open();

            changePasswordDialog.close();

        }
    }


    Component
    {
        id: userModifyComponent
        UserModify{
            appStackView: userPage.appStackView;
            onUserUpdated:()=>
            {
                //userPage.updateUser(user);
                userPage.appStackView.pop();
                userPage.userUpdated(); //user
            }
        }
    }

    Component
    {
        id: userDeleteComponent
        UserDelete{
            appStackView: userPage.appStackView;
            onUserDeleted: userPage.userDeleted();
        }
    }

}

