import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public"

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
    required property int step_id;


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
                    icon.source: "qrc:/assets/images/add.png"
                    icon.width: 32
                    icon.height: 32
                    icon.color:"transparent"
                    text: "دانش‌آموز جدید"
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    opacity: 0.5
                    onClicked: addStudentDialog.open();
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
                        border.color: "darkcyan"
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
                            Row{
                                Layout.preferredHeight: 50
                                Layout.preferredWidth: 100
                                Layout.alignment: Qt.AlignHCenter
                                Button
                                {
                                    width: 50
                                    height: 50
                                    background: Item{}
                                    icon.source: "qrc:/assets/images/trash.png"
                                    icon.width: 50
                                    icon.height: 50
                                    icon.color:"transparent"
                                    opacity: 0.5
                                    onClicked: {

                                        deleteStudentDialog.student_id = recdel.model.id
                                        deleteStudentDialog.student = recdel.model.name + " " + recdel.model.lastname
                                        deleteStudentDialog.class_name = classStudentsPageId.class_name
                                        deleteStudentDialog.open();
                                    }
                                    hoverEnabled: true
                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                }
                                Button
                                {
                                    width: 50
                                    height: 50
                                    background: Item{}
                                    icon.source: "qrc:/assets/images/change.png"
                                    icon.width: 50
                                    icon.height: 50
                                    icon.color:"transparent"
                                    opacity: 0.5
                                    onClicked: {
                                        changeStudentClassDialog.student_id = recdel.model.id
                                        changeStudentClassDialog.student = recdel.model.name + " " + recdel.model.lastname
                                        changeStudentClassDialog.class_name = classStudentsPageId.class_name
                                        changeStudentClassDialog.open();
                                    }
                                    hoverEnabled: true
                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                }
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
    }

    // add student
    Dialog{
        id: addStudentDialog

        closePolicy:Popup.NoAutoClose
        width: (parent.width > 500)? 500 : parent.width
        height: 300
        modal: true
        dim: true
        anchors.centerIn: parent;

        header: Rectangle{
            width: parent.width;
            height: 50;
            color: "royalblue";
            Text{ text: "افزودن دانش‌آموز به کلاس"; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "Kalameh"; font.pixelSize: 16}
        }

        contentItem:
            ColumnLayout{
            width: parent.width

            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "افزودن دانش‌آموز به کلاس " + classStudentsPageId.class_name
                font.family: "Kalameh"
                font.pixelSize: 14
                wrapMode: Text.WrapAnywhere
                color: "royalblue"
            }

            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                spacing: 0
                Text {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 50
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "فیلتر: "
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    wrapMode: Text.WrapAnywhere
                    color: "royalblue"
                }
                TextField
                {
                    id: filterTE
                    Layout.preferredHeight:  50
                    Layout.fillWidth: true
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    placeholderText: "بخشی از نام دانش‌آموز"
                }
                Button{
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    //background: Rectangle{color:"royalblue"}
                    display: AbstractButton.TextUnderIcon
                    icon.source: "qrc:/assets/images/search.png"
                    icon.width: 40
                    icon.height: 40
                    icon.color:"transparent"
                    opacity: 0.5
                    onClicked: {
                        var jsondata = dbMan.filterStudents(classStudentsPageId.step_id, filterTE.text);
                        studentModel.clear();
                        for(var obj of jsondata){
                            studentModel.append(obj);
                        }
                        studentCB.currentIndex = -1;
                    }
                    hoverEnabled: true
                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                }

            }

            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                spacing: 0
                Text {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 50
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "دانش‌آموز: "
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    wrapMode: Text.WrapAnywhere
                    color: "royalblue"
                }
                ComboBox
                {
                    id: studentCB
                    Layout.preferredHeight:  50
                    Layout.fillWidth: true
                    editable: true
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    model: ListModel{id: studentModel}
                    textRole: "text"
                    valueRole: "value"
                }

            }

            Item{Layout.fillHeight: true; Layout.preferredWidth: 1;}

        }

        footer:
            Item{
            width: parent.width;
            height: 50
            RowLayout
            {
                Button{
                    text: "انصراف"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    onClicked: addStudentDialog.close();
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
                }
                Button
                {
                    text: "تایید"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    onClicked: {}
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "royalblue"}
                }
                Item{Layout.fillWidth: true}
            }
        }
    }

    // delete student
    Dialog{
        id: deleteStudentDialog
        property int student_id
        property string student
        property string class_name

        closePolicy:Popup.NoAutoClose
        width: (parent.width > 500)? 500 : parent.width
        height: 300
        modal: true
        dim: true
        anchors.centerIn: parent;

        header: Rectangle{
            width: parent.width;
            height: 50;
            color: "crimson";
            Text{ text: "حذف دانش‌آموز از کلاس"; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "Kalameh"; font.pixelSize: 16}
        }

        contentItem:
            ColumnLayout
        {
            Text {
                Layout.preferredWidth: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: "آیا از حذف " + deleteStudentDialog.student + " از کلاس " + deleteStudentDialog.class_name + " اطمینان دارید؟"
                font.family: "Kalameh"
                font.pixelSize: 16
                wrapMode: Text.WrapAnywhere
                color: "black"
            }

            Text {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: 40
                horizontalAlignment: Text.AlignHCenter
                text: "تمامی نمرات ثبت شده دانس‌آموز در این کلاس حذف خواهند شد. "
                font.family: "Kalameh"
                font.pixelSize: 14
                wrapMode: Text.WrapAnywhere
                color: "crimson"
            }
            Item{Layout.fillHeight: true; Layout.preferredWidth: 1;}

        }

        footer:
            Item{
            width: parent.width;
            height: 50
            RowLayout
            {
                Button{
                    text: "انصراف"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    onClicked: deleteStudentDialog.close();
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
                }
                Button
                {
                    text: "تایید"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    onClicked: {

                        if(! dbman.deleteStudentRegistration(deleteStudentDialog.student_id, classStudentsPageId.class_id))
                        {
                            infoDialogId.open();
                        }
                        else{
                            var jsondata = dbMan.getClassStudentsArray(classStudentsPageId.class_id);
                            classStudentsModel.clear();
                            //id, step_id, name, lastname, fathername, gender, birthday, photo
                            for(var obj of jsondata)
                            {
                                classStudentsModel.append(obj);
                            }
                        }
                    }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                }
                Item{Layout.fillWidth: true}
            }
        }
    }

    // change
    // delete student
    Dialog{
        id: changeStudentClassDialog
        property int student_id
        property string student
        property string class_name

        closePolicy:Popup.NoAutoClose
        width: (parent.width > 500)? 500 : parent.width
        height: 250
        modal: true
        dim: true
        anchors.centerIn: parent;

        header: Rectangle{
            width: parent.width;
            height: 50;
            color: "olivedrab";
            Text{ text: "جابجایی کلاس دانش‌آموز"; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "Kalameh"; font.pixelSize: 16}
        }

        contentItem:
            ColumnLayout
        {
            Text {
                Layout.preferredWidth: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: "جابجایی کلاس " + changeStudentClassDialog.student + " از کلاس " + changeStudentClassDialog.class_name
                font.family: "Kalameh"
                font.pixelSize: 16
                wrapMode: Text.WrapAnywhere
                color: "black"
            }

            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Text {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 50
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "کلاس جدید "
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    wrapMode: Text.WrapAnywhere
                    color: "olivedrab"
                }
                ComboBox
                {
                    id: newClassCB
                    Layout.preferredHeight:  50
                    Layout.fillWidth: true
                    editable: false
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    model: ListModel{id: classModel}
                    textRole: "text"
                    valueRole: "value"
                    Component.onCompleted:
                    {
                        var jsondata = dbMan.getSimilarClasses(classStudentsPageId.class_id);
                        classModel.clear();
                        for(var obj of jsondata){
                            classModel.append(obj);
                        }

                        branchCB.currentIndex = -1

                    }

                }
            }


            Item{Layout.fillHeight: true; Layout.preferredWidth: 1;}

        }

        footer:
            Item{
            width: parent.width;
            height: 50
            RowLayout
            {
                Button{
                    text: "انصراف"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    onClicked: changeStudentClassDialog.close();
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
                }
                Button
                {
                    text: "تایید"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    onClicked: {

                        if(! dbMan.changeStudentClass(changeStudentClassDialog.student_id, classStudentsPageId.class_id, newClassCB.currentValue ))
                        {
                            infoDialogId.open();
                        }
                        else{
                            var jsondata = dbMan.getClassStudentsArray(classStudentsPageId.class_id);
                            classStudentsModel.clear();
                            //id, step_id, name, lastname, fathername, gender, birthday, photo
                            for(var obj of jsondata)
                            {
                                classStudentsModel.append(obj);
                            }

                            changeStudentClassDialog.close();
                        }
                    }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                }
                Item{Layout.fillWidth: true}
            }
        }
    }

    BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "انجام عملیات با خطا مواجه شد."
        dialogSuccess: false
    }
}
