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

    ColumnLayout
    {
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

            Button
            {
                height: 50
                width: 50
                anchors.right: parent.right
                background: Item{}
                icon.source: "qrc:/assets/images/refresh.png"
                icon.width: 50
                icon.height: 50
                icon.color:"transparent"
                opacity: 0.5
                onClicked: {
                    if(dbMan.refreshStudentEvals(studentCoursesPageId.class_id, studentCoursesPageId.student_id))
                    {
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
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
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
                opacity: 0.8
                onClicked: {}
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.8;
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
                opacity: 0.8
                onClicked:
                {
                    evalSelectionDialog.fillComboBox();
                    evalSelectionDialog.open();
                }
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.8;
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
                    width: parent.width
                    height: parent.height
                    model: ListModel{id: lvModel;}
                    clip: true
                    delegate:lvDelegate
                    Component.onCompleted: {
                        lvModel.clear();
                        var register_id = dbMan.getRegisterId(studentCoursesPageId.class_id, studentCoursesPageId.student_id);
                        var jsonarray = dbMan.getStudentCourses_evals(register_id);
                        //0sc.id, 1sc.register_id, 2sc.course_id, 3co.course_name, 4co.step_id, 5co.base_id, 6co.period_id,
                        //7co.course_coefficient, 8co.test_coefficient, 9co.shared_coefficient, 10co.final_weight, 11co.shared_weight
                        // evals [{}, {}] : {sce.student_course_eval_id, sce.student_course_id, sce.eval_id, e.eval_name, e.base_id, e.period_id, e.test_flag, e.final_flag,e.max_grade, sce.grade, sce.eval_time, sce.included}
                        for(var obj of jsonarray)
                        {
                            lvModel.append(obj);
                        }
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
            id: recdel;
            height: 110
            width: lv.width

            required property var model;
            color: (recdel.model.index % 2 == 0)? "aliceblue" : "mintcream"
            RowLayout{
                spacing: 10
                anchors.fill: parent
                Rectangle{
                    Layout.preferredWidth: 300
                    Layout.preferredHeight: 100
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
                    Layout.fillWidth: true
                    Layout.preferredHeight: 100
                    color: "transparent"
                    Rectangle{
                        width: parent.width
                        height: 50
                        color: "transparent"
                        anchors.top: parent.top
                        RowLayout{
                            anchors.fill: parent
                            spacing: 20
                            Label{
                                Layout.preferredHeight: 50
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
                                Layout.preferredHeight: 50
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
                                Layout.preferredHeight: 50
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
                                Layout.preferredHeight: 50
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text: "وزن ضریب اشتراکی: " + recdel.model.shared_weight
                                color: "darkslategray"
                                visible: (recdel.model.shared_weight > 0)? true : false
                            }

                            Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
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
                                    Layout.alignment: Qt.AlignLeft
                                    Layout.preferredHeight: 50
                                    Layout.preferredWidth:titlerec.implicitWidth + 120
                                    Layout.margins: 0

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
            if(dbMan.generateStudentCoursesXlsx(selectedFile, studentCoursesPageId.student_id, studentCoursesPageId.class_id, saveFileDialog.eval_id))
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
}
