pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

import "NewUserJS.js" as UserMethods

Page {
    id: addNewUserPageId
    property var selectedBranches:[]
    property var readStep:[]
    property var readStudyBase:[]

    property var selectedSteps:[]
    property var selectedBases:[]
    property var writeStep:[]
    property var writeStudyBase:[]

    required property StackView appStackView;
    signal userInsertedSignal();

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}
    Item{
        anchors.fill: parent
        anchors.margins: 5

        GridLayout
        {
            id: newUserGridLayout
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
                onClicked: addNewUserPageId.appStackView.pop();
                hoverEnabled: true
                onHoveredChanged: userListBackBtnId.opacity=(hovered)? 1 : 0.5;
            }
            Text {
                id: userListTitle
                text: "ایجاد کاربر جدید سامانه"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.family: "Kalameh"
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
                contentHeight : newUserFormGW.implicitHeight
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
                            id: newUserFormGW
                            width : centerBoxRec.width
                            //height : centerBoxRec.height
                            columns: 2
                            rowSpacing: 20
                            columnSpacing: 10

                            Image {
                                Layout.columnSpan: 2
                                source: "qrc:/assets/images/newUser.png"
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
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: newUserNameId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                placeholderText: "نام‌کاربر"

                            }

                            Text {
                                text: "نام‌خانوادگی"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: newUserLastNameId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                placeholderText: "نام خانوادگی"
                            }

                            Text {
                                text: "جنسیت"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            ComboBox {
                                id: newUserGenderId
                                editable: false
                                model: ["خانم", "آقا"]
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                Layout.preferredHeight: 50
                            }

                            Text {
                                text: "کدملی"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: newUserNatidId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                placeholderText: "کد ملی کاربر"
                            }

                            Text {
                                text: "رمز عبور کاربر"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: newUserPassId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                placeholderText: "رمز عبور"
                                echoMode: TextField.Password
                            }
                            Text {
                                text: "تکرار رمز عبور"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: newUserPassConfirmId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                placeholderText: "تکرار رمز عبور"
                                echoMode: TextField.Password
                            }

                            Text {
                                text: "پست کاربر"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: newUserPositionId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                placeholderText: "پست کاربر"
                            }

                            Text {
                                text: "شماره تماس"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            TextField
                            {
                                id: newUserTelId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                placeholderText: "شماره تماس"
                            }

                            //enabled
                            Text {
                                text: "فعال بودن کاربر"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Switch
                            {
                                id: newUserEnabledId
                                checked: true
                            }

                            // //admin
                            // Text {
                            //     text: "ادمین سامانه"
                            //     Layout.minimumWidth: 150
                            //     Layout.maximumWidth: 150
                            //     Layout.preferredHeight: 50
                            //     verticalAlignment: Text.AlignVCenter
                            //     font.family: "Kalameh"
                            //     font.pixelSize: 16
                            //     font.bold: true
                            //     color: "crimson"
                            // }
                            // Switch
                            // {
                            //     id: newUserAdminId
                            //     checked: false
                            //     onCheckedChanged:
                            //     {
                            //         //newUserAccPermId.visible=(checked)? false : true;
                            //         adminWarningMessage.visible=(checked)? true : false;
                            //     }
                            // }
                            // Text {
                            //     id: adminWarningMessage
                            //     visible: false
                            //     text: "هشدار! کاربر ادمین، دسترسی کامل به مدیریت سامانه دارد"
                            //     Layout.columnSpan: 2
                            //     Layout.alignment: Qt.AlignLeft
                            //     font.family: "Kalameh"
                            //     Layout.topMargin: -10
                            //     font.pixelSize: 16
                            //     font.bold: true
                            //     color: "orange"
                            // }

                            //PERMISSION
                            GridLayout
                            {
                                id: newUserAccPermId
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
                                    font.family: "Kalameh"
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
                                    font.family: "Kalameh"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }

                                Flow
                                {
                                    spacing: 20
                                    Layout.columnSpan: 2
                                    flow: Flow.TopToBottom
                                    Layout.preferredHeight: newUserBranchesId.count*70

                                    Repeater
                                    {
                                        id: newUserBranchesId
                                        model: ListModel {id: branchesModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            checked: (addNewUserPageId.selectedBranches.indexOf(model.Id) > -1)? true : false;
                                            height: 50;
                                            text: model.City + " - " + model.Branch_name
                                            font.family: "Kalameh"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = addNewUserPageId.selectedBranches.indexOf(model.Id);

                                                if(checked)
                                                {
                                                    //push step
                                                    if(index < 0)
                                                    addNewUserPageId.selectedBranches.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    addNewUserPageId.selectedBranches.splice(index, 1);
                                                }

                                                UserMethods.checkBranch();
                                                UserMethods.updateReadStep();
                                                UserMethods.updateReadStudyBase();
                                                UserMethods.updateWriteStepModel();
                                                UserMethods.updateWriteBaseModel();
                                                UserMethods.checkStep();
                                                UserMethods.checkBase();
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
                                    font.family: "Kalameh"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Flow
                                {
                                    spacing: 20
                                    Layout.columnSpan: 2
                                    flow: Flow.TopToBottom
                                    Layout.preferredHeight: newUserReadStepId.count*70

                                    Repeater
                                    {
                                        id: newUserReadStepId
                                        model: ListModel {id: readStepModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            text: model.Branch_name +" - "+ model.Step_name
                                            checked: (addNewUserPageId.readStep.indexOf(model.Id) > -1)? true : false;
                                            font.family: "Kalameh"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = addNewUserPageId.readStep.indexOf(model.Id);
                                                if(checked)
                                                {
                                                    if(index < 0)
                                                    addNewUserPageId.readStep.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    addNewUserPageId.readStep.splice(index, 1);
                                                }

                                                // write steps
                                                var index = addNewUserPageId.selectedSteps.indexOf(model.Id);
                                                if(checked)
                                                {
                                                    if(index < 0)
                                                        addNewUserPageId.selectedSteps.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                        addNewUserPageId.selectedSteps.splice(index, 1);
                                                }

                                                UserMethods.updateReadStep();
                                                UserMethods.updateWriteStepModel();

                                            }
                                        }
                                    }
                                }

                                // read study base

                                Text {
                                    text: "دسترسی‌ مشاهده پایه‌ها"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Flow
                                {
                                    spacing: 20
                                    Layout.columnSpan: 2
                                    flow: Flow.TopToBottom
                                    Layout.preferredHeight: newUserReadBasisId.count*70

                                    Repeater
                                    {
                                        id: newUserReadBasisId
                                        model: ListModel {id: readBaseModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            text: model.City +" - "+model.Branch_name +" - "+model.Study_base
                                            checked: (addNewUserPageId.readStudyBase.indexOf(model.Id) > -1)? true : false;
                                            font.family: "Kalameh"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = addNewUserPageId.readStudyBase.indexOf(model.Id)

                                                if(checked)
                                                {
                                                    if(index < 0)
                                                    addNewUserPageId.readStudyBase.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    addNewUserPageId.readStudyBase.splice(index, 1);

                                                }

                                                // write bases
                                                var index = addNewUserPageId.selectedBases.indexOf(model.Id);
                                                if(checked)
                                                {
                                                    if(index < 0)
                                                    addNewUserPageId.selectedBases.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    addNewUserPageId.selectedBases.splice(index, 1);
                                                }

                                                UserMethods.updateReadStudyBase();
                                                UserMethods.updateWriteBaseModel();
                                            }
                                        }
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
                                    font.family: "Kalameh"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Flow
                                {
                                    spacing: 20
                                    Layout.columnSpan: 2
                                    flow: Flow.TopToBottom
                                    Layout.preferredHeight: newUserWriteStepId.count*70

                                    Repeater
                                    {
                                        id: newUserWriteStepId
                                        model: ListModel {id: writeStepModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            text: model.Branch_name +" - "+ model.Step_name
                                            checked: (addNewUserPageId.writeStep.indexOf(model.Id) > -1)? true : false;
                                            font.family: "Kalameh"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = addNewUserPageId.writeStep.indexOf(model.Id);
                                                if(checked)
                                                {
                                                    if(index < 0)
                                                    addNewUserPageId.writeStep.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    addNewUserPageId.writeStep.splice(index, 1);
                                                }

                                            }
                                        }
                                    }
                                }

                                //write study base
                                Text {
                                    text: "دسترسی‌ ویرایش پایه‌ها"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "Kalameh"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Flow
                                {
                                    spacing: 20
                                    Layout.columnSpan: 2
                                    flow: Flow.TopToBottom
                                    Layout.preferredHeight: newUserwriteBasisId.count*70

                                    Repeater
                                    {
                                        id: newUserwriteBasisId
                                        model: ListModel {id: writeBaseModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            text: model.City +" - "+model.Branch_name +" - "+model.Study_base
                                            checked: (addNewUserPageId.writeStudyBase.indexOf(model.Id) > -1)? true : false;
                                            font.family: "Kalameh"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = addNewUserPageId.writeStudyBase.indexOf(model.Id)

                                                if(checked)
                                                {
                                                    if(index < 0)
                                                    addNewUserPageId.writeStudyBase.push(model.Id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    addNewUserPageId.writeStudyBase.splice(index, 1);
                                                }

                                            }
                                        }
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
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                                onClicked:
                                {
                                    var user = {};
                                    user["name"] = newUserNameId.text;
                                    user["lastname"] = newUserLastNameId.text;
                                    user["nat_id"] = newUserNatidId.text;
                                    user["password"] = newUserPassId.text;
                                    user["passwordConfirm"] = newUserPassConfirmId.text;
                                    user["job_position"] = newUserPositionId.text
                                    user["telephone"] = newUserTelId.text;

                                    var permission = {"read":{}, "write":{}}
                                    var rs = addNewUserPageId.readStep;
                                    var rsb = addNewUserPageId.readStudyBase;
                                    var ws = addNewUserPageId.writeStep;
                                    var wsb = addNewUserPageId.writeStudyBase;

                                    permission["read"]  = {"step": rs, "study_base": rsb};
                                    permission["write"] = {"step": ws, "study_base": wsb};

                                    user["permissions"] = permission;

                                    user["enabled"] = newUserEnabledId.checked
                                    user["admin"] = false
                                    user["gender"] = newUserGenderId.currentText

                                    var check = true
                                    // check entries
                                    if(!UserMethods.checkFormEntries(user))
                                    {
                                        newUserInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.insertUser(user))
                                    {
                                        addNewUserPageId.userInsertedSignal();
                                        newUserSuccessDialogId.open();
                                    }
                                    else
                                    {
                                        var errorString = dbMan.getLastError();
                                        newUserInfoDialogId.dialogTitle = "خطا"
                                        newUserInfoDialogId.dialogText = errorString
                                        newUserInfoDialogId.width = parent.width
                                        newUserInfoDialogId.height = 500
                                        newUserInfoDialogId.dialogSuccess = false
                                        newUserInfoDialogId.open();
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
        id: newUserInfoDialogId
        dialogTitle: "خطا"
        dialogText: "ورود فیلد الزامی می‌باشد"
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: newUserSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "کاربر جدید با موفقیت به دیتابیس افزوده شد"
        dialogSuccess: true
        onDialogAccepted: {newUserSuccessDialogId.close(); addNewUserPageId.appStackView.pop();}

    }

}
