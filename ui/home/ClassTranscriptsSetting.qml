import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import "./../public" as DialogBox
/*
    row
    course name
    coeff
    evals
    base rank
    class rank
    base avg
    max grade

    student count class/base
    avg
    avg rank class
    avg rank base
    course base avg

*/
Page {
    id: classTranscriptsSettingPage

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;
    required property string class_name;
    required property int class_id;
    required property StackView appStackView;

    property var evals: []

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent


            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "شعبه " + classTranscriptsSettingPage.branch + " - " + classTranscriptsSettingPage.step
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }


            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: (classTranscriptsSettingPage.field_based) ? "رشته " + classTranscriptsSettingPage.field + " - " + " پایه " + classTranscriptsSettingPage.base :  " پایه " + classTranscriptsSettingPage.base
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }

            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: " سال تحصیلی " +  classTranscriptsSettingPage.period + " - " + " کلاس " + classTranscriptsSettingPage.class_name
                font.family: "Kalameh"
                font.pixelSize: 20
                font.bold: true
                color: "darkmagenta"
            }




        Rectangle{
            Layout.preferredHeight: 1
            Layout.fillWidth: true
            //Layout.maximumWidth: 700
            Layout.alignment: Qt.AlignHCenter
            color: "darkgray"
        }

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 25
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "کارنامه دانش‌آموزان کلاس"
            font.family: "Kalameh"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
        }


        Rectangle{
            id: mainBox
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 600
            Layout.topMargin: 20
            color: "transparent"

            ScrollView{
                anchors.fill: parent
                contentHeight: rectSV.height

                Rectangle{
                    id: rectSV
                    width: parent.width
                    height: centerlayout.height + 50

                    ColumnLayout
                    {
                        id: centerlayout
                        width: parent.width

                        Repeater
                        {
                            id: evalsRp
                            model: ListModel{id: evalsModel;}
                            delegate:Switch{
                                required property var model
                                checked: (classTranscriptsSettingPage.evals.indexOf(model.id) > -1)? true : false;
                                Layout.fillWidth: true
                                Layout.maximumWidth: 500
                                Layout.preferredHeight: 50
                                Layout.alignment: Qt.AlignHCenter
                                text: " ارزیابی " + model.eval_name;
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                onToggled:
                                {
                                    var index = classTranscriptsSettingPage.evals.indexOf(model.id);

                                    if(checked)
                                    {
                                        //push
                                        if(index < 0)
                                        classTranscriptsSettingPage.evals.push(model.id);
                                    }
                                    else
                                    {
                                        if( index > -1 && (classTranscriptsSettingPage.evals.length > 1) )
                                        classTranscriptsSettingPage.evals.splice(index, 1);
                                        else
                                        this.checked = true
                                    }
                                }
                            }

                            Component.onCompleted:{
                                var jsondata = dbMan.getEvals();
                                //id, eval_name, base_id, period_id, test_flag, final_flag, max_grade
                                for(var obj of jsondata)
                                {
                                    classTranscriptsSettingPage.evals.push(obj.id)
                                    evalsModel.append(obj);
                                }
                            }
                        }

                        Switch{
                            id: semesterColumnSW
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter

                            text: "ارزیابی نیمسال"
                            checked: true
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }

                        Rectangle{Layout.fillWidth: true; Layout.maximumWidth: 500; Layout.alignment: Qt.AlignHCenter; Layout.preferredHeight: 1; color: "slategray";}

                        Switch{
                            id: baseRankSW
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter

                            text: "رتبه در پایه "
                            checked: true
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }

                        Switch{
                            id: classRankSW
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter

                            text: "رتبه در کلاس "
                            checked: true
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }

                        Switch{
                            id: baseAvgSW
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter

                            text: "میانگین پایه"
                            checked: true
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            onCheckedChanged: {
                                if(checked)
                                    predefinedBaseAvgSW.visible = true
                                else
                                    predefinedBaseAvgSW.visible = false
                            }
                        }

                        Switch{
                            id: maxGradeSW
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter

                            text: "بالاترین نمره پایه"
                            checked: true
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }

                        Rectangle{Layout.fillWidth: true; Layout.maximumWidth: 500; Layout.alignment: Qt.AlignHCenter; Layout.preferredHeight: 1; color: "slategray";}

                        RowLayout{
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter

                            Label{
                                Layout.preferredHeight: 50
                                Layout.preferredWidth: 100
                                Layout.alignment: Qt.AlignLeft
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                text:"نیمسال: "
                            }
                            TextField{
                                id: semesterNumberTF
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                placeholderText: "اول"
                                text: "اول"
                                font.bold: false
                                font.family: "Kalameh"
                                font.pixelSize: 16
                            }
                        }

                        Switch{
                            id: fieldBasedSW
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter
                            text: "گزارش مبتنی بر رشته " + classTranscriptsSettingPage.field
                            checked: classTranscriptsSettingPage.field_based
                            visible: classTranscriptsSettingPage.field_based
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }

                        RowLayout{
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter

                            Label{
                                Layout.preferredHeight: 50
                                Layout.preferredWidth: 200
                                Layout.alignment: Qt.AlignLeft
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                text:"مرجع مقایسه رتبه و میانگین: "
                            }
                            ComboBox{
                                id: compareRef
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.bold: false
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                model: ListModel{id: refModel}
                                textRole: "text"
                                valueRole: "value"
                                Component.onCompleted:
                                {
                                    //compareRef.currentIndex = -1
                                    refModel.clear();
                                    var jsondata = dbMan.getEvals();
                                    var finalValue = -1
                                    //id, eval_name, base_id, period_id, test_flag, final_flag, max_grade
                                    refModel.append({text: "ارزیابی نیمسال " , value: 0});
                                    for(var obj of jsondata)
                                    {
                                        if(obj.test_flag === false)
                                            refModel.append({text: "آزمون " + obj.eval_name, value: obj.id});
                                        if(obj.final_flag === true)
                                            finalValue = obj.id
                                    }
                                    compareRef.currentIndex = compareRef.indexOfValue(finalValue)
                                }
                            }
                        }

                        Rectangle{Layout.fillWidth: true; Layout.maximumWidth: 500; Layout.alignment: Qt.AlignHCenter; Layout.preferredHeight: 1; color: "slategray";}

                        Switch{
                            id: predefinedBaseAvgSW
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter

                            text: "استفاده از میانگین پایه دروس ثبت شده"
                            checked: true
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }

                        Item{
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                        }

                        RowLayout
                        {
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500;
                            Layout.alignment: Qt.AlignHCenter

                            spacing: 10

                            Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}

                            Button{
                                text: "انصراف"
                                Layout.preferredHeight:  50
                                Layout.preferredWidth:  100
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                onClicked: { classTranscriptsSettingPage.appStackView.pop(); }
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "mediumvioletred"}
                            }
                            Button
                            {
                                id: okBtn
                                text: "تایید"
                                Layout.preferredHeight:  50
                                Layout.preferredWidth:  200
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                onClicked:
                                {
                                    saveFolderDialog.open();
                                }

                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "darkcyan"}
                            }
                        }

                    }
                }
            }
        }
    }


    //dialog error
    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "عملیات با خطا مواجه شد."
        dialogSuccess: false
    }

    //dialog error
    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: ""
        dialogSuccess: true
        onDialogAccepted: classTranscriptsSettingPage.appStackView.pop();
    }


    // file dialog
    FolderDialog {
        id: saveFolderDialog
        title: "محل ذخیره گزارش"
        currentFolder: "file:///home/samad"
        //currentFolder: "C:/Users/YourUsername/Documents"
        onAccepted:{
            // class_id  evals  semester  baseRank classRank  baseAvg max_grade field_based
            var class_id = classTranscriptsSettingPage.class_id
            var evals = classTranscriptsSettingPage.evals
            var semester_flag = semesterColumnSW.checked
            var semester_value = semesterNumberTF.text
            var baseRank_flag = baseRankSW.checked
            var classRank_flag = classRankSW.checked
            var baseAvg_flag = baseAvgSW.checked
            var fieldBased_flag = fieldBasedSW.checked
            var maxGrade_flag = maxGradeSW.checked
            var compare_ref_id = compareRef.currentValue
            var compare_ref = compareRef.currentText
            var predefined_base_avg = predefinedBaseAvgSW.checked

            var params = {
                "class_id": class_id,
                "class_name": classTranscriptsSettingPage.class_name,
                "period": classTranscriptsSettingPage.period,
                "evals": evals,
                "semester_flag": semester_flag,
                "semester_value": semester_value,
                "baseRank_flag" : baseRank_flag,
                "classRank_flag" : classRank_flag,
                "baseAvg_flag" : baseAvg_flag,
                "fieldBased_flag" : fieldBased_flag,
                "maxGrade_flag" : maxGrade_flag,
                "compare_ref_id": compare_ref_id,
                "compare_ref" : compare_ref,
                "predefined_base_avg": predefined_base_avg
            }


            if(dbMan.generateClassTranscripts(saveFolderDialog.selectedFolder, params))
            {
                successDialogId.width = 500
                successDialogId.dialogText = "فایل‌ها در مسیر زیر ذخیره گردید." + "\n" + saveFolderDialog.selectedFolder
                successDialogId.open();
            }
            else
            {
                infoDialogId.width = 500;
                infoDialogId.dialogText = "برای دانش‌آموزان زیر کارنامه صادر نشد" + "\n" + dbMan.getLastError();
                infoDialogId.open();
            }
        }
        onRejected: saveFolderDialog.close();
    }
}
