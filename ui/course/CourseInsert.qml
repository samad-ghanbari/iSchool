pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Course.js" as Methods

Page {
    id: insertPage

    signal popStackSignal();
    signal insertedSignal();

    required property int branch_id;
    required property int step_id;
    required property int base_id;
    required property int period_id;

    required property string branch;
    required property string step;
    required property string base;
    required property string period;

    property var courseSharedCoef : []
    property var testSharedCoef : []

    property var existsCourses : dbMan.getAllCoursesMinimised(insertPage.step_id, insertPage.base_id, insertPage.period_id);// id course_name array of objects

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
            opacity: 0.5
            onClicked: insertPage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن درس جدید"
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
                width: (parent.width > 700)? 700 : parent.width
                implicitHeight : centerBox.implicitHeight + 40
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"

                GridLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20
                    columns: 2
                    Image
                    {
                        Layout.columnSpan: 2
                        Layout.preferredWidth: 128
                        Layout.preferredHeight: 128
                        Layout.alignment: Qt.AlignHCenter
                        source:  "qrc:/assets/images/course.png"
                    }

                    //branch
                    Text {
                        text: "شعبه"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text {
                        text: insertPage.branch
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }

                    //step
                    Text {
                        text: "دوره"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text {
                        text: insertPage.step
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }

                    //base
                    Text {
                        text: "پایه تحصیلی"
                        visible: (insertPage.base_id > 0)? true : false;
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text {
                        text:  insertPage.base
                        visible: (insertPage.base_id > 0)? true : false;
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }

                    //period
                    Text {
                        text: "سال تحصیلی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }

                    Text {
                        text:  insertPage.period
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }

                    //Course name
                    Text {
                        text: "نام درس"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    TextField
                    {
                        id: courseNameTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        placeholderText: "نام درس"

                    }
                    //class
                    Text {
                        text: "کلاس درس"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    ComboBox
                    {
                        id: classCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        editable: false
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        model: ListModel{id: classModel;}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted: Methods.updateClassCB(insertPage.branch_id);
                    }

                    // teacher
                    Text {
                        text: "مدرس"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    ComboBox
                    {
                        id: teacherCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        editable: false
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        model: ListModel{id: teacherModel;}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted: Methods.updateTeacherCB(insertPage.branch_id);
                    }

                    //final weight
                    Text {
                        text: "وزن ارزیابی نهایی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    TextField
                    {
                        id: finalWeightTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        placeholderText: "وزن ارزیابی نهایی"
                        validator: RegularExpressionValidator{regularExpression:  /^-?\d*\.?\d+$/; }
                    }

                    //Course coef
                    Text {
                        text: "ضریب درس"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    TextField
                    {
                        id: courseCoefTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        placeholderText: "ضریب درس"
                        validator: RegularExpressionValidator{regularExpression: /^[0-9]*$/; }
                    }

                    //test coefficient
                    Text {
                        text: "ضریب تست"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    TextField
                    {
                        id: testCoefTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        placeholderText: "ضریب تست"
                        validator: RegularExpressionValidator{regularExpression: /^[0-9]*$/; }
                    }

                    //course shared coefficient
                    Rectangle
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        color: "darkmagenta"
                        Text
                        {
                            anchors.centerIn: parent
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "white"
                            text:"ضریب مشترک دروس"
                        }
                    }
                    // get all course in this period
                    ListView
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        implicitHeight: 300
                        clip: true
                        model: ListModel{id: courseCoefModel;}
                        delegate:
                            Switch{
                                required property var model
                                checked: (insertPage.courseSharedCoef.indexOf(model.Id) > -1)? true : false;
                                height: 50;
                                width: parent.width
                                text:  model.Course_name
                                font.family: "B Yekan"
                                font.pixelSize: 14
                                onToggled:
                                {
                                    var index = insertPage.courseSharedCoef.indexOf(model.Id);

                                    if(checked)
                                    {
                                        //push step
                                        if(index < 0)
                                        insertPage.courseSharedCoef.push(model.Id);
                                    }
                                    else
                                    {
                                        if(index > -1)
                                        insertPage.courseSharedCoef.splice(index, 1);
                                    }
                                }
                            }

                        Component.onCompleted:{
                            for(var obj of insertPage.existsCourses)
                                    courseCoefModel.append({ Id: obj.id, Course_name: obj.course_name });
                        }
                    }

                    //test shared coefficient
                    Rectangle
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        color: "darkmagenta"
                        Text
                        {
                            anchors.centerIn: parent
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            color: "white"
                            text:"ضریب مشترک تست"
                        }
                    }

                    ListView
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        implicitHeight: 300
                        clip: true
                        model: ListModel{id: testCoefModel;}
                        delegate:
                            Switch{
                                required property var model
                                checked: (insertPage.testSharedCoef.indexOf(model.Id) > -1)? true : false;
                                height: 50;
                                width: parent.width
                                text:  model.Course_name
                                font.family: "B Yekan"
                                font.pixelSize: 14
                                onToggled:
                                {
                                    var index = insertPage.testSharedCoef.indexOf(model.Id);

                                    if(checked)
                                    {
                                        //push step
                                        if(index < 0)
                                        insertPage.testSharedCoef.push(model.Id);
                                    }
                                    else
                                    {
                                        if(index > -1)
                                        insertPage.testSharedCoef.splice(index, 1);
                                    }
                                }
                            }

                        Component.onCompleted:{
                            for(var obj of insertPage.existsCourses)
                                    testCoefModel.append({ Id: obj.id, Course_name: obj.course_name });
                        }
                    }

                    Item
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                    }

                    Button
                    {
                        Layout.columnSpan: 2
                        text: "تایید"
                        Layout.preferredWidth: 200
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                        onClicked:
                        {
                            var course = {};
                            course["step_id"] = insertPage.step_id
                            course["base_id"] = insertPage.base_id
                            course["period_id"] = insertPage.period_id

                            course["course_name"] = courseNameTF.text
                            course["course_coefficient"] = parseInt(courseCoefTF.text)
                            course["test_coefficient"] = parseInt(testCoefTF.text)
                            course["teacher_id"] = teacherCB.currentValue
                            course["class_id"] = classCB.currentValue
                            course["final_weight"] = parseFloat(finalWeightTF.text)

                            course["shared_coefficient"] = { "course": insertPage.courseSharedCoef, "test": insertPage.testSharedCoef };

                            if(dbMan.courseInsert(course))
                                successDialogId.open();
                            else
                            {
                                var errorString = dbMan.getLastError();
                                infoDialogId.dialogText = errorString
                                infoDialogId.width = parent.width
                                infoDialogId.height = 500
                                infoDialogId.open();
                            }
                        }
                    }

                    Item
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                    }



                }
            }
        }
    }

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن درس جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "درس جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            insertPage.popStackSignal();
            insertPage.insertedSignal();
        }

    }
}
