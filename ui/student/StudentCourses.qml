pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Student.js" as Methods

Page {
    id: studentCoursesPage

    required property StackView appStackView;
    required property var student;
    required property var model;
    // r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id,
    // s.branch_id, br.city, br.branch_name, s.name, s.lastname, s.fathername, s.gender, s.enabled
    // st.step_name, sb.study_base, sp.study_period, sp.passed

    property bool isFemale : (studentCoursesPage.student.gender === "خانم")? true : false;

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
            onClicked: studentCoursesPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "انتخاب دروس دانش‌آموز"
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
                color: "snow"

                GridLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20
                    columns: 2

                    //student info
                    Rectangle
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        implicitHeight: 200
                        RowLayout
                        {
                            anchors.fill: parent
                            Image
                            {
                                Layout.preferredWidth: 128
                                Layout.preferredHeight: 128
                                Layout.alignment: Qt.AlignLeft
                                source: (studentCoursesPage.isFemale)? "qrc:/assets/images/female.png" : "qrc:/assets/images/user.png"
                            }
                            Column{
                                Layout.fillWidth: true
                                Text {
                                    text: studentCoursesPage.student["name"] + " " + studentCoursesPage.student["lastname"]
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
                                    text: "نام پدر" + " : " + studentCoursesPage.student["fathername"]
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
                                    text: "شعبه " + " : " + studentCoursesPage.model.City + " - " + studentCoursesPage.model.Branch_name + " - " + studentCoursesPage.model.Step_name + " - " + studentCoursesPage.model.Study_base
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
                                    text:  studentCoursesPage.model.Study_period
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

                    Rectangle
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 4
                        color: "skyblue"
                        Layout.topMargin: 10
                        Layout.bottomMargin: 10
                    }

                    Item
                    {
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 64
                        Layout.fillWidth: true

                        Button
                        {

                            width: 64
                            height: 64
                            anchors.left: parent.left
                            background: Item{}
                            icon.source: "qrc:/assets/images/add.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked: studentCoursesPage.appStackView.push(insertStudentCourse)
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                        Button
                        {
                            id: refreshBtn
                            width: 64
                            height: 64
                            anchors.right: parent.right
                            background: Item{}
                            icon.source: "qrc:/assets/images/refresh.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked:
                            {
                                if(Methods.updateBaseCourses(studentCoursesPage.model.Id)) //registerId
                                {
                                    infoDialogId.dialogSuccess = true;
                                    infoDialogId.dialogTitle = "عملیات موفق";
                                    infoDialogId.dialogText = "بروزرسانی دروس پایه دانش‌آموز با موفقیت انجام شد.";
                                    infoDialogId.open();
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
                                studentCourseInfoDrawer.open();
                                studentCourseInfoDrawer.statCalulation();
                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }

                    GridView
                    {
                        id: studentCourseGV
                        Layout.columnSpan: 2
                        Layout.fillHeight: true
                        implicitHeight: 400
                        Layout.fillWidth: true
                        Layout.margins: 10
                        flickableDirection: Flickable.AutoFlickDirection
                        clip: true
                        cellWidth: 320
                        cellHeight: 220
                        model: ListModel{id: scModel}
                        highlight: Item{}
                        delegate: gvDelegate
                        Component.onCompleted: Methods.updateStudentCourses(studentCoursesPage.model.Id);

                        function closeSwipeHandler()
                        {
                            for (var i = 0; i <= studentCourseGV.count; i++)
                            {
                                var item = studentCourseGV.contentItem.children[i];
                                if(item.swipe)
                                {
                                    item.swipe.close();
                                    item.checked = false;
                                }
                            }
                        }

                    }

                }
            }
        }
    }

    // swipe delegate
    Component
    {
        id: gvDelegate
        // 0sc.id, sc.student_id, sc.course_id
        // 3co.course_name, co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id
        // 9t.name, t.lastname, cl.class_name

        SwipeDelegate
        {
            id: recDelt
            required property var model;
            height: 200
            width: 300
            checkable: true
            checked: recDelt.swipe.complete
            onCheckedChanged: { if(!recDelt.checked) recDelt.swipe.close();}
            clip: true
            swipe.enabled : !recDelt.model.Passed

            background: Rectangle{color: (recDelt.highlighted)? "snow" : "whitesmoke";}

            contentItem: Rectangle
            {
                color: (recDelt.highlighted)? "snow" : "whitesmoke";

                Rectangle{
                    height: 5;
                    width: parent.width;
                    anchors.bottom: parent.bottom;
                    color: (recDelt.model.Study_base_id > -1)? "mediumvioletred" : "goldenrod";
                }


                //coefficient
                Rectangle
                {
                    id: cBaseCoefLabel
                    width: 30
                    height: 30
                    anchors.top: parent.top
                    anchors.right: parent.right
                    color: (recDelt.highlighted)? "mediumvioletred" : "gray";
                    Text
                    {
                        anchors.centerIn: parent
                        text: recDelt.model.Course_coefficient
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "white"
                    }
                }
                Rectangle
                {
                    width: 30
                    height: 30
                    anchors.top: cBaseCoefLabel.bottom
                    anchors.right: parent.right
                    color: (recDelt.highlighted)? "darkmagenta" : "gray";
                    Text
                    {
                        anchors.centerIn: parent
                        text:  recDelt.model.Test_coefficient
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                    }
                }

                Column
                {
                    id: recDeltCol
                    anchors.fill: parent

                    spacing: 0
                    Label {
                        text: recDelt.model.Course_name
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDelt.highlighted)? 20 :16
                        font.bold: (recDelt.highlighted)? true : false
                        color: (recDelt.highlighted)? "darkcyan":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: "مدرس " + recDelt.model.Teacher
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: (recDelt.highlighted)? true : false
                        color: (recDelt.model.Passed)? "mediumvioletred":"dodgerblue"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: "کلاس " + recDelt.model.Class_name
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: (recDelt.highlighted)? true : false
                        color: (recDelt.model.Passed)? "mediumvioletred":"dodgerblue"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                }
            }

            onClicked: {recDelt.swipe.close();}
            onPressed: { studentCourseGV.currentIndex = model.index; studentCourseGV.closeSwipeHandler();}
            highlighted: (model.index === studentCourseGV.currentIndex)? true: false;

            swipe.right:
            Rectangle{
                width: 75
                height: 200
                color: "whitesmoke"
                anchors.left: parent.left

                Column{
                    anchors.fill: parent

                    Button
                    {
                        height: 75
                        width: 75
                        background: Rectangle{id:trashBtnBg; color: "crimson"}
                        hoverEnabled: true
                        onHoveredChanged: trashBtnBg.color=(hovered)? Qt.darker("crimson", 1.1):"crimson"
                        text: "حذف"
                        font.bold: true
                        font.family: "B Yekan"
                        font.pixelSize: 14
                        palette.buttonText:  "white"
                        icon.source: "qrc:/assets/images/trash.png"
                        icon.width: 32
                        icon.height: 32
                        display: AbstractButton.TextUnderIcon
                        SwipeDelegate.onClicked:
                        {
                            if(recDelt.swipe.complete)
                            recDelt.swipe.close();
                            // 0sc.id, sc.student_id, sc.course_id
                            // 3co.course_name, co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id
                            // 9t.name, t.lastname, cl.class_name
                            studentCoursesPage.appStackView.push(deleteComponent, {
                                                                     student_course_id: recDelt.model.Id,
                                                                     course_name: recDelt.model.Course_name,
                                                                     class_name: recDelt.model.Class_name,
                                                                     teacher: recDelt.model.Teacher
                                                                 });
                        }
                    }

                    Button
                    {
                        height: 75
                        width: 75
                        background: Rectangle{id:evalBtnBg; color: "dodgerblue"}
                        hoverEnabled: true
                        onHoveredChanged: evalBtnBg.color=(hovered)? Qt.darker("dodgerblue", 1.1):"dodgerblue"
                        text: "ارزیابی"
                        font.bold: true
                        font.family: "B Yekan"
                        font.pixelSize: 14
                        palette.buttonText:  "white"
                        icon.source: "qrc:/assets/images/evaluation.png"
                        icon.width: 32
                        icon.height: 32
                        display: AbstractButton.TextUnderIcon
                        SwipeDelegate.onClicked:
                        {
                            if(recDelt.swipe.complete)
                            recDelt.swipe.close();
                            // 0sc.id, sc.student_id, sc.course_id
                            // 3co.course_name, co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id
                            // 9t.name, t.lastname, cl.class_name
                            studentCoursesPage.appStackView.push(evalComponent, {
                                                                     studentCourseModel: recDelt.model
                                                                 });
                        }
                    }
                }
            }
        }
    }


    // insert student course
    Component
    {
        id: insertStudentCourse
        StudentCourseInsert
        {
            onPopStackViewSignal: studentCoursesPage.appStackView.pop();
            onInsertedSignal: Methods.updateStudentCourses(studentCoursesPage.model.Id);

            student: studentCoursesPage.student
            registerModel: studentCoursesPage.model

        }
    }

    // delete student course
    Component
    {
        id: deleteComponent
        StudentCourseDelete
        {
            onPopStackViewSignal: studentCoursesPage.appStackView.pop();
            onDeletedSignal: Methods.updateStudentCourses(studentCoursesPage.model.Id);

            student: studentCoursesPage.student
            registerModel: studentCoursesPage.model
        }
    }

    //dialog
    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "بروزرسانی دیتابیس با خطا مواجه شد."
        dialogSuccess: false
    }


    //eval
    Component
    {
        id: evalComponent
        StudentCourseEval
        {
            onPopStackViewSignal: studentCoursesPage.appStackView.pop();

            student: studentCoursesPage.student
            registerModel: studentCoursesPage.model
        }
    }


    // info drawer
    Drawer
    {
        id: studentCourseInfoDrawer
        modal: true
        height: parent.height
        width: 400 //(studentCoursesPage.width/2 > 500)? 500 : studentCoursesPage.width/2;

        dragMargin: 0
        property var studentStat : {}

        function statCalulation()
        {
            Methods.updateStudentStatModel(studentCoursesPage.model.Id);
        }

        ScrollView
        {
            id: studentCourseInfoSV
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter;

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            Column
            {
                width: studentCourseInfoSV.width
                spacing: 10
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
                    text: studentCoursesPage.student["name"] + " " + studentCoursesPage.student["lastname"]
                    font.family:"B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    color: "darkmagenta"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                }

                Label
                {
                    width: parent.width
                    height: 20
                    text: "ارزیابی دروس"
                    font.family:"B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                }

                Row
                {
                    width: parent.width
                    height: 40
                    Label
                    {
                        width: parent.width/2
                        height: 40
                        text: "مجموع ضرایب: " + dbMan.getStudentPeriodUnit(studentCoursesPage.model.Id, false);
                        font.family:"B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                        background: Rectangle{color:"darkslategray"}
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                    }
                    Label
                    {
                        width: parent.width/2
                        background: Rectangle{color:"darkslategray"}
                        height: 40
                        text: "مجموع ضرایب تست: " + dbMan.getStudentPeriodUnit(studentCoursesPage.model.Id, true);
                        font.family:"B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                    }
                }

                // course avg stat
                Rectangle
                {
                    width: parent.width
                    height: 120
                    color: "floralwhite"
                    anchors.margins: 0
                    GridLayout
                    {
                        anchors.fill: parent;
                        columns: 3
                        rowSpacing:0
                        columnSpacing: 0

                        //title
                        Label
                        {
                            Layout.columnSpan: 3
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            text: "معدل"
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"lavenderblush"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }

                        //types
                        Label
                        {
                            Layout.preferredWidth: parent.width/3
                            Layout.preferredHeight: 30
                            text: "مستمر"
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"floralwhite"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            Layout.preferredWidth: parent.width/3
                            Layout.preferredHeight: 30
                            text: "پایانی"
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"floralwhite"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            Layout.preferredWidth: parent.width/3
                            Layout.preferredHeight: 30
                            text: "نیمسال"
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"floralwhite"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }

                        //avg
                        Label
                        {
                            Layout.preferredWidth: parent.width/3
                            Layout.preferredHeight: 30
                            text: "1"
                            font.family:"B Yekan"
                            font.pixelSize: 20
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"floralwhite"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            Layout.preferredWidth: parent.width/3
                            Layout.preferredHeight: 30
                            text: "2"
                            font.family:"B Yekan"
                            font.pixelSize: 20
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"floralwhite"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            Layout.preferredWidth: parent.width/3
                            Layout.preferredHeight: 30
                            text: "3"
                            font.family:"B Yekan"
                            font.pixelSize: 20
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"floralwhite"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }


                    }
                }

                // test avg stat
                Rectangle
                {
                    width: parent.width
                    height: 120
                    color: "floralwhite"
                    anchors.margins: 0
                    GridLayout
                    {
                        anchors.fill: parent;
                        columns: 3
                        rowSpacing:0
                        columnSpacing: 0

                        //title
                        Label
                        {
                            Layout.columnSpan: 3
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            text: "تست"
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"lavenderblush"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }

                        //types
                        Label
                        {
                            Layout.preferredWidth: parent.width/3
                            Layout.preferredHeight: 30
                            text: "مستمر"
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"floralwhite"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            Layout.preferredWidth: parent.width/3
                            Layout.preferredHeight: 30
                            text: "پایانی"
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"floralwhite"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            Layout.preferredWidth: parent.width/3
                            Layout.preferredHeight: 30
                            text: "نیمسال"
                            font.family:"B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"floralwhite"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }

                        //avg
                        Label
                        {
                            Layout.preferredWidth: parent.width/3
                            Layout.preferredHeight: 30
                            text: "1"
                            font.family:"B Yekan"
                            font.pixelSize: 20
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"floralwhite"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            Layout.preferredWidth: parent.width/3
                            Layout.preferredHeight: 30
                            text: "2"
                            font.family:"B Yekan"
                            font.pixelSize: 20
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"floralwhite"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label
                        {
                            Layout.preferredWidth: parent.width/3
                            Layout.preferredHeight: 30
                            text: "3"
                            font.family:"B Yekan"
                            font.pixelSize: 20
                            font.bold: true
                            color: "darkslategray"
                            background: Rectangle{color:"floralwhite"}
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }


                    }
                }

                GridView
                {
                    id: studentStatGV
                    width: parent.width
                    implicitHeight: studentCourseInfoDrawer.height
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    cellWidth: 400
                    cellHeight: 270
                    model: ListModel{id: studentStatModel}
                    highlight: Item{}
                    delegate: studentStatDelegate
                }


            }
        }
    }

    Component
    {
        id: studentStatDelegate
        Rectangle
        {
            id: recDelg
            required property var model;
            // obects of
            // Course_name Course_coefficient  Test_coefficient
            // Course_continous Test_continous
            // Course_final Test_final
            // Course_semester test_semester
            width: 400;
            height: 240
            color: "floralwhite"
            GridLayout
            {
                anchors.fill: parent
                columns: 4
                rowSpacing:0
                columnSpacing: 0
                // course coef
                Label
                {
                    // course name
                    Layout.columnSpan: 3
                    Layout.preferredHeight: 60
                    Layout.fillWidth: true
                    background:Rectangle{ color: (recDelg.model.Base_course)? "mediumvioletred" : "goldenrod";}
                    color: "white"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    text: recDelg.model.Course_name
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                }
                Column
                {
                    //coefficient
                    Layout.preferredHeight: 60
                    Layout.preferredWidth: 30
                    Layout.maximumWidth: 30
                    Label
                    {
                        width: 30
                        height: 30
                        background:Rectangle{ color: "mediumvioletred" }
                        color: "white"
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        text: recDelg.model.Course_coefficient
                        font.family: "B Yekan"
                        font.pixelSize: 14
                        font.bold: true
                    }
                    Label
                    {
                        width: 30
                        height: 30
                        background:Rectangle{ color: "darkmagenta" }
                        color: "white"
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        text: recDelg.model.Test_coefficient
                        font.family: "B Yekan"
                        font.pixelSize: 14
                        font.bold: true
                    }
                }

                // title course test
                Item
                {
                    Layout.preferredHeight: 60
                    Layout.preferredWidth: 100
                    Rectangle{color: "snow"; anchors.fill: parent}
                }
                Label
                {
                    // course
                    Layout.preferredHeight: 60
                    Layout.preferredWidth: 150
                    color: "indigo"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    text: "آزمون درس"
                    background:Rectangle{color: "snow"}
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                }
                Label
                {
                    // test
                    Layout.preferredHeight: 60
                    Layout.fillWidth: true
                    Layout.columnSpan: 2
                    color: "indigo"
                    background:Rectangle{color: "snow"}
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    text: "آزمون تست"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                }

                // mostamer course test
                Label
                {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 100
                    Layout.maximumWidth: 100
                    background:Rectangle{color: "snow"}
                    color: "indigo"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    text: "مستمر: "
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                }
                // course
                Label
                {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 150
                    background:Rectangle{color: "snow"}
                    color: "indigo"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    text: (recDelg.model.Course_continous > 0)? recDelg.model.Course_continous : "-"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                }
                //  test
                Label
                {
                    Layout.columnSpan: 2
                    Layout.preferredHeight: 40
                    Layout.fillWidth: true
                    background:Rectangle{color: "snow"}
                    color: "indigo"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    text: (recDelg.model.Test_continous > 0)? recDelg.model.Test_continous + " % " : "-"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                }

                // final course test
                Label
                {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 100
                    Layout.maximumWidth: 100
                    background:Rectangle{color: "snow"}
                    color: "indigo"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    text: "پایانی: "
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                }
                // course
                Label
                {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 150
                    background:Rectangle{color: "snow"}
                    color: "indigo"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    text: (recDelg.model.Course_final > 0)? recDelg.model.Course_final : "-"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                }
                //  test
                Label
                {
                    Layout.columnSpan: 2
                    Layout.preferredHeight: 40
                    Layout.fillWidth: true
                    background:Rectangle{color: "snow"}
                    color: "indigo"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    text: (recDelg.model.Test_final > 0)? recDelg.model.Test_final + " % "  : "-"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                }
                // semester course test
                Label
                {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 100
                    Layout.maximumWidth: 100
                    background:Rectangle{color: "snow"}
                    color: "indigo"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    text: "نیمسال: "
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                }
                // course
                Label
                {
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 150
                    background:Rectangle{color: "snow"}
                    color: "indigo"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    text: (recDelg.model.Course_semester > 0)? recDelg.model.Course_semester : "-"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                }
                //  test
                Label
                {
                    Layout.columnSpan: 2
                    Layout.preferredHeight: 40
                    Layout.fillWidth: true
                    background:Rectangle{color: "snow"}
                    color: "indigo"
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    text: (recDelg.model.Test_semester > 0)? recDelg.model.Test_semester + " % "  : "-"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                }
            }
        }
    }
}
