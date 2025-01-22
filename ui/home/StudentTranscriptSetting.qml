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
            Text {
                width: parent.width
                height: parent.height
                Layout.preferredHeight: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "شعبه " + studentResultSettingPage.branch + " - " + studentResultSettingPage.step
                font.family: "Kalameh"
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
                    font.family: "Kalameh"
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
                    font.family: "Kalameh"
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
                    font.family: "Kalameh"
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
            font.family: "Kalameh"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
        }

        Flickable{
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentHeight: centerBox.height
            clip: true

            Rectangle{
                width: (parent.width > 700)? 700 : parent.width
                height: centerBox.height + 100
                anchors.horizontalCenter: parent.horizontalCenter
                color: "snow"

                Column
                {
                    id: centerBox
                    width: parent.width

                    Label{
                        height: 50
                        width : parent.width
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        text:"تنظیمات کارنامه"
                        color: "slategray"
                    }

                    Repeater
                    {
                        id: evalsRp
                        model: ListModel{id: evalsModel;}
                        delegate:Switch{
                            required property var model
                            checked: (studentResultSettingPage.evals.indexOf(model.id) > -1)? true : false;
                            width: parent.width
                            height: 50
                            text: " ارزیابی " + model.eval_name;
                            font.family: "Kalameh"
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
                        width: parent.width
                        height: 50

                        text: "ارزیابی نیمسال"
                        checked: true
                        font.family: "Kalameh"
                        font.pixelSize: 16
                    }

                    Rectangle{width: parent.width;  height: 1; color: "slategray";}

                    Switch{
                        id: baseRankSW
                        width: parent.width
                        height: 50
                        text: "رتبه در پایه "
                        checked: true
                        font.family: "Kalameh"
                        font.pixelSize: 16
                    }

                    Switch{
                        id: classRankSW
                        width: parent.width
                        height: 50
                        text: "رتبه در کلاس "
                        checked: true
                        font.family: "Kalameh"
                        font.pixelSize: 16
                    }

                    Switch{
                        id: baseAvgSW
                        width: parent.width
                        height: 50
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
                        width: parent.width
                        height: 50
                        text: "بالاترین نمره پایه"
                        checked: true
                        font.family: "Kalameh"
                        font.pixelSize: 16
                    }

                    Rectangle{width: parent.width; height: 1; color: "slategray";}

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
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
                        width: parent.width
                        height: 50
                        text: "گزارش مبتنی بر رشته " + studentResultSettingPage.field
                        checked: studentResultSettingPage.field_based
                        visible: studentResultSettingPage.field_based
                        font.family: "Kalameh"
                        font.pixelSize: 16
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
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

                    Rectangle{width: parent.width; height: 1; color: "slategray";}

                    Switch{
                        id: predefinedBaseAvgSW
                        width: parent.width
                        height: 50
                        text: "استفاده از میانگین پایه دروس ثبت شده"
                        checked: true
                        font.family: "Kalameh"
                        font.pixelSize: 16
                    }

                    Rectangle{width: parent.width; height: 2; color: "black";}

                    // printer

                    Label{
                        width: parent.width
                        height: 50
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        text:"تنظیمات چاپ"
                        color: "slategray"
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"انداره صفحه: "
                        }
                        ComboBox{
                            id: paperSizeCB
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.bold: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ListModel{id: paperModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                paperModel.append({text: "A4 (8.3 inch x 11.7 inch)", value: "A4"});
                                paperModel.append({text: "A3 (11.7 inch x 16.5 inch)", value: "A3"});
                                paperSizeCB.currentIndex = paperSizeCB.indexOfValue("A4")
                            }
                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"اندازه فونت نمرات جدول: "
                        }
                        ComboBox{
                            id: contentFontSizeCB
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.bold: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ListModel{id: contentFSModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                contentFSModel.append({text: "8", value: 8});
                                contentFSModel.append({text: "10", value: 10});
                                contentFSModel.append({text: "12", value: 12});
                                contentFSModel.append({text: "14", value: 14});
                                contentFSModel.append({text: "16", value: 16});
                                contentFSModel.append({text: "18", value: 18});
                                contentFSModel.append({text: "20", value: 20});

                                contentFontSizeCB.currentIndex = contentFontSizeCB.indexOfValue(14)
                            }
                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"اندازه فونت تیتر جدول: "
                        }
                        ComboBox{
                            id: titrFontSizeCB
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.bold: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ListModel{id: titrFontModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                titrFontModel.append({text: "8 Bold", value: 8});
                                titrFontModel.append({text: "10 Bold", value: 10});
                                titrFontModel.append({text: "12 Bold", value: 12});
                                titrFontModel.append({text: "14 Bold", value: 14});
                                titrFontModel.append({text: "16 Bold", value: 16});
                                titrFontModel.append({text: "18 Bold", value: 18});
                                titrFontModel.append({text: "20 Bold", value: 20});

                                titrFontSizeCB.currentIndex = titrFontSizeCB.indexOfValue(12)
                            }
                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"فونت"
                        }
                        ComboBox{
                            id: fontCB
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.bold: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ListModel{id: fontModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                fontModel.append({text: "زر", value: "Zar"});
                                fontModel.append({text: "یکان", value: "B Yekan"});
                                fontModel.append({text: "تیتر", value: "Titr"});
                                fontModel.append({text: "کلمه", value: "Kalameh"});
                                fontModel.append({text: "نازنین", value: "B Nazanin"});
                                fontModel.append({text: "میترا", value: "Mitra"});

                                fontCB.currentIndex = fontCB.indexOfValue("Zar")
                            }
                        }
                    }


                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"رنگ پس‌زمینه نمرات بین ۱۷ تا ۱۵: "
                        }
                        Button{
                            id: btn17_15
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 50
                            background: Rectangle{color: highlight1_Dialog.selectedColor; border.width: 1; border.color: "gray"}
                            onClicked: highlight1_Dialog.open();
                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"رنگ پس‌زمینه نمرات بین ۱۵ تا ۱۲: "
                        }
                        Button{
                            id: btn15_12
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 50
                            background: Rectangle{color: highlight2_Dialog.selectedColor; border.width: 1; border.color: "gray"}
                            onClicked: highlight2_Dialog.open();
                        }
                    }


                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"رنگ پس‌زمینه نمرات بین ۱۲ تا ۱۰: "
                        }
                        Button{
                            id: btn12_10
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 50
                            background: Rectangle{color: highlight3_Dialog.selectedColor; border.width: 1; border.color: "gray"}
                            onClicked: highlight3_Dialog.open();
                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"رنگ پس‌زمینه نمرات زیر ۱۰: "
                        }
                        Button{
                            id: btn10
                            Layout.preferredWidth: 100
                            Layout.preferredHeight: 50
                            background: Rectangle{color: highlight4_Dialog.selectedColor; border.width: 1; border.color: "gray"}
                            onClicked: highlight4_Dialog.open();
                        }
                    }

                    Item{
                        width: parent.width
                        height: 20
                    }

                    // buttons

                    RowLayout
                    {
                        width: parent.width
                        height: 50
                        spacing: 10

                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}

                        Button{
                            text: "انصراف"
                            Layout.preferredHeight:  50
                            Layout.preferredWidth:  100
                            font.family: "Kalameh"
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
                            font.family: "Kalameh"
                            font.pixelSize: 14
                            onClicked:
                            {
                                saveFileDialog.open();
                            }

                            Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "darkcyan"}
                        }
                    }

                    Item{
                        width: parent.width
                        height: 20
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
        onDialogAccepted: studentResultSettingPage.appStackView.pop();
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
            var predefined_base_avg = predefinedBaseAvgSW.checked

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
                "compare_ref" : compare_ref,
                "predefined_base_avg": predefined_base_avg,
                "paperSize": paperSizeCB.currentValue,
                "fontFamily" : fontCB.currentValue,
                "contentFontSize": contentFontSizeCB.currentValue,
                "titrFontSize": titrFontSizeCB.currentValue
            }

            //var result = dbMan.getStudentTranscript(params);


            if(dbMan.generatePdf(selectedFile, params, highlight1_Dialog.selectedColor, highlight2_Dialog.selectedColor, highlight3_Dialog.selectedColor, highlight4_Dialog.selectedColor ))
            {
                successDialogId.width = 500
                successDialogId.dialogText = "فایل در مسیر زیر ذخیره گردید." + "\n" + selectedFile
                successDialogId.open();
            }
            else
            {
                infoDialogId.open();
            }
        }
        onRejected: saveFileDialog.close();
    }


    //highlight1
    ColorDialog {
        id: highlight1_Dialog
        title: "انتخاب رنگ"
        selectedColor: "#fcdadf"
    }

    // highlight2
    ColorDialog {
        id: highlight2_Dialog
        title: "انتخاب رنگ"
        selectedColor: "#f6aab6"
    }

    // highlight3
    ColorDialog {
        id: highlight3_Dialog
        title: "انتخاب رنگ"
        selectedColor: "#f495a4"
    }
    //highlight4
    ColorDialog {
        id: highlight4_Dialog
        title: "انتخاب رنگ"
        selectedColor: "#f17b8d"
    }

}
