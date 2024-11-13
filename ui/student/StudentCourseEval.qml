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
    // r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id,
    // s.branch_id, br.city, br.branch_name, s.name, s.lastname, s.fathername, s.gender, s.enabled
    // st.step_name, sb.study_base, sp.study_period, sp.passed

    required property var studentCourseModel;
    // 0sc.id, sc.student_id, sc.course_id
    // 3co.course_name, co.course_coefficient, co.test_coefficient, co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id
    // 9t.name, t.lastname, cl.class_name

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
                                source: (studentCourseEvalPage.isFemale)? "qrc:/assets/images/female.png" : "qrc:/assets/images/user.png"
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
                             text: studentCourseEvalPage.studentCourseModel.Teacher + "  ( کلاس " + studentCourseEvalPage.studentCourseModel.Class_name + ") "
                             height: 50
                             width: parent.width
                             verticalAlignment: Text.AlignVCenter
                             horizontalAlignment: Text.AlignHCenter
                             font.family: "B Yekan"
                             font.pixelSize: 16
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
                        implicitHeight: 400
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
            //se.id, se.student_id, se.eval_id, se.student_grade, se.normalised_grade, e.eval_name, e.eval_time, e.course_id, e.max_value

            color:{
                if(recDelt.model.Student_grade == -1)
                    return "khaki";

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
                    text: recDelt.model.Eval_name
                    elide: Text.ElideLeft
                }
                // final
                Image
                {
                    source: "qrc:/assets/images/certified48.png"
                    width: 48
                    height: 48
                    anchors.top: parent.top
                    anchors.left : parent.left

                    visible: (recDelt.model.Final_eval)? true : false;
                }
                // not report included
                Image
                {
                    source: "qrc:/assets/images/stop48.png"
                    width: 48
                    height: 48
                    anchors.top: parent.top
                    anchors.left : parent.left
                    visible: (recDelt.model.Report_included)? false : true;
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
                    text: (recDelt.model.Percentage)? "بیشترین نمره: " + recDelt.model.Max_value +"%" : "بیشترین نمره: " +recDelt.model.Max_value;
                    elide: Text.ElideLeft
                }
            }

            Rectangle
            {
                id: studentGradeRect
                width: parent.width
                height: 50
                color: "transparent"
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
                color: "transparent"
                visible: (recDelt.model.Normalised_grade > -1)? true : false
                anchors.top : studentGradeRect.bottom
                Text
                {
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



            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onEntered:{
                    evalNameRect.color= "mediumvioletred"
                    studentGradeText.color = "mediumvioletred"
                }
                onExited: {
                    evalNameRect.color=  "slategray"
                    studentGradeText.color = "slategray"
                }

                onDoubleClicked:
                {
                    var eval_name = recDelt.model.Eval_name;
                    var student_grade = recDelt.model.Student_grade
                    var student = studentCourseEvalPage.student["name"] + " " + studentCourseEvalPage.student["lastname"];
                    var course = studentCourseEvalPage.studentCourseModel.Course_name

                    setStudentgradeDialog.studentVar = student
                    setStudentgradeDialog.evalnameVar = eval_name
                    setStudentgradeDialog.gradeVar = student_grade
                    setStudentgradeDialog.courseVar = course
                    setStudentgradeDialog.studentEvalId = recDelt.model.Id

                    setStudentgradeDialog.open();
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
        id: setStudentgradeDialog
        property string studentVar;
        property string evalnameVar;
        property int gradeVar;
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
                text: setStudentgradeDialog.studentVar
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
                text: setStudentgradeDialog.courseVar + " (" + setStudentgradeDialog.evalnameVar + ")"
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
                    text: (setStudentgradeDialog.gradeVar > -1)? setStudentgradeDialog.gradeVar : "";
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
                    onClicked: setStudentgradeDialog.close();
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
                        if(gradeTF.text == "")
                        grade = -1;

                        // set grade
                        if(dbMan.setStudentCourseEvalGrade(setStudentgradeDialog.studentEvalId, grade))
                        {
                            setStudentgradeDialog.close();
                            infoDialogId.dialogSuccess = true;
                            infoDialogId.dialogTitle = "عملیات موفق";
                            infoDialogId.dialogText = "نمره دانش‌آموز با موفقیت ثبت شد.";
                            infoDialogId.open();
                            Methods.updateCourseEvalModel(studentCourseEvalPage.student.id, studentCourseEvalPage.studentCourseModel.Course_id);

                            studentCourseEvalPage.studentCourseMean = dbMan.getStudentCourseMean(studentCourseEvalPage.student.id, studentCourseEvalPage.studentCourseModel.Course_id);
                            studentCourseEvalPage.studentCourseNormalisedMean = dbMan.getStudentCourseNormalisedMean(studentCourseEvalPage.student.id, studentCourseEvalPage.studentCourseModel.Course_id);

                        }
                        else
                        {
                            setStudentgradeDialog.close();
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
                    width: parent.width
                    height: 120
                    color: "ghostwhite"
                    Column
                    {
                        width: parent.width
                        height: 120
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " میانگین مستمر: "
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "steelblue"
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " با اعمال نمودار: " + studentCourseStatDrawer.studentCourseNormStat["continous"];
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
                            text: " بدون اعمال نمودار: " + studentCourseStatDrawer.studentCourseStat["continous"];
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
                    width: parent.width
                    height: 120
                    color: "ghostwhite"
                    Column
                    {
                        width: parent.width
                        height: 120
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " میانگین نهایی: "
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "steelblue"
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " با اعمال نمودار: " + studentCourseStatDrawer.studentCourseNormStat["final"];
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
                            text: " بدون اعمال نمودار: " + studentCourseStatDrawer.studentCourseStat["final"];
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
                    width: parent.width
                    height: 120
                    color: "ghostwhite"
                    Column
                    {
                        width: parent.width
                        height: 120
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " میانگین نیمسال: "
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "steelblue"
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " با اعمال نمودار: " + studentCourseStatDrawer.studentCourseNormStat["semester"];
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
                            text: " بدون اعمال نمودار: " + studentCourseStatDrawer.studentCourseStat["semester"];
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
                }


                // test
                // mostamar
                Rectangle
                {
                    width: parent.width
                    height: 120
                    color: "ghostwhite"
                    Column
                    {
                        width: parent.width
                        height: 120
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " میانگین تست: "
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "steelblue"
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " با اعمال نمودار: " + studentCourseStatDrawer.studentTestNormStat["continous"];
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
                            text: " بدون اعمال نمودار: " + studentCourseStatDrawer.studentTestStat["continous"];
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
                    width: parent.width
                    height: 120
                    color: "ghostwhite"
                    Column
                    {
                        width: parent.width
                        height: 120
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " میانگین تست نهایی: "
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "steelblue"
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " با اعمال نمودار: " + studentCourseStatDrawer.studentTestNormStat["final"];
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
                            text: " بدون اعمال نمودار: " + studentCourseStatDrawer.studentTestStat["final"];
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
                    width: parent.width
                    height: 120
                    color: "ghostwhite"
                    Column
                    {
                        width: parent.width
                        height: 120
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " میانگین تست نیمسال: "
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "steelblue"
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            width: parent.width
                            height: 40
                            text: " با اعمال نمودار: " + studentCourseStatDrawer.studentTestNormStat["semester"];
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
                            text: " بدون اعمال نمودار: " + studentCourseStatDrawer.studentTestStat["semester"];
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
