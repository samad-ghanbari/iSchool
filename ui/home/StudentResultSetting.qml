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
    id: studentResultSettingPage

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;
    required property string class_name;
    required property int class_id;
    required property int student_id;
    required property string student;
    required property string student_photo;
    required property StackView appStackView;

    property var evals: []

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            color:"transparent"
            // Button
            // {
            //     height: 64
            //     width: 64
            //     anchors.left: parent.left
            //     background: Item{}
            //     icon.source: "qrc:/assets/images/arrow-right.png"
            //     icon.width: 64
            //     icon.height: 64
            //     icon.color:"transparent"
            //     opacity: 0.5
            //     onClicked: studentResultSettingPage.appStackView.pop();
            //     hoverEnabled: true
            //     onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            // }
            Text {
                width: parent.width
                height: parent.height
                Layout.preferredHeight: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "شعبه " + studentResultSettingPage.branch + " - " + studentResultSettingPage.step
                font.family: "B Yekan"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }

        }

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight:  150

            Image {
                source:studentResultSettingPage.student_photo
                Layout.preferredWidth: 150
                Layout.preferredHeight: 150
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }
            Column{
                Layout.fillWidth: true
                Layout.preferredHeight: 150

                Text {
                    width: parent.width
                    height: 50
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignLeft
                    text: studentResultSettingPage.student
                    font.family: "B Yekan"
                    font.pixelSize: 20
                    font.bold: true
                    color: "darkmagenta"
                }

                Text {
                    width: parent.width
                    height: 50
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignLeft
                    text: (studentResultSettingPage.field_based) ? "رشته " + studentResultSettingPage.field + " - " + " پایه " + studentResultSettingPage.base :  " پایه " + studentResultSettingPage.base
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                }

                Text {
                    width: parent.width
                    height: 50
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignLeft
                    text: " سال تحصیلی " +  studentResultSettingPage.period + " - " + " کلاس " + studentResultSettingPage.class_name
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                }
            }
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
            text: "کارنامه دانش‌آموز"
            font.family: "B Yekan"
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
                                checked: (studentResultSettingPage.evals.indexOf(model.id) > -1)? true : false;
                                Layout.fillWidth: true
                                Layout.maximumWidth: 500
                                Layout.preferredHeight: 50
                                Layout.alignment: Qt.AlignHCenter
                                text: " ارزیابی " + model.eval_name;
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                onToggled:
                                {
                                    var index = studentResultSettingPage.evals.indexOf(model.id);

                                    if(checked)
                                    {
                                        //push
                                        if(index < 0)
                                        studentResultSettingPage.evals.push(model.id);
                                    }
                                    else
                                    {
                                        if( index > -1 && (studentResultSettingPage.evals.length > 1) )
                                        studentResultSettingPage.evals.splice(index, 1);
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
                                    studentResultSettingPage.evals.push(obj.id)
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
                            font.family: "B Yekan"
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
                            font.family: "B Yekan"
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
                            font.family: "B Yekan"
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
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            onCheckedChanged: {
                                if(checked)
                                    customeBaseAvgSW.visible = true
                                else
                                    customeBaseAvgSW.visible = false
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
                            font.family: "B Yekan"
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
                                font.family: "B Yekan"
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
                                font.family: "B Yekan"
                                font.pixelSize: 16
                            }
                        }

                        Switch{
                            id: fieldBasedSW
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter
                            text: "گزارش مبتنی بر رشته " + studentResultSettingPage.field
                            checked: studentResultSettingPage.field_based
                            visible: studentResultSettingPage.field_based
                            font.family: "B Yekan"
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
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                text:"مرجع مقایسه رتبه و میانگین: "
                            }
                            ComboBox{
                                id: compareRef
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.bold: false
                                font.family: "B Yekan"
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
                            id: customeBaseAvgSW
                            Layout.fillWidth: true
                            Layout.maximumWidth: 500
                            Layout.preferredHeight: 50
                            Layout.alignment: Qt.AlignHCenter

                            text: "استفاده از میانگین دروس ثبت شده"
                            checked: true
                            font.family: "B Yekan"
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
                                font.family: "B Yekan"
                                font.pixelSize: 14
                                onClicked: { studentResultSettingPage.appStackView.pop(); }
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "mediumvioletred"}
                            }
                            Button
                            {
                                id: okBtn
                                text: "تایید"
                                Layout.preferredHeight:  50
                                Layout.preferredWidth:  200
                                font.family: "B Yekan"
                                font.pixelSize: 14
                                onClicked:
                                {
                                    saveFileDialog.open();
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

    // file dialog
    FileDialog {
        id: saveFileDialog
        title: "محل ذخیره گزارش"
        currentFolder: "file:///home/samad"
        //currentFolder: "C:/Users/YourUsername/Documents"
        nameFilters: ["PDF Files (*.pdf)", "All Files (*)"]
        fileMode: FileDialog.SaveFile
        onAccepted:{
            // student_id   class_id  evals  semester  baseRank classRank  baseAvg max_grade field_based
            var student_id = studentResultSettingPage.student_id
            var class_id = studentResultSettingPage.class_id
            var evals = studentResultSettingPage.evals
            var semester_flag = semesterColumnSW.checked
            var semester_value = semesterNumberTF.text
            var baseRank_flag = baseRankSW.checked
            var classRank_flag = classRankSW.checked
            var baseAvg_flag = baseAvgSW.checked
            var fieldBased_flag = fieldBasedSW.checked
            var maxGrade_flag = maxGradeSW.checked
            var compare_ref_id = compareRef.currentValue
            var compare_ref = compareRef.currentText

            var params = {
                "student_id": student_id,
                "class_id": class_id,
                "evals": evals,
                "semester_flag": semester_flag,
                "semester_value": semester_value,
                "baseRank_flag" : baseRank_flag,
                "classRank_flag" : classRank_flag,
                "baseAvg_flag" : baseAvg_flag,
                "fieldBased_flag" : fieldBased_flag,
                "maxGrade_flag" : maxGrade_flag,
                "compare_ref_id": compare_ref_id,
                "compare_ref" : compare_ref
            }

            //var result = dbMan.getStudentTranscript(params);


            if(dbMan.generatePdf(selectedFile, params))
            {
                infoDialogId.dialogTitle = "عملیات موفق"
                infoDialogId.dialogSuccess = true
                infoDialogId.width = 500
                infoDialogId.dialogText = "فایل در مسیر زیر ذخیره گردید." + "\n" + selectedFile
                infoDialogId.open();
            }
            else
            {
                infoDialogId.open();
            }
        }
        onRejected: saveFileDialog.close();
    }
}
