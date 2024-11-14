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
        width: 300
        dragMargin: 0
        property var studentStat : {}
        // courses: {riazi :{ course_coefiicient:2 , mean: 15 , normalised: 18}, ... }
        // average : {course_coefficient: 32, average: 14 , normalised: 18}

        function statCalulation()
        {
        }

        ScrollView
        {
            id: studentCourseInfoSV
            anchors.fill: parent

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ColumnLayout
            {
                width: studentCourseInfoSV.width

            }
        }
    }
}
