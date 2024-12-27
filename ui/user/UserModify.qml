pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public"  as DialogBox

import "UserModify.js" as UserMethods

Page {
    id: userModifyPageId
    property var user;
    property var perm  : userModifyPageId.user["permissions"];

    property var branchPerm: userModifyPageId.perm["branch"];
    property var stepPerm: userModifyPageId.perm["step"];
    property var studyBasePerm:userModifyPageId.perm["study_base"];

    property var selectedSteps:userModifyPageId.perm["step"];
    property var selectedBases:userModifyPageId.perm["study_base"];

    required property StackView appStackView;

    signal userUpdated();

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
                onClicked: userModifyPageId.appStackView.pop();
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
            //  branch:[] , step:[], study_base:[]
            //}

            ScrollView
            {
                Layout.columnSpan: 2
                Layout.fillHeight: true
                Layout.fillWidth: true
                contentHeight : updateUserFormGW.implicitHeight


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
                                horizontalAlignment: Text.AlignLeft
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
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft

                            }

                            Text {
                                text: "نام‌خانوادگی"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
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
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                            }

                            Text {
                                text: "جنسیت"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
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
                                horizontalAlignment: Text.AlignLeft
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
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                            }

                            Text {
                                text: "پست کاربر"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
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
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                            }

                            Text {
                                text: "شماره تماس"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
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
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                            }

                            //enabled
                            Text {
                                text: "فعال بودن کاربر"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
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

                            // //admin
                            Text {
                                text: "ادمین شعبه"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
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
                                    //updateUserAccPermId.visible=(checked)? false : true;
                                    adminWarningMessage.visible=(checked)? true : false;
                                }
                            }
                            Text {
                                id: adminWarningMessage
                                visible:  (userModifyPageId.user["admin"])? true : false
                                text: "هشدار! کاربر ادمین، دسترسی کامل به مدیریت سامانه دارد"
                                Layout.columnSpan: 2
                                Layout.alignment: Qt.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
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
                                //rows: 11
                                rowSpacing: 20
                                columnSpacing: 10

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
                                    Layout.preferredHeight: updateUserBranchesId.count*70

                                    Repeater
                                    {
                                        id: updateUserBranchesId
                                        model: ListModel {id: branchModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            checked: (userModifyPageId.branchPerm.indexOf(model.id) > -1)? true : false;
                                            height: 50;
                                            text: model.city + " - " + model.branch_name
                                            font.family: "B Yekan"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = userModifyPageId.branchPerm.indexOf(model.id);

                                                if(checked)
                                                {
                                                    //push step
                                                    if(index < 0)
                                                    userModifyPageId.branchPerm.push(model.id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    userModifyPageId.branchPerm.splice(index, 1);
                                                }

                                                UserMethods.checkBranch();

                                                UserMethods.updateStep()
                                                UserMethods.updateStudyBase()

                                            }
                                        }
                                    }
                                }

                                //  study step
                                Text {
                                    text: "دوره‌ها"
                                    visible: (updateUserAdminId.checked)? false : true;
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
                                    visible: (updateUserAdminId.checked)? false : true;
                                    Layout.columnSpan: 2
                                    flow: Flow.TopToBottom
                                    Layout.preferredHeight: updateUserStepId.count*70

                                    Repeater
                                    {
                                        id: updateUserStepId
                                        model: ListModel {id: stepModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            text: model.branch_name +" - "+ model.step_name
                                            checked: (userModifyPageId.stepPerm.indexOf(model.id) > -1)? true : false;
                                            font.family: "B Yekan"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = userModifyPageId.stepPerm.indexOf(model.id);
                                                if(checked)
                                                {
                                                    if(index < 0)
                                                    userModifyPageId.stepPerm.push(model.id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    userModifyPageId.stepPerm.splice(index, 1);
                                                }

                                                // write steps
                                                var index = userModifyPageId.selectedSteps.indexOf(model.id);
                                                if(checked)
                                                {
                                                    if(index < 0)
                                                        userModifyPageId.selectedSteps.push(model.id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                        userModifyPageId.selectedSteps.splice(index, 1);

                                                    UserMethods.checkStep();
                                                }

                                                UserMethods.updateStep();

                                            }
                                        }
                                    }
                                }

                                //  study base

                                Text {
                                    text: "پایه‌های تحصیلی"
                                    Layout.columnSpan: 2
                                    Layout.alignment: Qt.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                    visible: (updateUserAdminId.checked)? false : true;
                                }
                                Flow
                                {
                                    spacing: 20
                                    Layout.columnSpan: 2
                                    flow: Flow.TopToBottom
                                    Layout.preferredHeight: updateUserReadBasisId.count*70
                                    visible: (updateUserAdminId.checked)? false : true;

                                    Repeater
                                    {
                                        id: updateUserReadBasisId
                                        model: ListModel {id: baseModel }
                                        delegate:
                                        Switch{
                                            required property var model
                                            text: model.city +" - "+model.branch_name +" - "+model.study_base
                                            checked: (userModifyPageId.studyBasePerm.indexOf(model.id) > -1)? true : false;
                                            font.family: "B Yekan"
                                            font.pixelSize: 14
                                            onToggled:
                                            {
                                                var index = userModifyPageId.studyBasePerm.indexOf(model.id)

                                                if(checked)
                                                {
                                                    if(index < 0)
                                                    userModifyPageId.studyBasePerm.push(model.id);
                                                }
                                                else
                                                {
                                                    if(index > -1)
                                                    userModifyPageId.studyBasePerm.splice(index, 1);
                                                }

                                                UserMethods.updateStudyBase();
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

                                Component.onCompleted:
                                {
                                    UserMethods.updateBranches()
                                    UserMethods.updateStep()
                                    UserMethods.updateStudyBase()


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
                                    user["id"] = userModifyPageId.user["id"];
                                    user["name"] = updateUserNameId.text;
                                    user["lastname"] = updateUserLastNameId.text;
                                    user["nat_id"] = updateUserNatidId.text;
                                    user["job_position"] = updateUserPositionId.text
                                    user["telephone"] = updateUserTelId.text;


                                    var permission = {"branch":[], "step":[], "study_base":[]}
                                    var b = userModifyPageId.branchPerm;
                                    var s = userModifyPageId.stepPerm;
                                    var sb = userModifyPageId.studyBasePerm;

                                    permission["branch"]  = b;
                                    permission["step"] = s;
                                    permission["study_base"] = sb;

                                    user["permissions"] = permission;

                                    user["enabled"] = updateUserEnabledId.checked
                                    user["gender"] = updateUserGenderId.currentText
                                    user["admin"] = updateUserAdminId.checked

                                    if(updateUserAdminId.checked){
                                        permission["step"] = [];
                                        permission["study_base"] = [];
                                    }

                                    var check = true
                                    // check entries
                                    if(!UserMethods.checkFormEntries(user))
                                    {
                                        updateUserInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.updateUser(user))
                                    {
                                        //userModifyPageId.userUpdated(user);
                                        updateUserSuccessDialogId.open();
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
        modal: true
    }

    DialogBox.BaseDialog
    {
        id: updateUserSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ویرایش کاربر با موفقیت انجام گرفت."
        dialogSuccess: true
        modal: true   
        onDialogAccepted:
        {
            updateUserSuccessDialogId.close();
            userModifyPageId.appStackView.pop();
            userModifyPageId.userUpdated();
        }
    }

}
