pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Evals.js" as Methods

Page {
    id: evalsCoursesPage

    required property StackView appStackView;
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
            icon.color:"transparent"
            opacity: 0.5
            onClicked: evalsCoursesPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ارزیابی‌های دروس"
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

                    // branch
                    Rectangle
                    {
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 40
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        Layout.alignment: Qt.AlignHCenter
                        Layout.margins: 10
                        color: "transparent"

                        RowLayout
                        {
                            anchors.fill: parent

                            Label
                            {
                                Layout.preferredHeight:  50
                                Layout.preferredWidth: 120
                                text:"شعبه"
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

                                onActivated: Methods.updateStepCB(branchCB.currentValue)
                            }
                        }

                    }

                    // step
                    Rectangle
                    {
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 40
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        Layout.alignment: Qt.AlignHCenter
                        Layout.margins: 10
                        color: "transparent"
                        RowLayout
                        {
                            anchors.fill: parent
                            Label
                            {
                                Layout.preferredHeight:  50
                                Layout.preferredWidth: 120
                                text:"دوره"
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                            }
                            ComboBox
                            {
                                id: stepCB
                                Layout.preferredHeight:  50
                                Layout.fillWidth: true
                                editable: false
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                model: ListModel{id: stepCBoxModel}
                                textRole: "text"
                                valueRole: "value"
                                Component.onCompleted: stepCB.currentIndex = -1

                                onActivated: Methods.updateBaseCB(branchCB.currentValue)
                            }
                        }
                    }

                    // base
                    Rectangle
                    {
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 40
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        Layout.alignment: Qt.AlignHCenter
                        Layout.margins: 10
                        color: "transparent"
                        RowLayout
                        {
                            anchors.fill: parent
                            Label
                            {
                                Layout.preferredHeight:  50
                                Layout.preferredWidth: 120
                                text:"پایه‌تحصیلی"
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                            }
                            ComboBox
                            {
                                id: baseCB
                                Layout.preferredHeight:  50
                                Layout.fillWidth: true
                                editable: false
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                model: ListModel{id: baseCBoxModel}
                                textRole: "text"
                                valueRole: "value"
                                Component.onCompleted:
                                {
                                    baseCB.currentIndex = -1
                                }

                                onActivated: Methods.updatePeriodCB(branchCB.currentValue);
                            }
                        }
                    }

                    // period
                    Rectangle
                    {
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 40
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        Layout.alignment: Qt.AlignHCenter
                        Layout.margins: 10
                        color: "transparent"
                        RowLayout
                        {
                            anchors.fill: parent
                            Label
                            {
                                Layout.preferredHeight:  50
                                Layout.preferredWidth: 120
                                text:"سال‌تحصیلی"
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                            }
                            ComboBox
                            {
                                id: periodCB
                                Layout.preferredHeight:  50
                                Layout.fillWidth: true
                                editable: false
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                model: ListModel{id: periodCBoxModel}
                                textRole: "text"
                                valueRole: "value"
                                Component.onCompleted: stepCB.currentIndex = -1

                                onActivated: Methods.updateCourses(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);
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


                    GridView
                    {
                        id: coursesGV
                        Layout.columnSpan: 2
                        implicitHeight: 600;
                        Layout.fillWidth: true
                        Layout.margins: 20
                        flickableDirection: Flickable.AutoFlickDirection
                        cellWidth: 320
                        cellHeight: 220 // 20 spacing
                        clip: true
                        model: ListModel{id: coursesModel}
                        highlight: Item{}
                        delegate: courseDelegate
                    }
                }
            }
        }
    }


    // delegate courses
    Component
    {
        id: courseDelegate
        // co.id, co.course_name, co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id,
        // cl.class_name, st.branch_id, st.step_name, sb.study_base, sp.study_period, t.teacher

        // Course_name  Class_name  Teacher

        Rectangle
        {
            id: recDel
            required property var model;
            property int fontSize : 16
            property string fontColor: "black"
            property bool fontBold : false
            width: 300;
            height: 250;

            Column
            {
                id: recDelCol
                anchors.fill: parent
                anchors.margins: 20

                spacing: 0
                Image
                {
                    width: 64
                    height: 64
                    anchors.horizontalCenter: parent.horizontalCenter
                    source:  "qrc:/assets/images/course.png"
                }

                Label {
                    text: recDel.model.Course_name
                    padding: 0
                    font.family: "B Yekan"
                    font.pixelSize: recDel.fontSize
                    font.bold: recDel.fontBold
                    color: recDel.fontColor
                    horizontalAlignment: Label.AlignHCenter
                    width: parent.width
                    height: 50
                    elide: Text.ElideRight
                }
                Label {
                    text: "مدرس: " + recDel.model.Teacher
                    padding: 0
                    font.family: "B Yekan"
                    font.pixelSize: recDel.fontSize
                    font.bold: recDel.fontBold
                    horizontalAlignment: Label.AlignHCenter
                    width: parent.width
                    height: 50
                    elide: Text.ElideRight
                }
                Label {
                    text: "کلاس: " + recDel.model.Class_name
                    padding: 0
                    font.family: "B Yekan"
                    font.pixelSize: recDel.fontSize
                    font.bold: recDel.fontBold
                    horizontalAlignment: Label.AlignHCenter
                    width: parent.width
                    height: 50
                    elide: Text.ElideRight
                }

                Rectangle{width: 200; height:10; anchors.horizontalCenter: parent.horizontalCenter;  color: "skyblue"; visible:(recDel.model.Study_base_id == "")? true : false;}
            }

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onEntered:
                {
                    recDel.fontSize = 20
                    recDel.fontColor = "royalblue"
                    recDel.fontBold = true

                    recDel.color = "snow"
                    recDel.border.width = 2;
                    recDel.border.color = "mediumvioletred"
                }

                onExited:
                {
                    recDel.fontSize = 16
                    recDel.fontColor = "black"
                    recDel.fontBold = false

                    recDel.color = "whitesmoke"
                     recDel.border.width = 1;
                    recDel.border.color =  "gray";

                }

                onClicked:
                {
                    evalsCoursesPage.appStackView.push(evalsComponent, {course_id: recDel.model.Id, course_name: recDel.model.Course_name, class_name: recDel.model.Class_name, teacher: recDel.model.Teacher });
                }
            }
        }
    }


    //evals components
    Component
    {
        id: evalsComponent
        Evals
        {
            appStackView: evalsCoursesPage.appStackView
            branch: branchCB.currentText
            step: stepCB.currentText
            base: baseCB.currentText
            period: periodCB.currentText
        }
    }
}
