pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public"  as DialogBox

Page {
    id: userPage
    required property int user_id;
    required property string name;
    required property string lastname;
    required property string gender;
    required property string nat_id;
    required property string job_position;
    required property string telephone;
    required property var permissions;
    required property bool enabled;
    required property bool admin;
    required property bool superadmin;

    required property StackView appStackView;
    signal deletedSignal();
    signal updatedSignal();

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignLeft
            text: "مدیریت کاربر"
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
                    // buttons
                    RowLayout
                    {
                        width: parent.width
                        height: 64

                        Button
                        {
                            background: Item{}
                            icon.source: "qrc:/assets/images/edit.png"
                            icon.width: 50
                            icon.height: 50
                            icon.color:"transparent"
                            opacity: 0.5
                            onClicked: userPage.appStackView.push(updateComponent)
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                        Button
                        {
                            background: Item{}
                            icon.source: "qrc:/assets/images/key1.png"
                            icon.width: 50
                            icon.height: 50
                            icon.color:"transparent"
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
                            Layout.preferredHeight: 1
                        }
                        Button
                        {
                            background: Item{}
                            icon.source: "qrc:/assets/images/trash.png"
                            icon.width: 50
                            icon.height: 50
                            icon.color:"transparent"
                            opacity: 0.5
                            onClicked: userPage.appStackView.push(deleteComponent)
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
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
                            visible: (userPage.superadmin)? true : false;
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
                            visible: (userPage.admin)? true : false;
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
                            color: (userPage.enabled)? "forestgreen" : "crimson"
                            Text
                            {
                                anchors.fill: parent
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter
                                font.family: "Kalameh"
                                font.pixelSize: 18
                                color: "white"
                                text: (userPage.enabled)? "فعال" : "غیرفعال"
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
                            text: userPage.name
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
                            text: userPage.lastname
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
                            text: userPage.gender
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
                            text: userPage.nat_id
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
                            text: userPage.job_position
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
                            text: userPage.telephone
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }
                    }

                    // Permissions
                    Rectangle
                    {
                        width: parent.width
                        height: 1
                        color: "dodgerblue"
                    }

                    Text {
                        width: parent.width
                        height: 25
                        text: "دسترسی‌های کاربر"
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                    }
                    // branches
                    Text {
                        text: "شعبه‌ها"
                        width: parent.width
                        height: 25
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                    }
                    ListView
                    {
                        id: userBranchLV
                        spacing: 20
                        width: parent.width
                        height: userBranchLV.contentHeight + 50
                        model: ListModel{id: branchModel;}
                        delegate:
                        Rectangle
                        {
                            id: recBrDelegate
                            required property var model;
                            width: userBranchLV.width;
                            height: 40;
                            color: "transparent"
                            Text
                            {
                                anchors.fill: parent
                                anchors.leftMargin: 40
                                text: recBrDelegate.model.city +" - "+  recBrDelegate.model.branch_name
                                font.family: "Kalameh"
                                font.pixelSize: 16
                            }
                        }

                        Component.onCompleted: {
                            branchModel.clear();
                            var branches = userPage.permissions["branch"];
                            var jsondata = dbMan.getBranchesById(branches);
                            for(var obj of jsondata)
                            {
                                branchModel.append(obj); //id, city, branch_name, branch_address
                            }
                        }

                    }

                    // steps
                    Text {
                        text: "دوره‌ها"
                        width: parent.width
                        height: 25
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                        visible: (userPage.admin)? false : true;
                    }
                    ListView
                    {
                        id: userStepLV
                        visible: (userPage.admin)? false : true;
                        spacing: 20
                        width: parent.width
                        height: userStepLV.contentHeight + 50
                        model: ListModel{id: stepModel;}
                        delegate:
                        Rectangle
                        {
                            id: recDelegate
                            required property var model;
                            width: userStepLV.width;
                            height: 40;
                            color: "transparent"
                            Text
                            {
                                anchors.fill: parent
                                anchors.leftMargin: 40
                                text: recDelegate.model.city +" - "+  recDelegate.model.branch_name + " - " + recDelegate.model.step_name
                                font.family: "Kalameh"
                                font.pixelSize: 16
                            }
                        }

                        Component.onCompleted:
                        {
                            stepModel.clear();
                            var steps = userPage.permissions["step"];
                            var jsondata = dbMan.getStepsById(steps);
                            for(var obj of jsondata)
                            {
                                stepModel.append(obj); // s.id, s.branch_id, s.step_name, b.city, b.branch_name
                            }
                        }
                    }

                    // base
                    Text {
                        text: "پایه‌های تحصیلی"
                        visible: (userPage.admin)? false : true;
                        width: parent.width
                        height: 25
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                    }
                    ListView
                    {
                        id: userBaseLV
                        visible: (userPage.admin)? false : true;
                        spacing: 20
                        width: parent.width
                        height: userBaseLV.contentHeight + 50
                        model: ListModel{id: baseModel;}
                        delegate:
                        Rectangle
                        {
                            id: recBaseDelegate
                            required property var model;
                            width: userBaseLV.width;
                            height: 40;
                            color: "transparent"
                            Text
                            {

                                anchors.fill: parent
                                anchors.leftMargin: 40
                                text:  recBaseDelegate.model.text
                                font.family: "Kalameh"
                                font.pixelSize: 16
                            }
                        }

                        Component.onCompleted:
                        {
                            baseModel.clear();
                            var array = userPage.permissions["base"];
                            var jsondata = dbMan.getBasesById(array);
                            // b.id, b.step_id, br.city, br.branch_name, s.step_name, s.field_based, b.field_id, f.field_name, b.base_name
                            let id, text
                            for(var obj of jsondata)
                            {
                                id = obj["id"];
                                text = obj["city"] + " - " + obj["branch_name"] + " - " + obj["step_name"];
                                if(obj["field_based"])
                                {
                                    text = text + " - " + obj["field_name"];
                                }

                                text = text + " - " + obj["base_name"];

                                baseModel.append({id: id, text: text});
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
                if(dbMan.changeUserPassword(userPage.user_id, password))
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
        id: updateComponent
        UpdateUser{
            onPopSignal: userPage.appStackView.pop();
            user_id : userPage.user_id;
            name : userPage.name;
            lastname : userPage.lastname;
            gender: userPage.gender;
            nat_id: userPage.nat_id;
            job_position: userPage.job_position;
            telephone: userPage.telephone;
            permissions: userPage.permissions;
            enabled: userPage.enabled;
            admin: userPage.admin;
            superadmin: userPage.superadmin;

            onUpdatedSignal: ()=>
            {
                userPage.updatedSignal();

                // update page
                var user = dbMan.getUser(userPage.user_id);
                //id, name, lastname, gender, nat_id, job_position, telephone, permissions, enabled, admin, superadmin
                userPage.name = user["name"];
                userPage.lastname = user["lastname"];
                userPage.gender = user["gender"];
                userPage.nat_id = user["nat_id"];
                userPage.job_position = user["job_position"];
                userPage.telephone = user["telephone"];
                userPage.permissions = user["permissions"];
                userPage.enabled = user["enabled"];
                userPage.admin = user["admin"];
                userPage.superadmin = user["superadmin"];

                //branch
                branchModel.clear();
                var branches = userPage.permissions["branch"];
                var jsondata = dbMan.getBranchesById(branches);
                for(var obj of jsondata)
                {
                    branchModel.append(obj); //id, city, branch_name, branch_address
                }

                // step
                stepModel.clear();
                var steps = userPage.permissions["step"];
                jsondata = dbMan.getStepsById(steps);
                for(obj of jsondata)
                {
                    stepModel.append(obj); // s.id, s.branch_id, s.step_name, b.city, b.branch_name
                }


                // base
                baseModel.clear();
                var array = userPage.permissions["base"];
                 jsondata = dbMan.getBasesById(array);
                // b.id, b.step_id, br.city, br.branch_name, s.step_name, s.field_based, b.field_id, f.field_name, b.base_name
                let id, text
                for(obj of jsondata)
                {
                    id = obj["id"];
                    text = obj["city"] + " - " + obj["branch_name"] + " - " + obj["step_name"];
                    if(obj["field_based"])
                    {
                        text = text + " - " + obj["field_name"];
                    }

                    text = text + " - " + obj["base_name"];

                    baseModel.append({id: id, text: text});
                }


            }
        }
    }

    Component
    {
        id: deleteComponent
        DeleteUser{

            user_id : userPage.user_id;
            name: userPage.name;
            lastname: userPage.lastname;
            gender: userPage.gender;
            nat_id: userPage.nat_id;
            job_position: userPage.job_position;
            telephone: userPage.telephone;
            enabled : userPage.enabled;
            admin: userPage.admin;
            superadmin: userPage.superadmin;

            onPopSignal: userPage.appStackView.pop();
            onDeletedSignal: {
                userPage.deletedSignal();
                userPage.appStackView.pop();
            }
        }
    }

}

