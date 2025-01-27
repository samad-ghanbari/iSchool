pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Class.js" as Methods
import "./../public" as DialogBox


Page {
    id: classStudentsPage
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
            icon.color:"transparent"
            opacity: 0.5
            onClicked: classStudentsPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "دانش‌آموزان کلاس "
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

                    RowLayout
                    {
                        Image {
                            source: "qrc:/assets/images/classroom.png"
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.preferredHeight:  150
                            Layout.preferredWidth:  150
                            NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                        }
                        Column{
                            Layout.fillWidth: true;
                            Layout.preferredHeight: 150
                            //branch
                            Text {
                                text: "شعبه " + classStudentsPage.branch_text
                                width: parent.width
                                height: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 18
                                font.bold: true
                                color: "royalblue"
                            }
                            // step-base
                            Text {
                                text: classStudentsPage.step_text + " - " + classStudentsPage.base_text
                                width: parent.width
                                height: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 18
                                font.bold: true
                                color: "royalblue"
                            }
                            //period
                            Text {
                                text:  "سال‌تحصیلی " + classStudentsPage.period_text
                                width: parent.width
                                height: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 18
                                font.bold: true
                                color: "royalblue"
                            }
                        }
                    }

                    //class
                    Text {
                        text: "کلاس " + classStudentsPage.class_name + " - " + classStudentsPage.class_desc
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        font.bold: true
                        color: "darkmagenta"
                    }
                    Rectangle{Layout.fillWidth: true; Layout.maximumWidth: 700; color:"darkmagenta"; Layout.preferredHeight:5; Layout.alignment: Qt.AlignHCenter;}

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 64
                        RowLayout{
                            anchors.fill: parent
                            Button
                            {
                                Layout.preferredWidth:   64
                                Layout.preferredHeight: 64
                                Layout.alignment: Qt.AlignRight
                                background: Item{}
                                icon.source: "qrc:/assets/images/stat.png"
                                icon.width: 64
                                icon.height: 64
                                icon.color:"transparent"
                                opacity: 0.5
                                onClicked:{
                                    classStatDrawer.open();
                                }

                                hoverEnabled: true
                                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                            }
                            Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                            Button
                            {
                                Layout.preferredWidth:   64
                                Layout.preferredHeight: 64
                                Layout.alignment: Qt.AlignLeft
                                background: Item{}
                                icon.source: "qrc:/assets/images/newUser.png"
                                icon.width: 64
                                icon.height: 64
                                icon.color:"transparent"
                                opacity: 0.5
                                onClicked:{
                                    if(studentCBoxModel.count == 0)
                                    {
                                        var jsondata = dbMan.getBranchStudents(classStudentsPage.branch_id, classStudentsPage.period_id);
                                        var temp;
                                        for(var obj of jsondata)
                                        {
                                            temp = obj.name + " " + obj.lastname;
                                            studentCBoxModel.append({value: obj.id,  text: temp})
                                        }
                                    }

                                    addStudentDialog.open();
                                }

                                hoverEnabled: true
                                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                            }
                        }
                    }


                    GridView
                    {
                        id: classStudentsGV
                        Layout.fillHeight: true
                        Layout.preferredHeight: classStudentsGV.contentHeight + 100
                        Layout.fillWidth: true
                        Layout.margins: 10
                        Layout.columnSpan: 2
                        flickableDirection: Flickable.AutoFlickDirection
                        clip: true
                        cellWidth: 320
                        cellHeight: 340
                        model: ListModel{id: classStudentsModel}
                        highlight: Item{}
                        delegate: gvDelegate

                        function closeSwipeHandler()
                        {
                            for (var i = 0; i <= classStudentsGV.count; i++)
                            {
                                var item = classStudentsGV.contentItem.children[i];
                                if(item.swipe)
                                {
                                    item.swipe.close();
                                    item.checked = false;
                                }
                            }
                        }

                        Component.onCompleted: Methods.updateClassStudentsModel(classStudentsPage.class_id);

                    }
                }

            }
        }
    }


    // swipe delegate
    Component
    {
        id: gvDelegate

        SwipeDelegate
        {
            id: recDel
            required property var model;
            property bool isFemale: (model.Gender === "خانم")? true : false;
            height: 300
            width: 300
            checkable: true
            checked: recDel.swipe.complete
            onCheckedChanged: { if(!recDel.checked) recDel.swipe.close();}
            clip: true

            background: Rectangle{
                color: (recDel.highlighted)? "snow" : "whitesmoke";
                border.color: "lightgray";
                border.width: (recDel.highlighted)? 4 : 0 ;
            }

            contentItem: Rectangle
            {
                // register_id , student_id, student, s.fathername, s.gender, s.birthday, s.photo

                width: parent.width
                height: parent.height

                ColumnLayout
                {
                    anchors.fill: parent

                    Image {
                        source:{
                            if(recDel.model.Photo == "")
                            {
                                if(recDel.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                            }
                            else
                            {
                                return recDel.model.Photo;
                            }

                        }
                        Layout.preferredWidth: 128
                        Layout.preferredHeight: 128
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: recDel.model.Student
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "darkmagenta"
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 50
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text {
                        text: "نام پدر: " + recDel.model.Fathername
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 50
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text {
                        text: "تاریخ تولد:‌ " + recDel.model.Birthday;
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 50
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Item{Layout.preferredWidth: parent.width; Layout.fillHeight: true;}
                }


            }

            onClicked: {recDel.swipe.close();}
            onPressed: { classStudentsGV.currentIndex = model.index; classStudentsGV.closeSwipeHandler();}
            highlighted: (model.index === classStudentsGV.currentIndex)? true: false;

            swipe.right:Column{
                width: 48
                height: 250
                anchors.left: parent.left

                Button
                {
                    height: 48
                    width: 48
                    background:Item{}
                    hoverEnabled: true
                    opacity: 0.5
                    onHoveredChanged: (hovered)? this.opacity=1 : this.opacity=0.5
                    icon.source: "qrc:/assets/images/evalcat.png"
                    icon.width: 48
                    icon.height: 48
                    icon.color:"transparent"
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked: {
                        if(recDel.swipe.complete)
                        recDel.swipe.close();

                        classStudentsPage.appStackView.push(classStudentCourseComponent,
                                                            {
                                                                student: recDel.model,
                                                                registerModel : dbMan.getRegistration(recDel.model.Register_id)
                                                            });
                    }
                }
                Button
                {
                    height: 48
                    width: 48
                    background:Item{}
                    hoverEnabled: true
                    opacity: 0.5
                    onHoveredChanged: (hovered)? this.opacity=1 : this.opacity=0.5
                    icon.source: "qrc:/assets/images/stat.png"
                    icon.width: 48
                    icon.height: 48
                    icon.color:"transparent"
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        studentStatDrawer.step_id = classStudentsPage.step_id
                        studentStatDrawer.base_id = classStudentsPage.base_id;
                        studentStatDrawer.period_id = classStudentsPage.period_id;
                        studentStatDrawer.student = recDel.model.Student + " ( " + recDel.model.Fathername + " ) "
                        studentStatDrawer.photo = recDel.model.Photo;
                        studentStatDrawer.register_id = recDel.model.Register_id
                        studentStatDrawer.baseClass = classStudentsPage.base_text + "  -  " + "کلاس " +  classStudentsPage.class_name
                        studentStatDrawer.period = classStudentsPage.period_text
                        studentStatDrawer.drawerInit();
                        studentStatDrawer.open();
                    }
                }
            }
        }
    }

    DialogBox.BaseDialog
    {
        id: infoDialog
        dialogTitle: "خطا"
        dialogText: "عملیات با خطا مواجه شد."
        dialogSuccess: false
    }

    // class student courses
    Component
    {
        id: classStudentCourseComponent
        ClassStudentCourses
        {
            appStackView: classStudentsPage.appStackView
        }
    }


    // drawer - student stat
    StudentStatDrawer{
        id: studentStatDrawer
    }

    // drawer - class stat
    Drawer
    {
        id: classStatDrawer
        modal: true
        height: parent.height
        width:  parent.width;
        dragMargin: 0
        edge: Qt.RightEdge

        property int class_id;
        property string baseClass;

        function statCalculate()
        {
        }

        ScrollView
        {
            id: classStatSV
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
                icon.color:"transparent"
                opacity: 0.5
                onClicked: classStatDrawer.close();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                anchors.left: parent.left
            }

            Column
            {
                width: classStatSV.width
                spacing: 20

                Item{
                    width: parent.width
                    height: 150
                    Image{
                        width: 128
                        height: 128
                        anchors.centerIn: parent
                        source: "qrc:/assets/images/stat.png"
                    }
                }
                Text{
                    width: parent.width;
                    height: 50
                    text: "class name"
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
                    id: emptyClassStatText
                    width: parent.width;
                    height: 50
                    text: "اطلاعات کلاس کامل نمی‌باشد."
                    font.bold: true
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "dodgerblue"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Column{
                    width: parent.width;
                    visible: ! emptyClassStatText.visible

                    Text{
                        width: parent.width;
                        height: 50
                        text: "----"
                        font.bold: true
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        color: "dodgerblue"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }


                    Repeater
                    {
                        id: classStatRepeater
                        width: parent.width
                        height: classStatRepeater.model.count*200

                        model: ListModel{id: classStatModel;}

                        delegate:Column{
                            required property var model;
                            width: parent.width;
                            height: 200;

                            Label{
                                text: "---"
                                width: parent.width
                                height: 50;
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                                font.bold: true
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                color: "white"
                                background:Rectangle{color: "slategray"}
                            }

                            Item{width: parent.width; height: 20;}
                        }

                    }

                    Item{height: 20; width: 5;}
                }
            }


        }
    }

    Dialog{
        id: addStudentDialog
        width: (parent.width > 400)? 400 : parent.width
        height: (parent.height > 250)? 250 : parent.height
        modal: true
        closePolicy:Popup.NoAutoClose
        dim: true
        anchors.centerIn: parent;
        title: "افزودن دانش‌آموز به کلاس " + classStudentsPage.class_name

        header: Rectangle{
            width: parent.width;
            height: 50;
            color: "forestgreen" ;
            Text{ text: "افزودن دانش‌آموز"; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "B Yekan"; font.pixelSize: 16}
        }

        contentItem:ColumnLayout{
            Label{
                text: "دانش‌آموز"
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignLeft
                font.family: "B Yekan"
                font.pixelSize: 16
                font.bold: true
                color: "royalblue"
            }
            ComboBox{
                id: studentCB
                Layout.preferredHeight:  50
                Layout.fillWidth: true
                editable: true
                font.family: "B Yekan"
                font.pixelSize: 16
                model: ListModel{id: studentCBoxModel}
                textRole: "text"
                valueRole: "value"
            }
            Item{Layout.fillHeight: true; Layout.preferredWidth:1;}
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
                    onClicked: addStudentDialog.close();
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
                }
                Button
                {
                    text: "افزودن"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    onClicked: {
                        // student-step-base-period-class
                        var reg = {}
                        reg["student_id"] = studentCB.currentValue;
                        reg["step_id"] = classStudentsPage.step_id
                        reg["study_base_id"] = classStudentsPage.base_id
                        reg["study_period_id"] = classStudentsPage.period_id
                        reg["class_id"] = classStudentsPage.class_id

                        if(dbMan.registerStudent(reg))
                        {
                            // on register > student_courses & student_evals should be inserted too

                            // student_courses : student_id, register_id, course_id, teacher_id
                            var register_id = dbMan.getLastInsertedId();
                            var student_id = studentCB.currentValue;
                            var class_id = classStudentsPage.class_id // get course_id & teacher_id of class
                            //student_evals : student_id, eval_id
                            // class_id > eval_ids

                            if(dbMan.registerStudentCourseInsert(student_id, register_id, class_id))
                                dbMan.registerStudentEvalInsert(student_id, class_id);
                            Methods.updateClassStudentsModel(classStudentsPage.class_id);

                            //remove user from model
                            var ind = studentCB.currentIndex
                            studentCB.model.remove(ind)
                            addStudentDialog.close();

                        }
                        else
                        {
                            var errorString = dbMan.getLastError();
                            infoDialog.dialogText = errorString
                            infoDialog.width = parent.width
                            infoDialog.height = 500
                            infoDialog.open();
                        }

                    }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                }
                Item{Layout.fillWidth: true}
            }
        }

    }
}
