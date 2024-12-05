pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Student.js" as Methods


Page {
    id: studentCourseEvalPage

    required property var student;
    required property var registerModel;
    // 0r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id, r.class_id,  s.branch_id
    // 6br.city, br.branch_name, st.step_name, sb.study_base, sp.study_period, sp.passed, cl.class_name

    required property var studentCourseModel;
    // 0sc.id, 1sc.student_id, 2sc.register_id, 3sc.course_id, 4sc.teacher_id,
    // 5co.course_name, 6.study_base_id, 7.course_coefficient, 8.test_coefficient, 9.shared_coefficient, 10.final_weight,
    // 11.teacher

    signal popStackViewSignal();

    property bool isFemale : (studentCourseEvalPage.student.gender === "خانم")? true : false;

    //property real studentCourseMean : dbMan.getStudentCourseMean(studentCourseEvalPage.student.id, studentCourseEvalPage.studentCourseModel.Course_id);
    //property real studentCourseNormalisedMean : dbMan.getStudentCourseNormalisedMean(studentCourseEvalPage.student.id, studentCourseEvalPage.studentCourseModel.Course_id);


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
            onClicked: studentCourseEvalPage.popStackViewSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ارزیابی واحد درسی دانش‌آموز"
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
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        implicitHeight: 200
                        RowLayout
                        {
                            anchors.fill: parent
                            Image
                            {
                                Layout.preferredWidth: 128
                                Layout.preferredHeight: 128
                                Layout.alignment: Qt.AlignLeft
                                source: {
                                    if(studentCourseEvalPage.student.photo == "")
                                    {
                                        if(studentCourseEvalPage.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                                    }
                                    else
                                    {
                                        return "file://"+studentCourseEvalPage.student.photo;
                                    }
                                }
                            }
                            Column{
                                Layout.fillWidth: true
                                Text {
                                    text: studentCourseEvalPage.student["name"] + " " + studentCourseEvalPage.student["lastname"]
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }

                                Text {
                                    text: "نام پدر" + " : " + studentCourseEvalPage.student["fathername"]
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                // branch step
                                Text {
                                    text: "شعبه " + " : " + studentCourseEvalPage.registerModel.City + " - " + studentCourseEvalPage.registerModel.Branch_name + " - " + studentCourseEvalPage.registerModel.Step_name + " - " + studentCourseEvalPage.registerModel.Study_base
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                // base period
                                Text {
                                    text:  studentCourseEvalPage.registerModel.Study_period
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "darkcyan"
                                }
                            }
                        }
                    }

                    // course info
                     Rectangle
                     {
                        Layout.columnSpan: 2
                         Layout.fillWidth: true
                         implicitHeight: 120
                         color: "olivedrab"
                         Layout.topMargin: 10
                         Layout.bottomMargin: 10
                         Text
                         {
                             id: courseNameInfo
                             text: studentCourseEvalPage.studentCourseModel.Course_name
                             height: 50
                             width: parent.width
                             verticalAlignment: Text.AlignVCenter
                             horizontalAlignment: Text.AlignHCenter
                             font.family: "B Yekan"
                             font.pixelSize: 20
                             font.bold: true
                             color: "white"
                         }
                         Text
                         {
                             anchors.top: courseNameInfo.bottom
                             text: studentCourseEvalPage.studentCourseModel.Teacher
                             height: 50
                             width: parent.width
                             verticalAlignment: Text.AlignVCenter
                             horizontalAlignment: Text.AlignHCenter
                             font.family: "B Yekan"
                             font.pixelSize: 18
                             font.bold: true
                             color: "white"
                         }

                         //coefficient
                         Label
                         {
                             id: courseCoefLbl
                             width: 30
                             height: 60
                             anchors.top: parent.top
                             anchors.right: parent.right
                             horizontalAlignment: Label.AlignHCenter
                             verticalAlignment: Label.AlignVCenter
                             font.family: "B Yekan"
                             font.pixelSize: 16
                             font.bold: true
                             text: studentCourseEvalPage.studentCourseModel.Course_coefficient
                             color: "white"
                             background: Rectangle{anchors.fill: parent; color:"mediumvioletred"}
                         }
                         Label
                         {
                             width: 30
                             height: 60
                             anchors.top: courseCoefLbl.bottom
                             anchors.right: parent.right
                             horizontalAlignment: Label.AlignHCenter
                             verticalAlignment: Label.AlignVCenter
                             font.family: "B Yekan"
                             font.pixelSize: 16
                             font.bold: true
                             text: studentCourseEvalPage.studentCourseModel.Test_coefficient
                             color: "white"
                             background: Rectangle{anchors.fill: parent; color:"darkmagenta"}
                         }

                     }

                    //refresh
                    //course
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
                                var student_id = studentCourseEvalPage.student.id
                                var course_id = studentCourseEvalPage.studentCourseModel.Course_id;
                                if(dbMan.updateStudentCourseEvals(student_id, course_id))
                                {
                                    infoDialogId.dialogSuccess = true;
                                    infoDialogId.dialogTitle = "عملیات موفق";
                                    infoDialogId.dialogText = "بروزرسانی ارزیابی‌ها با موفقیت انجام شد.";
                                    infoDialogId.open();
                                    Methods.updateCourseEvalModel(studentCourseEvalPage.student.id, studentCourseEvalPage.studentCourseModel.Course_id);
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
                            icon.source: "qrc:/assets/images/info.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked:
                            {
                                studentCourseStatDrawer.open();
                                studentCourseStatDrawer.statCalulation();
                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }



                    Rectangle
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true;
                        Layout.preferredHeight: 64
                        Layout.margins:0
                        color:"transparent"

                        RowLayout
                        {
                            width: parent.width
                            height: parent.height


                        }
                    }


                    GridView
                    {
                        id: courseEvalGV
                        Layout.columnSpan: 2
                        Layout.fillHeight: true
                        implicitHeight: 700
                        Layout.fillWidth: true
                        Layout.margins: 10
                        flickableDirection: Flickable.AutoFlickDirection
                        clip: true
                        cellWidth: 310
                        cellHeight:310
                        model: ListModel{id: courseEvalModel}
                        highlight: Item{}
                        delegate: gvDelegate
                        Component.onCompleted: Methods.updateCourseEvalModel(studentCourseEvalPage.student.id, studentCourseEvalPage.studentCourseModel.Course_id);
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
            //se.id, se.student_id, se.eval_id, se.student_grade, se.normalised_grade, e.eval_cat_id, e.course_id, e.class_id, e.eval_time, e.max_grade, e.included,
            //ec.eval_cat, ec.test_flag, ec.final_flag

            color:{
                if(recDelt.model.Student_grade == -1)
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
                    text: recDelt.model.Eval_cat
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
                    text: recDelt.model.Eval_time
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
                    text: (recDelt.model.Test_flag)? "بیشترین نمره: " + recDelt.model.Max_grade +"%" : "بیشترین نمره: " +recDelt.model.Max_grade;
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
                visible: (recDelt.model.Student_grade > -1)? true : false
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
                    text: "نمره دریافتی: " + recDelt.model.Student_grade
                    elide: Text.ElideLeft
                }
            }

            Rectangle
            {
                id: normGradeRect
                width: parent.width
                height: 50
                color: "honeydew"
                visible: (recDelt.model.Normalised_grade > -1)? true : false
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
                    text: "نمره با اعمال نمودار: " + recDelt.model.Normalised_grade
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
                    visible: (recDelt.model.Final_flag)? true : false;
                }
                // not report included
                Image
                {
                    source: "qrc:/assets/images/stop32.png"
                    width: 32
                    height: 32
                    visible: (recDelt.model.Included)? false : true;
                }
                //test
                Image
                {
                    source: "qrc:/assets/images/check32.png"
                    width: 32
                    height: 32
                    visible: (recDelt.model.Test_flag)? true : false;
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


                    var eval_cat = recDelt.model.Eval_cat;
                    var eval_time = recDelt.model.Eval_time
                    var student_grade = recDelt.model.Student_grade
                    var max_grade = recDelt.model.Max_grade
                    var student = studentCourseEvalPage.student["name"] + " " + studentCourseEvalPage.student["lastname"];
                    var course = studentCourseEvalPage.studentCourseModel.Course_name
                    gradeTF.text = (student_grade > -1)? student_grade : ""

                    setStudentGradeDialog.studentVar = student
                    setStudentGradeDialog.evalCatVar = eval_cat
                    setStudentGradeDialog.gradeVar = student_grade
                    setStudentGradeDialog.maxVar = max_grade
                    setStudentGradeDialog.courseVar = course
                    setStudentGradeDialog.studentEvalId = recDelt.model.Id

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
        height: 300
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

            RowLayout
            {
                width: parent.width
                height: 50
                anchors.top : courseText.bottom

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
                            Methods.updateCourseEvalModel(studentCourseEvalPage.student.id, studentCourseEvalPage.studentCourseModel.Course_id);

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

    // info drawer
    Drawer
    {
        id: studentCourseStatDrawer
        modal: true
        height: parent.height
        width: 300
        dragMargin: 0

        // given:  student_id & course_id
        // result: {continous: x , final: x , semester: x}
        property var studentCourseStat :     {"continous": "-" , "final":"-", "semester":"-"}
        property var studentCourseNormStat : {"continous": "-" , "final":"-", "semester":"-"}
        property var studentTestStat :       {"continous": "-" , "final":"-", "semester":"-"}
        property var studentTestNormStat :   {"continous": "-" , "final":"-", "semester":"-"}

        function statCalulation()
        {
            var student_id = studentCourseEvalPage.student.id;
            var course_id = studentCourseEvalPage.studentCourseModel.Course_id

            studentCourseStat = dbMan.getStudentCourseStat(student_id, course_id, false);
            studentCourseNormStat = dbMan.getStudentCourseStat(student_id, course_id, true);
            studentTestStat = dbMan.getStudentTestStat(student_id, course_id, false);
            studentTestNormStat = dbMan.getStudentTestStat(student_id, course_id, true);
        }

        ScrollView
        {
            id: studentCourseStatSV
            anchors.fill: parent

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            Column
            {
                width: studentCourseStatSV.width
                spacing: 20
                Image
                {
                    width: 128
                    height: 128
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/assets/images/report.png"

                }

                Label
                {
                    width: parent.width
                    height: 20
                    text: studentCourseEvalPage.student["name"] + " " + studentCourseEvalPage.student["lastname"]
                    font.family:"B Yekan"
                    font.pixelSize: 14
                    font.bold: true
                    color: "darkmagenta"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                }
                Label
                {
                    width: parent.width
                    height: 20
                    text: studentCourseEvalPage.studentCourseModel["Course_name"]
                    font.family:"B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    color: "mediumvioletred"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                }

                Label
                {
                    width: parent.width
                    height: 70
                    background: Rectangle{color: "mediumvioletred"}
                    text: "آمار ارزیابی درس"
                    font.family:"B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "white"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                }

                //course
                // mostamar
                Rectangle
                {
                    id: courseContinousBox
                    property bool normFlag: (studentCourseStatDrawer.studentCourseStat.continous == studentCourseStatDrawer.studentCourseNormStat.continous)? false  : true;
                    width: parent.width
                    height: 120
                    color: "ghostwhite"
                    visible: (studentCourseStatDrawer.studentCourseStat["continous"] > -1)? true : false;
                    Column
                    {
                        width: parent.width
                        height: 120
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " مستمر: "
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "steelblue"
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }

                        Label
                        {
                            visible: (courseContinousBox.normFlag)? true : false
                            width: parent.width
                            height: 40
                            text: " بدون اعمال نمودار: " + studentCourseStatDrawer.studentCourseStat["continous"];
                            font.family:"B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "teal"
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: (courseContinousBox.normFlag)? " با اعمال نمودار: " + studentCourseStatDrawer.studentCourseNormStat["continous"] : studentCourseStatDrawer.studentCourseNormStat["continous"];
                            font.family:"B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "teal"
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                    }
                }

                //final
                Rectangle
                {
                    id: courseFinalBox
                    property bool normFlag: (studentCourseStatDrawer.studentCourseStat.final == studentCourseStatDrawer.studentCourseNormStat.final)? false  : true;
                    width: parent.width
                    height: 120
                    color: "ghostwhite"
                    visible: (studentCourseStatDrawer.studentCourseStat["final"] > -1)? true : false;
                    Column
                    {
                        width: parent.width
                        height: 120
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " پایانی: "
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "steelblue"
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }

                        Label
                        {
                             visible: (courseFinalBox.normFlag)? true : false
                            width: parent.width
                            height: 40
                            text: " بدون اعمال نمودار: " + studentCourseStatDrawer.studentCourseStat["final"];
                            font.family:"B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "teal"
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }

                        Label
                        {
                            width: parent.width
                            height: 40
                            text: (courseFinalBox.normFlag)? " با اعمال نمودار: " + studentCourseStatDrawer.studentCourseNormStat["final"]:studentCourseStatDrawer.studentCourseNormStat["final"];
                            font.family:"B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "teal"
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }

                    }
                }

                //semester
                Rectangle
                {
                    id: courseSemesterBox
                    property bool normFlag: (studentCourseStatDrawer.studentCourseStat.semester == studentCourseStatDrawer.studentCourseNormStat.semester)? false  : true;

                    width: parent.width
                    height: 120
                    color: "ghostwhite"
                    visible: (studentCourseStatDrawer.studentCourseStat["semester"] > -1)? true : false;
                    Column
                    {
                        width: parent.width
                        height: 120
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " نیمسال: "
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "steelblue"
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }

                        Label
                        {
                            visible: (courseSemesterBox.normFlag)? true : false
                            width: parent.width
                            height: 40
                            text: " بدون اعمال نمودار: " + studentCourseStatDrawer.studentCourseStat["semester"];
                            font.family:"B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "teal"
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: (courseSemesterBox.normFlag)? " با اعمال نمودار: " + studentCourseStatDrawer.studentCourseNormStat["semester"] : studentCourseStatDrawer.studentCourseNormStat["semester"];
                            font.family:"B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "teal"
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                    }
                }

                Label
                {
                    width: parent.width
                    height: 70
                    background: Rectangle{color: "mediumvioletred"}
                    text: "آمار ارزیابی تست"
                    font.family:"B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "white"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter

                    visible: ((studentCourseStatDrawer.studentTestStat["continous"] > -1) || (studentCourseStatDrawer.studentTestStat["final"] > -1))? true : false;
                }


                // test
                // mostamar
                Rectangle
                {
                    id: testContinousBox
                    property bool normFlag: (studentCourseStatDrawer.studentTestStat.continous == studentCourseStatDrawer.studentTestNormStat.continous)? false  : true;
                    width: parent.width
                    height: 120
                    color: "ghostwhite"
                    visible: (studentCourseStatDrawer.studentTestStat["continous"] > -1)? true : false;
                    Column
                    {
                        width: parent.width
                        height: 120
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " تست مستمر: "
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "steelblue"
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }

                        Label
                        {
                            visible: (testContinousBox.normFlag)? true : false
                            width: parent.width
                            height: 40
                            text: " بدون اعمال نمودار: " + studentCourseStatDrawer.studentTestStat["continous"] +"%";
                            font.family:"B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "teal"
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: (testContinousBox.normFlag)? " با اعمال نمودار: " + studentCourseStatDrawer.studentTestNormStat["continous"] +"%" : studentCourseStatDrawer.studentTestNormStat["continous"] +"%";
                            font.family:"B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "teal"
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                    }
                }

                //final
                Rectangle
                {
                    id: testFinalBox
                    property bool normFlag: (studentCourseStatDrawer.studentTestStat.final == studentCourseStatDrawer.studentTestNormStat.final)? false  : true;

                    width: parent.width
                    height: 120
                    color: "ghostwhite"
                    visible: (studentCourseStatDrawer.studentTestStat["final"] > -1)? true : false;
                    Column
                    {
                        width: parent.width
                        height: 120
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " تست پایانی: "
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "steelblue"
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }

                        Label
                        {
                             visible: (testFinalBox.normFlag)? true : false
                            width: parent.width
                            height: 40
                            text: " بدون اعمال نمودار: " + studentCourseStatDrawer.studentTestStat["final"] +"%";
                            font.family:"B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "teal"
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: (testFinalBox.normFlag)?  " با اعمال نمودار: " + studentCourseStatDrawer.studentTestNormStat["final"] +"%" : studentCourseStatDrawer.studentTestNormStat["final"] +"%";
                            font.family:"B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "teal"
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                    }
                }

                //semester
                Rectangle
                {
                    id: testSemesterBox
                    property bool normFlag: (studentCourseStatDrawer.studentTestStat.semester == studentCourseStatDrawer.studentTestNormStat.semester)? false  : true;

                    width: parent.width
                    height: 120
                    color: "ghostwhite"
                    visible: (studentCourseStatDrawer.studentTestStat["semester"] > -1)? true : false;
                    Column
                    {
                        width: parent.width
                        height: 120
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " تست نیمسال: "
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "steelblue"
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }

                        Label
                        {
                            visible: (testSemesterBox.normFlag)? true : false
                            width: parent.width
                            height: 40
                            text: " بدون اعمال نمودار: " + studentCourseStatDrawer.studentTestStat["semester"] +"%";
                            font.family:"B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "teal"
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: (testSemesterBox.normFlag)? " با اعمال نمودار: " + studentCourseStatDrawer.studentTestNormStat["semester"] +"%" : studentCourseStatDrawer.studentTestNormStat["semester"] +"%";
                            font.family:"B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "teal"
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                    }
                }

            }
        }
    }
}
