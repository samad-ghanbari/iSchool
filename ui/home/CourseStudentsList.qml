import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "./../public" as DialogBox

Page {
    id: courseStudentsPageId

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;
    required property string class_name;
    required property int class_id;
    required property int course_id;
    required property string course_name;
    required property var class_evals; // [{eval-1}, {}, ] // id, eval_name, course_flag, test_flag, final_flag


    required property StackView appStackView;

    property string activeEval;
    property bool onEditing : false;
    required property var sceIds; // { mostamar:[], final:[], test:[]} one-course all-students

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

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent


        Text {
            Layout.fillWidth: true
            height: parent.height
            Layout.preferredHeight: 30
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: courseStudentsPageId.branch + " - " + courseStudentsPageId.step
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
        }


        Column{
            Layout.fillWidth: true
            Layout.preferredHeight: 100

            Text {
                width: parent.width
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: courseStudentsPageId.course_name
                font.family: "Kalameh"
                font.pixelSize: 24
                font.bold: true
                color: "mediumvioletred"
            }

            Text {
                width: parent.width
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: (courseStudentsPageId.field_based) ? courseStudentsPageId.field + " - " +  courseStudentsPageId.base :  courseStudentsPageId.base
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }

            Row{
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    height: 30
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    text: " سال تحصیلی "
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                }
                Text {
                    height: 30
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    text: courseStudentsPageId.period
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                }
                Text {
                    height: 30
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignHCenter
                    text: " - " +  courseStudentsPageId.class_name
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

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight: 25
            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: "ارزیابی درس دانش‌آموزان"
                font.family: "Kalameh"
                font.pixelSize: 20
                font.bold: true
                color: "mediumvioletred"
            }

            Button
            {
                Layout.preferredHeight:  50
                background: Item{}
                icon.source: "qrc:/assets/images/grade.png"
                icon.width: 32
                icon.height: 32
                icon.color:"transparent"
                text: "ثبت نمره"
                font.family: "Kalameh"
                font.pixelSize: 14
                font.bold: false
                display: AbstractButton.TextUnderIcon
                opacity: 0.8
                onClicked: {
                    setGradeDialog.evalCBox.currentIndex=-1
                    setGradeDialog.gradeValue=""
                    setGradeDialog.open();
                }
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.8;
            }

            Button
            {
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
                onClicked: {
                    evalSelectionDialog.fillComboBox();
                    evalSelectionDialog.open();
                }
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Button
            {
                height: 50
                background: Item{}
                icon.source: "qrc:/assets/images/refresh.png"
                icon.width: 32
                icon.height: 32
                text: "بروزرسانی ارزیابی‌ها"
                font.family: "Kalameh"
                font.pixelSize: 14
                font.bold: false
                display: AbstractButton.TextUnderIcon
                icon.color:"transparent"
                opacity: 0.5
                onClicked: {
                    if(dbMan.refreshCourseEvals(courseStudentsPageId.class_id, courseStudentsPageId.course_id))
                    {
                        infoDialogId.dialogSuccess = true
                        infoDialogId.dialogTitle = "عملیات موفق"
                        infoDialogId.dialogText = "آزمون‌های درس برای دانش‌آموزان بروزرسانی شد.";
                        infoDialogId.open();
                        // update model
                        lvModel.clear();
                        var jsonarray = dbMan.getCourseStudents_evals(courseStudentsPageId.class_id, courseStudentsPageId.course_id);
                        for(var obj of jsonarray)
                        {
                            lvModel.append(obj);
                        }

                    }
                    else{
                        infoDialogId.dialogText = "انجام عملیات با خطا مواجه شد."
                        infoDialogId.dialogTitle = "خطا"
                        infoDialogId.dialogSuccess = false
                        infoDialogId.open();
                    }
                }
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
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
                anchors.fill: parent
                contentHeight: lv.contentHeight
                contentWidth: lv.contentWidth

                ListView
                {
                    id: lv
                    anchors.fill: parent
                    model: ListModel{id: lvModel;}
                    clip: true
                    delegate:lvDelegate
                    Component.onCompleted: {
                        lvModel.clear();
                        // register_id, r.student_id, r.class_id, s.student, s.fathername, s.photo, evals[]
                        var jsonarray = dbMan.getCourseStudents_evals(courseStudentsPageId.class_id, courseStudentsPageId.course_id);
                        for(var obj of jsonarray)
                        {
                            lvModel.append(obj);
                        }
                    }
                    populate: Transition {
                        //NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 1000 }
                        NumberAnimation { properties: "x,y"; duration: 1000 }
                    }
                }
            }


        }
    }

    Component{
        id: lvDelegate
        Rectangle{
            id: recdel;
            height: 110
            width: lv.width

            required property var model;
            color: (recdel.model.index % 2 == 0)? "aliceblue" : "mintcream"
            RowLayout{
                //user
                spacing: 10
                anchors.fill: parent
                Image {
                    source:recdel.model.photo
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 100
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                }

                Rectangle{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 100
                    color: "transparent"
                    Rectangle{
                        width: parent.width
                        height: 50
                        color: "transparent"
                        anchors.top: parent.top
                        // top rect
                        RowLayout{
                            anchors.fill: parent
                            spacing: 20

                            //Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}

                            Label{
                                Layout.preferredHeight: 50
                                font.family: "Kalameh"
                                font.pixelSize: 20
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text:  recdel.model.student
                                color: "darkslategray"
                            }
                            Label{
                                Layout.preferredHeight: 50
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text:  "نام پدر: " + recdel.model.fathername
                                color: "darkslategray"
                                visible: (recdel.model.fathername !== "")? true : false
                            }


                            Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                        }
                        // line
                        Rectangle{
                            width: parent.width
                            height: 1
                            color: "gainsboro"
                            anchors.bottom: parent.bottom
                        }
                    }
                    // bottom rect
                    //evals & grade
                    Rectangle{
                        width: parent.width
                        height: 50
                        color: "transparent"
                        anchors.bottom: parent.bottom

                        RowLayout{
                            height: parent.height
                            width: parent.width
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

                                    Layout.alignment: Qt.AlignLeft
                                    Layout.preferredHeight: 50
                                    Layout.preferredWidth:titlerec.implicitWidth + 120
                                    Layout.margins: 0

                                    color:"floralwhite"
                                    border.width: 1
                                    border.color: "gray"





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
                                                courseStudentsPageId.onEditing = false
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
                                                        infoDialogId.dialogText = "انجام عملیات با خطا مواجه شد."
                                                        infoDialogId.dialogTitle = "خطا"
                                                        infoDialogId.dialogSuccess = false
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
                                                        infoDialogId.dialogText = "انجام عملیات با خطا مواجه شد."
                                                        infoDialogId.dialogTitle = "خطا"
                                                        infoDialogId.dialogSuccess = false
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
                                                Keys.onEscapePressed: {
                                                    evalRecDel.edit = false
                                                    te.text = (evalRecDel.value > -1000)? evalRecDel.value : ""
                                                    courseStudentsPageId.onEditing = false;
                                                }
                                                Keys.onTabPressed: {
                                                    parent.doneEdit();
                                                    var scei = parseInt(evalRecDel.model["student_course_eval_id"]);
                                                    var eval_name = evalRecDel.model["eval_name"];
                                                    var array = courseStudentsPageId.sceIds[eval_name]; // array
                                                    // find index
                                                    var index = array.indexOf(scei) + 1;
                                                    var nextScei = array[index];
                                                    if(nextScei === undefined) return;
                                                    // find record in repeater with property sceID equal to nextscei
                                                    var item = courseStudentsPageId.findItemRecursive(lv, "sceID", nextScei);
                                                    if(item){
                                                        item.edit = true;
                                                        item.cell.forceActiveFocus();
                                                        courseStudentsPageId.onEditing = true;

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
                                                    var array = courseStudentsPageId.sceIds[eval_name]; // array
                                                    // find index
                                                    var index = array.indexOf(scei) + 1;
                                                    var nextScei = array[index];
                                                    if(nextScei === undefined) return;
                                                    // find record in repeater with property sceID equal to nextscei
                                                    var item = courseStudentsPageId.findItemRecursive(lv, "sceID", nextScei);
                                                    if(item){
                                                        item.edit = true;
                                                        item.cell.forceActiveFocus();
                                                        courseStudentsPageId.onEditing = true;

                                                        item = lv.itemAtIndex(rowEvalRep.modelIndex)
                                                        if (item) {
                                                            flk.contentY = item.y - flk.height / 2  + 400; //+ item.height / 2
                                                        }
                                                    }

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
                                                        courseStudentsPageId.onEditing = false
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
                                                    anchors.fill: parent
                                                    onDoubleClicked:{
                                                        if(courseStudentsPageId.onEditing)
                                                        {
                                                            // find 2clicked items and save them before
                                                            var item = courseStudentsPageId.findItemRecursive(lv, "edit", true);
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

                                                                item = courseStudentsPageId.findItemRecursive(lv, "edit", true);
                                                            }

                                                        }

                                                        evalRecDel.edit = true
                                                        courseStudentsPageId.onEditing = true
                                                        te.forceActiveFocus();
                                                        courseStudentsPageId.activeEval = evalRecDel.model["eval_name"];
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

    // set grade of all students in once
    Dialog{
        id: setGradeDialog
        property alias gradeValue : gradeTF.text
        property alias evalCBox: evalCB

        property real maxValue: 0

        closePolicy:Popup.NoAutoClose
        width: (parent.width > 400)? 400 : parent.width
        height: 350
        modal: true
        dim: true
        anchors.centerIn: parent;
        title: "ثبت نمره یکسان به دانش‌آموزان کلاس"

        header: Rectangle{
            width: setGradeDialog.width;
            height: 50;
            color: "teal";
            Text{ text: "ثبت نمره یکسان به دانش‌آموزان کلاس"; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "Kalameh"; font.pixelSize: 16}
        }

        contentItem:Rectangle{
            width: parent.width
            height: 250
            anchors.margins: 20
            color: "transparent"

            ColumnLayout{
                id: baseDialogCLId
                anchors.fill: parent

                Item{Layout.preferredHeight:  10; Layout.preferredWidth: parent.width;}

                Label{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    verticalAlignment: Label.AlignVCenter
                    horizontalAlignment: Label.AlignLeft
                    text: " انتخاب ارزیابی "
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "teal"
                }
                ComboBox{
                    id: evalCB
                    Layout.preferredHeight:  50
                    Layout.fillWidth: true
                    editable: false
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    model: ListModel{id: evalCBoxModel}
                    textRole: "text"
                    valueRole: "value"
                    Component.onCompleted:
                    {
                        var jsondata = dbMan.getEvals(courseStudentsPageId.class_id);
                        // id, eval_name, base_id, period_id, test_flag, final_flag, max_grade
                        evalCBoxModel.clear();
                        for(var obj of jsondata){
                            var text = obj["eval_name"];
                            var id = obj["id"]
                            var max = obj["max_grade"]
                            evalCBoxModel.append({"text": text, "value": id, "max": max});
                        }

                        evalCB.currentIndex = -1
                    }
                    onActivated: setGradeDialog.maxValue = evalCBoxModel.get(evalCB.currentIndex)["max"];
                }

                Label{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    verticalAlignment: Label.AlignVCenter
                    horizontalAlignment: Label.AlignLeft
                    text: " نمره "
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "teal"
                }
                TextField{
                    id: gradeTF
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    verticalAlignment: Label.AlignVCenter
                    horizontalAlignment: Label.AlignLeft
                    placeholderText: "مقدار نمره "
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "teal"
                    validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                        regularExpression: /^-?\d*\.?\d+$/
                    }
                }

                Item{Layout.fillHeight: true; Layout.preferredWidth: parent.width;}
            }
        }

        footer:Item{
            width: parent.width;
            height: 50
            RowLayout
            {
                Button{
                    text: "انصراف"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    onClicked: setGradeDialog.close();
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "mediumvioletred"}
                }
                Button
                {
                    text: "تایید"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    onClicked: {

                        var eval_id = evalCB.currentValue
                        var text = gradeTF.text
                        var grade = parseFloat(text);
                        if(grade <= setGradeDialog.maxValue){

                            if(! dbMan.updateGrade(courseStudentsPageId.class_id, courseStudentsPageId.course_id, eval_id, grade)){
                                infoDialogId.dialogText = "انجام عملیات با خطا مواجه شد."
                                infoDialogId.dialogTitle = "خطا"
                                infoDialogId.dialogSuccess = false
                                infoDialogId.open();
                            }
                            else
                            {
                                lvModel.clear();
                                // register_id, r.student_id, r.class_id, s.student, s.fathername, s.photo, evals[]
                                var jsonarray = dbMan.getCourseStudents_evals(courseStudentsPageId.class_id, courseStudentsPageId.course_id);
                                for(var obj of jsonarray)
                                {
                                    lvModel.append(obj);
                                }

                                setGradeDialog.close();
                            }
                        }
                        else
                        {
                            infoDialogId.dialogText = "نمره وارد شده در محدوده نمره مجاز قرار ندارد."
                            infoDialogId.dialogTitle = "خطا"
                            infoDialogId.dialogSuccess = false
                            infoDialogId.open();
                        }
                    }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "teal"}
                }
                Item{Layout.fillWidth: true}
            }
        }

    }

    // eval Selection
    DialogBox.EvalDialog
    {
        id: evalSelectionDialog
        model : courseStudentsPageId.class_evals
        onEvalSelected: (eval_id)=>{
                            saveFileDialog.eval_id = eval_id;
                            saveFileDialog.open();
                            evalSelectionDialog.close();
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
            if(dbMan.generateCourseStudentsGradeXlsx(selectedFile, courseStudentsPageId.class_id, courseStudentsPageId.course_id, saveFileDialog.eval_id))
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
            if(dbMan.updateCourseStudentsGradeByXlsx(selectedFile, courseStudentsPageId.class_id, courseStudentsPageId.course_id))
            {
                successDialogId.width = 300
                successDialogId.dialogText = "نمرات دانش‌آموزان با موفقیت بروز گردید."
                successDialogId.open();

                lvModel.clear();
                var jsonarray = dbMan.getCourseStudents_evals(courseStudentsPageId.class_id, courseStudentsPageId.course_id);
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
