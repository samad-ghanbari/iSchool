pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "./User.js" as JS

Page {
    id: updatePage

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

    property var selectedBranches : permissions["branch"];
    property var selectedSteps: permissions["step"];
    property var selectedBases: permissions["base"];


    signal popSignal();
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
            text: "ویرایش کاربر"
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
                            source: "qrc:/assets/images/edit.png"
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
                            text : updatePage.name
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
                            text : updatePage.lastname
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

                            Component.onCompleted: genderCB.currentIndex = genderCB.find(updatePage.gender)
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
                            text : updatePage.nat_id
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
                            text : updatePage.job_position
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
                            text : updatePage.telephone
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
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
                            checked: updatePage.enabled
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
                            checked: updatePage.admin
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
                                checked: (updatePage.selectedBranches.indexOf(model.id) > -1)? true : false;
                                width: parent.width
                                height: 50;
                                text: model.city + " - " + model.branch_name
                                font.family: "Kalameh"
                                palette.highlight: "darkcyan"
                                font.pixelSize: 14
                                onToggled:
                                {
                                    var index = updatePage.selectedBranches.indexOf(model.id);

                                    if(checked)
                                    {
                                        //push step
                                        if(index < 0)
                                        updatePage.selectedBranches.push(model.id);
                                    }
                                    else
                                    {
                                        if(index > -1)
                                        updatePage.selectedBranches.splice(index, 1);
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
                                checked: (updatePage.selectedSteps.indexOf(model.id) > -1)? true : false;
                                width: parent.width
                                height: 50
                                font.family: "Kalameh"
                                palette.highlight: "darkcyan"
                                font.pixelSize: 14
                                onToggled:
                                {
                                    var index = updatePage.selectedSteps.indexOf(model.id);
                                    if(checked)
                                    {
                                        if(index < 0)
                                        updatePage.selectedSteps.push(model.id);
                                    }
                                    else
                                    {
                                        if(index > -1)
                                        updatePage.selectedSteps.splice(index, 1);
                                    }

                                    selectedBases = dbMan.filterBases(selectedSteps, selectedBases);
                                    JS.updateBases();
                                }
                            }
                        }

                        Component.onCompleted: JS.updateStep();
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
                                checked: (updatePage.selectedBases.indexOf(model.id) > -1)? true : false;
                                width: parent.width
                                height: 50
                                font.family: "Kalameh"
                                palette.highlight: "darkcyan"
                                font.pixelSize: 14
                                onToggled:
                                {
                                    var index = updatePage.selectedBases.indexOf(model.id);
                                    if(checked)
                                    {
                                        if(index < 0)
                                        updatePage.selectedBases.push(model.id);
                                    }
                                    else
                                    {
                                        if(index > -1)
                                        updatePage.selectedBases.splice(index, 1);
                                    }
                                }
                            }
                        }

                        Component.onCompleted: JS.updateBases();
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
                            user["id"] = updatePage.user_id;
                            user["name"] = nameTF.text;
                            user["lastname"] = lastnameTF.text;
                            user["nat_id"] = natIdTF.text;
                            user["job_position"] = jobPositionTF.text
                            user["telephone"] = telephoneTF.text;

                            var permission = {"branch":[], "step":[], "base":[]}
                            var br = updatePage.selectedBranches;
                            var ss = updatePage.selectedSteps;
                            var sb = updatePage.selectedBases;

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
                            if(!JS.checkFormEntries(user, false))
                            {
                                infoDialogId.open();
                                return;
                            }

                            if(dbMan.updateUser(user))
                            {
                                updatePage.updatedSignal();
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
        dialogText: "ویرایش کاربر با موفقیت انجام شد."
        dialogSuccess: true
        onDialogAccepted: {successDialogId.close(); updatePage.updatedSignal(); updatePage.popSignal();}
    }
}
