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
                            Layout.margins: 20
                            NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                        }
                        Column{
                            Layout.fillWidth: true;
                            Layout.preferredHeight: 200
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
                            //class
                            Text {
                                text: "کلاس " + classStudentsPage.class_name + " - " + classStudentsPage.class_desc
                                width: parent.width
                                height: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "B Yekan"
                                font.pixelSize: 20
                                font.bold: true
                                color: "darkmagenta"
                            }
                        }
                    }



                    Rectangle{Layout.fillWidth: true; Layout.maximumWidth: 700; color:"dodgerblue"; Layout.preferredHeight:5; Layout.alignment: Qt.AlignHCenter;}

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

            background: Rectangle{color: (recDel.highlighted)? "snow" : "whitesmoke";}

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

    Drawer
    {
        id: classStudentsStat
        modal: true
        height: parent.height
        width: 300 //(parent.width > 300)? 300 : parent.width;
        dragMargin: 0

        ScrollView
        {
            id: classStudentsSV
            anchors.fill: parent
            anchors.margins: 5

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ColumnLayout
            {}
        }
    }
}
