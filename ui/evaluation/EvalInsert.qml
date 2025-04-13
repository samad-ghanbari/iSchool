pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: insertPage

    signal popStackSignal();
    signal insertedSignal();

    required property int step_id;
    required property int base_id;
    required property int period_id;
    required property bool field_based;

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property string period;

    background: Rectangle{anchors.fill: parent; color: "honeydew"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن ارزیابی جدید"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        Flickable{
            Layout.fillHeight: true
            Layout.fillWidth: true
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

                    Image
                    {
                        width: 64
                        height: 64
                        anchors.horizontalCenter: parent.horizontalCenter
                        source:  "qrc:/assets/images/evaluation.png"
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }

                    //branch
                    Text {
                        width: parent.width
                        height: 50
                        text: insertPage.branch + " - " + insertPage.step
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text {
                        text: (insertPage.field_based) ? insertPage.field + " - " +  insertPage.base :  insertPage.base
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Row{
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text {
                            text: "سال تحصیلی "
                            height: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        Text {
                            text:  insertPage.period
                            height: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                    }

                    // semester
                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "نیمسال"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        ComboBox
                        {
                            id: semesterCB
                            Layout.preferredHeight:  50
                            Layout.fillWidth: true
                            editable: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ListModel{id: semModel;}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted: {
                                semModel.append({text:"نیمسال اول", value: 1});
                                semModel.append({text:"نیمسال دوم", value: 2});
                                semesterCB.currentIndex = 0;
                            }

                            onActivated: sortSB.value = dbMan.getEvalMaxSort(insertPage.step_id, insertPage.base_id, insertPage.period_id, semesterCB.currentValue) + 1;
                        }
                    }

                    // eval name
                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "نام ارزیابی"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        TextField
                        {
                            id: evalNameTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "نام ارزیابی"
                        }
                    }
                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    // max grade
                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "بیشترین نمره"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        TextField
                        {
                            id: maxGradeTF
                            Layout.fillWidth: true
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text: "20"
                            placeholderText: "بیشترین نمره"
                            validator: RegularExpressionValidator{regularExpression: /^-?\d*\.?\d+$/ }
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    ButtonGroup{
                        id: courseTestBG
                    }

                    GroupBox{
                        height: 120
                        width: parent.width

                        //title: "ارزیابی واحد درسی / تستی"
                        // course flag
                        Switch{
                            id: courseFlagSW
                            width: parent.width
                            height: 50
                            anchors.topMargin: 10
                            ButtonGroup.group: courseTestBG
                            text: "ارزیابی تشریحی"
                            checked: true
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            onClicked: {
                                if(checked)
                                {
                                    //testFlagSW.checked = false;
                                    maxGradeTF.text = "20"
                                }
                            }

                            onCheckedChanged:{
                                if(!courseFlagSW.checked)
                                {
                                    if(!testFlagSW.checked)
                                    courseFlagSW.checked = true;
                                    else
                                    courseFlagSW.checked = false;
                                }
                            }
                        }

                        // test flag
                        Switch{
                            id: testFlagSW
                            width: parent.width
                            height: 50
                            anchors.top: courseFlagSW.bottom
                            ButtonGroup.group: courseTestBG
                            text: "ارزیابی تستی"
                            checked: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            onClicked: {
                                if(checked)
                                {
                                    //courseFlagSW.checked = false;
                                    maxGradeTF.text = "100"
                                }
                            }
                            onCheckedChanged:{
                                if(!testFlagSW.checked)
                                {
                                    if(!courseFlagSW.checked)
                                    testFlagSW.checked = true;
                                    else
                                    testFlagSW.checked = false;
                                }
                            }
                        }

                    }

                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    ButtonGroup{
                        id: monthMidFormFinalBG
                    }

                    GroupBox{
                        width: parent.width
                        height: 220
                        //title : "نوع ارزیابی"

                        // per month flag
                        Switch{
                            id: perMonthFlagSW
                            width: parent.width
                            height: 50
                            anchors.topMargin: 10;
                            ButtonGroup.group: monthMidFormFinalBG
                            text: "ارزیابی ماهیانه"
                            checked: true
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            onClicked: {
                                if(checked){
                                    maxGradeTF.text = 20;
                                }
                            }
                            onCheckedChanged:{
                                if(!perMonthFlagSW.checked && ! midtermFlagSW.checked && ! formativeFlagSW.checked && !finalFlagSW.checked)
                                {
                                    perMonthFlagSW.checked = true;
                                }
                            }
                        }

                        // midterm flag
                        Switch{
                            id: midtermFlagSW
                            width: parent.width
                            height: 50
                            anchors.top : perMonthFlagSW.bottom
                            ButtonGroup.group: monthMidFormFinalBG
                            text: "ارزیابی میان‌ترم"
                            checked: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            onCheckedChanged:{
                                if(!perMonthFlagSW.checked && ! midtermFlagSW.checked && ! formativeFlagSW.checked && !finalFlagSW.checked)
                                {
                                    midtermFlagSW.checked = true;
                                }
                            }
                        }

                        // mostamar flag
                        Switch{
                            id: formativeFlagSW
                            width: parent.width
                            height: 50
                            anchors.top : midtermFlagSW.bottom
                            ButtonGroup.group: monthMidFormFinalBG
                            text: "ارزیابی مستمر یا تکویتی"
                            checked: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            onClicked: {
                                if(checked){
                                    maxGradeTF.text = 20;
                                }
                            }
                            onCheckedChanged:{
                                if(!perMonthFlagSW.checked && ! midtermFlagSW.checked && ! formativeFlagSW.checked && !finalFlagSW.checked)
                                {
                                    formativeFlagSW.checked = true;
                                }
                            }
                        }

                        // final flag
                        Switch{
                            id: finalFlagSW
                            width: parent.width
                            height: 50
                            anchors.top: formativeFlagSW.bottom
                            ButtonGroup.group: monthMidFormFinalBG
                            text: "ارزیابی نهایی "
                            checked: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            onCheckedChanged:{
                                if(!perMonthFlagSW.checked && ! midtermFlagSW.checked && ! formativeFlagSW.checked && !finalFlagSW.checked)
                                {
                                    finalFlagSW.checked = true;
                                }
                            }

                        }
                    }
                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    // sort priority
                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "اولویت نمایش"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        SpinBox
                        {
                            id: sortSB
                            Layout.fillWidth: true
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            value: dbMan.getEvalMaxSort(insertPage.step_id, insertPage.base_id, insertPage.period_id, semesterCB.currentValue) + 1;
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    Item{width: parent.width; height: 50;}


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
                            var eval = {};
                            eval["step_id"] = insertPage.step_id
                            eval["base_id"] = insertPage.base_id
                            eval["period_id"] = insertPage.period_id

                            eval["eval_name"] = evalNameTF.text
                            var grade = maxGradeTF.text
                            eval["max_grade"] = parseFloat(grade)
                            eval["course_flag"] = courseFlagSW.checked
                            eval["test_flag"] = testFlagSW.checked
                            eval["per_month"] = perMonthFlagSW.checked
                            eval["midterm"] = midtermFlagSW.checked
                            eval["formative"] = formativeFlagSW.checked
                            eval["final_flag"] = finalFlagSW.checked
                            eval["semester"] = semesterCB.currentValue

                            eval["sort_priority"] = sortSB.value



                            if(dbMan.insertEval(eval))
                            {
                                insertPage.insertedSignal();
                                successDialogId.open();
                            }
                            else
                            {
                                var errorString = dbMan.getLastError();
                                infoDialogId.dialogText = errorString
                                infoDialogId.width = parent.width
                                infoDialogId.height = 500
                                infoDialogId.open();
                            }
                        }
                    }

                    Item
                    {
                        width: parent.width
                        height: 5
                    }
                }
            }
        }
    }

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن ارزیابی جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ارزیابی جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            insertPage.popStackSignal();
        }

    }
}
