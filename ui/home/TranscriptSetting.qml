import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts
import QtQuick.Dialogs

import "./../public" as DialogBox

Item {
    id: settingPage

    required property bool student_class_transcript // student: false   class: true

    required property int student_id;

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;
    required property string class_name;
    required property int class_id;

    required property StackView appStackView;

    property var allEvals: dbMan.getEvals();
    property var evals: [] // selected evals to transcript
    property var test_evals: []
    property var eids :{ "semester1": -601, "semester2": -602, "semester_avg":-612, "formative_avg": -400, "final_avg": -500, "per_month_avg":-12, "class_rank": -24, "base_rank": -124, "test_avg":-10, "midterm_avg": -5, "base_avg": -19, "max_grade": -20}

    property int semester_Number : (dbMan.getCurrentSemester() === 1)? 1 : 2; // 0 1 2      0:studyPeriod   1:semester1    2:semester2

    property bool per_month_transcript : false;
    property bool midterm_transcript : false
    property bool semester_transcript : true
    property bool period_transcript : false

    property bool advisorComment : false;

    property var postScript;
    property bool compareReady : false;

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
                    settingPage.evals.push(obj["id"]);
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
                            settingPage.evals.push(obj["id"]);

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
                            settingPage.evals.push(obj["id"]);

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
                            settingPage.evals.push(obj["id"]);
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
                        if(settingPage.evals.includes(obj.id))
                        {
                            if(obj["semester"] === 1)
                                refModel.append({text: "آزمون " + obj.eval_name +" نیمسال اول ", value: obj.id});
                            else if(obj["semester"] === 2)
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

                            if(settingPage.evals.includes(obj.id))
                            {
                                if(obj["semester"] === 1)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                else if(obj["semester"] === 2)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});
                            }

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
                                if(settingPage.evals.includes(obj.id))
                                {
                                    if(obj["semester"] === 1)
                                        refModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                    else if(obj["semester"] === 2)
                                        refModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});
                                }

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
                    else if(SEMESTER === 2)
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
                                if(settingPage.evals.includes(obj.id))
                                {
                                    if(obj["semester"] === 1)
                                        refModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                    else if(obj["semester"] === 2)
                                        refModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم " , value: obj.id});
                                }


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
                    if(obj["semester"] === 1)
                        testRefModel.append({text: obj.eval_name +" نیمسال اول ", value: obj.id});
                    else if(obj["semester"] === 2)
                        testRefModel.append({text: obj.eval_name +" نیمسال دوم ", value: obj.id});

                    test_evals.push(id);
                }
        }

        if(test_evals.length > 0)
        {
            testCellHeightRL.visible = true;
            cellHeight1CB.currentIndex = cellHeight1CB.indexOfValue(10);
            cellHeight2CB.currentIndex = cellHeight2CB.indexOfValue(10);

            testRefRow.visible = true
            testCompareRef.currentIndex = 0;
            testAvgSW.visible = true
            baseTestAvgSW.visible = true
            predefinedTestBaseAvgSW.visible = true
            predefinedTestBaseAvgSW.checked = true
            if(testAvgSW.checked)
                testRefModel.append({"text": "میانگین تست", value: -10})
        }
        else
        {
            testCellHeightRL.visible = false;
            cellHeight1CB.currentIndex = cellHeight1CB.indexOfValue(20);
            cellHeight2CB.currentIndex = cellHeight2CB.indexOfValue(10);

            testRefRow.visible = false;
            testCompareRef.currentIndex = -1;
            testAvgSW.visible = false
            testAvgSW.checked = false
            baseTestAvgSW.visible = false
            predefinedTestBaseAvgSW.visible = false
        }

        if(refModel.count > 0)
            compareRef.currentIndex = 0;

        if(final_value > -1)
        {
            compareRef.currentIndex = compareRef.indexOfValue(final_value);
        }

        if(compareRef.currentIndex === -1)
            compareRef.currentIndex = 0;
    }

    function uncheckMonthSwitch(){
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

    function monthVisibility(){
        var sem = settingPage.semester_Number;
        if(sem == 1)
        {
            farSW.visible = false;
            ordSW.visible = false;
            khoSW.visible = false;

            tirSW.visible = false;
            morSW.visible = false;
            shaSW.visible = false;

            mehSW.visible = true;
            abaSW.visible = true;
            azaSW.visible = true;

            deySW.visible = true;
            bahSW.visible = false;
            esfSW.visible = false;

        }
        else if(sem == 2)
        {
            farSW.visible = true;
            ordSW.visible = true;
            khoSW.visible = true;

            tirSW.visible = false;
            morSW.visible = false;
            shaSW.visible = false;

            mehSW.visible = false;
            abaSW.visible = false;
            azaSW.visible = false;

            deySW.visible = false;
            bahSW.visible = true;
            esfSW.visible = true;
        }
        else
        {
            farSW.visible = true;
            ordSW.visible = true;
            khoSW.visible = true;

            tirSW.visible = true;
            morSW.visible = true;
            shaSW.visible = true;

            mehSW.visible = true;
            abaSW.visible = true;
            azaSW.visible = true;

            deySW.visible = true;
            bahSW.visible = true;
            esfSW.visible = true;
        }
    }

    function updatePostScript()
    {
        // output: signature, compare, test_compare, zero, shared[], count
        if(settingPage.compareReady)
        {
            let cmp = compareRef.currentText
            let tcmp = testCompareRef.currentText

            if(!testRefRow.visible)
                tcmp = "";
            settingPage.postScript = dbMan.generatePostScript(settingPage.class_id, cmp, tcmp);

            sigTF.text = settingPage.postScript["signature"];
            let txt;
            txt = settingPage.postScript["compare"];
            txt = txt + "\n" + settingPage.postScript["zero"];
            let array = settingPage.postScript["shared"];
            array.forEach(function(item){
                txt = txt + "\n" + item;
            });

            txt = txt + "\n" + settingPage.postScript["count"];

            infoPostSTA.text = txt;
        }
    }

    Flickable
    {
        anchors.fill: parent
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


                Label{
                    color: "darkslategray"
                    text: "تنظیمات کارنامه"
                    width: parent.width
                    horizontalAlignment: Label.AlignLeft
                }
                GroupBox{
                    width: parent.width
                    height: transCol.implicitHeight + 50

                    Column{
                        id: transCol
                        width: parent.width

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
                                    checked: (settingPage.semester_Number === 1)? true : false;
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

                                        settingPage.evals = []
                                        evalsModel.clear();

                                        if(checked){
                                            settingPage.semester_Number = 1;
                                            semesterTSW.checked = true
                                            settingPage.semester_transcript = true
                                        }

                                        settingPage.updateEvalsModel();
                                        settingPage.monthVisibility();
                                    }

                                }

                                // semester 2
                                Switch{
                                    id: semester2RB
                                    Layout.preferredHeight:  50
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    ButtonGroup.group: semesterGB
                                    text: "نیمسال دوم"
                                    checked: (settingPage.semester_Number === 2)? true : false;
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

                                        settingPage.evals = []
                                        evalsModel.clear();

                                        if(checked)
                                        {
                                            settingPage.semester_Number = 2;
                                            semesterTSW.checked = true
                                            settingPage.semester_transcript = true
                                        }

                                        settingPage.updateEvalsModel();
                                        settingPage.monthVisibility();
                                    }

                                }

                                // study period
                                Switch{
                                    id: periodRB
                                    Layout.preferredHeight:  50
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    ButtonGroup.group: semesterGB
                                    text: "سال‌تحصیلی"
                                    checked: (settingPage.semester_Number === 0)? true : false;
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

                                        settingPage.evals = []
                                        evalsModel.clear();

                                        if(checked)
                                        {
                                            settingPage.semester_Number = 0;
                                            periodTSW.checked = true
                                            settingPage.period_transcript = true
                                        }

                                        settingPage.updateEvalsModel();
                                        settingPage.monthVisibility();
                                    }

                                }
                            }
                        }

                        Label{
                            color: "darkcyan"
                            text: "نوع کارنامه"
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
                                    text: "کارنامه ماهیانه"
                                    checked: false
                                    ButtonGroup.group: transcriptBG
                                    visible: (settingPage.semester_Number > 0)? true : false
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

                                        settingPage.per_month_transcript = checked
                                        settingPage.updateEvalsModel();
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
                                    visible: (settingPage.semester_Number > 0)? true : false
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

                                        settingPage.midterm_transcript = checked
                                        settingPage.updateEvalsModel();
                                    }
                                }

                                // semester
                                Switch{
                                    id: semesterTSW
                                    Layout.preferredHeight:  50
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    ButtonGroup.group: transcriptBG
                                    text: "کارنامه نیمسال"
                                    checked: true
                                    visible: (settingPage.semester_Number > 0)? true : false
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

                                        settingPage.semester_transcript = checked
                                        settingPage.updateEvalsModel();
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
                                    visible: (settingPage.semester_Number == 0)? true : false
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

                                        settingPage.period_transcript = checked
                                        settingPage.updateEvalsModel();
                                    }
                                }
                            }
                        }

                        Label{
                            color: "royalblue"
                            text: "ارزیابی‌ها"
                            width: parent.width
                            horizontalAlignment: Label.AlignLeft
                        }
                        GroupBox{
                            width: parent.width
                            height: evalCol.implicitHeight + 50
                            //title: "ارزیابی‌ها"

                            Column{
                                id: evalCol
                                width: parent.width

                                Repeater
                                {
                                    id: evalsRp
                                    model: ListModel{id: evalsModel;}
                                    delegate:Switch{
                                        required property var model
                                        checked: (settingPage.evals.includes(model.id))? true : false;
                                        width: parent.width
                                        palette.highlight: (checked)? "royalblue" : "gray"
                                        palette.text:(checked)? "royalblue" : "gray"
                                        height: 50
                                        text: {
                                            if(settingPage.semester_Number == 0)
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
                                            var index = settingPage.evals.indexOf(model.id);

                                            if(checked)
                                            {
                                                //push
                                                if(index < 0)
                                                    settingPage.evals.push(model.id);
                                            }
                                            else
                                            {
                                                if( index > -1 && (settingPage.evals.length > 1) )
                                                    settingPage.evals.splice(index, 1);
                                                else
                                                    this.checked = true
                                            }


                                            settingPage.updateRefModel();
                                        }
                                    }

                                    Component.onCompleted: {
                                        settingPage.updateEvalsModel();
                                    }

                                }

                            }


                        }

                        Label{
                            color: "indianred"
                            text: "معیارهای سنجش"
                            width: parent.width
                            horizontalAlignment: Label.AlignLeft
                        }
                        GroupBox{

                            width: parent.width
                            height: paramCol.implicitHeight + 50

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
                                    visible: (settingPage.semester_transcript || settingPage.period_transcript )
                                    text: "میانگین پایه"
                                    checked: (settingPage.semester_transcript || settingPage.period_transcript )
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
                                    visible: (settingPage.semester_transcript || settingPage.period_transcript)? true : false
                                    text: (settingPage.period_transcript)? "نیمسال اول/دوم" : "نیمسال"
                                    checked: !settingPage.per_month_transcript
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    onToggled: settingPage.updateRefModel();
                                }

                                Switch{
                                    id: semesterAvgSW
                                    width: parent.width
                                    height: 50
                                    palette.highlight: "indianred"
                                    palette.text: (this.checked)? "indianred" : "gray"
                                    text: "میانگین نمیسال اول / دوم"
                                    visible: (settingPage.period_transcript)? true : false
                                    checked: true
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    onToggled: settingPage.updateRefModel();
                                }

                                Switch{
                                    id: finalAvgSW
                                    width: parent.width
                                    height: 50
                                    palette.highlight: "indianred"
                                    palette.text: (this.checked)? "indianred" : "gray"
                                    text: "میانگین نهایی اول/ دوم"
                                    visible: (settingPage.period_transcript)? true : false
                                    checked: true
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    onToggled: settingPage.updateRefModel();
                                }

                                Switch{
                                    id: formativeAvgSW
                                    width: parent.width
                                    height: 50
                                    palette.highlight: "indianred"
                                    palette.text: (this.checked)? "indianred" : "gray"
                                    text: "میانگین مستمر اول / دوم"
                                    visible: (settingPage.period_transcript)? true : false
                                    checked: true
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    onToggled: settingPage.updateRefModel();
                                }

                                Switch{
                                    id: perMonthAvgSW
                                    width: parent.width
                                    height: 50
                                    palette.highlight: "indianred"
                                    palette.text: (this.checked)? "indianred" : "gray"
                                    text: "میانگین ماهیانه"
                                    visible:{
                                        if(settingPage.per_month_transcript || settingPage.midterm_transcript )
                                        {
                                            return true;
                                        }
                                        else
                                            return false;
                                    }
                                    checked: false
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    onToggled: settingPage.updateRefModel();
                                }

                                Switch{
                                    id: baseTestAvgSW
                                    width: parent.width
                                    height: 50
                                    palette.highlight: "indianred"
                                    palette.text: (this.checked)? "indianred" : "gray"
                                    text: "میانگین تست پایه"
                                    visible:{
                                        if(settingPage.test_evals.length > 0 )
                                        {
                                            return true;
                                        }
                                        else
                                            return false;
                                    }
                                    checked: true
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                }

                                Switch{
                                    id: testAvgSW
                                    width: parent.width
                                    height: 50
                                    palette.highlight: "indianred"
                                    palette.text: (this.checked)? "indianred" : "gray"
                                    text: "میانگین تست‌های یک درس"
                                    visible:{
                                        if(settingPage.test_evals.length > 0 )
                                        {
                                            return true;
                                        }
                                        else
                                            return false;
                                    }
                                    checked: false
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                    onToggled: settingPage.updateRefModel();
                                }
                            }
                        }

                        Label{
                            color: "steelblue"
                            text: "محاسبات"
                            width: parent.width
                            horizontalAlignment: Label.AlignLeft
                        }
                        GroupBox{
                            width: parent.width
                            height:setCol.implicitHeight + 50

                            Column{
                                id: setCol
                                width: parent.width

                                Switch{
                                    id: fieldBasedSW
                                    width: parent.width
                                    height: 50
                                    palette.highlight: "steelblue"
                                    palette.text: (this.checked)? "steelblue" : "gray"
                                    text: "گزارش مبتنی بر " + settingPage.field
                                    checked: settingPage.field_based
                                    visible: settingPage.field_based
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
                                        Component.onCompleted: {settingPage.updateRefModel(); Qt.callLater(function(){settingPage.compareReady = true; settingPage.updatePostScript(); });}
                                        onCurrentTextChanged: {settingPage.updatePostScript(); }
                                    }
                                }

                                RowLayout{
                                    id: testRefRow
                                    visible: (settingPage.test_evals.length > 0)? true : false;
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
                                        Component.onCompleted: {settingPage.updateRefModel(); }
                                        onCurrentTextChanged: settingPage.updatePostScript();
                                    }
                                }


                                Switch{
                                    id: predefinedBaseAvgSW
                                    width: parent.width
                                    height: 50
                                    palette.highlight: "steelblue"
                                    palette.text: (this.checked)? "steelblue" : "gray"
                                    text: "استفاده از میانگین پایه دروس ثبت شده"
                                    checked: (settingPage.semester_transcript || settingPage.period_transcript )
                                    visible: (settingPage.semester_transcript || settingPage.period_transcript )
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                }

                                Switch{
                                    id: predefinedTestBaseAvgSW
                                    width: parent.width
                                    height: 50
                                    palette.highlight: "steelblue"
                                    palette.text: (this.checked)? "steelblue" : "gray"
                                    text: "استفاده از میانگین پایه تست ثبت شده"
                                    checked: (settingPage.test_evals.length > 0)? true : false;
                                    visible: (settingPage.test_evals.length > 0)? true : false;
                                    font.family: "Kalameh"
                                    font.pixelSize: 16
                                }

                            }
                        }

                        Label{
                            color: "midnightblue"
                            text: "نظر مشاور"
                            width: parent.width
                            horizontalAlignment: Label.AlignLeft
                        }
                        GroupBox{
                            width: parent.width
                            height:advisorCol.implicitHeight + 50
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
                                        checked: settingPage.advisorComment
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
                                                settingPage.uncheckMonthSwitch();

                                            settingPage.advisorComment = advisorChB.checked
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
                                    visible: settingPage.advisorComment

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

                                    Component.onCompleted: settingPage.monthVisibility();
                                }

                            }
                        }

                        // postscript
                        Label{
                            color: "mediumblue"
                            text: "پی‌نوشت"
                            width: parent.width
                            horizontalAlignment: Label.AlignLeft
                        }
                        GroupBox{
                            width: parent.width
                            height:postSCol.implicitHeight + 50

                            Column{
                                id: postSCol
                                width: parent.width
                                spacing: 5

                                RowLayout{
                                    width: parent.width
                                    height: 50
                                    Label{
                                        Layout.preferredHeight: 50
                                        Layout.preferredWidth: 150
                                        Layout.alignment: Qt.AlignLeft
                                        horizontalAlignment: Label.AlignLeft
                                        verticalAlignment: Label.AlignVCenter
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                        text:"متن امضا: "
                                        color: "mediumblue"
                                    }
                                    TextField{
                                        id: sigTF
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 50
                                        font.bold: false
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                        Component.onCompleted: {}
                                    }
                                }

                                RowLayout{
                                    width: parent.width
                                    height: infoPostSTA.height + 50
                                    Label{
                                        Layout.preferredHeight: 50
                                        Layout.preferredWidth: 150
                                        Layout.alignment: Qt.AlignLeft
                                        horizontalAlignment: Label.AlignLeft
                                        verticalAlignment: Label.AlignVCenter
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                        text:"اطلاعات پی‌نوشت: "
                                        color: "mediumblue"
                                    }
                                    TextArea{
                                        id: infoPostSTA
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: contentHeight + 50
                                        font.bold: false
                                        font.family: "Kalameh"
                                        font.pixelSize: 14
                                        background: Rectangle {
                                                    color: "#fff"
                                                    border.color: "#888"
                                                }
                                    }
                                }

                                RowLayout{
                                    width: parent.width
                                    height: 50
                                    Label{
                                        Layout.preferredHeight: 50
                                        Layout.preferredWidth: 150
                                        Layout.alignment: Qt.AlignLeft
                                        horizontalAlignment: Label.AlignLeft
                                        verticalAlignment: Label.AlignVCenter
                                        font.family: "Kalameh"
                                        font.pixelSize: 16
                                        text:"حاشیه بالا: "
                                        color: "mediumblue"
                                    }
                                    SpinBox{
                                        id: postScriptTMargin
                                        Layout.preferredWidth: 100
                                        Layout.preferredHeight: 50
                                        font.bold: false
                                        font.family: "Kalameh"
                                        font.pixelSize: 14
                                        value: 10
                                        from: 0
                                        to: 200
                                    }
                                    Item{
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 50
                                    }
                                }
                            }
                        }
                    }
                }

                Item{   width: parent.width;  height: 50; }
                // printer

                Label{
                    color: "darkslategray"
                    text: "تنظیمات چاپ"
                    width: parent.width
                    horizontalAlignment: Label.AlignLeft
                }
                GroupBox{
                    width: parent.width
                    height: printCol.implicitHeight + 50

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

                                    contentFontSizeCB.currentIndex = contentFontSizeCB.indexOfValue(16)
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

                                    titrFontSizeCB.currentIndex = titrFontSizeCB.indexOfValue(14)
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
                                Layout.preferredWidth: 300
                                Layout.alignment: Qt.AlignLeft
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                color: "darkslategray"
                                text:"ارتفاع سطرهای جدول: "
                            }
                            ComboBox{
                                id: cellHeight1CB
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.bold: false
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                model: ListModel{id: cellHeight1Model}
                                textRole: "text"
                                valueRole: "value"
                                Component.onCompleted:
                                {
                                    cellHeight1Model.append({text: "8", value: 8});
                                    cellHeight1Model.append({text: "10", value: 10});
                                    cellHeight1Model.append({text: "12", value: 12});
                                    cellHeight1Model.append({text: "14", value: 14});
                                    cellHeight1Model.append({text: "16", value: 16});
                                    cellHeight1Model.append({text: "18", value: 18});
                                    cellHeight1Model.append({text: "20", value: 20});
                                    cellHeight1Model.append({text: "22", value: 22});
                                    cellHeight1Model.append({text: "24", value: 24});
                                    cellHeight1Model.append({text: "26", value: 26});
                                    cellHeight1Model.append({text: "28", value: 28});
                                    cellHeight1Model.append({text: "30", value: 30});
                                    cellHeight1Model.append({text: "32", value: 32});
                                    cellHeight1Model.append({text: "34", value: 34});
                                    cellHeight1Model.append({text: "36", value: 36});
                                    cellHeight1Model.append({text: "38", value: 38});
                                    cellHeight1Model.append({text: "40", value: 40});

                                    cellHeight1CB.currentIndex = cellHeight1CB.indexOfValue(10)
                                }
                            }
                        }

                        RowLayout{
                            width: parent.width
                            height: 50
                            id: testCellHeightRL

                            Label{
                                Layout.preferredHeight: 50
                                Layout.preferredWidth: 300
                                Layout.alignment: Qt.AlignLeft
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                color: "darkslategray"
                                text:"ارتفاع سطرهای جدول تست: "
                            }
                            ComboBox{
                                id: cellHeight2CB
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.bold: false
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                model: ListModel{id: cellHeight2Model}
                                textRole: "text"
                                valueRole: "value"
                                Component.onCompleted:
                                {
                                    cellHeight2Model.append({text: "8", value: 8});
                                    cellHeight2Model.append({text: "10", value: 10});
                                    cellHeight2Model.append({text: "12", value: 12});
                                    cellHeight2Model.append({text: "14", value: 14});
                                    cellHeight2Model.append({text: "16", value: 16});
                                    cellHeight2Model.append({text: "18", value: 18});
                                    cellHeight2Model.append({text: "20", value: 20});
                                    cellHeight2Model.append({text: "22", value: 22});
                                    cellHeight2Model.append({text: "24", value: 24});
                                    cellHeight2Model.append({text: "26", value: 26});
                                    cellHeight2Model.append({text: "28", value: 28});
                                    cellHeight2Model.append({text: "30", value: 30});
                                    cellHeight2Model.append({text: "32", value: 32});
                                    cellHeight2Model.append({text: "34", value: 34});
                                    cellHeight2Model.append({text: "36", value: 36});
                                    cellHeight2Model.append({text: "38", value: 38});
                                    cellHeight2Model.append({text: "40", value: 40});

                                    cellHeight2CB.currentIndex = cellHeight2CB.indexOfValue(10)
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
                        onClicked: { settingPage.appStackView.pop(); }
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
                            if(settingPage.student_class_transcript)
                                saveFolderDialog.open(); // class print
                            else
                                saveFileDialog.open(); // student print
                        }

                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "darkcyan"}
                    }
                }

                Item{   width: parent.width;  height: 50; }
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
        onDialogAccepted: settingPage.appStackView.pop();
    }

    // file dialog
    FileDialog {
        id: saveFileDialog
        title: "محل ذخیره گزارش"
        //currentFolder: "file:///home/samad"
        currentFolder: "C:/"
        nameFilters: ["PDF Files (*.pdf)", "All Files (*)"]
        fileMode: FileDialog.SaveFile
        onAccepted:{
            // student_id   class_id  evals  semester  baseRank classRank  baseAvg max_grade field_based
            let student_id = settingPage.student_id
            let class_id = settingPage.class_id
            let class_name = settingPage.class_name
            let period = settingPage.period
            let evals = settingPage.evals
            let test_evals = settingPage.test_evals;
            let semester_number = settingPage.semester_Number;

            let field_based = fieldBasedSW.checked;
            let compare_ref_id = compareRef.currentValue;
            let compare_ref = compareRef.currentText;
            let test_compare_ref_id = testCompareRef.currentValue;
            let test_compare_ref = testCompareRef.currentText;
            let predefined_base_avg = predefinedBaseAvgSW.checked;
            let perMonthT  = settingPage.per_month_transcript;
            let midTermT = settingPage.midterm_transcript;
            let semesterT = settingPage.semester_transcript;
            let periodT = settingPage.period_transcript;
            let transcript = {"per_month": perMonthT , "midterm" : midTermT , "semester": semesterT, "period": periodT }
            let advisorComment_flag = settingPage.advisorComment
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
            let baseTestAvgField = baseTestAvgSW.checked

            if(test_evals.length < 1)
            {
                testAvgField = false;
                baseTestAvgField = false;
            }

            if(semester_Number > 0)
            {
                semesterAvgField = false;
                //perMonthAvgField = false;
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
            // if((compare_ref_id === -1) || (compare_ref === "") || (compare_ref_id === undefined ) )
            // {
            //     infoDialogId.dialogText = "لطفا مرجع مقایسه دروس را انتخاب نمایید.";
            //     infoDialogId.open();
            //     return;
            // }


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
                "class_name" : class_name,
                "period" : period,
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
                    "test_avg" : testAvgField,
                    "base_test_avg": baseTestAvgField
                }
                ,
                "fieldBased_flag" : settingPage.fieldBased_flag,
                "compare_ref_id": compare_ref_id,
                "compare_ref" : compare_ref,
                "test_compare_ref_id": test_compare_ref_id,
                "test_compare_ref" : test_compare_ref,
                "predefined_base_avg": predefined_base_avg,
                "predefined_test_avg": predefinedTestBaseAvgSW.checked,
                "advisor": advisorComment_flag,
                "comment_month": month,
                "postscript": {
                    "signature" : sigTF.text,
                    "text": infoPostSTA.text
                },

                "print":{
                    "paperSize": paperSizeCB.currentValue,
                    "fontFamily" : fontCB.currentValue,
                    "contentFontSize": contentFontSizeCB.currentValue,
                    "titrFontSize": titrFontSizeCB.currentValue,
                    "cellHeight1" : cellHeight1CB.currentValue,
                    "cellHeight2" : cellHeight2CB.currentValue,
                    "postScript_topMargin" : postScriptTMargin.value
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

    // folder dialog
    FolderDialog {
        id: saveFolderDialog
        title: "محل ذخیره گزارش"
        //currentFolder: "file:///home/samad"
        currentFolder: "C:/"
        onAccepted:{
            let class_id = settingPage.class_id
            let class_name = settingPage.class_name
            let period = settingPage.period
            let evals = settingPage.evals
            let test_evals = settingPage.test_evals;
            let semester_number = settingPage.semester_Number;

            let field_based = fieldBasedSW.checked;
            let compare_ref_id = compareRef.currentValue;
            let compare_ref = compareRef.currentText;
            let test_compare_ref_id = testCompareRef.currentValue;
            let test_compare_ref = testCompareRef.currentText;
            let predefined_base_avg = predefinedBaseAvgSW.checked;
            let perMonthT  = settingPage.per_month_transcript;
            let midTermT = settingPage.midterm_transcript;
            let semesterT = settingPage.semester_transcript;
            let periodT = settingPage.period_transcript;
            let transcript = {"per_month": perMonthT , "midterm" : midTermT , "semester": semesterT, "period": periodT }
            let advisorComment_flag = settingPage.advisorComment
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
            let testAvgField = testAvgSW.checked;
            let baseTestAvgField = baseTestAvgSW.checked

            if(test_evals.length < 1)
            {
                testAvgField = false;
                baseTestAvgField = false;
            }

            if(semester_Number > 0)
            {
                semesterAvgField = false;
                //perMonthAvgField = false;
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
            // if((compare_ref_id === -1) || (compare_ref === "") || (compare_ref_id === undefined ) )
            // {
            //     infoDialogId.dialogText = "لطفا مرجع مقایسه دروس را انتخاب نمایید.";
            //     infoDialogId.open();
            //     return;
            // }


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
                "class_id": class_id,
                "class_name" : class_name,
                "period" : period,
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
                    "test_avg" : testAvgField,
                    "base_test_avg": baseTestAvgField
                }
                ,
                "fieldBased_flag" : settingPage.fieldBased_flag,
                "compare_ref_id": compare_ref_id,
                "compare_ref" : compare_ref,
                "test_compare_ref_id": test_compare_ref_id,
                "test_compare_ref" : test_compare_ref,
                "predefined_base_avg": predefined_base_avg,
                "predefined_test_avg": predefinedTestBaseAvgSW.checked,
                "advisor": advisorComment_flag,
                "comment_month": month,
                "postscript": {
                    "signature" : sigTF.text,
                    "text": infoPostSTA.text
                },
                "print":{
                    "paperSize": paperSizeCB.currentValue,
                    "fontFamily" : fontCB.currentValue,
                    "contentFontSize": contentFontSizeCB.currentValue,
                    "titrFontSize": titrFontSizeCB.currentValue,
                    "cellHeight1" : cellHeight1CB.currentValue,
                    "cellHeight2" : cellHeight2CB.currentValue,
                    "postScript_topMargin" : postScriptTMargin.value
                }
            }

            if(dbMan.printClassTranscripts(selectedFolder, params, highlight1_Dialog.selectedColor, highlight2_Dialog.selectedColor, highlight3_Dialog.selectedColor, highlight4_Dialog.selectedColor))
            {
                successDialogId.width = 500
                successDialogId.dialogText = "فایل‌ها در مسیر زیر ذخیره گردید." + "\n" + selectedFolder
                successDialogId.open();
            }
            else
            {
                infoDialogId.dialogText = "عملیات با خطا مواجه شد.";
                infoDialogId.open();
            }
        }
        onRejected: saveFolderDialog.close();
    }

    //highlight1
    ColorDialog {
        id: highlight1_Dialog
        title: "انتخاب رنگ"
        selectedColor: "#fce3e3"
    }
    // highlight2
    ColorDialog {
        id: highlight2_Dialog
        title: "انتخاب رنگ"
        selectedColor: "#fcb5b5"
    }
    // highlight3
    ColorDialog {
        id: highlight3_Dialog
        title: "انتخاب رنگ"
        selectedColor: "#ff8f8f"
    }
    //highlight4
    ColorDialog {
        id: highlight4_Dialog
        title: "انتخاب رنگ"
        selectedColor: "#ff6363"
    }

}
