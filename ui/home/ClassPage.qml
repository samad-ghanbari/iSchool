import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: classPageId

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;

    required property StackView appStackView;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            color:"transparent"

            Text {
                width: parent.width
                height: parent.height
                Layout.preferredHeight: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "شعبه " + classPageId.branch + " - " + classPageId.step
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
        }


        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 25
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: (classPageId.field_based) ? "رشته " + classPageId.field + " - " + " پایه " + classPageId.base :  " پایه " + classPageId.base
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
        }

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 25
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: " سال تحصیلی " +  classPageId.period
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
        }

        Rectangle{
            Layout.preferredHeight: 1
            Layout.fillWidth: true
            //Layout.maximumWidth: 700
            Layout.alignment: Qt.AlignHCenter
            color: "darkgray"
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight:  64
            Layout.alignment: Qt.AlignRight

            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: 25
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: "  لیست کلاس‌ها  "
                font.family: "Kalameh"
                font.pixelSize: 20
                font.bold: true
                color: "mediumvioletred"
            }

            Button
            {
                Layout.preferredHeight:  64
                background: Item{}
                icon.source: "qrc:/assets/images/grade.png"
                text: "ثبت میانگین پایه"
                font.family: "Kalameh"
                font.pixelSize: 16
                icon.width: 32
                icon.height: 32
                display: AbstractButton.TextUnderIcon
                icon.color:"transparent"
                opacity: 0.5
                onClicked: appStackView.push(baseAverageComponent);
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }

            Button
            {
                Layout.preferredHeight:  64
                background: Item{}
                icon.source: "qrc:/assets/images/stat.png"
                text: "رتبه‌بندی"
                font.family: "Kalameh"
                font.pixelSize: 16
                icon.width: 32
                icon.height: 32
                display: AbstractButton.TextUnderIcon
                icon.color:"transparent"
                opacity: 0.5
                onClicked: appStackView.push(rankComponent);
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }

        }


        Rectangle{
            id: mainBox
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 20
            color: "transparent"

            GridView{
                id: classGV
                model: ListModel{id: classModel;}
                anchors.fill: parent
                anchors.topMargin: 20
                clip: true
                flickableDirection: Flickable.AutoFlickDirection
                cellWidth: 350
                cellHeight: 250
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                delegate: Rectangle{
                    id: recdel;
                    required property var model;
                    width: 320
                    height: 200
                    border.width: 2
                    border.color: "mediumvioletred"
                    color: "slategray";
                    radius: 5

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "mediumvioletred";
                        onExited: parent.color = "slategray";
                        //acceptedButtons: Qt.NoButton
                        onClicked:{
                            classPageId.appStackView.push(classStudentsComponent, {
                                                             objectName:"classStudentsON",
                                                             class_name: recdel.model.class_name,
                                                             class_id: recdel.model.id
                                                         });
                        }
                    }

                    Label{
                        width: parent.width
                        height: 150
                        font.family: "Kalameh"
                        font.pixelSize: 20
                        font.bold: true
                        color: "white"
                        text: "کلاس " + recdel.model.class_name + "\n" + recdel.model.class_desc
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        anchors.top: parent.top
                    }
                    Rectangle{
                        width: parent.width
                        height: 50
                        color:"transparent"
                        anchors.bottom: parent.bottom

                        Button{
                            width: 50
                            height: 50
                            visible: false
                            anchors.left: parent.left
                            icon.source: "qrc:/assets/images/student.png"
                            icon.width: 50
                            icon.height: 50
                            icon.color:"transparent"
                            background: Item{}
                            onClicked: {
                                classPageId.appStackView.push(classStudentsComponent, {
                                                                 objectName:"classStudentsON",
                                                                 class_name: recdel.model.class_name,
                                                                 class_id: recdel.model.id
                                                             });
                            }
                        }
                        Button{
                            width: 50
                            height: 50
                            anchors.right: parent.right
                            icon.source: "qrc:/assets/images/course.png"
                            icon.width: 50
                            icon.height: 50
                            icon.color:"transparent"
                            background: Item{}
                            onClicked: {
                                classPageId.appStackView.push(classCoursesComponent, {
                                                                 objectName:"classCoursesON",
                                                                 class_name: recdel.model.class_name,
                                                                 class_id: recdel.model.id
                                                             });
                            }
                        }
                    }


                }

                Component.onCompleted: {
                    var jsondata = dbMan.getClasses();
                    classModel.clear();
                     //c.id, c.base_id, c.period_id, c.class_name, c.class_desc, b.field_id
                    for(var obj of jsondata)
                    {
                        classModel.append(obj);
                    }
                }
            }

        }

    }

    Component{
        id: classCoursesComponent
        ClassCoursePage{
            appStackView: classPageId.appStackView
            branch: classPageId.branch
            step: classPageId.step
            base: classPageId.base
            field : classPageId.field
            field_based: classPageId.field_based
            period: classPageId.period
        }
    }

    Component{
        id: classStudentsComponent
        ClassStudentPage{
            appStackView: classPageId.appStackView
            branch: classPageId.branch
            step: classPageId.step
            base: classPageId.base
            field : classPageId.field
            field_based: classPageId.field_based
            period: classPageId.period
        }
    }

    Component{
        id: baseAverageComponent
        BaseAvg{
            branch: classPageId.branch
            step: classPageId.step
            base: classPageId.base
            field : classPageId.field
            field_based: classPageId.field_based
            period: classPageId.period
        }
    }

    Component{
        id:rankComponent
        Rank{
            branch: classPageId.branch
            step: classPageId.step
            base: classPageId.base
            field : classPageId.field
            field_based: classPageId.field_based
            period: classPageId.period

            onPopSignal: classPageId.appStackView.pop();
        }
    }
}
