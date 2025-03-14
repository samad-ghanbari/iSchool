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

    property var allEvals: dbMan.getEvals();
    property var evals: [] // selected evals to transcript
    property var test_evals: []
    property var eids :{ "semester1": -601, "semester2": -602, "semester_avg":-612, "formative_avg": -400, "final_avg": -500, "per_month_avg":-12, "class_rank": -24, "base_rank": -124, "test_avg":-10, "midterm_avg": -5, "base_avg": -19, "max_grade": -20}

    property int semester_Number : 1 // 0 1 2      0:studyPeriod   1:semester1    2:semester2

    property bool per_month_transcript : true;
    property bool midterm_transcript : false
    property bool semester_transcript : false
    property bool period_transcript : false

    property bool advisorComment : false;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    function updateEvalsModel(){
        evals = [];
        test_evals = [];
        evalsModel.clear();
        let obj;
        // semester : 0 >> formative-final of each semester
        // semester : 1-2
        //              per_month : month
        //              midterm   : month-midterm
        //              semester  : formative-final
        let PER_MONTH, MIDTERM, FORMATIVE, FINAL, SEMESTER;
        if(semester_Number == 0)
        {
            FORMATIVE = true;
            FINAL = true;

            for(obj of allEvals)
            {
                if( (obj["formative"] === true) || (obj["final_flag"] === true) )
                {
                    studentResultSettingPage.evals.push(obj["id"]);
                    evalsModel.append(obj);
                }
            }
        }
        else  // 1-2
        {
            if(per_month_transcript)
            {
                PER_MONTH = true;
                SEMESTER = semester_Number;

                for(obj of allEvals)
                {
                    if( (obj["per_month"] === true) && (obj["semester"] === SEMESTER) )
                    {
                        if(evals.length == 0)
                            studentResultSettingPage.evals.push(obj["id"]);

                        evalsModel.append(obj);
                    }
                }
            }
            else if(midterm_transcript)
            {
                PER_MONTH = true;
                MIDTERM = true;
                SEMESTER = semester_Number;

                for(obj of allEvals)
                {
                    if(obj["semester"] === SEMESTER)
                    {
                        if(obj["midterm"] === true)
                            studentResultSettingPage.evals.push(obj["id"]);

                        if( (obj["per_month"] === true) ||  (obj["midterm"] === true))
                            evalsModel.append(obj);
                    }
                }


            }
            else if(semester_transcript)
            {
                FORMATIVE = true;
                FINAL = true;
                SEMESTER = semester_Number;

                for(obj of allEvals)
                {
                    if(obj["semester"] === SEMESTER)
                    {
                        if( (obj["formative"] === true) ||  (obj["final_flag"] === true))
                        {
                            studentResultSettingPage.evals.push(obj["id"]);
                            evalsModel.append(obj);
                        }
                    }
                }
            }
        }

        updateRefModel();
    }

    function updateRefModel(){

        refModel.clear();
        testRefModel.clear();
        test_evals = [];
        let PER_MONTH, MIDTERM, FORMATIVE, FINAL, SEMESTER;
        let final_value = -1;

        if(semester_Number == 0)
        {
            FORMATIVE = true;
            FINAL = true;

            if(finalAvgSW.checked)
                refModel.append({text: "میانگین نهایی اول/دوم", value: -500});
            if(semesterAvgSW.checked)
                refModel.append({text: "میانگین نیمسال اول/دوم", value: -612});
            if(semester12SW.checked)
            {
                refModel.append({text: "نیمسال اول", value: -601});
                refModel.append({text: "نیمسال دوم", value: -602});
            }

            for( var obj of allEvals)
            {
                if( (obj["test_flag"] === false) )
                {
                    if( (obj["formative"] === true) || (obj["final_flag"] === true) )
                    {
                        if(studentResultSettingPage.evals.includes(obj.id))
                        {
                            if(obj["semester"] === 1)
                                refModel.append({text: "آزمون " + obj.eval_name +" نیمسال اول ", value: obj.id});
                            else
                                refModel.append({text: "آزمون " + obj.eval_name +" نیمسال دوم ", value: obj.id});
                        }
                    }
                }
            }
        }
        else
        {
            if(per_month_transcript)
            {
                PER_MONTH = true;
                SEMESTER = semester_Number;

                for(obj of allEvals)
                {
                    if( (obj["test_flag"] === false) )
                    {
                        if( (obj["per_month"] === true) && (obj["semester"] === SEMESTER) )
                        {
                            if(final_value == -1)
                                if((obj["per_month"] === true))
                                    final_value = obj["id"];

                            if(studentResultSettingPage.evals.includes(obj.id))
                                refModel.append({text: "آزمون " + obj.eval_name, value: obj.id});

                        }
                    }
                }

                if(perMonthAvgSW.checked)
                    refModel.append({text: "میانگین ماهیانه", value: -12});
            }
            else if(midterm_transcript)
            {
                PER_MONTH = true;
                MIDTERM = true;
                SEMESTER = semester_Number;

                for(obj of allEvals)
                {
                    if( (obj["test_flag"] === false) )
                    {
                        if(obj["semester"] === SEMESTER)
                        {
                            if( (obj["per_month"] === true) ||  (obj["midterm"] === true))
                            {
                                if(studentResultSettingPage.evals.includes(obj.id))
                                    refModel.append({text: "آزمون " + obj.eval_name, value: obj.id});

                                if(final_value == -1)
                                    if((obj["midterm"] === true))
                                        final_value = obj["id"];
                            }
                        }
                    }
                }

                if(perMonthAvgSW.checked)
                    refModel.append({text: "میانگین ماهیانه", value: -12});

            }
            else if(semester_transcript)
            {
                FORMATIVE = true;
                FINAL = true;
                SEMESTER = semester_Number;

                if(semester12SW.checked)
                {
                    if(SEMESTER === 1)
                        refModel.append({text: "نیمسال اول", value: -601});
                    else
                        refModel.append({text: "نیمسال دوم", value: -602});
                }



                for(obj of allEvals)
                {
                    if( (obj["test_flag"] === false) )
                    {
                        if(obj["semester"] === SEMESTER)
                        {
                            if( (obj["formative"] === true) ||  (obj["final_flag"] === true))
                            {
                                if(studentResultSettingPage.evals.includes(obj.id))
                                    refModel.append({text: "آزمون " + obj.eval_name, value: obj.id});


                                if(final_value == -1)
                                    if((obj["final_flag"] === true))
                                        final_value = obj["id"];
                            }
                        }
                    }
                }
            }
        }

        //test
        let id;
        for(let obj of allEvals)
        {
            id = obj["id"];
            if(obj["test_flag"])
                if(evals.includes(id))
                {
                    testRefModel.append({"text": obj["eval_name"], value: obj["id"]})
                    test_evals.push(id);
                }
        }

        if(test_evals.length > 0)
        {
            testRefRow.visible = true
            testCompareRef.currentIndex = 0;
            testAvgSW.visible = true
            if(testAvgSW.checked)
                testRefModel.append({"text": "میانگین تست", value: -10})
        }
        else
        {
            testRefRow.visible = false;
            testCompareRef.currentIndex = -1;
            testAvgSW.visible = false
            testAvgSW.checked = false
        }

        if(refModel.count > 0)
            compareRef.currentIndex = 0;

        if(final_value > -1)
            compareRef.currentIndex = compareRef.indexOfValue(final_value)

        if(compareRef.currentIndex === -1)
            compareRef.currentIndex = 0;
    }

    function uncheckMonthSwitch()
    {
        farSW.checked = false;
        ordSW.checked = false;
        khoSW.checked = false;
        tirSW.checked = false;
        morSW.checked = false;
        shaSW.checked = false;
        mehSW.checked = false;
        abaSW.checked = false;
        azaSW.checked = false;
        deySW.checked = false;
        bahSW.checked = false;
        esfSW.checked = false;
    }

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: studentResultSettingPage.branch + " - " + studentResultSettingPage.step
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight:  100

            Image {
                source:studentResultSettingPage.student_photo
                Layout.preferredWidth: 100
                Layout.preferredHeight: 100
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }
            Column{
                Layout.fillWidth: true
                Layout.preferredHeight: 100

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
                    text: (studentResultSettingPage.field_based) ? studentResultSettingPage.field + " - " + studentResultSettingPage.base :   studentResultSettingPage.base
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                }
            }
        }
        Row{
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignHCenter

            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: studentResultSettingPage.class_name + " - " + "سال‌تحصیلی "
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: studentResultSettingPage.period
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
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

        Flickable
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            contentHeight: centerCol.implicitHeight
            clip: true
            Rectangle{
                id: centerRect
                width: (parent.width > 700)? 700 : parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                height: centerCol.implicitHeight
                color:"snow"

                Column{
                    id: centerCol
                    anchors.fill: parent
                    anchors.margins: 10

                    ButtonGroup{
                        id: semesterGB;
                    }
                    ButtonGroup{
                        id: transcriptBG;
                    }


                    GroupBox{
                        width: parent.width
                        height: transCol.implicitHeight + 50
                        label: Label{
                            color: "darkslategray"
                            text: "تنظیمات کارنامه"
                            width: parent.width
                            horizontalAlignment: Label.AlignLeft
                        }

                        Column{
                            id: transCol
                            width: parent.width

                            GroupBox{
                                width: parent.width
                                height: 80
                                padding: 0
                                label: Label{
                                    color: "darkmagenta"
                                    text: "مقطع زمانی"
                                    width: parent.width
                                    horizontalAlignment: Label.AlignLeft
                                }

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
                                        checked: true
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

                                            studentResultSettingPage.evals = []
                                            evalsModel.clear();

                                            if(checked){
                                                studentResultSettingPage.semester_Number = 1;
                                                perMonthTSW.checked = true
                                                studentResultSettingPage.per_month_transcript = true
                                            }

                                            studentResultSettingPage.updateEvalsModel();
                                        }

                                    }

                                    // semester 2
                                    Switch{
                                        id: semester2RB
                                        Layout.preferredHeight:  50
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                        ButtonGroup.group: semesterGB
                                        text: "نیمسال دوم"
                                        checked: false
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

                                            studentResultSettingPage.evals = []
                                            evalsModel.clear();

                                            if(checked)
                                            {
                                                studentResultSettingPage.semester_Number = 2;
                                                perMonthTSW.checked = true
                                                studentResultSettingPage.per_month_transcript = true
                                            }

                                            studentResultSettingPage.updateEvalsModel();
                                        }

                                    }

                                    // study period
                                    Switch{
                                        id: periodRB
                                        Layout.preferredHeight:  50
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                        ButtonGroup.group: semesterGB
                                        text: "سال‌تحصیلی"
                                        checked: false
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

                                            studentResultSettingPage.evals = []
                                            evalsModel.clear();

                                            if(checked)
                                            {
                                                studentResultSettingPage.semester_Number = 0;
                                                periodTSW.checked = true
                                                studentResultSettingPage.period_transcript = true
                                            }

                                            studentResultSettingPage.updateEvalsModel();
                                        }

                                    }
                                }
                            }

                            GroupBox{
                                width: parent.width
                                height: 80
                                padding: 0
                                label: Label{
                                    color: "darkcyan"
                                    text: "نوع کارنامه"
                                    width: parent.width
                                    horizontalAlignment: Label.AlignLeft
                                }

                                RowLayout{
                                    width: parent.width
                                    height: 50

                                    // per month
                                    Switch{
                                        id: perMonthTSW
                                        Layout.preferredHeight:  50
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                        text: "کارنامه ماهیانه"
                                        checked: true
                                        ButtonGroup.group: transcriptBG
                                        visible: (studentResultSettingPage.semester_Number > 0)? true : false
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

                                            studentResultSettingPage.per_month_transcript = checked
                                            studentResultSettingPage.updateEvalsModel();
                                        }
                                    }

                                    // midterm
                                    Switch{
                                        id: midtermTSW
                                        Layout.preferredHeight:  50
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                        ButtonGroup.group: transcriptBG
                                        text: "کارنامه میان‌ترم"
                                        checked: false
                                        visible: (studentResultSettingPage.semester_Number > 0)? true : false
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

                                            studentResultSettingPage.midterm_transcript = checked
                                            studentResultSettingPage.updateEvalsModel();
                                        }
                                    }

                                    // semester
                                    Switch{
                                        id: semesterTSW
                                        Layout.preferredHeight:  50
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                        ButtonGroup.group: transcriptBG
                                        text: "کارنامه نیمسال"
                                        checked: false
                                        visible: (studentResultSettingPage.semester_Number > 0)? true : false
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

                                            studentResultSettingPage.semester_transcript = checked
                                            studentResultSettingPage.updateEvalsModel();
                                        }
                                    }

                                    // study period
                                    Switch{
                                        id: periodTSW
                                        Layout.preferredHeight:  50
                                        Layout.alignment:  Qt.AlignHCenter | Qt.AlignVCenter
                                        ButtonGroup.group: transcriptBG
                                        text: "کارنامه سال‌تحصیلی"
                                        checked: false
                                        visible: (studentResultSettingPage.semester_Number == 0)? true : false
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

                                            studentResultSettingPage.period_transcript = checked
                                            studentResultSettingPage.updateEvalsModel();
                                        }
                                    }
                                }
                            }

                            GroupBox{
                                width: parent.width
                                height: evalCol.implicitHeight + 50
                                //title: "ارزیابی‌ها"
                                label: Label{
                                    color: "royalblue"
                                    text: "ارزیابی‌ها"
                                    width: parent.width
                                    horizontalAlignment: Label.AlignLeft
                                }

                                Column{
                                    id: evalCol
                                    width: parent.width

                                    Repeater
                                    {
                                        id: evalsRp
                                        model: ListModel{id: evalsModel;}
                                        delegate:Switch{
                                            required property var model
                                            checked: (studentResultSettingPage.evals.includes(model.id))? true : false;
                                            width: parent.width
                                            palette.highlight: (checked)? "royalblue" : "gray"
                                            palette.text:(checked)? "royalblue" : "gray"
                                            height: 50
                                            text: {
                                                if(studentResultSettingPage.semester_Number == 0)
                                                {
                                                    if(model.semester === 1)
                                                        return  model.eval_name + " نیمسال اول "
                                                    else
                                                        return  model.eval_name + " نیمسال دوم "
                                                }
                                                else
                                                    return  model.eval_name;
                                            }
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


                                                studentResultSettingPage.updateRefModel();
                                            }
                                        }

                                        Component.onCompleted: {
                                            studentResultSettingPage.updateEvalsModel();
                                        }

                                    }

                                }


                            }

                            GroupBox{

                                width: parent.width
                                height: paramCol.implicitHeight + 50
                                label: Label{
                                    color: "indianred"
                                    text: "معیارهای سنجش"
                                    width: parent.width
                                    horizontalAlignment: Label.AlignLeft
                                }

                                Column{
                                    id: paramCol
                                    width: parent.width
                                    Switch{
                                        id: baseRankSW
                                        width: parent.width
                                        palette.highlight: "indianred"
                                        palette.text: (this.checked)? "indianred" : "gray"
                                        height: 50
                                        text: "رتبه در پایه "
                                        checked: true
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                    }

                                    Switch{
                                        id: classRankSW
                                        width: parent.width
                                        palette.highlight: "indianred"
                                        palette.text: (this.checked)? "indianred" : "gray"
                                        height: 50
                                        text: "رتبه در کلاس "
                                        checked: true
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                    }

                                    Switch{
                                        id: baseAvgSW
                                        width: parent.width
                                        palette.highlight: "indianred"
                                        palette.text: (this.checked)? "indianred" : "gray"
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
                                        palette.highlight: "indianred"
                                        palette.text: (this.checked)? "indianred" : "gray"
                                        text: "بالاترین نمره پایه"
                                        checked: true
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                    }

                                    // semester
                                    Switch{
                                        id: semester12SW
                                        width: parent.width
                                        height: 50
                                        palette.highlight: "indianred"
                                        palette.text: (checked)? "indianred" : "gray"
                                        visible: (studentResultSettingPage.semester_transcript || studentResultSettingPage.period_transcript)? true : false
                                        text: (studentResultSettingPage.period_transcript)? "نیمسال اول/دوم" : "نیمسال"
                                        checked: !studentResultSettingPage.per_month_transcript
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                        onToggled: studentResultSettingPage.updateRefModel();
                                    }

                                    Switch{
                                        id: semesterAvgSW
                                        width: parent.width
                                        height: 50
                                        palette.highlight: "indianred"
                                        palette.text: (this.checked)? "indianred" : "gray"
                                        text: "میانگین نمیسال اول / دوم"
                                        visible: (studentResultSettingPage.period_transcript)? true : false
                                        checked: true
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                        onToggled: studentResultSettingPage.updateRefModel();
                                    }

                                    Switch{
                                        id: finalAvgSW
                                        width: parent.width
                                        height: 50
                                        palette.highlight: "indianred"
                                        palette.text: (this.checked)? "indianred" : "gray"
                                        text: "میانگین نهایی اول/ دوم"
                                        visible: (studentResultSettingPage.period_transcript)? true : false
                                        checked: true
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                        onToggled: studentResultSettingPage.updateRefModel();
                                    }

                                    Switch{
                                        id: formativeAvgSW
                                        width: parent.width
                                        height: 50
                                        palette.highlight: "indianred"
                                        palette.text: (this.checked)? "indianred" : "gray"
                                        text: "میانگین مستمر اول / دوم"
                                        visible: (studentResultSettingPage.period_transcript)? true : false
                                        checked: true
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                        onToggled: studentResultSettingPage.updateRefModel();
                                    }

                                    Switch{
                                        id: perMonthAvgSW
                                        width: parent.width
                                        height: 50
                                        palette.highlight: "indianred"
                                        palette.text: (this.checked)? "indianred" : "gray"
                                        text: "میانگین ماهیانه"
                                        visible:{
                                            if(studentResultSettingPage.per_month_transcript || studentResultSettingPage.midterm_transcript )
                                            {
                                                return true;
                                            }
                                            else
                                                return false;
                                        }
                                        checked: false
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                        onToggled: studentResultSettingPage.updateRefModel();
                                    }

                                    Switch{
                                        id: testAvgSW
                                        width: parent.width
                                        height: 50
                                        palette.highlight: "indianred"
                                        palette.text: (this.checked)? "indianred" : "gray"
                                        text: "میانگین تست"
                                        visible:{
                                            if(studentResultSettingPage.test_evals.length > 0 )
                                            {
                                                return true;
                                            }
                                            else
                                                return false;
                                        }
                                        checked: false
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                        onToggled: studentResultSettingPage.updateRefModel();
                                    }
                                }
                            }

                            GroupBox{
                                width: parent.width
                                height:setCol.implicitHeight + 50
                                label: Label{
                                    color: "steelblue"
                                    text: "محاسبات"
                                    width: parent.width
                                    horizontalAlignment: Label.AlignLeft
                                }

                                Column{
                                    id: setCol
                                    width: parent.width

                                    Switch{
                                        id: fieldBasedSW
                                        width: parent.width
                                        height: 50
                                        palette.highlight: "steelblue"
                                        palette.text: (this.checked)? "steelblue" : "gray"
                                        text: "گزارش مبتنی بر " + studentResultSettingPage.field
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
                                            text:"مرجع مقایسه رتبه و میانگین دروس: "
                                            color: "steelblue"
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
                                            Component.onCompleted: studentResultSettingPage.updateRefModel();
                                        }
                                    }

                                    RowLayout{
                                        id: testRefRow
                                        visible: (studentResultSettingPage.test_evals.length > 0)? true : false;
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
                                            text:"مرجع مقایسه رتبه و میانگین تست: "
                                            color: "steelblue"
                                        }
                                        ComboBox{
                                            id: testCompareRef
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: 50
                                            font.bold: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            model: ListModel{id: testRefModel}
                                            textRole: "text"
                                            valueRole: "value"
                                            Component.onCompleted: studentResultSettingPage.updateRefModel();
                                        }
                                    }


                                    Switch{
                                        id: predefinedBaseAvgSW
                                        width: parent.width
                                        height: 50
                                        palette.highlight: "steelblue"
                                        palette.text: (this.checked)? "steelblue" : "gray"
                                        text: "استفاده از میانگین پایه دروس ثبت شده"
                                        checked: true
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                    }
                                }
                            }

                            GroupBox{
                                width: parent.width
                                height:advisorCol.implicitHeight + 50
                                label: Label{
                                    color: "midnightblue"
                                    text: "نظر مشاور"
                                    width: parent.width
                                    horizontalAlignment: Label.AlignLeft
                                }
                                Column
                                {
                                    id: advisorCol
                                    width: parent.width

                                    RowLayout{
                                        width: parent.width
                                        height: 20
                                        CheckBox {
                                            id: advisorChB
                                            Layout.preferredHeight: 20
                                            Layout.preferredWidth:  20
                                            checked: studentResultSettingPage.advisorComment
                                            indicator: Rectangle {
                                                width: 20
                                                height: 20
                                                radius: 2
                                                color: "white"
                                                border.width: 1
                                                border.color:"gray"

                                                Rectangle{
                                                    width: 10
                                                    height: 10
                                                    anchors.centerIn: parent
                                                    color: advisorChB.checked ? "midnightblue" : "white"
                                                }
                                            }

                                            onCheckedChanged:{
                                                if(!checked)
                                                    studentResultSettingPage.uncheckMonthSwitch();

                                                studentResultSettingPage.advisorComment = advisorChB.checked
                                            }
                                        }
                                        Label
                                        {
                                            Layout.preferredHeight: 25
                                            verticalAlignment: Label.AlignVCenter
                                            text: "درج نظر مشاور"
                                            font.family: "Kalameh"
                                            font.pixelSize: 14
                                            color:"midnightblue";
                                            MouseArea{
                                                anchors.fill: parent
                                                onClicked: advisorChB.toggle();
                                            }
                                        }

                                        Item{Layout.fillWidth: true; Layout.preferredHeight: 20}
                                    }

                                    Flow{
                                        width: parent.width
                                        visible: studentResultSettingPage.advisorComment

                                        Switch{
                                            id: farSW
                                            height:  50
                                            width: 160
                                            text: "فروردین ماه"
                                            checked: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            palette.highlight: "midnightblue"
                                            palette.text: (checked)? "midnightblue" : "gray"
                                            onCheckedChanged:  {}
                                        }

                                        Switch{
                                            id: ordSW
                                            height:  50
                                            width: 160
                                            text: "اردیبهشت ماه"
                                            checked: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            palette.highlight: "midnightblue"
                                            palette.text: (checked)? "midnightblue" : "gray"
                                            onCheckedChanged:  {}
                                        }

                                        Switch{
                                            id: khoSW
                                            height:  50
                                            width: 160
                                            text: "خرداد ماه"
                                            checked: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            palette.highlight: "midnightblue"
                                            palette.text: (checked)? "midnightblue" : "gray"
                                            onCheckedChanged:  {}
                                        }

                                        Switch{
                                            id: tirSW
                                            height:  50
                                            width: 160
                                            text: "تیر ماه"
                                            checked: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            palette.highlight: "midnightblue"
                                            palette.text: (checked)? "midnightblue" : "gray"
                                            onCheckedChanged:  {}
                                        }

                                        Switch{
                                            id: morSW
                                            height:  50
                                            width: 160
                                            text: "مرداد ماه"
                                            checked: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            palette.highlight: "midnightblue"
                                            palette.text: (checked)? "midnightblue" : "gray"
                                            onCheckedChanged:  {}
                                        }

                                        Switch{
                                            id: shaSW
                                            height:  50
                                            width: 160
                                            text: "شهریور ماه"
                                            checked: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            palette.highlight: "midnightblue"
                                            palette.text: (checked)? "midnightblue" : "gray"
                                            onCheckedChanged:  {}
                                        }

                                        Switch{
                                            id: mehSW
                                            height:  50
                                            width: 160
                                            text: "مهر ماه"
                                            checked: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            palette.highlight: "midnightblue"
                                            palette.text: (checked)? "midnightblue" : "gray"
                                            onCheckedChanged:  {}
                                        }

                                        Switch{
                                            id: abaSW
                                            height:  50
                                            width: 160
                                            text: "آبان ماه"
                                            checked: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            palette.highlight: "midnightblue"
                                            palette.text: (checked)? "midnightblue" : "gray"
                                            onCheckedChanged:  {}
                                        }

                                        Switch{
                                            id: azaSW
                                            height:  50
                                            width: 160
                                            text: "آذر ماه"
                                            checked: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            palette.highlight: "midnightblue"
                                            palette.text: (checked)? "midnightblue" : "gray"
                                            onCheckedChanged:  {}
                                        }

                                        Switch{
                                            id: deySW
                                            height:  50
                                            width: 160
                                            text: "دی ماه"
                                            checked: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            palette.highlight: "midnightblue"
                                            palette.text: (checked)? "midnightblue" : "gray"
                                            onCheckedChanged:  {}
                                        }

                                        Switch{
                                            id: bahSW
                                            height:  50
                                            width: 160
                                            text: "بهمن ماه"
                                            checked: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            palette.highlight: "midnightblue"
                                            palette.text: (checked)? "midnightblue" : "gray"
                                            onCheckedChanged:  {}
                                        }

                                        Switch{
                                            id: esfSW
                                            height:  50
                                            width: 160
                                            text: "اسفند ماه"
                                            checked: false
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            palette.highlight: "midnightblue"
                                            palette.text: (checked)? "midnightblue" : "gray"
                                            onCheckedChanged:  {}
                                        }

                                    }

                                }
                            }
                        }
                    }

                    Item{   width: parent.width;  height: 50; }
                    // printer

                    GroupBox{
                        width: parent.width
                        height: printCol.implicitHeight + 50
                        label: Label{
                            color: "darkslategray"
                            text: "تنظیمات چاپ"
                            width: parent.width
                            horizontalAlignment: Label.AlignLeft
                        }

                        Column{
                            id: printCol
                            width: parent.width

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
                                    color: "darkslategray"
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
                                    color: "darkslategray"
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
                                    color: "darkslategray"
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
                                    color: "darkslategray"
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
                                    color: "darkslategray"
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
                                    color: "darkslategray"
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
                                    color: "darkslategray"
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
                                    color: "darkslategray"
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

                        }
                    }


                    // buttons
                    Item{   width: parent.width;  height: 50; }

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

                    Item{   width: parent.width;  height: 50; }
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
            let student_id = studentResultSettingPage.student_id
            let class_id = studentResultSettingPage.class_id
            let evals = studentResultSettingPage.evals
            let test_evals = studentResultSettingPage.test_evals;
            let semester_number = studentResultSettingPage.semester_Number;

            let field_based = fieldBasedSW.checked;
            let compare_ref_id = compareRef.currentValue;
            let compare_ref = compareRef.currentText;
            let test_compare_ref_id = testCompareRef.currentValue;
            let test_compare_ref = testCompareRef.currentText;
            let predefined_base_avg = predefinedBaseAvgSW.checked;
            let perMonthT  = studentResultSettingPage.per_month_transcript;
            let midTermT = studentResultSettingPage.midterm_transcript;
            let semesterT = studentResultSettingPage.semester_transcript;
            let periodT = studentResultSettingPage.period_transcript;
            let transcript = {"per_month": perMonthT , "midterm" : midTermT , "semester": semesterT, "period": periodT }
            let advisorComment_flag = studentResultSettingPage.advisorComment
            let month = [];
            if(advisorComment_flag)
            {
                if(farSW.checked)
                    month.push(1);
                if(ordSW.checked)
                    month.push(2);
                if(khoSW.checked)
                    month.push(3);
                if(tirSW.checked)
                    month.push(4);
                if(morSW.checked)
                    month.push(5);
                if(shaSW.checked)
                    month.push(6);
                if(mehSW.checked)
                    month.push(7);
                if(abaSW.checked)
                    month.push(8);
                if(azaSW.checked)
                    month.push(9);
                if(deySW.checked)
                    month.push(10);
                if(bahSW.checked)
                    month.push(11);
                if(esfSW.checked)
                    month.push(12);
            }

            let semesterField = semester12SW.checked;
            let semesterAvgField = semesterAvgSW.checked;
            let perMonthAvgField = perMonthAvgSW.checked;
            let formativeAvgField = formativeAvgSW.checked;
            let finalAvgField = finalAvgSW.checked;
            let testAvgField = testAvgSW.checked

            if(test_evals.length < 1)
                testAvgField = false;

            if(semester_Number > 0)
            {
                semesterAvgField = false;
                perMonthAvgField = false;
                formativeAvgField = false;
                finalAvgField = false;
            }

            if(perMonthT || midTermT)
            {
                semesterField = false;
                semesterAvgField = false;
                formativeAvgField = false;
                finalAvgField = false;
            }

            // test only print error
            if((compare_ref_id === -1) || (compare_ref === "") || (compare_ref_id === undefined ) )
            {
                infoDialogId.dialogText = "لطفا مرجع مقایسه دروس را انتخاب نمایید.";
                infoDialogId.open();
                return;
            }

            if(test_evals.length > 0)
            {
                if((test_compare_ref_id === -1) || (test_compare_ref === "") || (test_compare_ref_id === undefined ) )
                {
                    infoDialogId.dialogText = "لطفا مرجع مقایسه تست را انتخاب نمایید.";
                    infoDialogId.open();
                    return;
                }
            }

            var params = {
                "student_id": student_id,
                "class_id": class_id,
                "evals": evals,
                "test_evals": test_evals,
                "semester_number": semester_Number,
                "transcript" : transcript,
                "fields" : {
                    "base_rank": baseRankSW.checked,
                    "class_rank": classRankSW.checked,
                    "base_avg" : baseAvgSW.checked,
                    "max_grade": maxGradeSW.checked,

                    "semester": semesterField,
                    "semester_avg": semesterAvgField,
                    "per_month_avg": perMonthAvgField,
                    "formative_avg" : formativeAvgField,
                    "final_avg" : finalAvgField,
                    "test_avg" : testAvgField
                }
                ,
                "fieldBased_flag" : studentResultSettingPage.fieldBased_flag,
                "compare_ref_id": compare_ref_id,
                "compare_ref" : compare_ref,
                "test_compare_ref_id": test_compare_ref_id,
                "test_compare_ref" : test_compare_ref,
                "predefined_base_avg": predefined_base_avg,
                "advisor": advisorComment_flag,
                "comment_month": month,
                "print":{
                    "paperSize": paperSizeCB.currentValue,
                    "fontFamily" : fontCB.currentValue,
                    "contentFontSize": contentFontSizeCB.currentValue,
                    "titrFontSize": titrFontSizeCB.currentValue
                }
            }

            //var result = dbMan.getStudentTranscript(params);
            //dbMan.generatePdf(selectedFile, params, highlight1_Dialog.selectedColor, highlight2_Dialog.selectedColor, highlight3_Dialog.selectedColor, highlight4_Dialog.selectedColor )

            if(dbMan.printStudentTranscript(selectedFile, params, highlight1_Dialog.selectedColor, highlight2_Dialog.selectedColor, highlight3_Dialog.selectedColor, highlight4_Dialog.selectedColor))
            {
                successDialogId.width = 500
                successDialogId.dialogText = "فایل در مسیر زیر ذخیره گردید." + "\n" + selectedFile
                successDialogId.open();
            }
            else
            {
                infoDialogId.dialogText = "عملیات با خطا مواجه شد.";
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
