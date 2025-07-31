import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts
import QtQuick.Dialogs

import "./../public" as DialogBox

Column {
    id: reportPage

    spacing: 5
    required property string class_base_report;
    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;

    required property string class_name;
    required property int class_id;

    property string evalType : "semester" // per_month - midterm semester period
    property int semester_number : (dbMan.getCurrentSemester() === 1)? 1 : 2;

    property var allEvals: dbMan.getEvals(); // [{eval-1}, {eval-2}]

    signal popSignal();

    function updateRefModel(){

        refModel.clear();
        testRefModel.clear();
        var final_value = -1;

        if(semester_number == 0)
        {
            refModel.append({text: "میانگین نهایی اول/دوم", value: -500});
            refModel.append({text: "میانگین نیمسال اول/دوم", value: -612});
            refModel.append({text: "نیمسال اول", value: -601});
            refModel.append({text: "نیمسال دوم", value: -602});

            for( var obj of allEvals)
            {
                if(obj["test_flag"] === false)
                {
                    if( (obj["formative"] === true) || (obj["final_flag"] === true) )
                    {
                        if(obj["semester"] === 1)
                            refModel.append({text: "آزمون " + obj.eval_name +" نیمسال اول ", value: obj.id});
                        else if(obj["semester"] === 2)
                            refModel.append({text: "آزمون " + obj.eval_name +" نیمسال دوم ", value: obj.id});
                    }
                }
                else
                {
                    if(obj["semester"] === 1)
                        testRefModel.append({text: "آزمون " + obj.eval_name +" نیمسال اول ", value: obj.id});
                    else if(obj["semester"] === 2)
                        testRefModel.append({text: "آزمون " + obj.eval_name +" نیمسال دوم ", value: obj.id});
                }
            }

            compareRef.currentIndex = compareRef.indexOfValue(-500)
            if(testRefModel.count > 0)
                compareTestRef.currentIndex = 0;
        }
        else
        {
            if(evalType === "per_month")
            {
                for(obj of allEvals)
                {
                    if( (obj["per_month"] === true) && (obj["semester"] === semester_number) )
                    {
                        if(obj["test_flag"] === false)
                        {
                            if(obj["semester"] === 1)
                                refModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                            else if(obj["semester"] === 2)
                                refModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});
                        }
                        else
                        {
                            if(obj["semester"] === 1)
                                testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                            else if(obj["semester"] === 2)
                                testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});
                        }
                    }

                }

                refModel.append({text: "میانگین ماهیانه", value: -12});
                compareRef.currentIndex = 0

                if(testRefModel.count > 0)
                    compareTestRef.currentIndex = 0;
            }
            else if(evalType === "midterm")
            {
                for(obj of allEvals)
                {
                    if(obj["semester"] === semester_number)
                    {
                        if( (obj["per_month"] === true) ||  (obj["midterm"] === true))
                        {
                            if(obj["test_flag"] === false)
                            {
                                if(obj["semester"] === 1)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                else if(obj["semester"] === 2)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});

                                if(final_value == -1)
                                    if((obj["midterm"] === true))
                                        final_value = obj["id"];
                            }
                            else
                            {
                                if(obj["semester"] === 1)
                                    testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                else if(obj["semester"] === 2)
                                    testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});
                            }
                        }
                    }
                }

                refModel.append({text: "میانگین ماهیانه", value: -12});
                compareRef.currentIndex = compareRef.indexOfValue(final_value);

                if(testRefModel.count > 0)
                    compareTestRef.currentIndex = 0;
            }
            else if(evalType === "semester")
            {
                final_value = -1;

                for(obj of allEvals)
                {
                    if(obj["semester"] === semester_number)
                    {
                        if( (obj["formative"] === true) ||  (obj["final_flag"] === true) ||  ( (obj["per_month"] === false) && (obj["midterm"] === false) ) )
                        {
                            if(obj["test_flag"] === false)
                            {
                                if(obj["semester"] === 1)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                else if(obj["semester"] === 2)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});

                                if(final_value == -1)
                                    if((obj["final_flag"] === true) && (obj["test_flag"] === false))
                                        final_value = obj["id"];
                            }
                            else
                            {
                                if(obj["semester"] === 1)
                                    testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                else if(obj["semester"] === 2)
                                    testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});
                            }

                        }
                    }
                }

                compareRef.currentIndex = compareRef.indexOfValue(final_value);

                if(testRefModel.count > 0)
                    compareTestRef.currentIndex = 0;
            }
        }
    }

    Label{
        height: 50
        width : parent.width
        horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
        font.family: "Kalameh"
        font.pixelSize: 16
        text:"تنظیمات گزارش"
        color: "slategray"
    }

    ButtonGroup{
        id: semesterGB;
    }
    ButtonGroup{
        id: typeBG;
    }

    Label{
                color: "darkmagenta"
                text: "مقطع زمانی"
                width: parent.width
                horizontalAlignment: Label.AlignLeft
            }
    GroupBox{
        width: parent.width
        height: 80
        padding: 0

        RowLayout{
            width: parent.width
            height: 50

            // semester 1
            Switch{
                id: semester1RB
                Layout.preferredHeight:  50
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                ButtonGroup.group: semesterGB
                text: "نیمسال اول"
                checked: (reportPage.semester_number === 1)? true : false;
                font.family: "Kalameh"
                font.pixelSize: 16
                palette.highlight: "darkmagenta"
                palette.text: (checked)? "darkmagenta" : "gray"
                onCheckedChanged:  {
                    if(!checked)
                    {
                        if(!semester2RB.checked && !periodRB.checked)
                            semester1RB.checked = true;
                    }

                    if(checked){
                        reportPage.semester_number = 1;
                        semesterTSW.checked = true
                        reportPage.evalType = "semester"

                    }

                    reportPage.updateRefModel();
                }
            }

            // semester 2
            Switch{
                id: semester2RB
                Layout.preferredHeight:  50
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                ButtonGroup.group: semesterGB
                text: "نیمسال دوم"
                checked: (reportPage.semester_number === 2)? true : false;
                font.family: "Kalameh"
                font.pixelSize: 16
                palette.highlight: "darkmagenta"
                palette.text: (this.checked)? "darkmagenta" : "gray"
                onCheckedChanged:
                {
                    if(!checked)
                    {
                        if(!semester1RB.checked && !periodRB.checked)
                            semester2RB.checked = true;
                    }

                    if(checked)
                    {
                        reportPage.semester_number = 2;
                        semesterTSW.checked = true
                        reportPage.evalType = "semester"
                    }

                    reportPage.updateRefModel();
                }
            }

            // study period
            Switch{
                id: periodRB
                Layout.preferredHeight:  50
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                ButtonGroup.group: semesterGB
                text: "سال‌تحصیلی"
                checked: (reportPage.semester_number === 0)? true : false;
                font.family: "Kalameh"
                font.pixelSize: 16
                palette.highlight: "darkmagenta"
                palette.text: (this.checked)? "darkmagenta" : "gray"
                onCheckedChanged: {
                    if(!checked)
                    {
                        if(!semester1RB.checked && !semester2RB.checked)
                            periodRB.checked = true;
                    }

                    if(checked)
                    {
                        reportPage.semester_number = 0;
                        periodTSW.checked = true
                        reportPage.evalType = "period"
                    }

                    reportPage.updateRefModel();
                }
            }
        }
    }

    Label{
                color: "darkcyan"
                text: "نوع آزمون"
                width: parent.width
                horizontalAlignment: Label.AlignLeft
            }
    GroupBox{
        width: parent.width
        height: 80
        padding: 0


        RowLayout{
            width: parent.width
            height: 50

            // per month
            Switch{
                id: perMonthTSW
                Layout.preferredHeight:  50
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                text: "آزمون‌های ماهیانه"
                checked: false
                ButtonGroup.group: typeBG
                visible: (reportPage.semester_number > 0)? true : false
                font.family: "Kalameh"
                font.pixelSize: 16
                palette.highlight: "darkcyan"
                palette.text: (this.checked)? "darkcyan" : "gray"
                onCheckedChanged:
                {
                    if(!checked)
                    {
                        if(!periodTSW.checked && !midtermTSW.checked && !semesterTSW.checked)
                            perMonthTSW.checked = true;
                    }
                    else
                        reportPage.evalType = "per_month"

                    reportPage.updateRefModel();
                }
            }

            // midterm
            Switch{
                id: midtermTSW
                Layout.preferredHeight:  50
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                ButtonGroup.group: typeBG
                text: "آزمون‌های میان‌ترم"
                checked: false
                visible: (reportPage.semester_number > 0)? true : false
                font.family: "Kalameh"
                font.pixelSize: 16
                palette.highlight: "darkcyan"
                palette.text: (this.checked)? "darkcyan" : "gray"
                onCheckedChanged:{
                    if(!checked)
                    {
                        if(!periodTSW.checked && !perMonthTSW.checked && !semesterTSW.checked)
                            midtermTSW.checked = true;
                    }
                    else
                        reportPage.evalType = "midterm"

                    reportPage.updateRefModel();
                }
            }

            // semester
            Switch{
                id: semesterTSW
                Layout.preferredHeight:  50
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                ButtonGroup.group: typeBG
                text: "آزمون‌های نیمسال"
                checked: true
                visible: (reportPage.semester_number > 0)? true : false
                font.family: "Kalameh"
                font.pixelSize: 16
                palette.highlight: "darkcyan"
                palette.text: (this.checked)? "darkcyan" : "gray"
                onCheckedChanged:{
                    if(!checked)
                    {
                        if(!periodTSW.checked && !midtermTSW.checked && !perMonthTSW.checked)
                            semesterTSW.checked = true;
                    }
                    else
                        reportPage.evalType = "semester"

                    reportPage.updateRefModel();
                }
            }

            // study period
            Switch{
                id: periodTSW
                Layout.preferredHeight:  50
                Layout.alignment:  Qt.AlignHCenter | Qt.AlignVCenter
                ButtonGroup.group: typeBG
                text: "آزمون‌های سال‌تحصیلی"
                checked: false
                visible: (reportPage.semester_number === 0)? true : false
                font.family: "Kalameh"
                font.pixelSize: 16
                palette.highlight: "darkcyan"
                palette.text: (this.checked)? "darkcyan" : "gray"
                onCheckedChanged:{
                    if(!checked)
                    {
                        if(!midtermTSW.checked && !semesterTSW.checked && !perMonthTSW.checked)
                            periodTSW.checked = true;
                    }
                    else
                        reportPage.evalType = "period"

                    reportPage.updateRefModel();
                }
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
            text:"آزمون مرجع: "
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

            Component.onCompleted: reportPage.updateRefModel();
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
            text: "مرجع تست: "
        }
        ComboBox{
            id: compareTestRef
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            font.bold: false
            font.family: "Kalameh"
            font.pixelSize: 16
            model: ListModel{id: testRefModel}
            textRole: "text"
            valueRole: "value"

            Component.onCompleted: reportPage.updateRefModel();
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
            text:"تاریخ: "
        }
        TextField{
            id: dateTE
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            placeholderText: "1403/11/11"
            text: dbMan.getCurrentDate();
            font.bold: false
            font.family: "Kalameh"
            font.pixelSize: 16
            validator: RegularExpressionValidator
            {
                regularExpression: /^\d{4}\/\d{2}\/\d{2}$/
                // Regex pattern to match date in yyyy/MM/dd format
            }
        }
    }

    Switch{
        id: testSW
        width: parent.width
        height: 50
        text: "درج درصد تست"
        visible: (class_base_report === "base")? true : false
        checked: (class_base_report === "base")? true : false
        font.family: "Kalameh"
        font.pixelSize: 16
    }

    Switch{
        id: photoSW
        width: parent.width
        height: 50
        text: "نمایش تصویر دانش‌آموز"
        checked: false
        font.family: "Kalameh"
        font.pixelSize: 16
    }

    Switch{
        id: fathernameSW
        width: parent.width
        height: 50
        text: "درج نام‌پدر دانش‌آموز"
        checked: false
        font.family: "Kalameh"
        font.pixelSize: 16
    }

    Item{width: parent.width; height: 10;}
    Rectangle{width: parent.width; height: 2; color: "black";}
    Item{width: parent.width; height: 10;}

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

                contentFontSizeCB.currentIndex = contentFontSizeCB.indexOfValue(12)
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

                titrFontSizeCB.currentIndex = titrFontSizeCB.indexOfValue(10)
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
            onClicked: { reportPage.popSignal();}
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
        onDialogAccepted: reportPage.popSignal();
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

            var params = {
                "eval_id": compareRef.currentValue,
                "test_eval_id": compareTestRef.currentValue,
                "eval" : compareRef.currentText,
                "test_eval" : compareTestRef.currentText,
                "class_id": reportPage.class_id,
                "class_name": reportPage.class_name,
                "semester": reportPage.semester_number,
                "eval_type": reportPage.evalType,
                "date": dateTE.text,
                "include_test": testSW.checked,
                "include_photo" : photoSW.checked,
                "include_fathername" : fathernameSW.checked,
                "paperSize": paperSizeCB.currentValue,
                "fontFamily" : fontCB.currentValue,
                "contentFontSize": contentFontSizeCB.currentValue,
                "titrFontSize": titrFontSizeCB.currentValue
            }

            if(reportPage.class_base_report === "class")
            {
                if(dbMan.generateClassReportPdf(selectedFile, params))
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
            else if(reportPage.class_base_report === "base")
            {
                if(dbMan.generateRankPdf(selectedFile, params))
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


        }
        onRejected: saveFileDialog.close();
    }

}
