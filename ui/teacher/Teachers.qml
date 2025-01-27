pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Teachers.js" as Methods

Page {
    id: teachersPage
    required property StackView appStackView;

    property bool admin  : dbMan.isUserAdmin();

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
            onClicked: teachersPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "لیست دبیران"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }


        RowLayout{
            Layout.columnSpan: 2
            Layout.preferredHeight:  50
            Layout.preferredWidth: branchLbl.width + branchCB.width
            Layout.alignment: Qt.AlignHCenter

            Label
            {
                id: branchLbl
                Layout.preferredHeight:  50
                Layout.preferredWidth: 100
                text:" انتخاب شعبه"
                font.family: "B Yekan"
                font.pixelSize: 16
                font.bold: true
                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
            }
            ComboBox
            {
                id: branchCB
                Layout.preferredHeight:  50
                Layout.fillWidth: true
                Layout.maximumWidth: 400
                editable: false
                font.family: "B Yekan"
                font.pixelSize: 16
                model: ListModel{id: branchCBoxModel}
                textRole: "text"
                valueRole: "value"
                Component.onCompleted:
                {
                    Methods.updateBranchCB();
                    branchCB.currentIndex = -1
                }

                onActivated: Methods.teachersUpdate(branchCB.currentValue)
            }
        }

        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "ghostwhite"
            ColumnLayout
            {
                anchors.fill: parent
                RowLayout
                {
                    Layout.preferredHeight:   64
                    Layout.fillWidth: true
                    //Layout.alignment: Qt.AlignRight

                    Button
                    {
                        background: Item{}
                        visible: ((branchCB.currentIndex >=0) && teachersPage.admin )? true : false;
                        Layout.preferredWidth: 64
                        Layout.preferredHeight: 64
                        icon.source: "qrc:/assets/images/add.png"
                        icon.width: 64
                        icon.height: 64
                        icon.color:"transparent"
                        opacity: 0.5
                        enabled: teachersPage.admin
                        onClicked:
                        {
                            var bid = branchCB.currentValue;
                            if(bid >= 0)
                                teachersPage.appStackView.push(teacherInsertComponent);
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }
                    Item{Layout.fillWidth: true}
                    Button
                    {
                        visible: (branchCB.currentIndex >=0)? true : false;
                        Layout.preferredWidth: 64
                        Layout.preferredHeight: 64
                        background: Item{}
                        icon.source: "qrc:/assets/images/search.png"
                        icon.width: 64
                        icon.height: 64
                        icon.color:"transparent"
                        opacity: 0.5
                        onClicked:
                        {
                            var bid = branchCB.currentValue;
                            if(bid >= 0)
                                teacherSearchDrawer.open();
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }
                }



                GridView {
                    Layout.columnSpan: 3
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: 20
                    cellWidth: 300
                    cellHeight: 330
                    clip: true
                    model: ListModel{id: teacherModel}
                    delegate: teacherDelegate
                    layoutDirection: Qt.LeftToRight
                }
            }
        }
    }

    // delegate
    Component
    {
        id: teacherDelegate
        Rectangle {
            id: teacherWidget
            required property var model;
            property bool userIsFemale: (model.Gender === "خانم")? true : false;

            width: 256
            height: 300
            color:(model.Enabled)? "white" : "lightpink"
            border.color : "lavenderblush"
            opacity: 0.8
            radius: 10

            Item
            {
                anchors.fill: parent
                anchors.margins: 5
                ColumnLayout
                {
                    anchors.fill: parent

                    Image {
                        source: (teacherWidget.userIsFemale)? "qrc:/assets/images/female.png" : "qrc:/assets/images/user.png"
                        Layout.preferredWidth: 128
                        Layout.preferredHeight: 128
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: teacherWidget.model.Name + " " + teacherWidget.model.LastName
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                        Layout.preferredWidth: parent.width
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text {
                        text: "تحصیلات" + " : " + teacherWidget.model.StudyDegree
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.fillWidth: true
                    }
                    Text {
                        text: "رشته تحصیلی" + " : " + teacherWidget.model.StudyField
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.fillWidth: true
                    }
                }

            }

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged:{
                    if(containsMouse){
                        parent.opacity=1;
                        teacherWidget.border.color = "pink"
                    }
                        else
                        {
                            teacherWidget.border.color = "lavenderblush"
                            parent.opacity=0.8
                        }
                }
                onClicked: {teachersPage.appStackView.push(teacherComponent, {teacherId: teacherWidget.model.Id });}
            }



        }
    }

    //Insert
    Component
    {
        id: teacherInsertComponent
        TeacherInsert
        {
            branchId : branchCB.currentValue
            branchText: branchCB.currentText
            onPopStackSignal: teachersPage.appStackView.pop();
            onTeacherInsertedSignal:
            {
                var branchId = branchCB.currentValue;
                Methods.teachersUpdate(branchId);
            }
        }
    }

    Component
    {
        id: teacherComponent
        Teacher
        {
            appStackView: teachersPage.appStackView
            branchText: branchCB.currentText
            onDeletedSignal: Methods.teachersUpdate(branchCB.currentValue)
            onUpdatedSignal: Methods.teachersUpdate(branchCB.currentValue)
        }
    }

    //drawer
    Drawer
    {
        id: teacherSearchDrawer
        modal: true
        height: parent.height
        width: 300
        dragMargin: 0

        ScrollView
        {
            id: teacherDrawerSV
            anchors.fill: parent

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ColumnLayout
            {
                width: teacherDrawerSV.width

                Rectangle
                {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 110
                    color: "mediumvioletred"

                    Image {
                        id: searchImage
                        source: "qrc:/assets/images/search.png"
                        width: 64
                        height: 64
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        width: parent.width
                        height: 40
                        anchors.top: searchImage.bottom
                        horizontalAlignment: Qt.AlignHCenter
                        anchors.topMargin: 10
                        text: "جستجوی دبیران"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignHCenter
                        font.bold: true
                        color:"white"
                    }
                }

                Text {
                    text: "نام دبیر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "mediumvioletred"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: nameTF
                    placeholderText: "نام دبیر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }

                //lastname
                Text {
                    text: "نام ‌خانوادگی دبیر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "mediumvioletred"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: lastNameTF
                    placeholderText: "نام ‌خانوادگی دبیر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }

                //gender
                Text {
                    text: "جنسیت"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "mediumvioletred"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                ComboBox {
                    id: genderId
                    editable: false
                    model: ["", "آقا", "خانم"]
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    Layout.preferredHeight: 40
                    Layout.leftMargin: 10
                    Layout.topMargin: -5
                }


                //study field
                Text {
                    text: "رشته تحصیلی"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "mediumvioletred"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: studyFieldTF
                    placeholderText: "رشته تحصیلی"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }

                //study degree
                Text {
                    text: "سطح تحصیلات"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "mediumvioletred"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: studyDegreeTF
                    placeholderText: "سطح تحصیلات"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }

                //enabled
                Text {
                    text: "وضعیت فعال/غیرفعال"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "mediumvioletred"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                Switch
                {
                    id: enabledId
                    checked: true
                    Layout.topMargin: -5
                    text: checked? "فعال" : "غیرفعال";
                    font.family: "B Yekan"
                    palette.highlight: "mediumvioletred"
                    palette.text: "gray"
                }

                // button

                Button
                {
                    text: "جستجو"
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 100
                    Layout.alignment: Qt.AlignHCenter
                    icon.source: "qrc:/assets/images/search.png"
                    icon.width: 32
                    icon.height: 32
                    icon.color:"transparent"

                    onClicked: {

                        var teacher = {};
                        teacher["branch_id"] = branchCB.currentValue;
                        teacher["name"] = nameTF.text;
                        teacher["lastname"] = lastNameTF.text;
                        teacher["gender"] = genderId.currentText;
                        teacher["study_field"] = studyFieldTF.text;
                        teacher["study_degree"] = studyDegreeTF.text;
                        teacher["enabled"] = enabledId.checked;

                        Methods.filterTeachers(teacher);
                    }

                    Rectangle{width: parent.width; height: 4; color:"mediumvioletred"; anchors.bottom: parent.bottom}
                }
            }
        }
    }
}
