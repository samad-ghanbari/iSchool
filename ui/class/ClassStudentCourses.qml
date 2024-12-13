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
            textFormat: Text.RichText
            text: "دروس دانش‌آموز" + " " + "<font color='darkmagenta'>"+ classStudentCoursesPage.student.Student + " ( " + classStudentCoursesPage.student.Fathername + " ) </font> "
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

                ColumnLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20

                    //student info
                    Rectangle
                    {
                        Layout.fillWidth: true
                        implicitHeight: 150
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
                        Layout.fillWidth: true
                        Layout.preferredHeight: 4
                        color: "skyblue"
                        Layout.topMargin: 10
                        Layout.bottomMargin: 10
                    }

                    Item
                    {
                        Layout.preferredHeight: 64
                        Layout.fillWidth: true

                        // refresh
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
                        // student stat
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
                                studentStatDrawer.student = classStudentCoursesPage.student.Student + " ( " + classStudentCoursesPage.student.Fathername + " ) "
                                studentStatDrawer.photo = classStudentCoursesPage.student.Photo;
                                studentStatDrawer.register_id = classStudentCoursesPage.registerModel.id
                                studentStatDrawer.baseClass = classStudentCoursesPage.registerModel.study_base + "  -  " + "کلاس " +  classStudentCoursesPage.registerModel.class_name
                                studentStatDrawer.statCalculate();
                                studentStatDrawer.open();
                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }

                    GridView
                    {
                        id: studentCourseGV
                        Layout.fillHeight: true
                        Layout.preferredHeight: studentCourseGV.contentHeight + 100
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
                    color:{
                        if(recDelt.model.Study_base_id > -1)
                        {
                            if(recDelt.highlighted)
                                return "mediumvioletred";
                            else
                                return "lightgray";
                        }
                        else
                        {
                            if(recDelt.highlighted)
                                return "goldenrod";
                            else
                                return "lightgray";
                        }
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
                color:{
                    if(recDelt.model.Study_base_id > -1)
                    {
                        if(recDelt.highlighted)
                            return "mediumvioletred";
                        else
                            return "lightgray";
                    }
                    else
                    {
                        if(recDelt.highlighted)
                            return "goldenrod";
                        else
                            return "lightgray";
                    }
                }
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

    // drawer - student stat
    Drawer
    {
        id: studentStatDrawer
        modal: true
        height: parent.height
        width:  parent.width;
        dragMargin: 0
        edge: Qt.RightEdge

        property int register_id;
        property string student;
        property string photo;
        property string baseClass;

        function statCalculate()
        {
            var stat = dbMan.getStudentStat(studentStatDrawer.register_id);
        }

        ScrollView
        {
            id: studentStatDrawerSV
            width: parent.width
            height: parent.height
            anchors.margins: 5

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            Button
            {
                height: 48
                width: 48
                background: Item{}
                icon.source: "qrc:/assets/images/arrow-right.png"
                icon.width: 48
                icon.height: 48
                opacity: 0.5
                onClicked: studentStatDrawer.close();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                anchors.left: parent.left
            }

            Column
            {
                width: studentStatDrawerSV.width
                spacing: 20

                Item{
                    width: parent.width
                    height: 150
                    Image{
                        width: 128
                        height: 128
                        anchors.centerIn: parent
                        source: {
                            if(studentStatDrawer.photo == "")
                            {
                                return "qrc:/assets/images/stat.png";
                            }
                            else
                            {
                                return "file://"+studentStatDrawer.photo;
                            }
                        }
                    }
                }
                Text{
                    width: parent.width;
                    height: 50
                    text: studentStatDrawer.student
                    font.bold: true
                    font.family: "B Yekan"
                    font.pixelSize: 20
                    color: "royalblue"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                Text{
                    width: parent.width;
                    height: 50
                    text: studentStatDrawer.baseClass
                    font.bold: true
                    font.family: "B Yekan"
                    font.pixelSize: 20
                    color: "royalblue"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Rectangle{
                    width: parent.width
                    height: 2
                    color: "dodgerblue"
                    anchors.margins: 10
                }

                Text{
                    id: emptyStudentStatText
                    width: parent.width;
                    height: 50
                    text: "نمرات دانش‌آموز به صورت کامل وارد نشده است."
                    font.bold: true
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "dodgerblue"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Column{
                    width: parent.width;
                    visible: ! emptyStudentStatText.visible

                    Text{
                        width: parent.width;
                        height: 50
                        text: "---"
                        font.bold: true
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        color: "dodgerblue"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    Text{
                        width: parent.width;
                        height: 50
                        text: " -- "
                        font.bold: true
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        color: "dodgerblue"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    Repeater
                    {
                        id: studentStatRepeater
                        width: parent.width
                        height: studentStatRepeater.model.count*200

                        model: ListModel{id: studentStatModel;}
                        delegate:Column{
                            required property var model;

                            width: parent.width;
                            height: 200;

                            Label{
                                text: "----"
                                width: parent.width
                                height: 50;
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                                font.bold: true
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                color: "slategray"
                                MouseArea {
                                    anchors.fill: parent;
                                    hoverEnabled: true;
                                    onEntered: parent.color = "mediumvioletred"
                                    onExited: parent.color = "slategray"
                                }
                            }
                            Item{width: parent.width; height: 20;}
                        }

                    }

                    Item{height: 20; width: 5;}
                }
            }


        }
    }

}
