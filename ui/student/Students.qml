pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Student.js" as Methods

Page {
    id: studentsPage
    required property StackView appStackView;

    property int limit : 20
    property int offset: 0
    property int studentsCount
    // offset shoud be less or equal than limit

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "مدیریت دانش‌آموزان"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        Flickable{
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentHeight: centerBox.implicitHeight

            Column{
                id: centerBox
                width: parent.width
                // branch
                RowLayout
                {
                    width: 400
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"شعبه:"
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignRight
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: branchCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        editable: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: branchModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted:
                        {
                            branchModel.clear();
                            stepModel.clear();
                            studentModel.clear();
                            var jsondata = dbMan.getBranches();
                            //id, city, branch_name, address
                            var temp;
                            for(var obj of jsondata)
                            {
                                temp = obj.city + " - "+ obj.branch_name;
                                branchModel.append({value: obj.id,  text: temp })
                            }
                            branchCB.currentIndex = -1
                        }

                        onActivated: {
                            stepModel.clear();
                            studentModel.clear();
                            var jsondata = dbMan.getBranchSteps(branchCB.currentValue);
                            //s.id, s.branch_id, s.step_name, s.field_based, s.numeric_graded, b.city, b.branch_name
                            var temp;
                            for(var obj of jsondata)
                            {
                                stepModel.append({value: obj.id,  text: obj.step_name, field_based: obj.field_based })
                            }
                        }

                    }
                }
                //step
                RowLayout
                {
                    width: 400
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"دوره: "
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignRight
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: stepCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        editable: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: stepModel}
                        textRole: "text"
                        valueRole: "value"
                        onActivated: {
                            studentModel.clear();
                            var cond = {};
                            var jsondata = dbMan.getStudents(stepCB.currentValue, cond, studentsPage.limit, studentsPage.offset);
                            for(var obj of jsondata){
                                studentModel.append(obj);
                            }
                        }

                    }
                }

                Item{width: parent.width; height: 10;}
                Rectangle{width: parent.width; height: 1; color: "darkgray";}
                Item{width: parent.width; height: 10;}

                RowLayout
                {
                    Layout.preferredHeight:   64
                    Layout.fillWidth: true

                    Button
                    {
                        background: Item{}
                        visible: (stepCB.currentIndex >=0)? true : false;
                        Layout.preferredWidth: 64
                        Layout.preferredHeight: 64
                        icon.source: "qrc:/assets/images/add.png"
                        icon.width: 64
                        icon.height: 64
                        icon.color:"transparent"
                        opacity: 0.5
                        onClicked:
                        {
                            var sid = stepCB.currentValue;
                            if(sid >= 0)
                                studentsPage.appStackView.push(studentInsertComponent);
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }
                    Item{Layout.fillWidth: true}
                    Button
                    {
                        visible: (stepCB.currentIndex >=0)? true : false;
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
                            var sid = stepCB.currentValue;
                            if(sid >= 0)
                                studentSearchDrawer.open();
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }
                }

                RowLayout
                {
                    Layout.preferredHeight:   32
                    Layout.fillWidth: true

                    Item{Layout.fillWidth: true}
                    Button
                    {
                        background: Item{}
                        visible: (stepCB.currentIndex >=0)? true : false;
                        Layout.preferredWidth: 32
                        Layout.preferredHeight: 32
                        icon.source: "qrc:/assets/images/arrow-right.png"
                        icon.width: 32
                        icon.height: 32
                        icon.color:"transparent"
                        opacity: 0.5
                        onClicked:
                        {
                            studentsPage.offset = studentsPage.offset + 19;
                            if(studentsPage.offset >= studentsPage.studentsCount ) studentsPage.offset = 0;

                            Methods.updateStudentsModel(stepCB.currentValue, periodCB.currentValue, studentsPage.limit, studentsPage.offset);
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }

                    Button
                    {
                        visible: (stepCB.currentIndex >=0)? true : false;
                        Layout.preferredWidth: 32
                        Layout.preferredHeight: 32
                        background: Item{}
                        icon.source: "qrc:/assets/images/arrow-left.png"
                        icon.width: 32
                        icon.height: 32
                        icon.color:"transparent"
                        opacity: 0.5
                        onClicked:
                        {
                            studentsPage.offset = studentsPage.offset - 19;
                            if(studentsPage.offset  < 0 ) studentsPage.offset = 0;
                            Methods.updateStudentsModel(stepCB.currentValue, periodCB.currentValue, studentsPage.limit, studentsPage.offset);
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }
                    Item{Layout.fillWidth: true}
                }

                Item{width: parent.width; height: 10;}

                GridView {
                    id: studentsGV
                    width: parent.width
                    height: studentsGV.contentHeight
                    cellWidth: 300
                    cellHeight: 340
                    clip: true
                    model: ListModel{id: studentModel}
                    delegate: studentDelegate
                    layoutDirection: Qt.LeftToRight
                }
            }
        }
    }

    // delegate
    Component
    {
        id: studentDelegate
        Rectangle {
            id: studentWidget
            required property var model;
            property bool isFemale: (model.Gender === "خانم")? true : false;

            width: 256
            height: 300
            color:(model.Enabled)? "white" : "lightpink"
            opacity: 0.8
            radius: 10
            border.width: 2
            border.color: "lavenderblush"

            Item
            {
                anchors.fill: parent
                anchors.margins: 5
                ColumnLayout
                {
                    anchors.fill: parent

                    Image {
                        source:{
                            if(studentWidget.model.Photo == "")
                            {
                                if(studentWidget.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                            }
                            else
                            {
                                return studentWidget.model.Photo;
                            }

                        }
                        Layout.preferredWidth: 128
                        Layout.preferredHeight: 128
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: studentWidget.model.Name + " " + studentWidget.model.LastName
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                        Layout.preferredWidth: parent.width
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text {
                        text: "نام پدر" + " : " + studentWidget.model.FatherName
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.fillWidth: true
                    }
                    Text {
                        text: "تاریخ تولد" + " : " + studentWidget.model.Birthday
                        font.family: "Kalameh"
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
                        studentWidget.border.color = "pink"
                    }
                        else
                        {
                            studentWidget.border.color = "lavenderblush"
                            parent.opacity=0.8
                        }
                }
                onClicked: {studentsPage.appStackView.push(studentComponent, {studentId: studentWidget.model.Id });}
            }



        }
    }

    //Insert
    Component
    {
        id: studentInsertComponent
        StudentInsert
        {
            branchId : branchCB.currentValue
            branchText: branchCB.currentText
            onPopStackSignal: studentsPage.appStackView.pop();
            onInsertedSignal:
            {
                Methods.updateStudentsModel(branchCB.currentValue, periodCB.currentValue);
            }
        }
    }

    //student component
    Component
    {
        id: studentComponent
        Student
        {
            appStackView: studentsPage.appStackView
            branchText: branchCB.currentText
            onDeletedSignal: Methods.updateStudentsModel(branchCB.currentValue, periodCB.currentValue)
            onUpdatedSignal: Methods.updateStudentsModel(branchCB.currentValue, periodCB.currentValue)
        }
    }

    //drawer
    Drawer
    {
        id: studentSearchDrawer
        modal: true
        height: parent.height
        width: 300
        dragMargin: 0
        //interactive: false


        ScrollView
        {
            id: studentDrawerSV
            anchors.fill: parent

            ColumnLayout
            {
                width: studentDrawerSV.width

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
                        text: "جستجوی دانش‌آموزان "
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignHCenter
                        font.bold: true
                        color:"white"
                    }
                }

                Text {
                    text: "نام دانش‌آموز"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "mediumvioletred"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: nameTF
                    placeholderText: "نام دانش‌آموز"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }

                //lastname
                Text {
                    text: "نام ‌خانوادگی دانش‌آموز"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "mediumvioletred"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: lastnameTF
                    placeholderText: "نام ‌خانوادگی دانش‌آموز"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }

                //fathername
                Text {
                    text: "نام پدر دانش‌آموز"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "mediumvioletred"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: fathernameTF
                    placeholderText: "نام پدر دانش‌آموز"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }
                //gender
                Text {
                    text: "جنسیت"
                    font.family: "Kalameh"
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
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.preferredHeight: 40
                    Layout.leftMargin: 10
                    Layout.topMargin: -5
                }


                //birthday
                Text {
                    text: "تاریخ تولد"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "mediumvioletred"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: birthdayTF
                    placeholderText: "تاریخ تولد"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }

                //enabled
                Text {
                    text: "وضعیت فعال/غیرفعال"
                    font.family: "Kalameh"
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
                    font.family: "Kalameh"
                    palette.highlight: "mediumvioletred"
                    palette.text: "gray"
                }

                // button

                Button
                {
                    text: "جستجو"
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 100
                    Layout.alignment: Qt.AlignHCenter
                    icon.source: "qrc:/assets/images/search.png"
                    icon.width: 32
                    icon.height: 32
                    icon.color:"transparent"

                    onClicked: {

                        var student = {};
                        student["branch_id"] = branchCB.currentValue;
                        student["name"] = nameTF.text;
                        student["lastname"] = lastnameTF.text;
                        student["fathername"] = fathernameTF.text;
                        student["gender"] = genderId.currentText;
                        student["birthday"] = birthdayTF.text;
                        student["enabled"] = enabledId.checked;

                        Methods.filterStudents(student);
                    }

                    Rectangle{width: parent.width; height: 4; color:"mediumvioletred"; anchors.bottom: parent.bottom}
                }
            }
        }
    }
}
