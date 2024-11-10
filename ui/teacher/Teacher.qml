pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: teacherPage
    property string branchText;
    property var teacherId;
    property var teacher: dbMan.getTeacher(teacherPage.teacherId)
    required property StackView appStackView;

    signal deletedSignal();
    signal updatedSignal();


    background: Rectangle{anchors.fill: parent; color: (teacherPage.teacher.enabled)? "mintcream" : "lavenderblush";}

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
                onClicked: teacherPage.appStackView.pop();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Text {
                id: userListTitle
                text: "مشخصات دبیر شعبه"
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
                            height: 64


                            Button
                            {
                                background: Item{}
                                icon.source: "qrc:/assets/images/edit.png"
                                icon.width: 64
                                icon.height: 64
                                opacity: 0.5
                                onClicked: teacherPage.appStackView.push(modifyComponent)
                                hoverEnabled: true
                                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                NumberAnimation on rotation { duration: 400; from: 0; to:360; easing.type: Easing.Linear }
                            }
                            Item
                            {
                                Layout.fillWidth: true
                            }
                            Button
                            {
                                background: Item{}
                                icon.source: "qrc:/assets/images/trash.png"
                                icon.width: 64
                                icon.height: 64
                                opacity: 0.5
                                onClicked:teacherPage.appStackView.push(deleteComponent)
                                hoverEnabled: true
                                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                NumberAnimation on rotation { duration: 400; from: 0; to:360; easing.type: Easing.Linear }
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

                            Rectangle{Layout.columnSpan: 2;  color: (teacherPage.teacher.enabled)? "mintcream" : "lavenderblush"; Layout.preferredHeight: 10; Layout.fillWidth: true;}

                            Text {
                                text: "نام دبیر "
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
                                text: teacherPage.teacher["name"]
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 16

                            }

                            Text {
                                text: "نام خانوادگی دبیر"
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
                                id: lastNameId
                                text: teacherPage.teacher["lastname"]
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
                                text: teacherPage.teacher["gender"]
                            }

                            Text {
                                text: "سطح تحصیلات"
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
                                id: studyDegreeId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                text: teacherPage.teacher["study_degree"]
                            }

                            Text {
                                text: "رشته تحصیلی"
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
                                id: studyFieldId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                text: teacherPage.teacher["study_field"]
                            }

                            Text {
                                text: "شماره تماس"
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
                                id: telephoneId
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignLeft
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                text: teacherPage.teacher["telephone"]
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
                                checked: teacherPage.teacher["enabled"]
                                text: checked? "فعال" : "غیرفعال";
                                font.family: "B Yekan"
                                palette.highlight: "royalblue"
                                palette.text: "gray"
                                enabled: false
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
        TeacherUpdate
        {
            model: teacherPage.teacher
            branchText: teacherPage.branchText
            onPopStackSignal: teacherPage.appStackView.pop();
            onUpdatedSignal:
            {
                teacherPage.teacher = dbMan.getTeacher(teacherPage.teacherId)
                teacherPage.updatedSignal();
            }
        }
    }

    //-----delete
    Component
    {
        id: deleteComponent
        TeacherDelete
        {
            model: teacherPage.teacher
            branchText: teacherPage.branchText
            onPopStackSignal: teacherPage.appStackView.pop();
            onDeletedSignal:
            {
                teacherPage.appStackView.pop();
                teacherPage.deletedSignal();
            }
        }
    }

}

