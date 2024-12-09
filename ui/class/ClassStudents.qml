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
                        Button
                        {
                            height:   64
                            width: 64
                            anchors.right: parent.right
                            background: Item{}
                            icon.source: "qrc:/assets/images/stat.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked:{
                                classStatDrawer.open();
                            }

                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }


                    GridView
                    {
                        id: classStudentsGV
                        Layout.fillHeight: true
                        implicitHeight: 500
                        Layout.fillWidth: true
                        Layout.margins: 10
                        Layout.columnSpan: 2
                        flickableDirection: Flickable.AutoFlickDirection
                        clip: true
                        cellWidth: 320
                        cellHeight: 140
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
                                return "file://"+recDel.model.Photo;
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
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        studentStatDrawer.student_id = recDel.model.Student_id
                        studentStatDrawer.student = recDel.model.Student + " ( " + recDel.model.Fathername + " ) "
                        studentStatDrawer.photo = recDel.model.Photo;
                        studentStatDrawer.register_id = recDel.model.Register_id
                        studentStatDrawer.baseClass = classStudentsPage.base_text + "  -  " + "کلاس " +  classStudentsPage.class_name
                        studentStatDrawer.statCalculate();
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
    Drawer
    {
        id: studentStatDrawer
        modal: true
        height: parent.height
        width:  parent.width;
        dragMargin: 0

        property int student_id;
        property int register_id;
        property string student;
        property string photo;
        property string baseClass;

        function statCalculate()
        {
            var stat = dbMan.
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
                icon.source: "qrc:/assets/images/arrow-left.png"
                icon.width: 48
                icon.height: 48
                opacity: 0.5
                onClicked: studentStatDrawer.close();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                anchors.right: parent.right
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

    // drawer - class stat
    Drawer
    {
        id: classStatDrawer
        modal: true
        height: parent.height
        width:  parent.width;
        dragMargin: 0

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
                icon.source: "qrc:/assets/images/arrow-left.png"
                icon.width: 48
                icon.height: 48
                opacity: 0.5
                onClicked: classStatDrawer.close();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                anchors.right: parent.right
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

}
