import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: classStudentsPageId

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
            Button
            {
                height: 64
                width: 64
                anchors.left: parent.left
                background: Item{}
                icon.source: "qrc:/assets/images/arrow-right.png"
                icon.width: 64
                icon.height: 64
                icon.color:"transparent"
                opacity: 0.5
                onClicked: classStudentsPageId.appStackView.pop();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Text {
                width: parent.width
                height: parent.height
                Layout.preferredHeight: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "شعبه " + classStudentsPageId.branch + " - " + classStudentsPageId.step
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
            text: (classStudentsPageId.field_based) ? "رشته " + classStudentsPageId.field + " - " + " پایه " + classStudentsPageId.base :  " پایه " + classStudentsPageId.base
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
            text: " سال تحصیلی " +  classStudentsPageId.period + " - " + " کلاس " + classStudentsPageId.class_name
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
            text: " دانش‌آموزان کلاس "
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
                model: ListModel{id: classStudentsModel;}
                anchors.fill: parent
                anchors.margins: 20
                clip: true
                flickableDirection: Flickable.AutoFlickDirection
                cellWidth: 350
                cellHeight: 350
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                delegate: Rectangle{
                    id: recdel;
                    required property var model;
                    property bool isFemale : (recdel.model.gender === "خانم") ? true : false;
                    width: 320
                    height: 320
                    border.width: 2
                    border.color: "mediumvioletred"
                    color: "slategray";
                    radius: 5
                    ColumnLayout
                    {
                        anchors.fill: parent

                        Image {
                            source:{
                                if(recdel.model.photo === "")
                                {
                                    if(recdel.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                                }
                                else
                                {
                                    return recdel.model.photo;
                                }

                            }
                            Layout.preferredWidth: 200
                            Layout.preferredHeight: 200
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: recdel.model.name + " " + recdel.model.lastname
                            font.family: "B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color: "white"
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: "نام پدر: " + recdel.model.fathername
                            font.family: "B Yekan"
                            font.pixelSize: 14
                            font.bold: true
                            color: "white"
                            Layout.preferredWidth: parent.width
                            Layout.preferredHeight: 25
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Text {
                            text: "تاریخ تولد:‌ " + recdel.model.birthday;
                            font.family: "B Yekan"
                            font.pixelSize: 14
                            font.bold: true
                            color: "white"
                            Layout.preferredWidth: parent.width
                            Layout.preferredHeight: 25
                            horizontalAlignment: Text.AlignHCenter
                        }

                        Item{Layout.preferredWidth: parent.width; Layout.fillHeight: true;}
                    }

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.color = "mediumvioletred";
                        onExited: parent.color = "slategray";
                        onClicked: {
                            var photo = recdel.model.photo;
                            if(photo === "")
                                {
                                    if(recdel.isFemale)
                                        photo = "qrc:/assets/images/female.png";
                                    else
                                        photo = "qrc:/assets/images/user.png";
                                }

                            classStudentsPageId.appStackView.push(studentCoursesComponent, {
                                                                      student: recdel.model.name + " " + recdel.model.lastname,
                                                                      student_id: recdel.model.id,
                                                                      student_photo: photo
                                                                  });
                        }
                    }
                }

                Component.onCompleted: {
                    var jsondata = dbMan.getClassStudentsArray(classStudentsPageId.class_id);
                    classStudentsModel.clear();
                     //id, step_id, name, lastname, fathername, gender, birthday, photo
                    for(var obj of jsondata)
                    {
                        classStudentsModel.append(obj);
                    }
                }
            }

        }

    }

    Component{
        id: studentCoursesComponent
        StudentCoursesList{
            appStackView: classStudentsPageId.appStackView
            branch: classStudentsPageId.branch
            step: classStudentsPageId.step
            base: classStudentsPageId.base
            field : classStudentsPageId.field
            field_based: classStudentsPageId.field_based
            period: classStudentsPageId.period
            class_name: classStudentsPageId.class_name
            class_id: classStudentsPageId.class_id
        }
    }
}
