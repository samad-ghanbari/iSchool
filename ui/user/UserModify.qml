pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public"  as DialogBox

import "UserModify.js" as UserMethods

Page {
    id: userModifyPageId
    property var user;
    property var readPerm  : userModifyPageId.user["permissions"]["read"];
    property var writePerm : userModifyPageId.user["permissions"]["write"];

    property var selectedBranches: dbMan.getUserBranch(userModifyPageId.user["id"]);
    property var readStep: userModifyPageId.readPerm["step"];
    property var readStudyBase:userModifyPageId.readPerm["study_base"];

    property var selectedSteps:userModifyPageId.readPerm["step"];
    property var selectedBases:userModifyPageId.readPerm["study_base"];
    property var writeStep: userModifyPageId.writePerm["step"];
    property var writeStudyBase:userModifyPageId.writePerm["study_base"];

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}
    Item{
        anchors.fill: parent
        anchors.margins: 5

        GridLayout
        {
            id: updateUserGridLayout
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
                opacity: 0.5
                onClicked: homeStackViewId.pop();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Text {
                id: userListTitle
                text: "ویرایش کاربر"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.family: "B Yekan"
                font.pixelSize: 24
                font.bold: true
                color: "mediumvioletred"
            }

            //id, name, lastname, gender, nat_id, password, job_position, telephone, permissions, enabled, admin
            //permission {
            // read:{ base_study:[], step:[] } ,
            // write: {base_study:[], step:[]}
            //}

            ScrollView
            {
                Layout.columnSpan: 2
                Layout.fillHeight: true
                Layout.fillWidth: true
                contentHeight : updateUserFormGW.implicitHeight
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
                            id: updateUserFormGW
                            width : centerBoxRec.width
                            //height : centerBoxRec.height
                            columns: 2
                            rowSpacing: 20
                            columnSpacing: 10

                            Image {
                                Layout.columnSpan: 2
                                source: "qrc:/assets/images/edit.png"
                                Layout.margins: 20
                                Layout.preferredHeight: 128
                                Layout.preferredWidth: 128
                                Layout.alignment: Qt.AlignHCenter
                                NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
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
                            TextField
                            {
                                id: updateUserNameId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                placeholderText: "نام‌کاربر"
                                text: userModifyPageId.user["name"]

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
                            TextField
                            {
                                id: updateUserLastNameId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                placeholderText: "نام خانوادگی"
                                text: userModifyPageId.user["lastname"]
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
                            ComboBox {
                                id: updateUserGenderId
                                editable: false
                                model: ["خانم", "آقا"]
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                Layout.preferredHeight: 50
                                Component.onCompleted: updateUserGenderId.currentIndex = find(userModifyPageId.user["gender"])
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
                            TextField
                            {
                                id: updateUserNatidId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                placeholderText: "کد ملی کاربر"
                                text: userModifyPageId.user["nat_id"]
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
                            TextField
                            {
                                id: updateUserPositionId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                placeholderText: "پست کاربر"
                                text: userModifyPageId.user["job_position"]
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
                            TextField
                            {
                                id: updateUserTelId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                placeholderText: "شماره تماس"
                                text: userModifyPageId.user["telephone"]
                            }

                            //enabled
                            Text {
                                text: "فعال بودن کاربر"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Switch
                            {
                                id: updateUserEnabledId
                                checked: (userModifyPageId.user["enabled"])? true : false
                            }

                            //admin
                            Text {
                                text: "ادمین سامانه"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "crimson"
                            }
                            Switch
                            {
                                id: updateUserAdminId
                                checked:  (userModifyPageId.user["admin"])? true : false
                                onCheckedChanged:
                                {
                                    updateUserAccPermId.visible=(checked)? false : true;
                                    adminWarningMessage.visible=(checked)? true : false;
                                }
                            }
                            Text {
                                id: adminWarningMessage
                                visible:  (userModifyPageId.user["admin"])? true : false
                                text: "هشدار! کاربر ادمین، دسترسی کامل به مدیریت سامانه دارد"
                                Layout.columnSpan: 2
                                Layout.alignment: Qt.AlignLeft
                                font.family: "B Yekan"
                                Layout.topMargin: -10
                                font.pixelSize: 16
                                font.bold: true
                                color: "orange"
                            }

                            //PERMISSION
                            GridLayout
                            {
                                id: updateUserAccPermId
                                Layout.columnSpan: 2
                                Layout.fillWidth: true
                                columns: 2
                                rows: 11
                                rowSpacing: 20
                                columnSpacing: 10
                                /*
                            {
                              "read":{
                                "base":[1,2,3],
                                "step":[1]
                              },
                              "write":{
                                "base":[1],
                                "step":[1]
                              }
                            }
                            */

                                // READ
                                Text {
                                    text: "دسترسی‌های کاربر"
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

                                // branches
                                Text {
                                    text: "شعبه‌ها"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "B Yekan"
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
                                        id: updateUserBranchesId
                                        model: ListModel {id: branchesModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            checked: (userModifyPageId.selectedBranches.indexOf(model.Id) > -1)? true : false;
                                            height: 50;
                                            text: model.City + " - " + model.Branch_name
                                            font.family: "B Yekan"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = userModifyPageId.selectedBranches.indexOf(model.Id);

                                                if(checked)
                                                {
                                                    //push step
                                                    if(index < 0)
                                                    userModifyPageId.selectedBranches.push(model.Id);
                                                }
                                                else
                                                {
                                                    //pop study_step
                                                    //pop study_base

                                                    if(index > -1)
                                                    userModifyPageId.selectedBranches.splice(index, 1);
                                                }

                                                UserMethods.updateReadStep();
                                                UserMethods.updateReadStudyBase();
                                                UserMethods.updateWriteStepModel();
                                                UserMethods.updateWriteBaseModel();
                                            }
                                        }
                                    }
                                    Component.onCompleted:
                                    {
                                        UserMethods.updateBranches()
                                    }
                                }

                                // read study step
                                Text {
                                    text: "دسترسی‌ مشاهده دوره‌ها"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "B Yekan"
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
                                        id: updateUserReadStepId
                                        model: ListModel {id: readStepModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            text: model.Branch_name +" - "+ model.Step_name
                                            checked: (userModifyPageId.readStep.indexOf(model.Id) > -1)? true : false;
                                            font.family: "B Yekan"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = userModifyPageId.readStep.indexOf(model.Id);
                                                if(checked)
                                                {
                                                    if(index < 0)
                                                    userModifyPageId.readStep.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    userModifyPageId.readStep.splice(index, 1);
                                                }

                                                // write steps
                                                var index = userModifyPageId.selectedSteps.indexOf(model.Id);
                                                if(checked)
                                                {
                                                    if(index < 0)
                                                        userModifyPageId.selectedSteps.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                        userModifyPageId.selectedSteps.splice(index, 1);
                                                }

                                                UserMethods.updateReadStep();
                                                UserMethods.updateWriteStepModel();

                                            }
                                        }
                                    }

                                    Component.onCompleted:
                                    {
                                        UserMethods.updateReadStep()
                                    }
                                }

                                // read study base

                                Text {
                                    text: "دسترسی‌ مشاهده پایه‌ها"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "B Yekan"
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
                                        id: updateUserReadBasisId
                                        model: ListModel {id: readBaseModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            text: model.City +" - "+model.Branch_name +" - "+model.Study_base
                                            checked: (userModifyPageId.readStudyBase.indexOf(model.Id) > -1)? true : false;
                                            font.family: "B Yekan"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = userModifyPageId.readStudyBase.indexOf(model.Id)

                                                if(checked)
                                                {
                                                    if(index < 0)
                                                    userModifyPageId.readStudyBase.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    userModifyPageId.readStudyBase.splice(index, 1);

                                                }

                                                // write bases
                                                var index = userModifyPageId.selectedBases.indexOf(model.Id);
                                                if(checked)
                                                {
                                                    if(index < 0)
                                                    userModifyPageId.selectedBases.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    userModifyPageId.selectedBases.splice(index, 1);
                                                }

                                                UserMethods.updateReadStudyBase();
                                                UserMethods.updateWriteBaseModel();
                                            }
                                        }
                                    }

                                    Component.onCompleted:
                                    {
                                        UserMethods.updateReadStudyBase()
                                    }
                                }


                                Rectangle
                                {
                                    Layout.columnSpan: 2
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 1
                                    color: "dodgerblue"
                                }

                                //write study step
                                Text {
                                    text: "دسترسی‌ ویرایش دوره‌ها"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "B Yekan"
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
                                        id: updateUserWriteStepId
                                        model: ListModel {id: writeStepModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            text: model.Branch_name +" - "+ model.Step_name
                                            checked: (userModifyPageId.writeStep.indexOf(model.Id) > -1)? true : false;
                                            font.family: "B Yekan"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = userModifyPageId.writeStep.indexOf(model.Id);
                                                if(checked)
                                                {
                                                    if(index < 0)
                                                    userModifyPageId.writeStep.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    userModifyPageId.writeStep.splice(index, 1);
                                                }

                                            }
                                        }
                                    }

                                    Component.onCompleted:
                                    {
                                        UserMethods.updateWriteStepModel()
                                    }
                                }

                                //write study base
                                Text {
                                    text: "دسترسی‌ ویرایش پایه‌ها"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "B Yekan"
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
                                        id: updateUserwriteBasisId
                                        model: ListModel {id: writeBaseModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            text: model.City +" - "+model.Branch_name +" - "+model.Study_base
                                            checked: (userModifyPageId.writeStudyBase.indexOf(model.Id) > -1)? true : false;
                                            font.family: "B Yekan"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = userModifyPageId.writeStudyBase.indexOf(model.Id)

                                                if(checked)
                                                {
                                                    if(index < 0)
                                                    userModifyPageId.writeStudyBase.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    userModifyPageId.writeStudyBase.splice(index, 1);
                                                }

                                            }
                                        }
                                    }

                                    Component.onCompleted:
                                    {
                                        UserMethods.updateWriteStepModel()
                                    }
                                }

                            }


                            Button
                            {
                                Layout.columnSpan: 2
                                Layout.margins: 20
                                text: "تایید"
                                Layout.preferredWidth: 200
                                Layout.preferredHeight: 50
                                Layout.alignment: Qt.AlignHCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                                onClicked:
                                {
                                    var user = {};
                                    user["name"] = updateUserNameId.text;
                                    user["lastname"] = updateUserLastNameId.text;
                                    user["nat_id"] = updateUserNatidId.text;
                                    user["job_position"] = updateUserPositionId.text
                                    user["telephone"] = updateUserTelId.text;

                                    var permission = {"read":{}, "write":{}}
                                    var rs = userModifyPageId.readStep;
                                    var rsb = userModifyPageId.readStudyBase;
                                    var ws = userModifyPageId.writeStep;
                                    var wsb = userModifyPageId.writeStudyBase;

                                    permission["read"]  = {"step": rs, "study_base": rsb};
                                    permission["write"] = {"step": ws, "study_base": wsb};

                                    user["permissions"] = permission;

                                    user["enabled"] = updateUserEnabledId.checked
                                    user["admin"] = updateUserAdminId.checked
                                    user["gender"] = updateUserGenderId.currentText

                                    var check = true
                                    // check entries
                                    if(!UserMethods.checkFormEntries(user))
                                    {
                                        updateUserInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.updateUser(user))
                                    {
                                        updateUserInfoDialogId.dialogSuccess = true
                                        updateUserInfoDialogId.dialogTitle = "عملیات موفق"
                                        updateUserInfoDialogId.dialogText = "ویرایش کاربر با موفقیت انجام گرفت."
                                        userListPage.updateUserListModel();
                                        updateUserInfoDialogId.acceptAction = function(){updateUserInfoDialogId.close(); homeStackViewId.pop();}
                                        updateUserInfoDialogId.open();

                                    }
                                    else
                                    {
                                        var errorString = dbMan.getLastError();
                                        updateUserInfoDialogId.dialogTitle = "خطا"
                                        updateUserInfoDialogId.dialogText = errorString
                                        updateUserInfoDialogId.width = parent.width
                                        updateUserInfoDialogId.height = 500
                                        updateUserInfoDialogId.dialogSuccess = false
                                        updateUserInfoDialogId.open();
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
        id: updateUserInfoDialogId
        dialogTitle: "خطا"
        dialogText: "ورود فیلد الزامی می‌باشد"
        dialogSuccess: false
    }
}
