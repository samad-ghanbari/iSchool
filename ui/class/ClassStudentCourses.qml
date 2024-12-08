pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Class.js" as Methods

Page {
    id: classStudentCoursesPage

    required property StackView appStackView;
    required property var student;
    // Register_id, Student_id , Student, Fathername, Gender, Birthday, Photo
    required property var registerModel;
    // 0r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id, r.class_id,  s.branch_id
    // 6br.city, br.branch_name, st.step_name, sb.study_base, sp.study_period, sp.passed, cl.class_name

    property bool isFemale : (classStudentCoursesPage.student.gender === "خانم")? true : false;

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
            onClicked: classStudentCoursesPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "دروس دانش‌آموز"
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
                        implicitHeight: 250
                        RowLayout
                        {
                            anchors.fill: parent
                            spacing: 10
                            Image
                            {
                                Layout.preferredWidth: 128
                                Layout.preferredHeight: 128
                                Layout.alignment: Qt.AlignLeft
                                source:{
                                    if(classStudentCoursesPage.student.Photo == "")
                                    {
                                        if(classStudentCoursesPage.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                                    }
                                    else
                                    {
                                        return "file://"+classStudentCoursesPage.student.Photo;
                                    }
                                }
                            }
                            Column{
                                Layout.fillWidth: true
                                Text {
                                    text: classStudentCoursesPage.student.Student
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
                                    text: "نام پدر" + " : " + classStudentCoursesPage.student.Fathername
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
                                    text: "شعبه " + " : " + classStudentCoursesPage.registerModel.city + " - " + classStudentCoursesPage.registerModel.branch_name + " - " + classStudentCoursesPage.registerModel.step_name + " - " + classStudentCoursesPage.registerModel.study_base
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                // class
                                Text {
                                    text: "کلاس " + " : " + classStudentCoursesPage.registerModel.class_name
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
                                    text: "سال تحصیلی " + " : " + classStudentCoursesPage.registerModel.study_period
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
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
                                var register_id = classStudentCoursesPage.registerModel.id
                                //update database
                                if(dbMan.updateStudentBaseCourses(register_id))
                                {
                                    // update model
                                    Methods.updateClassStudentCourses(register_id);
                                    infoDialogId.dialogSuccess = true;
                                    infoDialogId.dialogTitle = "عملیات موفق";
                                    infoDialogId.dialogText = "بروزرسانی دروس پایه دانش‌آموز با موفقیت انجام شد.";
                                    infoDialogId.open();
                                }
                                else
                                    infoDialogId.open();
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
                        cellHeight: 200
                        model: ListModel{id: cscModel}
                        highlight: Item{}
                        delegate: gvDelegate
                        Component.onCompleted: Methods.updateClassStudentCourses(classStudentCoursesPage.registerModel.id);

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
        // 0sc.Id, 1sc.Student_id, 2sc.Register_id, 3sc.Course_id, 4sc.Teacher_id,
        // 5co.Course_name, 6.Study_base_id, 7.Course_coefficient, 8.Test_coefficient, 9.Shared_coefficient, 10.Final_weight,
        // 11.Teacher

        SwipeDelegate
        {
            id: recDelt
            required property var model;
            height: 180
            width: 300
            checkable: true
            checked: recDelt.swipe.complete
            onCheckedChanged: { if(!recDelt.checked) recDelt.swipe.close();}
            clip: true
            //swipe.enabled : !recDelt.model.Passed

            background: Rectangle{color: (recDelt.highlighted)? "snow" : "whitesmoke";}

            padding: 0
            contentItem: Rectangle
            {
                color: (recDelt.highlighted)? "snow" : "whitesmoke";


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
                        color: "dodgerblue"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }

                }

                // bottom bar
                Rectangle{
                    height: 5;
                    width: recDelt.width;
                    anchors.bottom: parent.bottom;
                    anchors.margins: 0
                    color: (recDelt.model.Study_base_id > -1)? "mediumvioletred" : "goldenrod";
                }
            }

            onClicked: {recDelt.swipe.close();}
            onPressed: { studentCourseGV.currentIndex = model.index; studentCourseGV.closeSwipeHandler();}
            highlighted: (model.index === studentCourseGV.currentIndex)? true: false;

            swipe.right:
            Rectangle{
                width: 75
                height: 200
                color: (recDelt.model.Study_base_id > -1)? "mediumvioletred" : "goldenrod";
                anchors.left: parent.left

                Column{
                    anchors.fill: parent

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
                            classStudentCoursesPage.appStackView.push(classSCEvalComponent, {
                                                                     studentCourseModel: recDelt.model
                                                                 });
                        }
                    }
                }
            }
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
        id: classSCEvalComponent
        ClassSCEval
        {
            onPopStackViewSignal: classStudentCoursesPage.appStackView.pop();

            student: classStudentCoursesPage.student
            registerModel: classStudentCoursesPage.registerModel
        }
    }

}
