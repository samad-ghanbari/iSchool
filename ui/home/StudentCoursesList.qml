import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import "./../public" as DialogBox

Page {
    id: studentCoursesPageId

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
    required property var class_evals; // [{eval-1}, {}, ] // id, eval_name, course_flag, test_flag, final_flag

    required property StackView appStackView;

    property bool per_month: true;
    property bool midterm: true;
    property bool formative: true;
    property bool final_flag: true;
    property bool semester_1: true;
    property bool course_flag: true;
    property bool test_flag: false;

    property string activeEval;
    property bool onEditing : false
    required property var sceIds; // { mostamar:[], final:[], test:[]} one-student all-course

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    function findItemRecursive(parent, propertyName, propertyValue) {
        for (var i = 0; i < parent.children.length; i++) {
            var child = parent.children[i];
            if (child[propertyName] === propertyValue) {
                return child;
            }
            // Recursively search in the child's children
            var found = findItemRecursive(child, propertyName, propertyValue);
            if (found) {
                return found;
            }
        }
        return null; // Return null if no item is found
    }


    function refreshAllEvals() {
        if(dbMan.refreshStudentEvals(studentCoursesPageId.class_id, studentCoursesPageId.student_id))
        {
            studentCoursesPageId.class_evals = dbMan.getClassEvalsArray(studentCoursesPageId.class_id);
            studentCoursesPageId.sceIds = dbMan.getCategorisedSCEIds(studentCoursesPageId.class_id, studentCoursesPageId.student_id)


            infoDialogId.dialogSuccess = true
            infoDialogId.dialogTitle = "عملیات موفق"
            infoDialogId.dialogText = "آزمون‌های دانش‌آموز با موفقیت به روزرسانی شد."
            infoDialogId.open();

            lvModel.clear();
            var register_id = dbMan.getRegisterId(studentCoursesPageId.class_id, studentCoursesPageId.student_id);
            var jsonarray = dbMan.getStudentCourses_evals(register_id);
            for(var obj of jsonarray)
            {
                lvModel.append(obj);
            }
        }
        else
            infoDialogId.open();
    }

    function refreshEval(eval_id){
        if(dbMan.refreshStudentEval(studentCoursesPageId.class_id, studentCoursesPageId.student_id, eval_id))
        {
            studentCoursesPageId.class_evals = dbMan.getClassEvalsArray(studentCoursesPageId.class_id);
            studentCoursesPageId.sceIds = dbMan.getCategorisedSCEIds(studentCoursesPageId.class_id, studentCoursesPageId.student_id)


            infoDialogId.dialogSuccess = true
            infoDialogId.dialogTitle = "عملیات موفق"
            infoDialogId.dialogText = "آزمون منتخب دانش‌آموز با موفقیت به روزرسانی شد."
            infoDialogId.open();

            lvModel.clear();
            var register_id = dbMan.getRegisterId(studentCoursesPageId.class_id, studentCoursesPageId.student_id);
            var jsonarray = dbMan.getStudentCourses_evals(register_id);
            for(var obj of jsonarray)
            {
                lvModel.append(obj);
            }
        }
        else
            infoDialogId.open();
    }

    function checkVisibility(model)
    {
        let PER_MONTH = model["per_month"];
        let MIDTERM = model["midterm"];
        let FORMATIVE = model["formative"];
        let FINAL_FLAG = model["final_flag"];
        let SEMESTER = model["semester"];
        let COURSE_FLAG = model["course_flag"];
        let TEST_FLAG = model["test_flag"];


        if(COURSE_FLAG)
            if(!studentCoursesPageId.course_flag)
                return false;

        if(TEST_FLAG)
            if(!studentCoursesPageId.test_flag)
                return false;


        if(SEMESTER === "نیمسال اول")
            if(!studentCoursesPageId.semester_1)
                return false;

        if(PER_MONTH)
            if(studentCoursesPageId.per_month)
                return true;

        if(MIDTERM)
            if(studentCoursesPageId.midterm)
                return true;

        if(FORMATIVE)
            if(studentCoursesPageId.formative)
                return true;

        if(FINAL_FLAG)
            if(studentCoursesPageId.final_flag)
                return true;

        return false;
    }

    ColumnLayout
    {
        id: clayout
        anchors.fill: parent
        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight:  50
            Layout.margins: 0
            color:"transparent"

            Text {
                width: parent.width
                height: 50
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: studentCoursesPageId.branch + " - " + studentCoursesPageId.step
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight:  100

            Image {
                source:studentCoursesPageId.student_photo
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
                    text: studentCoursesPageId.student
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
                    text: (studentCoursesPageId.field_based) ?  studentCoursesPageId.field + " - " + studentCoursesPageId.base :   studentCoursesPageId.base
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                }
            }
        }


        Row{
            Layout.preferredHeight:  30
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 0
            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: " سال تحصیلی "
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text:   studentCoursesPageId.period
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text:  " - " + studentCoursesPageId.class_name
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

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            Text {
                Layout.preferredHeight: 50
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: " دروس دانش‌آموز "
                font.family: "Kalameh"
                font.pixelSize: 20
                font.bold: true
                color: "mediumvioletred"
            }
            Item{Layout.fillWidth: true; Layout.preferredHeight: 50;}
            Button
            {
                visible: !dbMan.idPeriodPassed()
                height: 50
                background: Item{}
                icon.source: "qrc:/assets/images/upload.png"
                icon.width: 32
                icon.height: 32
                text: "بارگزاری فایل اکسل"
                font.family: "Kalameh"
                font.pixelSize: 14
                font.bold: false
                display: AbstractButton.TextUnderIcon
                icon.color:"transparent"
                opacity: 0.5
                onClicked: {
                    openFileDialog.open();
                }
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Button
            {
                visible: !dbMan.idPeriodPassed()
                height: 50
                background: Item{}
                icon.source: "qrc:/assets/images/download.png"
                icon.width: 32
                icon.height: 32
                text: "دریافت فایل اکسل"
                font.family: "Kalameh"
                font.pixelSize: 14
                font.bold: false
                display: AbstractButton.TextUnderIcon
                icon.color:"transparent"
                opacity: 0.5
                onClicked:
                {
                    evalSelectionDialog.fillComboBox();
                    evalSelectionDialog.open();
                }
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Button
            {
                visible: !dbMan.idPeriodPassed()
                height: 50
                background: Item{}
                icon.source: "qrc:/assets/images/refresh.png"
                icon.width: 32
                icon.height: 32
                text: "ارزیابی‌ها"
                font.family: "Kalameh"
                font.pixelSize: 14
                font.bold: false
                display: AbstractButton.TextUnderIcon
                icon.color:"transparent"
                opacity: 0.5
                onClicked: {
                    evalSelectionRefreshDialog.fillComboBox();
                    evalSelectionRefreshDialog.open(); // studentCoursesPageId.refreshAllEvals();
                }
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
        }

        // filter
        Flickable
        {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            contentWidth: innerFilterBox.width

            Rectangle
            {
                id: innerFilterBox
                width: (clayout.width > innerFilterBoxRow.implicitWidth)? clayout.width : innerFilterBoxRow.implicitWidth
                height: 50
                color: "snow"
                Row{
                    id: innerFilterBoxRow
                    height: 50
                    anchors.left: parent.left

                    Image {
                        source:"qrc:/assets/images/filter.png"
                        width: 32
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    //semester
                    ButtonGroup{
                        id: semesterBG
                    }
                    GroupBox{
                        width: innerBox.implicitWidth;
                        height: 50
                        padding: 0


                        Row{
                            id: innerBox
                            height: 50
                            anchors.margins: 0;

                            RadioButton{
                                height: 50
                                anchors.verticalCenter: parent.verticalCenter
                                ButtonGroup.group: semesterBG
                                text: "نیمسال اول"
                                palette.text: (this.checked)? "steelblue" : "gray"
                                palette.buttonText:  (this.checked)? "steelblue" : "gray"
                                checked: true
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                onCheckedChanged: {
                                    studentCoursesPageId.semester_1  = (this.checked)? true: false;
                                }
                            }
                            RadioButton{
                                height: 50
                                anchors.verticalCenter: parent.verticalCenter
                                ButtonGroup.group: semesterBG
                                text: "نیمسال دوم"
                                palette.text:  (this.checked)? "steelblue" : "gray"
                                palette.buttonText:  (this.checked)? "steelblue" : "gray"
                                checked: false
                                font.family: "Kalameh"
                                font.pixelSize: 16
                            }
                        }
                    }

                    ButtonGroup{
                        id: testCourseBG
                    }

                    GroupBox{
                        width: innerTestCourseBox.implicitWidth;
                        height: 50
                        padding: 0
                        Row{
                            id: innerTestCourseBox
                            height: 50
                            anchors.margins: 0;
                            RadioButton{
                                //width: parent.width
                                height: 50
                                text: "ارزیابی تستی"
                                palette.text: (this.checked)? "steelblue" : "gray"
                                palette.buttonText:  (this.checked)? "steelblue" : "gray"
                                ButtonGroup.group: testCourseBG
                                checked: studentCoursesPageId.test_flag
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                onCheckedChanged:{
                                    if(this.checked)
                                        studentCoursesPageId.test_flag = true;
                                    else
                                        studentCoursesPageId.test_flag = false;
                                }
                            }
                            RadioButton{
                                //width: parent.width
                                height: 50
                                text: "ارزیابی تشریحی"
                                palette.text: (this.checked)? "steelblue" : "gray"
                                palette.buttonText:  (this.checked)? "steelblue" : "gray"
                                ButtonGroup.group: testCourseBG
                                checked: studentCoursesPageId.course_flag
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                onCheckedChanged:{
                                    if(this.checked)
                                        studentCoursesPageId.course_flag = true;
                                    else
                                        studentCoursesPageId.course_flag = false;
                                }
                            }
                        }
                    }

                    //per_month
                    Switch{
                        //width: parent.width
                        height: 50
                        text: "ارزیابی ماهیانه"
                        palette.text: (this.checked)? "steelblue" : "gray"
                        palette.highlight: (this.checked)? "steelblue" : "gray"
                        checked: studentCoursesPageId.per_month
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        onCheckedChanged:{
                            if(this.checked)
                                studentCoursesPageId.per_month = true;
                            else
                                studentCoursesPageId.per_month = false;
                        }
                    }
                    //midterm
                    Switch{
                        //width: parent.width
                        height: 50
                        text: "ارزیابی میان‌ترم"
                        palette.text: (this.checked)? "steelblue" : "gray"
                        palette.highlight: (this.checked)? "steelblue" : "gray"
                        checked: studentCoursesPageId.midterm
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        onCheckedChanged:{
                            if(this.checked)
                                studentCoursesPageId.midterm = true;
                            else
                                studentCoursesPageId.midterm = false;
                        }
                    }
                    //formative
                    Switch{
                        //width: parent.width
                        height: 50
                        text: "ارزیابی مستمر"
                        palette.text: (this.checked)? "steelblue" : "gray"
                        palette.highlight: (this.checked)? "steelblue" : "gray"
                        checked: studentCoursesPageId.formative
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        onCheckedChanged:{
                            if(this.checked)
                                studentCoursesPageId.formative = true;
                            else
                                studentCoursesPageId.formative = false;
                        }
                    }
                    //final
                    Switch{
                        //width: parent.width
                        height: 50
                        text: "ارزیابی نهایی"
                        palette.text: (this.checked)? "steelblue" : "gray"
                        palette.highlight: (this.checked)? "steelblue" : "gray"
                        checked: studentCoursesPageId.final_flag
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        onCheckedChanged:{
                            if(this.checked)
                                studentCoursesPageId.final_flag = true;
                            else
                                studentCoursesPageId.final_flag = false;
                        }
                    }

                }
            }
        }

        Rectangle{
            id: mainBox
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 600
            Layout.topMargin: 20
            color: "transparent"

            Flickable{
                id: flk
                width: parent.width
                height: parent.height
                contentHeight: lv.height
                contentWidth: lv.width
                clip: true


                ListView
                {
                    id: lv
                    width: Math.max(lv.contentWidth , flk.width)
                    height: Math.max(lv.contentHeight , flk.height)
                    model: ListModel{id: lvModel;}
                    delegate:lvDelegate
                    Component.onCompleted: {
                        lvModel.clear();
                        let cnt;
                        var register_id = dbMan.getRegisterId(studentCoursesPageId.class_id, studentCoursesPageId.student_id);
                        var jsonarray = dbMan.getStudentCourses_evals(register_id);
                        //0sc.id, 1sc.register_id, 2sc.course_id, 3co.course_name, 4co.step_id, 5co.base_id, 6co.period_id,
                        //7co.course_coefficient, 8co.test_coefficient, 9co.shared_coefficient, 10co.final_weight, 11co.shared_weight
                        // evals [{}, {}] : {sce.student_course_eval_id, sce.student_course_id, sce.eval_id, e.eval_name, e.base_id, e.period_id, e.test_flag, e.final_flag, e.per_month, e.midterm, e.formative, e.semester, e.max_grade, sce.grade, sce.eval_time, sce.included}
                        for(var obj of jsonarray)
                        {
                            lvModel.append(obj);
                        }

                        lv.width = Math.max(lv.contentWidth , lv.width)
                        lv.height = Math.max(lv.contentHeight , flk.height)

                        flk.contentWidth = Math.max(lv.width, 1500)
                        flk.contentHeight = lv.height
                    }
                    populate: Transition {
                        // NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 1000 }
                        NumberAnimation { properties: "x,y"; duration: 1000 }
                    }
                }
            }


        }
    }

    Component{
        id: lvDelegate
        Rectangle{
            id: recdel
            required property var model;
            height: 110
            width:  Math.max(lv.width, dlgRow.implicitWidth)

            color: (recdel.model.index % 2 == 0)? "aliceblue" : "mintcream"
            Row{
                id: dlgRow
                spacing: 10
                height : 100
                anchors.left: parent.left

                Rectangle{
                    width: 300
                    height: 100
                    color: "transparent"
                    Label{
                        anchors.fill: parent
                        font.family: "Kalameh"
                        font.pixelSize: 20
                        font.bold: true
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                        text: "   "+ recdel.model.course_name
                        color: "darkmagenta"
                    }
                }

                Rectangle{
                    width: Math.max( evalGradeRec.width, coeffRec.width)
                    height: 100
                    color: "transparent"
                    Rectangle{
                        id: coeffRec
                        width: coeffRow.implicitWidth
                        height: 50
                        anchors.left: parent.left
                        color: "transparent"
                        anchors.top: parent.top
                        Row{
                            id: coeffRow
                            height: parent.height
                            anchors.left: parent.left
                            spacing: 20
                            Label{
                                height: 50
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text: "ضریب درس: " + recdel.model.course_coefficient
                                color: "darkslategray"
                                visible: (recdel.model.course_coefficient > 0)? true : false
                            }
                            Label{
                                height: 50
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text: "ضریب تست: " + recdel.model.test_coefficient
                                color: "darkslategray"
                                visible: (recdel.model.test_coefficient > 0)? true : false
                            }
                            Label{
                                height: 50
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text: "وزن آزمون نهایی: " + recdel.model.final_weight
                                color: "darkslategray"
                                visible: (recdel.model.final_weight > 0)? true : false
                            }
                            Label{
                                height: 50
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text: "وزن ضریب اشتراکی: " + recdel.model.shared_weight
                                color: "darkslategray"
                                visible: (recdel.model.shared_weight > 0)? true : false
                            }
                        }

                        Rectangle{
                            width: parent.width
                            height: 1
                            color: "gainsboro"
                            anchors.bottom: parent.bottom
                        }
                    }
                    // evals & grade
                    Rectangle{
                        id: evalGradeRec
                        width: evalGradeRow.implicitWidth
                        anchors.left: parent.left
                        height: 50
                        color: "transparent"
                        anchors.bottom: parent.bottom
                        Row{
                            id: evalGradeRow
                            height: parent.height
                            anchors.left: parent.left
                            // evals

                            Repeater{
                                id: rowEvalRep
                                property int modelIndex : recdel.model.index
                                model: (typeof recdel.model["evals"] != "undefined")? recdel.model["evals"] : [] // [{},{}]
                                delegate:
                                    Rectangle{
                                    id: evalRecDel
                                    required property var model;
                                    property int sceID : (typeof evalRecDel.model["student_course_eval_id"] != "undefined")? parseInt(evalRecDel.model["student_course_eval_id"]) : -1;
                                    property alias cell : te
                                    height: 50
                                    width:titlerec.implicitWidth + 120
                                    Layout.margins: 0
                                    visible: studentCoursesPageId.checkVisibility(evalRecDel.model);

                                    color:"floralwhite"
                                    border.width: 1
                                    border.color: "gray"


                                    property bool edit : false
                                    property real value : {
                                        if(typeof evalRecDel.model["grade"] != "undefined"){
                                            if(evalRecDel.model["grade"] !== "")
                                                return evalRecDel.model["grade"];
                                            else
                                                return -1000;
                                        }
                                        else return -1000;
                                    }

                                    Row{
                                        anchors.fill: parent
                                        anchors.margins: 5
                                        //title
                                        Label{
                                            id: titlerec
                                            height: 50
                                            horizontalAlignment: Text.AlignRight
                                            verticalAlignment: Text.AlignVCenter
                                            font.family: "Kalameh"
                                            font.pixelSize: 16
                                            font.bold: true
                                            color:"black"
                                            text: evalRecDel.model.eval_name +": "
                                            //background: Rectangle{color:"blue"}
                                        }
                                        //content
                                        Rectangle{
                                            height: 50
                                            width: 100
                                            color: "transparent"

                                            function doneEdit()
                                            {
                                                evalRecDel.edit = false
                                                studentCoursesPageId.onEditing = false
                                                var v = parseFloat(te.text);
                                                var scei = parseInt(evalRecDel.model["student_course_eval_id"]);
                                                if(v > evalRecDel.model.max_grade)
                                                {
                                                    te.text = ""
                                                    infoDialogId.dialogSuccess = false
                                                    infoDialogId.dialogTitle = "خطا"
                                                    infoDialogId.dialogText = "مقدار وارد شده از بیشترین نمره مجاز بالاتر است."
                                                    infoDialogId.open();
                                                    return;
                                                }

                                                if(te.text === "")
                                                {
                                                    if(!dbMan.setStudentCourseEvalGrade(scei))
                                                    {
                                                        infoDialogId.open();
                                                    }
                                                    else
                                                    {
                                                        evalRecDel.value = v;
                                                    }
                                                }
                                                else{
                                                    if(!dbMan.setStudentCourseEvalGrade(scei, v))
                                                    {
                                                        infoDialogId.open();
                                                    }
                                                    else
                                                    {
                                                        evalRecDel.value = v;
                                                    }
                                                }
                                            }

                                            TextField{
                                                id: te
                                                height: 40
                                                width: 100
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                font.family: "Kalameh"
                                                font.pixelSize: 18
                                                font.bold: true
                                                color:"darkmagenta"
                                                text:(evalRecDel.value > -1000)? evalRecDel.value :"";
                                                visible: evalRecDel.edit
                                                Rectangle{height:2; width: parent.width; color: "olivedrab"; anchors.bottom:parent.bottom;}
                                                validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                                                    regularExpression: /^-?\d*\.?\d+$/
                                                }

                                                //onEditingFinished:parent.doneEdit();
                                                //onFocusChanged: parent.doneEdit();
                                                Keys.onTabPressed: {
                                                    parent.doneEdit();
                                                    var scei = parseInt(evalRecDel.model["student_course_eval_id"]);
                                                    var eval_name = evalRecDel.model["eval_name"];
                                                    var array = studentCoursesPageId.sceIds[eval_name]; // array
                                                    // find index
                                                    var index = array.indexOf(scei) + 1;
                                                    var nextScei = array[index];
                                                    if(nextScei === undefined) return;
                                                    // find record in repeater with property sceID equal to nextscei
                                                    var item = studentCoursesPageId.findItemRecursive(lv, "sceID", nextScei);
                                                    if(item){
                                                        item.edit = true;
                                                        studentCoursesPageId.onEditing = true
                                                        item.cell.forceActiveFocus();

                                                        item = lv.itemAtIndex(rowEvalRep.modelIndex)
                                                        if (item) {
                                                            flk.contentY = item.y - flk.height / 2  + 400; //+ item.height / 2
                                                        }
                                                    }

                                                }

                                                Keys.onReturnPressed: {
                                                    parent.doneEdit();
                                                    var scei = parseInt(evalRecDel.model["student_course_eval_id"]);
                                                    var eval_name = evalRecDel.model["eval_name"];
                                                    var array = studentCoursesPageId.sceIds[eval_name]; // array
                                                    // find index
                                                    var index = array.indexOf(scei) + 1;
                                                    var nextScei = array[index];
                                                    if(nextScei === undefined) return;
                                                    // find record in repeater with property sceID equal to nextscei
                                                    var item = studentCoursesPageId.findItemRecursive(lv, "sceID", nextScei);
                                                    if(item){
                                                        item.edit = true;
                                                        studentCoursesPageId.onEditing = true
                                                        item.cell.forceActiveFocus();

                                                        item = lv.itemAtIndex(rowEvalRep.modelIndex)
                                                        if (item) {
                                                            flk.contentY = item.y - flk.height / 2  + 400; //+ item.height / 2
                                                        }
                                                    }

                                                }

                                                Keys.onEscapePressed: {
                                                    evalRecDel.edit = false
                                                    studentCoursesPageId.onEditing = false
                                                    te.text = (evalRecDel.value > -1000)? evalRecDel.value : ""
                                                }

                                                Button{
                                                    height: 24
                                                    width: 24
                                                    background: Rectangle{color:"transparent"}
                                                    icon.source: "qrc:/assets/images/tick.png"
                                                    icon.width: 24
                                                    icon.height: 24
                                                    icon.color:"transparent"
                                                    opacity: 0.5
                                                    onClicked: parent.parent.doneEdit();
                                                    hoverEnabled: true
                                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                                    anchors.right:parent.right
                                                    anchors.top: parent.top
                                                }
                                                Button{
                                                    height: 24
                                                    width: 24
                                                    background: Rectangle{color:"transparent"}
                                                    icon.source: "qrc:/assets/images/cross.png"
                                                    icon.width: 24
                                                    icon.height: 24
                                                    icon.color:"transparent"
                                                    opacity: 0.5
                                                    onClicked: {
                                                        evalRecDel.edit = false
                                                        studentCoursesPageId.onEditing = false
                                                        te.text = (evalRecDel.value > -1000)? evalRecDel.value : ""
                                                    }
                                                    hoverEnabled: true
                                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                                    anchors.left:parent.left
                                                    anchors.top: parent.top
                                                }
                                            }

                                            Label{
                                                width: 100
                                                height: 50
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                font.family: "Kalameh"
                                                font.pixelSize: 18
                                                font.bold: true
                                                color:"black"
                                                background: Item{}
                                                text:{
                                                    if(evalRecDel.value > -1000)
                                                    {
                                                        if(evalRecDel.model["test_flag"])
                                                        {
                                                            return evalRecDel.value + " % "
                                                        }
                                                        else
                                                            return evalRecDel.value;
                                                    }
                                                    else return ""
                                                }
                                                visible: !evalRecDel.edit
                                                MouseArea{
                                                    visible: !dbMan.idPeriodPassed()
                                                    anchors.fill: parent
                                                    onDoubleClicked:{

                                                        if(studentCoursesPageId.onEditing)
                                                        {
                                                            // find 2clicked items and save them before
                                                            var item = studentCoursesPageId.findItemRecursive(lv, "edit", true);
                                                            while(item)
                                                            {
                                                                var scei = item.sceID;
                                                                var val = item.cell.text;
                                                                item.edit = false;
                                                                if(!dbMan.setStudentCourseEvalGrade(scei, val))
                                                                {
                                                                    infoDialogId.dialogText = "انجام عملیات با خطا مواجه شد."
                                                                    infoDialogId.dialogTitle = "خطا"
                                                                    infoDialogId.dialogSuccess = false
                                                                    infoDialogId.open();
                                                                }
                                                                else
                                                                {
                                                                    item.value = val;
                                                                }

                                                                item = studentCoursesPageId.findItemRecursive(lv, "edit", true);
                                                            }

                                                        }

                                                        evalRecDel.edit = true
                                                        studentCoursesPageId.onEditing = true
                                                        te.forceActiveFocus();
                                                        studentCoursesPageId.activeEval = evalRecDel.model["eval_name"];
                                                    }
                                                }
                                            }

                                        }

                                    }
                                }


                            }


                            Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}

                        }

                    }
                }
            }

            Rectangle{width: parent.width; height: 5; color: "gainsboro"; anchors.bottom: parent.bottom;}
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
        dialogTitle: "موفق"
        dialogText: "عملیات با موفقیت انجام شد."
        dialogSuccess: true
    }

    // eval Selection
    DialogBox.EvalDialog
    {
        id: evalSelectionDialog
        model : studentCoursesPageId.class_evals
        onEvalSelected: (eval_id)=>{
                            saveFileDialog.eval_id = eval_id;
                            saveFileDialog.open();
                            evalSelectionDialog.close();
                        }
    }

    // eval Selection for refresh
    DialogBox.EvalDialog
    {
        id: evalSelectionRefreshDialog
        model : studentCoursesPageId.class_evals
        onEvalSelected: (eval_id)=>{
                            studentCoursesPageId.refreshEval(eval_id);
                            evalSelectionRefreshDialog.close();
                        }
    }
    // file dialog
    FileDialog {
        id: saveFileDialog
        title: "محل ذخیره فایل اکسل"
        currentFolder: "file:///home/samad/share/Desktop/"
        //currentFolder: "C:/Users/YourUsername/Documents"
        nameFilters: ["xlsx Files (*.xlsx)", "All Files (*)"]
        fileMode: FileDialog.SaveFile

        property int eval_id;

        onAccepted:{
            if(dbMan.generateStudentCoursesGradeXlsx(selectedFile, studentCoursesPageId.student_id, studentCoursesPageId.class_id, saveFileDialog.eval_id))
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

    // file dialog
    FileDialog {
        id: openFileDialog
        title: "انتخاب فایل اکسل"
        currentFolder: "file:///home/samad/share/Desktop/"
        //currentFolder: "C:/Users/YourUsername/Documents"
        nameFilters: ["xlsx Files (*.xlsx)", "All Files (*)"]
        fileMode: FileDialog.OpenFile

        onAccepted:{
            if(dbMan.updateStudentCoursesGradeByXlsx(selectedFile, studentCoursesPageId.student_id, studentCoursesPageId.class_id))
            {
                successDialogId.width = 300
                successDialogId.dialogText = "نمرات دانش‌آموز با موفقیت بروز گردید."
                successDialogId.open();

                lvModel.clear();
                var register_id = dbMan.getRegisterId(studentCoursesPageId.class_id, studentCoursesPageId.student_id);
                var jsonarray = dbMan.getStudentCourses_evals(register_id);
                for(var obj of jsonarray)
                {
                    lvModel.append(obj);
                }
            }
            else
            {
                infoDialogId.width = 400
                infoDialogId.dialogText = dbMan.getLastError();
                infoDialogId.open();
            }
        }
        onRejected: openFileDialog.close();
    }
}
