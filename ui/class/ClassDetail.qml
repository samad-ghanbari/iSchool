pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Class.js" as Methods
import "./../public" as DialogBox


Page {
    id: classDetailPage
    required property int class_id;
    required property int branch_id;
    required property int step_id;
    required property int base_id;
    required property int period_id;
    required property string branch_text
    required property string step_text
    required property string base_text
    required property string period_text
    required property string class_name
    required property string class_desc

    required property StackView appStackView;
    signal classDetailUpdatedSignal();

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    GridLayout
    {
        anchors.fill: parent
        columns:2

        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/arrow-right.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: classDetailPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "جزئیات کلاس"
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

                    Text {
                        Layout.columnSpan: 2
                        text: "شعبه " + classDetailPage.branch_text
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }
                    Text {
                        Layout.columnSpan: 2
                        text: classDetailPage.step_text + " - " + classDetailPage.base_text
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }
                    Text {
                        Layout.columnSpan: 2
                        text:  classDetailPage.period_text
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }

                    //class
                    Text {
                        Layout.columnSpan: 2
                        text: "کلاس " + classDetailPage.class_name + " - " + classDetailPage.class_desc
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }



                    Item
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 64
                        Button
                        {
                            height:   64
                            width: 64
                            anchors.left: parent.left
                            background: Item{}
                            icon.source: "qrc:/assets/images/add.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked: classDetailPage.appStackView.push(classDetailInsertComponent);
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }
                    Item
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 64
                        Button
                        {
                            height:   64
                            width: 64
                            anchors.right: parent.right
                            background: Item{}
                            icon.source: "qrc:/assets/images/refresh.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked:{
                                var courses = dbMan.getClassLeftCourses(classDetailPage.class_id, classDetailPage.step_id, classDetailPage.base_id, classDetailPage.period_id);
                                if(courses.length > 0)
                                {
                                    classCoursesRefreshDrawer.courses = courses;
                                    classCoursesRefreshDrawer.courseTeacher = [];
                                    classCoursesRefreshDrawer.open();
                                }
                                else
                                {
                                    infoDialog.dialogTitle = "بروزرسانی";
                                    infoDialog.dialogText = "اطلاعات کلاس بروز می‌باشد.";
                                    infoDialog.dialogSuccess = true;
                                    infoDialog.open();
                                }
                            }

                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }


                    GridView
                    {
                        id: classDetailGV
                        Layout.fillHeight: true
                        implicitHeight: 500
                        Layout.fillWidth: true
                        Layout.margins: 10
                        Layout.columnSpan: 2
                        flickableDirection: Flickable.AutoFlickDirection
                        clip: true
                        cellWidth: 320
                        cellHeight: 140
                        model: ListModel{id: classDetailModel}
                        highlight: Item{}
                        delegate: classDetailDelegate

                        function closeSwipeHandler()
                        {
                            for (var i = 0; i <= classDetailGV.count; i++)
                            {
                                var item = classDetailGV.contentItem.children[i];
                                if(item.swipe)
                                {
                                    item.swipe.close();
                                    item.checked = false;
                                }
                            }
                        }

                        Component.onCompleted: Methods.updateClassDetailModel(classDetailPage.class_id);

                    }

                }

            }
        }
    }


    // swipe delegate
    Component
    {
        id: classDetailDelegate
        SwipeDelegate
        {
            id: recDelg
            required property var model;

            // id, cd.class_id, cd.course_id, cd.teacher_id, co.course_name, t.teacher
            height: 120
            width: 300
            checkable: true
            checked: recDelg.swipe.complete
            onCheckedChanged: { if(!recDelg.checked) recDelg.swipe.close();}
            clip: true

            background: Rectangle{color: (recDelg.highlighted)? "snow" : "whitesmoke";}

            contentItem: Rectangle
            {
                color: (recDelg.highlighted)? "snow" : "whitesmoke";
                border.color: (recDelg.highlighted)? "mediumvioletred" : "lightgray"

                Column
                {
                    id: recDelgCol
                    anchors.fill: parent
                    Item{ width: parent.width;height: 10;}
                    spacing: 0
                    Label {
                        text:  recDelg.model.Course_name
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDelg.highlighted)? 20 :16
                        font.bold: (recDelg.highlighted)? true : false
                        color: (recDelg.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: recDelg.model.Teacher
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDelg.highlighted)? 20 :16
                        font.bold: (recDelg.highlighted)? true : false
                        color: (recDelg.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Item{ width: parent.width;height: 10;}
                }
            }

            onClicked: {recDelg.swipe.close();}
            onPressed: { classDetailGV.currentIndex = model.index; classDetailGV.closeSwipeHandler();}
            highlighted: (model.index === classDetailGV.currentIndex)? true: false;

            swipe.right: Column{
                width: 60
                height: 120
                anchors.left: parent.left


                Button
                {
                    height: 32
                    width: 32
                    hoverEnabled: true
                    font.bold: true
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    palette.buttonText:  "white"
                    icon.source: "qrc:/assets/images/edit.png"
                    icon.width: 32
                    icon.height: 32
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(recDelg.swipe.complete)
                        recDelg.swipe.close();

                        classDetailPage.appStackView.push(updateClassDetailComponent, {
                                                              class_detail_id: recDelg.model.Id,
                                                              class_id: recDelg.model.Class_id,
                                                              course_id: recDelg.model.Course_id,
                                                              teacher_id: recDelg.model.Teacher_id
                                                          });

                    }
                }

                Button
                {
                    height: 32
                    width: 32
                    hoverEnabled: true
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
                        if(recDelg.swipe.complete)
                        recDelg.swipe.close();

                        classDetailPage.appStackView.push(deleteClassDetailComponent, {
                                                              class_detail_id: recDelg.model.Id,
                                                              class_id: recDelg.model.Class_id,
                                                              course_name: recDelg.model.Course_name,
                                                              teacher: recDelg.model.Teacher,
                                                          });
                    }
                }
            }


        }
    }

    //Insert
    Component
    {
        id: classDetailInsertComponent
        ClassDetailInsert{
            branch_id : classDetailPage.branch_id;
            step_id: classDetailPage.step_id;
            base_id: classDetailPage.base_id;
            period_id: classDetailPage.period_id;
            class_id: classDetailPage.class_id;

            branch_text: classDetailPage.branch_text;
            step_text: classDetailPage.step_text;
            base_text: classDetailPage.base_text;
            period_text: classDetailPage.period_text;
            class_name: classDetailPage.class_name;
            class_desc: classDetailPage.class_desc;

            onPopStackSignal: classDetailPage.appStackView.pop();
            onInsertedSignal: Methods.updateClassDetailModel(classDetailPage.class_id);
        }
    }

    //update
    Component
    {
        id: updateClassDetailComponent
        ClassDetailUpdate{
            branch_id : classDetailPage.branch_id;
            step_id: classDetailPage.step_id;
            base_id: classDetailPage.base_id;
            period_id: classDetailPage.period_id;
            class_id: classDetailPage.class_id;

            branch_text: classDetailPage.branch_text;
            step_text: classDetailPage.step_text;
            base_text: classDetailPage.base_text;
            period_text: classDetailPage.period_text;
            class_name: classDetailPage.class_name;
            class_desc: classDetailPage.class_desc;

            onPopStackSignal: classDetailPage.appStackView.pop();
            onUpdatedSignal: Methods.updateClassDetailModel(classDetailPage.class_id);
        }
    }

    //delete
    Component
    {
        id: deleteClassDetailComponent
        ClassDetailDelete{
            branch_id : classDetailPage.branch_id;
            step_id: classDetailPage.step_id;
            base_id: classDetailPage.base_id;
            period_id: classDetailPage.period_id;
            class_id: classDetailPage.class_id;

            branch_text: classDetailPage.branch_text;
            step_text: classDetailPage.step_text;
            base_text: classDetailPage.base_text;
            period_text: classDetailPage.period_text;
            class_name: classDetailPage.class_name;
            class_desc: classDetailPage.class_desc;

            onPopStackSignal: classDetailPage.appStackView.pop();
            onDeletedSignal: Methods.updateClassDetailModel(classDetailPage.class_id);
        }
    }

    DialogBox.BaseDialog
    {
        id: infoDialog
        dialogTitle: "خطا در بروزرسانی اطلاعات"
        dialogText: "بروزرسانی اطلاعات کلاس با خطا مواجه شد."
        dialogSuccess: false
    }

    Drawer
    {
        id: classCoursesRefreshDrawer
        property var courses; // id, course_name
        property var courseTeacher: []; // course_id teacher_id

        property var teachersModel: Methods.getTeacherModel(classDetailPage.branch_id)
        modal: true
        height: parent.height
        width: 300 //(parent.width > 300)? 300 : parent.width;
        dragMargin: 0

        ScrollView
        {
            id: classCoursesSV
            anchors.fill: parent
            anchors.margins: 5

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ColumnLayout
            {
                width: classCoursesSV.width

                Rectangle
                {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 110
                    color: "lightgray"

                    Image {
                        id: classCourseImage
                        source: "qrc:/assets/images/refresh.png"
                        width: 64
                        height: 64
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        width: parent.width
                        height: 40
                        anchors.top: classCourseImage.bottom
                        horizontalAlignment: Qt.AlignHCenter
                        anchors.topMargin: 10
                        text: "بروزرسانی اطلاعات کلاس"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignHCenter
                        font.bold: true
                        color:"royalblue"
                    }
                }

                Repeater
                {
                    Layout.fillWidth: true
                    model: classCoursesRefreshDrawer.courses
                    delegate:Column
                    {
                        id: teacherDelg
                        required property var model
                        anchors.topMargin: 10
                        anchors.bottomMargin: 10
                        width: parent.width

                        Text {
                            text: "دبیر " + teacherDelg.model["course_name"]
                            width: parent.width
                            height: 50
                            verticalAlignment: Text.AlignVCenter
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        ComboBox
                        {
                            id: teacherCB
                            height:  50
                            width: parent.width
                            editable: false
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            model: classCoursesRefreshDrawer.teachersModel
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted: teacherCB.currentIndex = -1

                            onActivated: {
                                classCoursesRefreshDrawer.courseTeacher.push({course_id: teacherDelg.model["id"] , course_name: teacherDelg.model["course_name"],  teacher_id : teacherCB.currentValue } );
                            }
                        }
                    }

                }

                Item{Layout.fillWidth: true; Layout.preferredHeight: 20;}
                // button
                Button
                {
                    text: "بروزرسانی"
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 100
                    Layout.alignment: Qt.AlignHCenter

                    onClicked: {

                        var _class_id = classDetailPage.class_id;

                        for (var i of classCoursesRefreshDrawer.courseTeacher)
                        {
                            var obj = {}
                            obj["class_id"] = _class_id;
                            obj["course_id"] = i.course_id
                            obj["teacher_id"] = i.teacher_id;

                            if(!dbMan.classDetailInsert(obj))
                            {
                                infoDialog.dialogText = "بروزرسانی درس " + i._course_name + " با خطا مواجه شد."
                                infoDialog.close();
                            }
                        }

                        Methods.updateClassDetailModel(_class_id);
                        classCoursesRefreshDrawer.close();
                    }

                    Rectangle{width: parent.width; height: 4; color:"royalblue"; anchors.bottom: parent.bottom}
                }
            }
        }
    }
}
