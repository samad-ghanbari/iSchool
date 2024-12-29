pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Student.js" as Methods

Page {
    id: registersPage

    required property StackView appStackView;
    required property var student;
    property bool isFemale : (registersPage.student.gender === "خانم")? true : false;

    signal registerUpdateSignal();

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    GridLayout
    {
        anchors.fill: parent
        columns:3

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
            onClicked: registersPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ثبت نامی‌های دانش‌آموز"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }
        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/add.png"
            icon.width: 64
            icon.height: 64
            icon.color:"transparent"
            opacity: 0.5
            onClicked: registersPage.appStackView.push(registerComponent);
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }

        //info

        Image
        {
            Layout.columnSpan: 3
            Layout.preferredWidth: 128
            Layout.preferredHeight: 128
            Layout.alignment: Qt.AlignHCenter
            source:{
                if(registersPage.student.photo == "")
                {
                    if(registersPage.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                }
                else
                {
                    return registersPage.student.photo;
                }
            }
        }

        Text {
            Layout.columnSpan: 3
            text: registersPage.student["name"] + " " + registersPage.student["lastname"]
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "B Yekan"
            font.pixelSize: 20
            font.bold: true
            color: "royalblue"
        }

        Text {
            Layout.columnSpan: 3
            text: "نام پدر" + " : " + registersPage.student["fathername"]
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "B Yekan"
            font.pixelSize: 18
            font.bold: true
            color: "royalblue"
        }

        Rectangle
        {
            Layout.columnSpan: 3
            Layout.fillWidth: true
            Layout.preferredHeight: 4
            color: "skyblue"
            Layout.topMargin: 10
            Layout.bottomMargin: 10
        }

        GridView
        {
            id: registersGV
            Layout.columnSpan: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 10
            flickableDirection: Flickable.AutoFlickDirection
            clip: true
            cellWidth: 310
            cellHeight: 260
            model: ListModel{id: regsModel}
            highlight: Item{}
            delegate: registerDelegate

            Component.onCompleted:
            {
                Methods.updateStudentRegs(registersPage.student.branch_id, registersPage.student.id);
            }

            function closeSwipeHandler()
            {
                for (var i = 0; i <= registersGV.count; i++)
                {
                    var item = registersGV.contentItem.children[i];
                    if(item.swipe)
                    {
                        item.swipe.close();
                        item.checked = false;
                    }
                }
            }

        }

    }

    //register
    Component
    {
        id: registerComponent
        Register
        {
            student: registersPage.student
            onPopStackSignal: registersPage.appStackView.pop();
            onNewRegisterSignal:
            {
                Methods.updateStudentRegs(registersPage.student.branch_id, registersPage.student.id);
                registersPage.registerUpdateSignal();
            }
        }
    }

    // swipe delegate
    Component
    {
        id: registerDelegate
        // 0r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id, r.class_id,  s.branch_id
        // 6br.city, br.branch_name, st.step_name, sb.study_base, sp.study_period, sp.passed, cl.class_name

        SwipeDelegate
        {
            id: regRecDel
            required property var model;
            height: 250
            width: 300
            checkable: true
            checked: regRecDel.swipe.complete
            onCheckedChanged: { if(!regRecDel.checked) regRecDel.swipe.close();}
            clip: true
            swipe.enabled : !regRecDel.model.Passed

            background: Rectangle{color: (regRecDel.highlighted)? "snow" : "whitesmoke";}

            contentItem: Rectangle
            {
                color: (regRecDel.highlighted)? "snow" : "whitesmoke";

                Column
                {
                    id: regRecDelCol
                    anchors.fill: parent
                    spacing: 0

                    Item{
                        width: parent.width
                        height: 80
                        Image{
                            width: 64
                            height: 64
                            anchors.centerIn: parent
                            source: "qrc:/assets/images/folders.png"
                        }
                    }

                    Label {
                        text: regRecDel.model.Step_name + " - " + regRecDel.model.Study_base
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (regRecDel.highlighted)? 20 :16
                        font.bold: (regRecDel.highlighted)? true : false
                        color: (regRecDel.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: regRecDel.model.Study_period
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (regRecDel.highlighted)? 18 :16
                        font.bold: (regRecDel.highlighted)? true : false
                        color: (regRecDel.model.Passed)? "mediumvioletred":"dodgerblue"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }

                    Label {
                        text: "کلاس " + regRecDel.model.Class_name
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: (regRecDel.highlighted)? true : false
                        color: (regRecDel.model.Passed)? "mediumvioletred":"dodgerblue"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Rectangle{width: 400; height:5; color: (regRecDel.highlighted)? "mediumvioletred" : "whitesmoke"; anchors.horizontalCenter: parent.horizontalCenter }
                }
            }

            onClicked: {regRecDel.swipe.close();}
            onPressed: { registersGV.currentIndex = model.index; registersGV.closeSwipeHandler();}
            highlighted: (model.index === registersGV.currentIndex)? true: false;

            swipe.right: Column{
                width: 80
                height: 160
                anchors.left: parent.left

                Button
                {
                    height: 80
                    width: 80
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
                    icon.color:"transparent"
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(regRecDel.swipe.complete)
                            regRecDel.swipe.close();

                        registersPage.appStackView.push(deleteComponent, {
                                                            regId: regRecDel.model.Id,
                                                            regStep: regRecDel.model.Step_name,
                                                            regBase: regRecDel.model.Study_base,
                                                            regPeriod: regRecDel.model.Study_period,
                                                            regClass: regRecDel.model.Class_name

                                                        });
                    }
                }
                Button
                {
                    height: 80
                    width: 80
                    background: Rectangle{id:courseBtnBg; color: "darkcyan"}
                    hoverEnabled: true
                    onHoveredChanged: courseBtnBg.color=(hovered)? Qt.darker("darkcyan", 1.1):"darkcyan"
                    text: "دروس"
                    font.bold: true
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    palette.buttonText:  "white"
                    icon.source: "qrc:/assets/images/course.png"
                    icon.width: 32
                    icon.height: 32
                    icon.color:"transparent"
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(regRecDel.swipe.complete)
                            regRecDel.swipe.close();

                        registersPage.appStackView.push(studentCourseComponent,
                                                        {
                                                            student: registersPage.student,
                                                            model: regRecDel.model
                                                        });
                    }
                }
            }
        }
    }


    //delete
    Component
    {
        id: deleteComponent
        RegisterDelete
        {
            student: registersPage.student
            onPopStackSignal: registersPage.appStackView.pop();
            onDeletedSignal :
            {
                Methods.updateStudentRegs(registersPage.student.branch_id, registersPage.student.id);
                registersPage.registerUpdateSignal();
            }
        }
    }

    // student courses
    Component
    {
        id: studentCourseComponent
        StudentCourses
        {
            appStackView: registersPage.appStackView
        }
    }

}
