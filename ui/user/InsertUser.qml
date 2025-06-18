pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts

import "./../public" as DialogBox
import "./User.js" as JS

Page {
    id: insertPage
    property var selectedBranches:[]
    property var selectedSteps:[]
    property var selectedBases:[]


    signal popSignal();
    signal insertedSignal();

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignLeft
            text: "افزودن کاربر جدید"
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
                    spacing: 10

                    Item{
                        width: parent.width
                        height: 64
                        Image {
                            source: "qrc:/assets/images/newUser.png"
                            height: 64
                            width: 64
                            anchors.centerIn: parent
                            NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
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
                        TextField
                        {
                            id: nameTF
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
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        TextField
                        {
                            id: lastnameTF
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
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        ComboBox
                        {
                            id: genderCB
                            Layout.preferredHeight:  50
                            Layout.fillWidth: true
                            Layout.maximumWidth: 200
                            editable: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ["خانم", "آقا"]
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
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
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        TextField
                        {
                            id: natIdTF
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
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        TextField
                        {
                            id: jobPositionTF
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
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        TextField
                        {
                            id: telephoneTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }
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


                    //enabled
                    RowLayout{
                        width: parent.width
                        height: 50
                        //enabled
                        Text {
                            text: "وضعیت فعال/غیرفعال"
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.bold: true
                            color: "darkcyan"
                        }
                        Switch
                        {
                            id: enabledSW
                            checked: true
                            text: checked? "فعال" : "غیرفعال";
                            font.family: "Kalameh"
                            palette.highlight: "darkcyan"
                            palette.text: "gray"
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                        }
                        Item{Layout.preferredHeight: 1; Layout.fillWidth: true;}
                    }

                    //admin
                    RowLayout{
                        width: parent.width
                        height: 50
                        //enabled
                        Text {
                            text: "ادمین شعبه"
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.bold: true
                            color: "darkcyan"
                        }
                        Switch
                        {
                            id: adminSW
                            checked: true
                            text: checked? "ادمین" : "غیرادمین";
                            font.family: "Kalameh"
                            palette.highlight: "darkcyan"
                            palette.text: "gray"
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                        }
                        Item{Layout.preferredHeight: 1; Layout.fillWidth: true;}
                    }

                    // Permissions
                    Rectangle
                    {
                        width: parent.width
                        height: 1
                        color: "darkcyan"
                    }

                    Text {
                        width: parent.width
                        height: 25
                        text: "دسترسی‌های کاربر"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                    }

                    // branches
                    Text {
                        text: "شعبه‌ها"
                        width: parent.width
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkslategray"
                    }
                    Flow
                    {
                        spacing: 20
                        flow: Flow.TopToBottom
                        height: branchesRp.count*70
                        width: parent.width

                        Repeater
                        {
                            id: branchesRp
                            model: ListModel {id: branchModel }
                            delegate:
                            Switch{
                                required property var model
                                checked: (insertPage.selectedBranches.indexOf(model.id) > -1)? true : false;
                                width: parent.width
                                height: 50;
                                text: model.city + " - " + model.branch_name
                                font.family: "Kalameh"
                                palette.highlight: "darkcyan"
                                font.pixelSize: 14
                                onToggled:
                                {
                                    var index = insertPage.selectedBranches.indexOf(model.id);

                                    if(checked)
                                    {
                                        //push step
                                        if(index < 0)
                                        insertPage.selectedBranches.push(model.id);
                                    }
                                    else
                                    {
                                        if(index > -1)
                                        insertPage.selectedBranches.splice(index, 1);
                                    }

                                    selectedSteps = dbMan.filterSteps(selectedBranches, selectedSteps);
                                    selectedBases = dbMan.filterBases(selectedSteps, selectedBases);
                                    JS.updateStep();
                                    JS.updateBases();
                                }
                            }
                        }
                        Component.onCompleted:
                        {
                            JS.updateBranches()
                        }
                    }

                    //steps
                    Text {
                        text: "دوره‌ها"
                        visible:(adminSW.checked)? false : true;
                        width: parent.width
                        height: 50
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkslategray"
                    }
                    Flow
                    {
                        spacing: 20
                        visible:(adminSW.checked)? false : true;
                        flow: Flow.TopToBottom
                        height: stepsRp.count*70
                        width: parent.width

                        Repeater
                        {
                            id: stepsRp
                            model: ListModel {id: stepModel }
                            delegate:
                            Switch{
                                required property var model
                                //s.id, s.branch_id, s.step_name, b.city, b.branch_name, s.field_based, s.numeric_graded
                                text: model.branch_name +" - "+ model.step_name
                                checked: (insertPage.selectedSteps.indexOf(model.id) > -1)? true : false;
                                width: parent.width
                                height: 50
                                font.family: "Kalameh"
                                palette.highlight: "darkcyan"
                                font.pixelSize: 14
                                onToggled:
                                {
                                    var index = insertPage.selectedSteps.indexOf(model.id);
                                    if(checked)
                                    {
                                        if(index < 0)
                                        insertPage.selectedSteps.push(model.id);
                                    }
                                    else
                                    {
                                        if(index > -1)
                                        insertPage.selectedSteps.splice(index, 1);
                                    }

                                    selectedBases = dbMan.filterBases(selectedSteps, selectedBases);
                                    JS.updateBases();
                                }
                            }
                        }
                    }

                    //bases
                    Text {
                        text: "پایه‌های تحصیلی"
                        visible:(adminSW.checked)? false : true;
                        width: parent.width
                        height: 50
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkslategray"
                    }
                    Flow
                    {
                        spacing: 20
                        visible:(adminSW.checked)? false : true;
                        flow: Flow.TopToBottom
                        height: basesRp.count*70
                        width: parent.width

                        Repeater
                        {
                            id: basesRp
                            model: ListModel {id: baseModel }
                            delegate:
                            Switch{
                                required property var model
                                // id text
                                text: model.text
                                checked: (insertPage.selectedBases.indexOf(model.id) > -1)? true : false;
                                width: parent.width
                                height: 50
                                font.family: "Kalameh"
                                palette.highlight: "darkcyan"
                                font.pixelSize: 14
                                onToggled:
                                {
                                    var index = insertPage.selectedBases.indexOf(model.id);
                                    if(checked)
                                    {
                                        if(index < 0)
                                        insertPage.selectedBases.push(model.id);
                                    }
                                    else
                                    {
                                        if(index > -1)
                                        insertPage.selectedBases.splice(index, 1);
                                    }
                                }
                            }
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
                            var user = {};
                            user["name"] = nameTF.text;
                            user["lastname"] = lastnameTF.text;
                            user["nat_id"] = natIdTF.text;
                            user["password"] = passwordTF.text;
                            user["confirm"] = confirmTF.text;
                            user["job_position"] = jobPositionTF.text
                            user["telephone"] = telephoneTF.text;

                            var permission = {"branch":[], "step":[], "base":[]}
                            var br = insertPage.selectedBranches;
                            var ss = insertPage.selectedSteps;
                            var sb = insertPage.selectedBases;

                            permission["branch"]  = br;
                            permission["step"] = ss;
                            permission["base"] = sb;

                            user["permissions"] = permission;

                            user["enabled"] = enabledSW.checked
                            user["admin"] = adminSW.checked
                            user["gender"] = genderCB.currentText

                            if(adminSW.checked)
                            {
                                permission["step"] = [];
                                permission["base"] = [];
                            }

                            var check = true
                            // check entries
                            if(!JS.checkFormEntries(user))
                            {
                                infoDialogId.open();
                                return;
                            }

                            if(dbMan.insertUser(user))
                            {
                                insertPage.insertedSignal();
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
                    }
                }
            }
        }
    }

    DialogBox.BaseDialog
    {
        id:infoDialogId
        dialogTitle: "خطا"
        dialogText: "ورود فیلد الزامی می‌باشد"
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "کاربر جدید با موفقیت به دیتابیس افزوده شد"
        dialogSuccess: true
        onDialogAccepted: {successDialogId.close(); insertPage.insertedSignal(); insertPage.popSignal();}

    }

}
