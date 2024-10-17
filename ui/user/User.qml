import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public"

import "User.js" as UserMethods

Page {
    id: userPage
    property var userId;
    property var user: dbMan.getUserJson(userId)

    function updateUser(User)
    {
        user = User;
        UserMethods.updateAccessPermission();
        userWidget.updatePage(User)
    }

    function userDeleted()
    {
        homeStackViewId.pop();

    }

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        RowLayout
        {
            width: parent.width
            Button
            {
                background: Item{}
                icon.source: "qrc:/Assets/images/arrow-right.png"
                icon.width: 64
                icon.height: 64
                opacity: 0.5
                onClicked: homeStackViewId.pop();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Item
            {
                Layout.fillWidth: true
            }

            Text {
                id: newUserTitle
                text: user["name"] + " " + user["lastname"]
                Layout.alignment: Qt.AlignHCenter
                font.family: yekanFont.font.family
                font.pixelSize: 24
                font.bold: true
                color: "mediumvioletred"
                style: Text.Outline
                styleColor: "white"
            }

            Item
            {
                Layout.fillWidth: true
            }
        }

        ScrollView
        {
            id: userSV
            Layout.fillHeight: true
            Layout.fillWidth: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            PaddedRectangle
            {
                id: userBox
                color:"white"
                width:  (parent.width < 700)? parent.width : 700
                anchors.horizontalCenter: parent.horizontalCenter
                implicitHeight: userManColId.height
                padding: -10
                radius: 10

                ColumnLayout
                {
                    id: userManColId
                    width: parent.width

                    RowLayout
                    {
                        width: parent.width
                        Button
                        {
                            background: Item{}
                            icon.source: "qrc:/Assets/images/edit.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked: homeStackViewId.push(userModifyComponent, {user: user})
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                        Button
                        {
                            background: Item{}
                            icon.source: "qrc:/Assets/images/key1.png"
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
                            icon.source: "qrc:/Assets/images/trash.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked: homeStackViewId.push(userDeleteComponent, {user: user})
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }


                    }
                    //id, name, lastname, nat_id, password, email, job_position, telephone, access, write_permission, enabled, admin, gender
                    GridLayout
                    {
                        id: userBasicsId
                        columns: 2
                        rows: 9
                        rowSpacing: 20
                        columnSpacing: 10
                        width: userBox.width

                        //admin
                        Rectangle
                        {
                            Layout.columnSpan: 2
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                            color: "mediumvioletred"
                            visible: (user["admin"])? true : false;
                            Text {
                                anchors.fill: parent
                                text: "ادمین سامانه"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter
                                font.family: yekanFont.font.family
                                font.pixelSize: 24
                                font.bold: true
                                color: "white"
                            }
                        }

                        Rectangle
                        {
                            Layout.columnSpan: 2
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                            color: (user["enabled"])? "forestgreen" : "crimson"
                            Text
                            {
                                anchors.fill: parent
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter
                                font.family: yekanFont.font.family
                                font.pixelSize: 24
                                color: "white"
                                text: (user["enabled"])? "فعال" : "غیرفعال"
                            }
                        }


                        Text {
                            text: "نام‌کاربر "
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
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
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["name"]
                        }

                        Text {
                            text: "نام‌خانوادگی"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
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
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["lastname"]
                        }

                        Text {
                            text: "کدملی"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
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
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["nat_id"]
                        }

                        Text {
                            text: "جنسیت"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
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
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["gender"]
                        }

                        Text {
                            text: "پست‌کاربر"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
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
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["job_position"]
                        }

                        Text {
                            text: "شماره‌تماس"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
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
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["telephone"]
                        }

                    }

                    GridLayout
                    {
                        id: userAccPermId
                        columns: 2
                        rows: 16
                        rowSpacing: 20
                        columnSpacing: 10
                        width: parent.width


                        // access
                        Text {
                            text: "دسترسی‌های کاربر"
                            Layout.columnSpan: 2
                            Layout.alignment: Qt.AlignHCenter
                            font.family: yekanFont.font.family
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

                        // branch
                        Text {
                            text: "دسترسی‌ به شعبه‌ها"
                            Layout.columnSpan: 2
                            Layout.alignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 18
                            font.bold: true
                            color: "royalblue"
                        }

                        ListView
                        {
                            id: userAccessBrancheLV
                            spacing: 20
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            Layout.maximumHeight: 200
                            Layout.minimumHeight: 100
                            model: ListModel{id: userBranchListModel;}
                            delegate:
                                Rectangle
                            {
                                width: userBox.width
                                height: 40;
                                color: "white"
                                Text
                                {
                                    anchors.fill: parent
                                    anchors.leftMargin: 40
                                    text: city + " - " + branch_name
                                    font.family: yekanFont.font.family
                                    font.pixelSize: 16
                                }
                            }

                            Component.onCompleted:
                            {
                                UserMethods.accessBranchModel();
                            }
                        }

                        // step
                        Text {
                            text: "دسترسی‌ به دوره‌ها"
                            Layout.columnSpan: 2
                            Layout.alignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 18
                            font.bold: true
                            color: "royalblue"
                        }
                        ListView
                        {
                            id: userAccessStepLV
                            spacing: 20
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            Layout.maximumHeight: 200
                            Layout.minimumHeight: 100
                            model: ListModel{id: userStepListModel;}
                            delegate:
                                Rectangle
                            {
                                width: userBox.width;
                                height: 40;
                                color: "white"
                                Text
                                {
                                    anchors.fill: parent
                                    anchors.leftMargin: 40
                                    text: branch_name + " - " + step_name
                                    font.family: yekanFont.font.family
                                    font.pixelSize: 16
                                }
                            }

                            Component.onCompleted:
                            {
                                UserMethods.accessStepModel();
                            }
                        }

                        // basis
                        Text {
                            text: "دسترسی‌ به پایه‌ها"
                            Layout.columnSpan: 2
                            Layout.alignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 18
                            font.bold: true
                            color: "royalblue"
                        }
                        ListView
                        {
                            id: userAccessBasisLV
                            spacing: 20
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            Layout.maximumHeight: 200
                            Layout.minimumHeight: 100
                            model: ListModel{id: userBasisListModel;}
                            delegate:
                                Rectangle
                            {
                                width: userBox.width;
                                height: 40;
                                color: "white"
                                Text
                                {
                                    anchors.fill: parent
                                    anchors.leftMargin: 40
                                    text: branch_name + " - " + step_name + " - " + basis_name
                                    font.family: yekanFont.font.family
                                    font.pixelSize: 16
                                }
                            }

                            Component.onCompleted:
                            {
                                UserMethods.accessBasisModel();
                            }
                        }

                        // permissions
                        Text {
                            text: "مجوزهای اعمال تغییرات"
                            Layout.columnSpan: 2
                            Layout.alignment: Qt.AlignHCenter
                            font.family: yekanFont.font.family
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
                            text: "مجوز اعمال تغییرات در شعبه‌ها"
                            Layout.columnSpan: 2
                            Layout.alignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 18
                            font.bold: true
                            color: "royalblue"
                        }
                        ListView
                        {
                            id: userPermissionBranchLV
                            spacing: 20
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            Layout.maximumHeight: 200
                            Layout.minimumHeight: 100
                            model: ListModel{id: userPermBranchListModel;}
                            delegate:
                                Rectangle
                            {
                                width: userBox.width;
                                height: 40;
                                color: "white"
                                Text
                                {
                                    anchors.fill: parent
                                    anchors.leftMargin: 40
                                    text: city + " - " + branch_name
                                    font.family: yekanFont.font.family
                                    font.pixelSize: 16
                                }
                            }

                            Component.onCompleted:
                            {
                                UserMethods.permissionBranchModel();
                            }
                        }

                        Text {
                            text: "مجوز اعمال تغییرات در دوره‌ها"
                            Layout.columnSpan: 2
                            Layout.alignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 18
                            font.bold: true
                            color: "royalblue"
                        }
                        ListView
                        {
                            id: userPermissionStepLV
                            spacing: 20
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            Layout.maximumHeight: 200
                            Layout.minimumHeight: 100
                            model: ListModel{id: userPermStepListModel;}
                            delegate:
                                Rectangle
                            {
                                width: userBox.width;
                                height: 40;
                                color: "white"
                                Text
                                {
                                    anchors.fill: parent
                                    anchors.leftMargin: 40
                                    text: branch_name + " - " + step_name
                                    font.family: yekanFont.font.family
                                    font.pixelSize: 16
                                }
                            }

                            Component.onCompleted:
                            {
                                UserMethods.permissionStepModel();
                            }
                        }

                        // basis
                        Text {
                            text: "مجوز اعمال تغییرات در پایه‌ها"
                            Layout.columnSpan: 2
                            Layout.alignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 18
                            font.bold: true
                            color: "royalblue"
                        }
                        ListView
                        {
                            id: userPermissionBasisLV
                            spacing: 20
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            Layout.maximumHeight: 200
                            Layout.minimumHeight: 100
                            model: ListModel{id: userPermBasisListModel;}
                            delegate:
                                Rectangle
                            {
                                width: userBox.width;
                                height: 40;
                                color: "white"
                                Text
                                {
                                    anchors.fill: parent
                                    anchors.leftMargin: 40
                                    text:  branch_name + " - " + step_name + " - " + basis_name
                                    font.family: yekanFont.font.family
                                    font.pixelSize: 16
                                }
                            }

                            Component.onCompleted:
                            {
                                UserMethods.permissionBasisModel();
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

    Component
    {
        id: userModifyComponent
        UserModify{}
    }

    Component
    {
        id: userDeleteComponent
        UserDelete{}
    }

    Component
    {
        id: changePasswordComponent
        ChangePassword{}
    }

    //password
    BaseDialog {
        id: changePasswordInitialDialog
        dialogTitle: "رمز عبور";
        dialogText: "برای ادامه فرآیند رمز عبور خود را وارد نمایید."
        acceptVisible: true
        rejectVisible: true
        textFieldVisible: true
        dialogSuccess : true;
        textFieldEcho : TextField.Password
        textFieldValue: "";
        acceptAction : function(){
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
    BaseDialog {
        id: changePasswordErrorDialog
        dialogTitle: "رمز عبور";
        dialogText: "تغییر رمز عبور کاربر با مشکل مواجه شد."
        acceptVisible: true
        rejectVisible: false
        textFieldVisible: false
        dialogSuccess : false;
    }
    BaseDialog {
        id: changePasswordSuccessDialog
        dialogTitle: "رمز عبور";
        dialogText: "تغییر رمز عبور کاربر با موفقیت انجام شد."
        acceptVisible: true
        rejectVisible: false
        textFieldVisible: false
        dialogSuccess : true;
    }
    ChangePassDialogBox {
        id: changePasswordDialog
        textField1Value: ""
        textField2Value: ""

        acceptAction: function(){
            var password = textField1Value;
            var confirmPassword = textField2Value;
            var ok = false
            if(password === confirmPassword)
            {
                if(dbMan.changeUserPassword(user["id"], password))
                    ok = true
                else
                    ok = false;
            }

            if(ok)
                changePasswordSuccessDialog.open();
            else
                changePasswordErrorDialog.open();

        }
    }

}

