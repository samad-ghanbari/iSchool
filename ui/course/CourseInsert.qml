pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

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
            icon.color:"transparent"
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
                        text : "2"
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
                        validator: RegularExpressionValidator{regularExpression: /^-?\d*\.?\d+$/ }
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
                        validator: RegularExpressionValidator{regularExpression: /^-?\d*\.?\d+$/ }
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
                        id: courseCoefLV
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: courseCoefLV.contentHeight + 100
                        clip: true
                        model: ListModel{id: courseCoefModel;}
                        delegate:
                        Switch{
                            required property var model
                            checked: (insertPage.courseSharedCoef.indexOf(model.Id) > -1)? true : false;
                            height: 50;
                            width: courseCoefLV.width
                            text:  model.Course_name;
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

                            courseCoefLV.height = courseCoefLV.contentHeight + 100
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
                        id: testCoefLV
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: testCoefLV.contentHeight + 100
                        clip: true
                        model: ListModel{id: testCoefModel;}
                        delegate:
                        Switch{
                            required property var model
                            checked: (insertPage.testSharedCoef.indexOf(model.Id) > -1)? true : false;
                            height: 50;
                            width: testCoefLV.width
                            text:  model.Course_name;
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

                            testCoefLV.height = testCoefLV.contentHeight + 100
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
                            course["course_coefficient"] = parseFloat(courseCoefTF.text)
                            course["test_coefficient"] = parseFloat(testCoefTF.text)
                            course["final_weight"] = parseFloat(finalWeightTF.text)

                            course["shared_coefficient"] = { "course": insertPage.courseSharedCoef, "test": insertPage.testSharedCoef };

                            if(dbMan.courseInsert(course))
                            {
                                // class_detail : class_id, course_id, teacher_id
                                var course_id = dbMan.getLastInsertedId();
                                // get teachers for each class
                                var classes = dbMan.getClassesBrief(insertPage.step_id, insertPage.base_id, insertPage.period_id );
                                //c.id, c.class_name, c.class_desc
                                var teachers = dbMan.getBranchTeachersBrief(insertPage.branch_id );
                                //t.id, t.teacher

                                insertPage.insertedSignal();

                                if( ( insertPage.base_id > -1) && (classes.length > 0) && (teachers.length > 0) )
                                {
                                    doneDialog.period = insertPage.period;
                                    doneDialog.base = insertPage.base;
                                    doneDialog.courseName = courseNameTF.text
                                    doneDialog.course_id = course_id;
                                    doneDialog.classes = classes;
                                    doneDialog.classTeacher = {}
                                    okBtn.enabled = false
                                    doneDialog.teachersModel.clear();
                                    for(var t of teachers)
                                    {
                                        doneDialog.teachersModel.append(t)
                                    }

                                    doneDialog.open();
                                }
                                else
                                {
                                    successDialogId.close();
                                    insertPage.popStackSignal();
                                }

                            }
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
        }

    }

    //get teacher id for each class
    Dialog
    {
        id: doneDialog
        property string period;
        property string base;
        property string courseName;
        property alias teachersModel : teacheCBModel;
        // id , teacher

        property var classes;
        //id, c.class_name, c.class_desc

        property var classTeacher : {} // class_id: teacher_id - supports only string key - have to convert to int
        property int course_id;

        closePolicy:Popup.NoAutoClose
        modal: true
        dim: true
        anchors.centerIn: parent;
        width: (parent.width > 500)? 500 : parent.width
        height: 500
        header: Rectangle{
            width: parent.width;
            height: 50;
            color: "mediumvioletred"
            Text{ text: "تعیین دبیر کلاس "; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "B Yekan"; font.pixelSize: 16}
        }

        ListModel{id: teacheCBModel;} // supports index=-1 and not selectable

        contentItem:
        ScrollView{
            id: dialogSV
            width: parent.width
            height: parent.height

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ColumnLayout
            {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: "سال‌تحصیلی " + doneDialog.period
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                    Layout.preferredWidth: dialogSV.width
                    Layout.preferredHeight: 50
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    text: "پایه تحصیلی: " + doneDialog.base
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                    Layout.preferredWidth: dialogSV.width
                    Layout.preferredHeight: 50
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    text: doneDialog.courseName
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                    Layout.preferredWidth: dialogSV.width
                    Layout.preferredHeight: 50
                    horizontalAlignment: Text.AlignHCenter
                }
                Flow
                {
                    spacing: 20
                    flow: Flow.TopToBottom
                    Layout.minimumHeight: classTeacherRp.count*50+20
                    Layout.fillWidth: true

                    Repeater
                    {
                        id: classTeacherRp
                        model: doneDialog.classes
                        delegate:Rectangle{
                            id: recDel
                            width : dialogSV.width;
                            height: 50;
                            required property var model
                            color: "transparent"

                            RowLayout{
                                anchors.fill: parent
                                spacing: 10
                                Text {
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "darkmagenta"
                                    Layout.preferredWidth: 150
                                    Layout.preferredHeight: 50
                                    horizontalAlignment: Text.AlignLeft
                                    verticalAlignment: Text.AlignVCenter
                                    text: "دبیر کلاس " + recDel.model.class_name
                                }
                                ComboBox
                                {
                                    Layout.preferredHeight:  50
                                    Layout.fillWidth: true
                                    Layout.alignment: Qt.AlignLeft
                                    editable: false
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    model: teacheCBModel
                                    textRole: "teacher"
                                    valueRole: "id"
                                    Component.onCompleted: currentIndex = -1;
                                    onActivated:{
                                        doneDialog.classTeacher[recDel.model.id] = currentValue;
                                        okBtn.enabled = (Object.keys(doneDialog.classes).length == Object.keys(doneDialog.classTeacher).length)? true : false;
                                    }
                                }
                            }
                        }
                    }
                }

                Item{Layout.preferredWidth: dialogSV.width; Layout.fillHeight: true;}
            }
        }
        footer:
        Item{
            width: parent.width;
            height: 50
            RowLayout
            {
                width: parent.width
                height: 50
                spacing: 10

                Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}

                Button{
                    text: "انصراف"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    onClicked: { doneDialog.close(); }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "red"}
                }
                Button
                {
                    id: okBtn
                    text: "تایید"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    enabled: false;

                    onClicked:
                    {
                        if(dbMan.classDetailsInsert(doneDialog.classTeacher, doneDialog.course_id))
                        {
                            successDialogId.dialogText = "درس جدید با موفقیت افزوده شد و \n به کلاس‌های موجود اضافه گردید."
                            successDialogId.open();
                        }
                        else
                        {
                            successDialogId.dialogText = "درس جدید با موفقیت افزوده شد."
                            successDialogId.open();
                        }

                        doneDialog.close();
                    }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                }
            }
        }

    }


}
