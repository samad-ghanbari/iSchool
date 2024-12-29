pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "./Evals.js" as Methods

Page {
    id: insertPage

    required property string branch
    required property string step
    required property string base
    required property string period

    required property int step_id
    required property int base_id
    required property int period_id

    required property string eval_cat
    required property int eval_cat_id
    required property bool test_flag
    required property bool final_flag

    signal popStackSignal();
    signal insertedSignal();

    property var allBaseClasses : dbMan.getClasses(insertPage.step_id, insertPage.base_id, insertPage.period_id);

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    GridLayout
    {
        columns: 2
        anchors.fill: parent

        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/arrow-right.png"
            icon.width: 64
            icon.height: 64
            icon.color:"transparent"
            opacity: 0.5
            onClicked: insertPage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ثبت ارزیابی جدید"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        ScrollView
        {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            Rectangle
            {
                width: (parent.width > 700)? 700 : parent.width
                implicitHeight : centerBox.implicitHeight + 40
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"

                GridLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20
                    columns: 2

                    Image
                    {
                        Layout.columnSpan: 2
                        Layout.preferredWidth: 128
                        Layout.preferredHeight: 128
                        Layout.alignment: Qt.AlignHCenter
                        source:  "qrc:/assets/images/evaluation.png"
                    }

                    // branch
                    Text {
                        text: "شعبه" + " " + insertPage.branch
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }

                    // step base
                    Text {
                        text: {
                            if(insertPage.base.indexOf("پایه") == -1)
                            return insertPage.step + " - پایه " + insertPage.base;
                            else
                            return insertPage.step + " - " + insertPage.base;
                        }
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }

                    // period
                    Text {
                        text: "سال تحصیلی" + " " + insertPage.period
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    // eval cat
                    Text {
                        text:  insertPage.eval_cat
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        font.bold: true
                        color: "mediumvioletred"
                    }

                    // course
                    Text {
                        text: "درس"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    ComboBox
                    {
                        id: courseCB
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        model:ListModel { id: courseCBoxModel; }
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted: {
                            Methods.updateCourseCB(insertPage.step_id, insertPage.base_id, insertPage.period_id);
                            courseCBoxModel.append({ value: -1, text:"همه دروس"});
                        }
                        onActivated:{
                            var course_id = courseCB.currentValue;
                            if(course_id > -1)
                            {

                                if(dbMan.isStepCourse(course_id))
                                    classCBoxModel.append({ value: -1, text:"ارزیابی پایه"});
                                else
                                {
                                    Methods.updateClassCB(course_id);
                                    classCBoxModel.append({ value: 0, text:"همه کلاس‌ها"});
                                }
                            }
                            else
                            {
                                classCBoxModel.clear();
                                var jsondata = insertPage.allBaseClasses
                                for(var obj of jsondata)
                                {
                                    classCBoxModel.append({value: obj.id,  text: obj.class_name });
                                }
                                classCBoxModel.append({ value: 0, text:"همه کلاس‌ها"});
                            }
                        }
                    }

                    //class
                    Text {
                        text: "کلاس"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                        visible: (insertPage.base_id > -1)? true : false;
                    }
                    ComboBox
                    {
                        id: classCB
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        model:ListModel { id: classCBoxModel; }
                        textRole: "text"
                        valueRole: "value"
                        visible: (insertPage.base_id > -1)? true : false;
                    }

                    // eval time
                    Text {
                        text: "زمان ارزیابی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                        visible : (courseCB.currentValue > -1)? true : false
                    }
                    TextField
                    {
                        id: evaltimeTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        placeholderText: "1403/08/10"
                        validator: RegularExpressionValidator
                        {
                            regularExpression: /^\d{4}\/\d{2}\/\d{2}$/
                            // Regex pattern to match date in yyyy/MM/dd format
                        }
                        visible : (courseCB.currentValue > -1)? true : false
                    }

                    //max value
                    Text {
                        text: "بالاترین نمره"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    TextField
                    {
                        id: maxGradeTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        placeholderText: "مقدار عددی مانند ۲۰"
                        validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                            regularExpression: /^-?\d*\.?\d+$/
                        }
                    }

                    //report included
                    Text {
                        text: "تاثیر در ارزیابی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Switch
                    {
                        id: includedSW
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignLeft
                        checked: true

                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                    }

                    Button
                    {
                        text: "تایید"
                        Layout.columnSpan: 2
                        Layout.preferredWidth: 200
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                        enabled: {
                            var stepFlag;
                            if( (insertPage.base_id > -1) && (classCB.currentValue > -1) )
                            stepFlag = true;
                            else
                            stepFlag = false;

                            if(  (maxGradeTF.text !== "") && stepFlag )
                            return true;
                            else
                            return false;
                        }
                        onClicked:
                        {
                            var Eval = {};
                            Eval["eval_cat_id"] = insertPage.eval_cat_id
                            Eval["course_id"] = courseCB.currentValue
                            // class
                            // -1 : step eval
                            // 0  : all class
                            if(insertPage.base_id > -1)
                            Eval["class_id"] = classCB.currentValue
                            else
                            Eval["class_id"] = -1;
                            if(courseCB.currentValue > -1)
                                Eval["eval_time"] = evaltimeTF.text
                            else
                                Eval["eval_time"] = ""

                            Eval["max_grade"] = parseFloat(maxGradeTF.text)
                            Eval["included"] = includedSW.checked

                            // all class ids
                            var allClassId = [];
                            for (var c of insertPage.allBaseClasses)
                            {
                                allClassId.push(c.id);
                            }

                            Eval["all_class"] = allClassId;

                            if(dbMan.evalInsert(Eval))
                            {
                                // insert student_evals : student_id, eval_id
                                var eval_id = dbMan.getLastInsertedId();
                                // student of class
                                var class_id = classCB.currentValue

                                if(dbMan.StudentEvalEvaluationInsert(eval_id, class_id))
                                {
                                    successDialogId.dialogText = "ارزیابی جدید با موفقیت افزوده شد." + "\n" + "ارزیابی دانش‌آموزان کلاس بروز گردید."
                                    successDialogId.open();
                                }
                                else
                                {
                                    successDialogId.dialogText = "ارزیابی جدید با موفقیت افزوده شد."
                                    successDialogId.open();
                                }
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
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
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
            insertPage.insertedSignal();
        }

    }
}
