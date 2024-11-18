pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: studentPage
    property string branchText;
    property var studentId;
    property var student: dbMan.getStudent(studentPage.studentId)
    required property StackView appStackView;
    property bool isFemale : (studentPage.student.gender === "خانم")? true : false;

    signal deletedSignal();
    signal updatedSignal();


    background: Rectangle{anchors.fill: parent; color: (studentPage.student.enabled)? "mintcream" : "lavenderblush";}

    Item{
        anchors.fill: parent
        anchors.margins: 5

        GridLayout
        {
            anchors.fill: parent
            columns: 2

            Button
            {
                Layout.preferredHeight: 64
                Layout.preferredWidth: 64
                background: Item{}
                icon.source: "qrc:/assets/images/arrow-right.png"
                icon.width: 64
                icon.height: 64
                opacity: 0.5
                onClicked: studentPage.appStackView.pop();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Text {
                id: userListTitle
                text: "مشخصات دانش‌آموز"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.family: "B Yekan"
                font.pixelSize: 24
                font.bold: true
                color: "mediumvioletred"
            }

            ScrollView
            {
                Layout.columnSpan: 2
                Layout.fillHeight: true
                Layout.fillWidth: true
                contentHeight : infoBox.implicitHeight + 150
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                Rectangle
                {

                    height: parent.height
                    width: (parent.width > 700)? 700 : parent.width;
                    color: "ghostwhite"
                    radius: 5
                    anchors.horizontalCenter: parent.horizontalCenter

                    Item
                    {
                        id: centerBoxRect
                        anchors.fill: parent
                        anchors.margins : 5

                        RowLayout
                        {
                            id: toolbarRL
                            width: centerBoxRect.width
                            height: 48


                            Button
                            {
                                background: Item{}
                                icon.source: "qrc:/assets/images/edit.png"
                                icon.width: 48
                                icon.height: 48
                                opacity: 0.5
                                onClicked: studentPage.appStackView.push(modifyComponent)
                                hoverEnabled: true
                                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                NumberAnimation on scale { duration: 400; from: 0; to:1; easing.type: Easing.Linear }
                            }
                            Item
                            {
                                Layout.fillWidth: true
                            }
                            Button
                            {
                                background: Item{}
                                icon.source: "qrc:/assets/images/trash.png"
                                icon.width: 48
                                icon.height: 48
                                opacity: 0.5
                                onClicked:studentPage.appStackView.push(deleteComponent)
                                hoverEnabled: true
                                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                NumberAnimation on scale { duration: 400; from: 0; to:1; easing.type: Easing.Linear }
                            }
                        }

                        GridLayout
                        {
                            id: infoBox
                            width : centerBoxRect.width
                            anchors.top: toolbarRL.bottom
                            anchors.topMargin: 10
                            columns: 2
                            rowSpacing: 20
                            columnSpacing: 10

                            Rectangle{Layout.columnSpan: 2;  color: (studentPage.student.enabled)? "mintcream" : "lavenderblush"; Layout.preferredHeight: 10; Layout.fillWidth: true;}

                            Image
                            {
                                Layout.columnSpan: 2
                                Layout.preferredWidth: 128
                                Layout.preferredHeight: 128
                                Layout.alignment: Qt.AlignHCenter
                                source:{
                                    if(studentPage.student.photo == "")
                                    {
                                        if(studentPage.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                                    }
                                    else
                                    {
                                        return "file://"+studentPage.student.photo;
                                    }
                                }
                            }

                            Text {
                                text: "نام دانش‌آموز "
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: nameId
                                text: studentPage.student["name"]
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16

                            }

                            Text {
                                text: "نام خانوادگی دانش‌آموز"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: lastnameId
                                text: studentPage.student["lastname"]
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16
                            }

                            Text {
                                text: "نام پدر دانش‌آموز"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text
                            {
                                id: fathernameId
                                text: studentPage.student["fathername"]
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16
                            }

                            Text {
                                text: "جنسیت"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text {
                                id: genderId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                text: studentPage.student["gender"]
                            }

                            Text {
                                text: "تاریخ تولد"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Text {
                                id: birthdayId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                text: studentPage.student["birthday"]
                            }


                            Text {
                                text: "فعال/غیرفعال"
                                Layout.minimumWidth: 150
                                Layout.maximumWidth: 150
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                color: "royalblue"
                            }
                            Switch
                            {
                                id: enabledSW
                                checked: studentPage.student["enabled"]
                                text: checked? "فعال" : "غیرفعال";
                                font.family: "B Yekan"
                                palette.highlight: "royalblue"
                                palette.text: "gray"
                                enabled: false
                            }

                            //register
                            Button
                            {
                                Layout.columnSpan: 2
                                Layout.minimumHeight: 50
                                Layout.fillWidth: true
                                Layout.maximumWidth: 300
                                Layout.alignment: Qt.AlignHCenter
                                text: "ثبت نامی‌های دانش‌آموز"
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                font.bold: true
                                onClicked:studentPage.appStackView.push(registersComponent);
                                Rectangle{width: parent.width;  height: 4; color:"skyblue"; anchors.bottom: parent.bottom;}
                            }
                        }

                    }
                }
            }
        }
    }

    Component
    {
        id: modifyComponent
        StudentUpdate
        {
            model: studentPage.student
            branchText: studentPage.branchText
            onPopStackSignal: studentPage.appStackView.pop();
            onUpdatedSignal:
            {
                studentPage.student = dbMan.getStudent(studentPage.studentId)
                studentPage.updatedSignal();
            }
        }
    }

    //-----delete
    Component
    {
        id: deleteComponent
        StudentDelete
        {
            model: studentPage.student
            branchText: studentPage.branchText
            onPopStackSignal: studentPage.appStackView.pop();
            onDeletedSignal:
            {
                studentPage.appStackView.pop();
                studentPage.deletedSignal();
            }
        }
    }

    //register
    Component
    {
        id: registersComponent
        Registrations
        {
            student: studentPage.student
            appStackView: studentPage.appStackView;
        }
    }

}

