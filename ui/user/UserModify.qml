import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public"

import "UserModify.js" as UserMethods

Page {
    property var user

    property var accessBranch: user["access"]["branch"]
    property var accessStep: user["access"]["step"]
    property var accessBasis: user["access"]["basis"]
    property var permissionBranch: user["write_permission"]["branch"]
    property var permissionStep:user["write_permission"]["step"]
    property var permissionBasis: user["write_permission"]["basis"]

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
                palette.buttonText: "steelblue"
                onClicked: homeStackViewId.pop();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Item
            {
                Layout.fillWidth: true
            }

            Text {
                text: user["name"] + " " + user["lastname"];
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
        PaddedRectangle
        {
            Layout.fillHeight: true
            Layout.fillWidth: true

            color: "honeydew"

            ScrollView
            {
                height: parent.height
                width: parent.width
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                PaddedRectangle
                {
                    id: centerBoxId
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
                        Image {
                            source: "qrc:/Assets/images/edit.png"
                            Layout.alignment: Qt.AlignHCenter
                            Layout.maximumHeight: 128
                            Layout.maximumWidth: 128
                            Layout.margins: 20
                            width: 128
                            height: 128
                            NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                        }

                        GridLayout
                        {
                            id: userBasicsId
                            columns: 2
                            rows: 10
                            rowSpacing: 20
                            columnSpacing: 10
                            Layout.preferredWidth:  parent.width


                            Text {
                                text: "نام‌کاربر "
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: userNameId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                placeholderText: "نام‌کاربر"
                                text: user["name"]

                            }

                            Text {
                                text: "نام‌خانوادگی"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: userLastNameId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                placeholderText: "نام خانوادگی"
                                text: user["lastname"]
                            }

                            Text {
                                text: "کدملی"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: userNatidId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                placeholderText: "کد ملی کاربر"
                                text: user["nat_id"]
                            }

                            Text {
                                text: "جنسیت"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            ComboBox {
                                id: userGenderId
                                editable: false
                                model: ["خانم", "آقا"]
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                Layout.preferredHeight: 50
                                Component.onCompleted: userGenderId.currentIndex = find(user["gender"])
                            }


                            Text {
                                text: "پست الکترونیکی"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: userEmailId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                placeholderText: "پست الکترونیکی"
                                text: user["email"]
                            }

                            Text {
                                text: "پست کاربر"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: userPositionId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                placeholderText: "سمت‌شغلی"
                                text: user["job_position"]
                            }

                            Text {
                                text: "شماره تماس"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: userTelId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                placeholderText: "شماره تماس"
                                text: user["telephone"]
                            }


                            //enabled
                            Text {
                                text: "فعال بودن کاربر"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Switch
                            {
                                id: userEnabledId
                                checked: (user["enabled"])? true : false;
                            }

                            //admin
                            Text {
                                text: "ادمین‌سامانه"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: yekanFont.font.family
                                font.pixelSize: 16
                                font.bold: true
                                color: "crimson"
                            }
                            Switch
                            {
                                id: userAdminId
                                checked: (user["admin"])? true : false;
                                onCheckedChanged:
                                {
                                    userAccPermId.visible=(checked)? false : true;
                                    adminWarningMessage.visible=(checked)? true : false;
                                }
                            }
                            Text {
                                id: adminWarningMessage
                                visible: false
                                text: "هشدار! کاربر ادمین، دسترسی کامل به مدیریت سامانه دارد"
                                Layout.columnSpan: 2
                                Layout.alignment: Qt.AlignLeft
                                font.family: yekanFont.font.family
                                Layout.topMargin: -10
                                font.pixelSize: 16
                                font.bold: true
                                color: "orange"
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

                            Flow
                            {
                                spacing: 20
                                Layout.columnSpan: 2
                                flow: Flow.TopToBottom

                                Repeater
                                {
                                    id: userAccessBranchId
                                    model: ListModel {id: accessBranchModel }
                                    delegate:
                                        Switch{
                                        checked: (accessBranch.indexOf(id) > -1)? true : false;
                                        text: city + " - " + branch_name
                                        font.family: yekanFont.font.family
                                        font.pixelSize: 14
                                        onToggled:
                                        {
                                            permissionBranchModel.clear();
                                            permissionStepModel.clear();
                                            permissionBasisModel.clear();

                                            accessBasisModel.clear();
                                            accessStepModel.clear();

                                            permissionBranch = [];
                                            permissionStep = [];
                                            permissionBasis = [];

                                            accessStep = []
                                            accessBasis = []

                                            var branchId = id;
                                            var index = accessBranch.indexOf(branchId)

                                            if(this.checked)
                                            {
                                                if(index < 0)
                                                    accessBranch.push(branchId);
                                            }
                                            else
                                            {
                                                if(index > -1)
                                                    accessBranch.splice(index, 1);

                                            }

                                            UserMethods.updateAccessStep(false)
                                            UserMethods.updatePermissionBranch();
                                        }
                                    }
                                }
                                Component.onCompleted:
                                {
                                    UserMethods.updateAccessBranch()
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
                            Flow
                            {
                                spacing: 20
                                Layout.columnSpan: 2
                                flow: Flow.TopToBottom

                                Repeater
                                {
                                    id: userAccessStepId
                                    model: ListModel {id: accessStepModel }
                                    delegate:
                                        Switch{
                                        text: branch_name +"-"+step_name
                                        checked: (accessStep.indexOf(id) > -1)? true : false;
                                        font.family: yekanFont.font.family
                                        font.pixelSize: 14
                                        onToggled:
                                        {
                                            accessBasisModel.clear();
                                            accessBasis = [];

                                            permissionBasisModel.clear();
                                            permissionBasis=[];

                                            permissionStepModel.clear();
                                            permissionStep=[];



                                            var stepId = id;
                                            var index = accessStep.indexOf(stepId)

                                            if(this.checked)
                                            {
                                                if(index < 0)
                                                    accessStep.push(stepId);
                                            }
                                            else
                                            {
                                                if(index > -1)
                                                    accessStep.splice(index, 1);

                                            }

                                            UserMethods.updateAccessBasis(false);
                                            UserMethods.updatePermissionStep();

                                        }
                                    }
                                }
                                Component.onCompleted:
                                {
                                    UserMethods.updateAccessStep()
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
                            Flow
                            {
                                spacing: 20
                                Layout.columnSpan: 2
                                flow: Flow.TopToBottom

                                Repeater
                                {
                                    id: userAccessBasisId
                                    model: ListModel {id: accessBasisModel }
                                    delegate:
                                        Switch{
                                        text: branch_name +"-"+step_name+"-"+basis_name
                                        checked: (accessBasis.indexOf(id) > -1)? true : false;
                                        font.family: yekanFont.font.family
                                        font.pixelSize: 14
                                        onToggled:
                                        {
                                            permissionBasisModel.clear();
                                            permissionBasis=[]

                                            var basisId = id;
                                            var index = accessBasis.indexOf(basisId)

                                            if(this.checked)
                                            {
                                                if(index < 0)
                                                    accessBasis.push(basisId);
                                            }
                                            else
                                            {
                                                if(index > -1)
                                                    accessBasis.splice(index, 1);

                                            }

                                            UserMethods.updatePermissionBasis();
                                        }
                                    }
                                }
                                Component.onCompleted:
                                {
                                    UserMethods.updateAccessBasis()
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

                            // branch
                            Text {
                                text: "مجوز اعمال تغییرات در شعبه‌ها"
                                Layout.columnSpan: 2
                                Layout.alignment: Qt.AlignLeft
                                font.family: yekanFont.font.family
                                font.pixelSize: 18
                                font.bold: true
                                color: "royalblue"
                            }
                            Flow
                            {
                                spacing: 20
                                Layout.columnSpan: 2
                                flow: Flow.TopToBottom

                                Repeater
                                {
                                    id: userPermissionBranchId
                                    model: ListModel {id: permissionBranchModel }
                                    delegate:
                                        Switch{
                                        checked: (permissionBranch.indexOf(id) > -1)? true : false;
                                        text: city + " - " + branch_name
                                        font.family: yekanFont.font.family
                                        font.pixelSize: 14
                                        onToggled:
                                        {
                                            var branchId = id;
                                            var index = permissionBranch.indexOf(branchId)

                                            if(this.checked)
                                            {
                                                if(index < 0)
                                                    permissionBranch.push(branchId);
                                            }
                                            else
                                            {
                                                if(index > -1)
                                                    permissionBranch.splice(index, 1);

                                            }
                                        }
                                    }
                                }

                                Component.onCompleted:
                                {
                                    UserMethods.updatePermissionBranch();
                                }
                            }
                            // step
                            Text {
                                text: "مجوز اعمال تغییرات در دوره‌ها"
                                Layout.columnSpan: 2
                                Layout.alignment: Qt.AlignLeft
                                font.family: yekanFont.font.family
                                font.pixelSize: 18
                                font.bold: true
                                color: "royalblue"
                            }
                            Flow
                            {
                                spacing: 20
                                Layout.columnSpan: 2
                                flow: Flow.TopToBottom

                                Repeater
                                {
                                    id: userPermissionStepId
                                    model: ListModel {id: permissionStepModel }
                                    delegate:
                                        Switch{
                                        checked: (permissionStep.indexOf(id) > -1)? true : false;
                                        text: branch_name + " - " + step_name
                                        font.family: yekanFont.font.family
                                        font.pixelSize: 14
                                        onToggled:
                                        {
                                            var stepId = id;
                                            var index = permissionStep.indexOf(stepId)

                                            if(this.checked)
                                            {
                                                if(index < 0)
                                                    permissionStep.push(stepId);
                                            }
                                            else
                                            {
                                                if(index > -1)
                                                    permissionStep.splice(index, 1);

                                            }
                                        }
                                    }
                                }

                                Component.onCompleted:
                                {
                                    UserMethods.updatePermissionStep();
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
                            Flow
                            {
                                spacing: 20
                                Layout.columnSpan: 2
                                flow: Flow.TopToBottom

                                Repeater
                                {
                                    id: userPermissionBasisId
                                    model: ListModel {id: permissionBasisModel }
                                    delegate:
                                        Switch{
                                        checked: (permissionBasis.indexOf(id) > -1)? true : false;
                                        text: branch_name + " - " + step_name + " - " + basis_name
                                        font.family: yekanFont.font.family
                                        font.pixelSize: 14
                                        onToggled:
                                        {
                                            var basisId = id;
                                            var index = permissionStep.indexOf(basisId)

                                            if(this.checked)
                                            {
                                                if(index < 0)
                                                    permissionBasis.push(basisId);
                                            }
                                            else
                                            {
                                                if(index > -1)
                                                    permissionBasis.splice(index, 1);
                                            }
                                        }
                                    }
                                }

                                Component.onCompleted:
                                {
                                    UserMethods.updatePermissionBasis();
                                }
                            }
                        }


                        Item
                        {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                        }

                        Button
                        {
                            text: "تایید"
                            Layout.preferredWidth: 200
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                            onClicked:
                            {
                                var User = {};
                                User["id"] = user["id"];
                                User["name"] = userNameId.text;
                                User["lastname"] = userLastNameId.text;
                                User["nat_id"] = userNatidId.text;
                                User["email"] = userEmailId.text;
                                User["job_position"] = userPositionId.text
                                User["telephone"] = userTelId.text;

                                User["accessBranch"] = accessBranch;
                                User["accessStep"] = accessStep;
                                User["accessBasis"] = accessBasis;

                                User["permissionBranch"] = permissionBranch;
                                User["permissionStep"] = permissionStep;
                                User["permissionBasis"] = permissionBasis;

                                User["enabled"] = userEnabledId.checked
                                User["admin"] = userAdminId.checked
                                User["gender"] = userGenderId.currentText

                                var check = true
                                // check entries
                                if(!UserMethods.checkFormEntries(User))
                                {
                                    userInfoDialogId.open();
                                    return;
                                }

                                if(dbMan.updateUser(User))
                                {
                                    userInfoDialogId.dialogSuccess = true
                                    userInfoDialogId.dialogTitle = "عملیات موفق"
                                    userInfoDialogId.dialogText = "اطلاعات کاربر با موفقیت بروزرسانی شد"
                                    User = dbMan.getUserJson(User["id"]);
                                    //updated(User);
                                    userPage.updateUser(User);
                                    userInfoDialogId.acceptAction = function(){userInfoDialogId.close(); homeStackViewId.pop();}
                                    userInfoDialogId.open();

                                }
                                else
                                {
                                    var errorString = dbMan.getLastError();
                                    userInfoDialogId.dialogTitle = "خطا"
                                    userInfoDialogId.dialogText = errorString
                                    userInfoDialogId.width = parent.width
                                    userInfoDialogId.height = 500
                                    userInfoDialogId.dialogSuccess = false
                                    userInfoDialogId.open();
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

    BaseDialog
    {
        id: userInfoDialogId
        dialogTitle: "خطا"
        dialogText: "ورود فیلد الزامی می‌باشد"
        dialogSuccess: false
    }
}
