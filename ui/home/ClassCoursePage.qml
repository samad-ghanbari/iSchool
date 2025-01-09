import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: classCoursePageId

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;
    required property string class_name;
    required property int class_id;

    required property StackView appStackView;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            color:"transparent"
            // Button
            // {
            //     height: 64
            //     width: 64
            //     anchors.left: parent.left
            //     background: Item{}
            //     icon.source: "qrc:/assets/images/arrow-right.png"
            //     icon.width: 64
            //     icon.height: 64
            //     icon.color:"transparent"
            //     opacity: 0.5
            //     onClicked: classCoursePageId.appStackView.pop();
            //     hoverEnabled: true
            //     onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            // }
            Text {
                width: parent.width
                height: parent.height
                Layout.preferredHeight: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "شعبه " + classCoursePageId.branch + " - " + classCoursePageId.step
                font.family: "B Yekan"
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
            text: (classCoursePageId.field_based) ? "رشته " + classCoursePageId.field + " - " + " پایه " + classCoursePageId.base :  " پایه " + classCoursePageId.base
            font.family: "B Yekan"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
        }

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 25
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: " سال تحصیلی " +  classCoursePageId.period + " - " + " کلاس " + classCoursePageId.class_name
            font.family: "B Yekan"
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

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 25
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: " دروس کلاس "
            font.family: "B Yekan"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
        }


        Rectangle{
            id: mainBox
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 20
            color: "transparent"

            GridView{
                id: classCoursesGV
                model: ListModel{id: classCourseModel;}
                anchors.fill: parent
                anchors.margins: 20
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
                    height: 220
                    border.width: 2
                    border.color: "mediumvioletred"
                    color: "slategray";
                    radius: 5
                    ColumnLayout{
                        width: parent.width
                        height: parent.height
                        anchors.margins: 5

                        Label{
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "B Yekan"
                            font.pixelSize: 20
                            font.bold: true
                            color: "white"
                            text: recdel.model.course_name
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                        }

                        Item{Layout.fillHeight: true; Layout.preferredWidth: 1;}

                        Label{
                            Layout.fillWidth: true
                            Layout.preferredHeight: 20
                            font.family: "B Yekan"
                            font.pixelSize: 14
                            font.bold: true
                            color: "lightgray"
                            text: " ضریب درس: " + recdel.model.course_coefficient
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label{
                            Layout.fillWidth: true
                            Layout.preferredHeight: 20
                            font.family: "B Yekan"
                            font.pixelSize: 14
                            font.bold: true
                            color: "lightgray"
                            text: " ضریب تست: " + recdel.model.test_coefficient
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label{
                            Layout.fillWidth: true
                            Layout.preferredHeight:  20
                            font.family: "B Yekan"
                            font.pixelSize: 14
                            font.bold: true
                            color: "lightgray"
                            text: " وزن آزمون نهایی: " + recdel.model.final_weight
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }
                        Label{
                            Layout.fillWidth: true
                            Layout.preferredHeight:  20
                            font.family: "B Yekan"
                            font.pixelSize: 14
                            font.bold: true
                            color: "lightgray"
                            text: " وزن اشتراکی: " + recdel.model.shared_weight
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }
                        Item{Layout.preferredHeight: 5; Layout.preferredWidth: 1;}

                    }

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "mediumvioletred";
                        onExited: parent.color = "slategray";
                        onClicked: {
                            classCoursePageId.appStackView.push(courseStudentsComponent,  {
                                                                    objectName: "courseStudentON",
                                                                    course_id: recdel.model.id,
                                                                    course_name: recdel.model.course_name

                                                                });
                        }
                    }
                }

                Component.onCompleted: {
                    var jsondata = dbMan.getClassCoursesArray(classCoursePageId.class_id);
                    classCourseModel.clear();
                     //id, course_name, step_id, base_id, period_id, course_coefficient, test_coefficient, shared_coefficient, final_weight, shared_weight
                    for(var obj of jsondata)
                    {
                        classCourseModel.append(obj);
                    }
                }
            }

        }
    }

    Component{
        id: courseStudentsComponent
        CourseStudentsList{
            appStackView: classCoursePageId.appStackView
            branch: classCoursePageId.branch
            step: classCoursePageId.step
            base: classCoursePageId.base
            field : classCoursePageId.field
            field_based: classCoursePageId.field_based
            period: classCoursePageId.period
            class_name: classCoursePageId.class_name
            class_id: classCoursePageId.class_id
        }
    }
}
