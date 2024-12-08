pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Class.js" as Methods


Page {
    id: classSCEPage // class student course evals

    required property var student;
    // Register_id, Student_id , Student, Fathername, Gender, Birthday, Photo
    required property var registerModel;
    // 0r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id, r.class_id,  s.branch_id
    // 6br.city, br.branch_name, st.step_name, sb.study_base, sp.study_period, sp.passed, cl.class_name
    required property var studentCourseModel;
    // 0sc.Id, 1sc.Student_id, 2sc.Register_id, 3sc.Course_id, 4sc.Teacher_id,
    // 5co.Course_name, 6.Study_base_id, 7.Course_coefficient, 8.Test_coefficient, 9.Shared_coefficient, 10.Final_weight,
    // 11.Teacher

    signal popStackViewSignal();

    property bool isFemale : (classSCEPage.student.gender === "خانم")? true : false;

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
            opacity: 0.5
            onClicked: classSCEPage.popStackViewSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ارزیابی واحد درسی " + classSCEPage.student.Student
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
                width: parent.width
                implicitHeight : centerBox.implicitHeight + 40
                anchors.horizontalCenter : parent.horizontalCenter
                color: "ghostwhite"

                GridLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20
                    columns: 2

                    Rectangle
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        implicitHeight: 400
                        RowLayout
                        {
                            anchors.fill: parent
                            spacing: 10
                            Image
                            {
                                Layout.preferredWidth: 200
                                Layout.preferredHeight: 200
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                source:{
                                    if(classSCEPage.student.Photo == "")
                                    {
                                        if(classSCEPage.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                                    }
                                    else
                                    {
                                        return "file://"+classSCEPage.student.Photo;
                                    }
                                }
                            }
                            Column{
                                Layout.fillWidth: true
                                Text {
                                    text: classSCEPage.student.Student
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "darkmagenta"
                                    elide: Text.ElideLeft
                                }

                                Text {
                                    text: "نام پدر" + " : " + classSCEPage.student.Fathername
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                    elide: Text.ElideLeft
                                }

                                // branch step
                                Text {
                                    text: "شعبه " + " : " + classSCEPage.registerModel.city + " - " + classSCEPage.registerModel.branch_name + " - " + classSCEPage.registerModel.step_name + " - " + classSCEPage.registerModel.study_base
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                    elide: Text.ElideLeft
                                }

                                Text {
                                    text: "سال تحصیلی " + " : " + classSCEPage.registerModel.study_period
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                    elide: Text.ElideLeft
                                }

                                // class
                                Text {
                                    text: "کلاس " + " : " + classSCEPage.registerModel.class_name
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                    elide: Text.ElideLeft
                                }

                                // course
                                Text {
                                    text: "درس:‌ " + classSCEPage.studentCourseModel.Course_name + " ( " + classSCEPage.studentCourseModel.Teacher + " ) "
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "darkmagenta"
                                    elide: Text.ElideLeft
                                }

                                // coefficient
                                Text {
                                    text:  "ضریب درس: " + classSCEPage.studentCourseModel.Course_coefficient + "     " + "ضریب تست: " + classSCEPage.studentCourseModel.Test_coefficient
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                    elide: Text.ElideLeft
                                }
                            }
                        }
                    }

                    //refresh
                    Item
                    {
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 64
                        Layout.fillWidth: true

                        Button
                        {
                            id: refreshBtn
                            Layout.preferredWidth: 64
                            Layout.preferredHeight: 64
                            Layout.alignment: Qt.AlignRight
                            background: Item{}
                            icon.source: "qrc:/assets/images/refresh.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked:
                            {
                                var student_id = classSCEPage.student.Student_id
                                var course_id = classSCEPage.studentCourseModel.Course_id;
                                if(dbMan.updateStudentCourseEvals(student_id, course_id))
                                {
                                    infoDialogId.dialogSuccess = true;
                                    infoDialogId.dialogTitle = "عملیات موفق";
                                    infoDialogId.dialogText = "بروزرسانی ارزیابی‌ها با موفقیت انجام شد.";
                                    infoDialogId.open();
                                    Methods.updateClassSCEvalModel(student_id, course_id);
                                }
                                else
                                {
                                    infoDialogId.open();
                                }
                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }

                        Button
                        {

                            width: 64
                            height: 64
                            anchors.right: refreshBtn.left
                            background: Item{}
                            icon.source: "qrc:/assets/images/stat.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked:
                            {
                                classSCEStat.student_id = classSCEPage.student.Student_id;
                                classSCEStat.course_id = classSCEPage.studentCourseModel.Course_id;
                                classSCEStat.student = classSCEPage.student.Student
                                classSCEStat.baseClass = classSCEPage.registerModel.study_base + "   " + "کلاس " + classSCEPage.registerModel.class_name
                                classSCEStat.statObject = {}
                                classSCEStat.statCalculate();
                                classSCEStat.open();
                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }


                    ListView
                    {
                        id: courseEvalLV
                        Layout.columnSpan: 2
                        Layout.fillHeight: true
                        implicitHeight: 700
                        Layout.fillWidth: true
                        Layout.margins: 10
                        clip: true
                        model: ListModel{id: classSCEModel;}

                        delegate:Column{
                            id: recdel
                            required property var model;
                            height: courseEvalGV.height + 80
                            width: ListView.view.width
                            spacing: 20
                            Label{
                                width: parent.width;
                                height: 80
                                text: recdel.model.category + " ( " + classSCEPage.studentCourseModel.Course_name + " ) "
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                                font.bold: true
                                font.family: "B Yekan"
                                font.pixelSize: 20
                                color: "white"
                                background:Rectangle{color: "navy"}

                            }

                            GridView
                            {
                                id: courseEvalGV
                                height: (courseEvalGV.model.count ) * 400
                                width: parent.width

                                flickableDirection: Flickable.AutoFlickDirection
                                clip: true
                                cellWidth: 310
                                cellHeight:310
                                model: recdel.model.evals
                                highlight: Item{}
                                delegate: gvDelegate
                            }
                        }

                        Component.onCompleted: Methods.updateClassSCEvalModel(classSCEPage.student.Student_id, classSCEPage.studentCourseModel.Course_id);
                    }


                }
            }
        }
    }

    //delegate
    Component
    {
        id: gvDelegate
        Rectangle
        {
            id: recDelt
            width: 300
            height: 300
            required property var model;
            //se.id, se.Student_id, se.Eval_id, se.Student_grade, se.Normalised_grade, e.Eval_cat_id, e.Course_id, e.Class_id, e.Eval_time, e.Max_grade, e.Included,
            //ec.Eval_cat, ec.Test_flag, ec.Final_flag

            color:{
                if(recDelt.model.student_grade == -1)
                return "lavenderblush";

                if(recDelt.model.index % 2 == 0)
                return "whitesmoke"
                else
                return "snow";
            }

            Rectangle
            {
                id: evalNameRect
                width: parent.width
                height: 50
                color: "slategray"
                anchors.top : recDelt.top
                Text
                {
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    text: recDelt.model.eval_cat
                    elide: Text.ElideLeft
                }

            }

            Rectangle
            {
                id: evalTimeRect
                width: parent.width
                height: 50
                color: "transparent"
                anchors.top : evalNameRect.bottom
                Text
                {
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "slategray"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    text: recDelt.model.eval_time
                    elide: Text.ElideLeft
                }
            }

            Rectangle
            {
                id: maxGradeRect
                width: parent.width
                height: 50
                color: "transparent"
                anchors.top : evalTimeRect.bottom
                Text
                {

                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "slategray"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    text: (recDelt.model.test_flag)? "بیشترین نمره: " + recDelt.model.max_grade +" % " : "بیشترین نمره: " +recDelt.model.max_grade;
                    elide: Text.ElideLeft
                }
            }

            Rectangle
            {
                id: studentGradeRect
                width: parent.width
                height: 50
                color: "mintcream"
                anchors.top : maxGradeRect.bottom
                visible: (recDelt.model.student_grade > -1)? true : false
                Text
                {
                    id: studentGradeText
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "slategray"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    text: (recDelt.model.test_flag)? "نمره دریافتی: " + recDelt.model.student_grade + " % " :  "نمره دریافتی: " + recDelt.model.student_grade;
                    elide: Text.ElideLeft
                }
            }

            Rectangle
            {
                id: normGradeRect
                width: parent.width
                height: 50
                color: "honeydew"
                visible: (recDelt.model.normalised_grade > -1)? true : false
                anchors.top : studentGradeRect.bottom
                Text
                {
                    id: studentNormGradeText
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "slategray"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    text: "نمره با اعمال نمودار: " + recDelt.model.normalised_grade
                    elide: Text.ElideLeft
                }
            }


            Row{
                width: parent.width;
                height: 32
                anchors.bottom: parent.bottom
                // final
                Image
                {
                    source: "qrc:/assets/images/certified32.png"
                    width: 32
                    height: 32
                    visible: (recDelt.model.final_flag)? true : false;
                }
                // not report included
                Image
                {
                    source: "qrc:/assets/images/stop32.png"
                    width: 32
                    height: 32
                    visible: (recDelt.model.included)? false : true;
                }
                //test
                Image
                {
                    source: "qrc:/assets/images/check32.png"
                    width: 32
                    height: 32
                    visible: (recDelt.model.test_flag)? true : false;
                }

            }

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onEntered:{
                    evalNameRect.color= "mediumvioletred"
                    studentGradeText.color = "mediumvioletred"
                    studentNormGradeText.color = "mediumvioletred"
                }
                onExited: {
                    evalNameRect.color=  "slategray"
                    studentGradeText.color = "slategray"
                    studentNormGradeText.color = "slategray"
                }

                onDoubleClicked:
                {


                    var eval_cat = recDelt.model.eval_cat;
                    var eval_time = recDelt.model.eval_time
                    var student_grade = recDelt.model.student_grade
                    var max_grade = recDelt.model.max_grade
                    var student = classSCEPage.student.Student
                    var course = classSCEPage.studentCourseModel.Course_name
                    gradeTF.text = (student_grade > -1)? student_grade : ""

                    setStudentGradeDialog.studentVar = student
                    setStudentGradeDialog.timeVar = eval_time
                    setStudentGradeDialog.evalCatVar = eval_cat
                    setStudentGradeDialog.gradeVar = student_grade
                    setStudentGradeDialog.maxVar = max_grade
                    setStudentGradeDialog.courseVar = course
                    setStudentGradeDialog.studentEvalId = recDelt.model.id

                    setStudentGradeDialog.open();
                }
            }
        }
    }

    //dialog
    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "بروزرسانی ارزیابی‌ها با خطا مواجه شد."
        dialogSuccess: false
    }

    // set student grade
    Dialog
    {
        id: setStudentGradeDialog
        property string studentVar;
        property string timeVar;
        property string evalCatVar;
        property real gradeVar;
        property real maxVar;

        property string courseVar;

        property int studentEvalId;

        closePolicy:Popup.NoAutoClose
        modal: true
        dim: true
        anchors.centerIn: parent;
        width: (parent.width > 500)? 500 : parent.width
        height: 350
        title: ""
        header: Rectangle{
            width: parent.width;
            height: 50;
            color: "mediumvioletred"
            Text{ text: "ثبت نمره دانش‌آموز"; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "B Yekan"; font.pixelSize: 16}
        }

        contentItem:
        Rectangle
        {
            color: "transparent"
            Text
            {
                id: studentInfoText
                width: parent.width
                height: 50
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "darkmagenta"
                font.family: "B Yekan"
                font.pixelSize: 20
                font.bold: true
                text: setStudentGradeDialog.studentVar
                elide: Text.ElideLeft
            }
            Text
            {
                id: courseText
                width: parent.width
                height: 50
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top : studentInfoText.bottom
                color: "slategray"
                font.family: "B Yekan"
                font.pixelSize: 16
                font.bold: true
                text: setStudentGradeDialog.courseVar + " (" + setStudentGradeDialog.evalCatVar + ")"
                elide: Text.ElideLeft
            }
            Text
            {
                id: timeTextId
                width: parent.width
                height: 50
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.top : courseText.bottom
                color: "slategray"
                font.family: "B Yekan"
                font.pixelSize: 14
                font.bold: true
                text: setStudentGradeDialog.timeVar
                elide: Text.ElideLeft
            }

            RowLayout
            {
                width: parent.width
                height: 50
                anchors.top : timeTextId.bottom

                Text
                {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 50
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    color: "black"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    text: "نمره دریافتی"
                    elide: Text.ElideLeft
                }
                TextField
                {
                    id: gradeTF
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    color: "black"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    placeholderText: "بزرگترین مقدار معتبر " + setStudentGradeDialog.maxVar
                    text: (setStudentGradeDialog.gradeVar > -1)? setStudentGradeDialog.gradeVar : "";
                    validator: RegularExpressionValidator{regularExpression: /^-?\d*\.?\d+$/ }
                }
            }
        }

        footer:
        Item{
            width: parent.width;
            height: 50
            RowLayout
            {
                Button{
                    text: "انصراف"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    onClicked: { setStudentGradeDialog.gradeVar = -1; setStudentGradeDialog.close(); }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "red"}
                }
                Button
                {
                    text: "تایید"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    onClicked:
                    {
                        var grade = gradeTF.text
                        grade = parseFloat(grade);
                        if(gradeTF.text == "") grade = -1;

                        if(grade > setStudentGradeDialog.maxVar)
                        {
                            infoDialogId.dialogText = "مقدار وارد شده از سقف نمره ارزیابی بزرگتر است.";
                            infoDialogId.open();
                            return;
                        }

                        // set grade
                        if(dbMan.setStudentEvalGrade(setStudentGradeDialog.studentEvalId, grade))
                        {
                            setStudentGradeDialog.gradeVar = -1;
                            setStudentGradeDialog.close();
                            infoDialogId.dialogSuccess = true;
                            infoDialogId.dialogTitle = "عملیات موفق";
                            infoDialogId.dialogText = "نمره دانش‌آموز با موفقیت ثبت شد.";
                            infoDialogId.open();
                            Methods.updateClassSCEvalModel(classSCEPage.student.Student_id, classSCEPage.studentCourseModel.Course_id);

                        }
                        else
                        {
                            setStudentGradeDialog.gradeVar = -1;
                            setStudentGradeDialog.close();
                            infoDialogId.dialogSuccess = false;
                            infoDialogId.dialogTitle = "خطا";
                            infoDialogId.dialogText = "ثبت نمره دانش‌آموز با خطا مواجه شد.";
                            infoDialogId.open();
                        }

                    }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                }
                Item{Layout.fillWidth: true}
            }
        }

    }

    // stat drawer
    Drawer
    {
        id: classSCEStat
        modal: true
        height: parent.height
        width: (parent.width > 500)? 500 : parent.width;
        dragMargin: 0

        property int student_id;
        property int course_id;
        property string student;
        property string baseClass;

        property var statObject: {}

        function statCalculate()
        {
            //foreach eval-cat calculate mean/normalised
            // statObject = {cat1:{ mean: x, nmean:y} , cat2:{}, cat3:{}, cat4:{} }



            if(Object.keys(classSCEStat.statObject).length > 0)
                emptyStatText.visible = false;
            else
                emptyStatText.visible = true;
        }

        ScrollView
        {
            id: classStudentsSV
            anchors.fill: parent
            anchors.margins: 5

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            Rectangle{
                anchors.fill: parent

                ColumnLayout
                {
                    anchors.fill: parent

                    Image{
                        Layout.preferredWidth: 128
                        Layout.preferredHeight: 128
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.topMargin: 20
                        source: "qrc:/assets/images/stat.png"
                    }

                    Rectangle{
                        Layout.fillWidth: true
                        Layout.preferredHeight: 2
                        color: "dodgerblue"
                        Layout.margins: 10
                    }

                    Text{
                        id: emptyStatText
                        Layout.fillWidth: true;
                        Layout.fillHeight: true;
                        text: "آزمونی برای این درس ثبت نشده است."
                        font.bold: true
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        color: "dodgerblue"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Loader{
                        sourceComponent: drawerStatComponent;
                        visible: !emptyStatText.visible;
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }

                    Item{Layout.fillHeight: true; Layout.preferredWidth: 5;}
                }
            }
        }
    }

    //stat component
    Component{
        id: drawerStatComponent
        Item{
            id: statCmp

            ColumnLayout
            {
                anchors.fill: parent

                Text{
                    Layout.fillWidth: true;
                    Layout.preferredHeight: 50
                    text: classSCEStat.student
                    font.bold: true
                    font.family: "B Yekan"
                    font.pixelSize: 20
                    color: "dodgerblue"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                Text{
                    Layout.fillWidth: true;
                    Layout.preferredHeight: 50
                    text: classSCEStat.baseClass
                    font.bold: true
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    color: "dodgerblue"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }


                Flow
                {
                    spacing: 20
                    Layout.columnSpan: 2
                    flow: Flow.TopToBottom
                    Layout.preferredHeight: statRepeater.count*70

                    Repeater
                    {
                        id: statRepeater
                        model: ListModel {id: statModel }
                        delegate:Item{}
                    }
                    Component.onCompleted:
                    {
                    }
                }



                Item{Layout.fillHeight: true; Layout.preferredWidth: 5;}
            }
        }
    }
}
