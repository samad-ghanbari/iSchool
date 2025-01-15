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

    Flickable{
        anchors.fill: parent
        contentHeight: classCoursesGV.contentHeight + 400

        ColumnLayout
        {
            id: cspCL
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
                    text: "شعبه " + classStudentsPageId.branch + " - " + classStudentsPageId.step
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
                text: (classStudentsPageId.field_based) ? "رشته " + classStudentsPageId.field + " - " + " پایه " + classStudentsPageId.base :  " پایه " + classStudentsPageId.base
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
                text: " سال تحصیلی " +  classStudentsPageId.period + " - " + " کلاس " + classStudentsPageId.class_name
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
                    text: " دانش‌آموزان کلاس "
                    font.family: "Kalameh"
                    font.pixelSize: 20
                    font.bold: true
                    color: "mediumvioletred"
                }

                Button
                {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight:  100
                    background: Item{}
                    display: AbstractButton.TextUnderIcon
                    icon.source: "qrc:/assets/images/evaluation.png"
                    icon.width: 32
                    icon.height: 32
                    icon.color:"transparent"
                    text: "صدور کارنامه"
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    opacity: 0.5
                    onClicked: classStudentsPageId.appStackView.push(classTranscriptsComponent);
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
                    id: classCoursesGV
                    model: ListModel{id: classStudentsModel;}
                    anchors.fill: parent
                    anchors.margins: 20
                    clip: true
                    flickableDirection: Flickable.AutoFlickDirection
                    cellWidth: 350
                    cellHeight: 350
                    interactive: false
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
                                    if(recdel.model["photo"] === "")
                                    {
                                        if(recdel.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                                    }
                                    else
                                    {
                                        return recdel.model.photo;
                                    }

                                }
                                Layout.preferredWidth: 150
                                Layout.preferredHeight: 150
                                Layout.alignment: Qt.AlignHCenter
                            }
                            Text {
                                text: recdel.model.name + " " + recdel.model.lastname
                                font.family: "Kalameh"
                                font.pixelSize: 18
                                font.bold: true
                                color: "white"
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                horizontalAlignment: Text.AlignHCenter
                            }
                            Text {
                                text: "نام پدر: " + recdel.model.fathername
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                font.bold: true
                                color: "white"
                                Layout.preferredWidth: parent.width
                                Layout.preferredHeight: 25
                                horizontalAlignment: Text.AlignHCenter
                            }
                            Text {
                                text: "تاریخ تولد:‌ " + recdel.model.birthday;
                                font.family: "Kalameh"
                                font.pixelSize: 14
                                font.bold: true
                                color: "white"
                                Layout.preferredWidth: parent.width
                                Layout.preferredHeight: 25
                                horizontalAlignment: Text.AlignHCenter
                            }

                            Item{Layout.preferredWidth: parent.width; Layout.fillHeight: true;}
                            Rectangle{
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                                color: "lightgray"
                                Row{
                                    anchors.fill: parent
                                    Button
                                    {
                                        height: 48
                                        width: 48
                                        background: Item{}
                                        icon.source: "qrc:/assets/images/course.png"
                                        icon.width: 48
                                        icon.height: 48
                                        icon.color:"transparent"
                                        opacity: 1
                                        onClicked:{
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
                                    Button
                                    {
                                        height: 48
                                        width: 48
                                        background: Item{}
                                        icon.source: "qrc:/assets/images/evaluation.png"
                                        icon.width: 48
                                        icon.height: 48
                                        icon.color:"transparent"
                                        opacity: 1
                                        onClicked:{
                                            var photo = recdel.model.photo;
                                            if(photo === "")
                                            {
                                                if(recdel.isFemale)
                                                    photo = "qrc:/assets/images/female.png";
                                                else
                                                    photo = "qrc:/assets/images/user.png";
                                            }
                                            classStudentsPageId.appStackView.push(studentResultComponent, {
                                                                                      student: recdel.model.name + " " + recdel.model.lastname,
                                                                                      student_id: recdel.model.id,
                                                                                      student_photo: photo
                                                                                  });
                                        }

                                    }
                                }
                            }
                        }

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: parent.color = "mediumvioletred";
                            onExited: parent.color = "slategray";
                            acceptedButtons: Qt.NoButton
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

    // student result
    Component{
        id: studentResultComponent
        StudentTranscriptSetting{
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

    // class result - class transcript
    Component{
        id: classTranscriptsComponent
        ClassTranscriptsSetting{
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
