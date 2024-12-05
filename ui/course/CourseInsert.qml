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
                        id: courseCoefLV
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
                        implicitHeight: 300
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
                            // get teachers for each class
                            var classes = dbMan.getClasses(insertPage.step_id, insertPage.base_id, insertPage.period_id  );
                            //c.id, c.step_id, c.study_base_id, c.study_period_id, c.class_name, c.class_desc, c.sort_priority, st.step_name, sb.study_base, sp.study_period
                            var teachers = dbMan.getBranchTeachers(insertPage.branch_id );
                            //t.id, t.branch_id, t.name, t.lastname, t.gender, t.study_degree, t.study_field, t.telephone, t.enabled, b.city, b.branch_name

                            var classModel = [];
                            var teacherModel = [];
                            for(var obj of classes)
                            {
                                classModel.append({value: obj.id, text: obj.class_name});
                            }
                            for(var obj of teachers)
                            {
                                teacherModel.append({value: obj.id, text: obj.name+" " +obj.lastname});
                            }

                            var course = {};
                            course["step_id"] = insertPage.step_id
                            course["base_id"] = insertPage.base_id
                            course["period_id"] = insertPage.period_id

                            course["course_name"] = courseNameTF.text
                            course["course_coefficient"] = parseInt(courseCoefTF.text)
                            course["test_coefficient"] = parseInt(testCoefTF.text)
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

    //get teacher id for each class
    Dialog
    {
        id: doneDialog
        required property var eval;
        required property var teacherModel;
        required property var classModel;
        required property string courseName;

        closePolicy:Popup.NoAutoClose
        modal: true
        dim: true
        anchors.centerIn: parent;
        width: (parent.width > 500)? 500 : parent.width
        height: 400
        title: "نرمالایز کردن نمرات"
        header: Rectangle{
            width: parent.width;
            height: 50;
            color: "mediumvioletred"
            Text{ text: "نرمالایز کردن نمرات"; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "B Yekan"; font.pixelSize: 16}
        }

        contentItem:
        ColumnLayout
        {
            width: parent.width
            height: 300

            Image {
                source:"qrc:/assets/images/normalised.png"
                Layout.preferredWidth: 100
                Layout.preferredHeight: 100
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "آزمون " + normalisedDialog.courseName + " (" + normalisedDialog.periodName + ") "
                font.family: "B Yekan"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: 50
                horizontalAlignment: Text.AlignHCenter
            }
            RowLayout
            {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                spacing: 5

                Text
                {
                    Layout.preferredWidth: 150
                    Layout.preferredHeight: 50
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    color: "black"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    text: "نمره مبنا جهت نرمالایز "
                    elide: Text.ElideLeft
                }
                TextField
                {
                    id: normaliseGradeTF
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    color: "black"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    placeholderText: "بزرگترین مقدار معتبر " + normalisedDialog.maxGrade
                    validator: RegularExpressionValidator{regularExpression: /^-?\d*\.?\d+$/ }
                }
            }


            Item{Layout.preferredWidth: parent.width; Layout.fillHeight: true;}
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

                Button{
                    text: "حذف نمودار"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    onClicked: {

                        if(dbMan.studentEvalDenormalise(normalisedDialog.eval_id))
                        {
                            normaliseGradeTF.text = "";
                            normalisedDialog.close();
                            infoDialogId.dialogSuccess = true;
                            infoDialogId.dialogTitle = "عملیات موفق";
                            infoDialogId.dialogText = "نمرات دانش‌آموزان از نمودار خارج گردید.";
                            infoDialogId.open();
                            Methods.updateClassStudentsEval(evalStudentsPage.class_id, evalStudentsPage.eval_id );
                        }
                        else
                        {
                            normaliseGradeTF.text = "";
                            normalisedDialog.close();
                            infoDialogId.dialogSuccess = false;
                            infoDialogId.dialogTitle = "خطا";
                            infoDialogId.dialogText = "عملیات با خطا مواجه شد.";
                            infoDialogId.open();
                        }
                    }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "red"}
                }

                Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}

                Button{
                    text: "انصراف"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    onClicked: { normaliseGradeTF.text = ""; normalisedDialog.close(); }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "orange"}
                }
                Button
                {
                    text: "تایید"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    onClicked:
                    {
                        var norm = normaliseGradeTF.text
                        norm = parseFloat(norm);
                        if(normaliseGradeTF.text == "")
                        norm = -1;

                        if(norm > normalisedDialog.maxGrade)
                        {
                            infoDialogId.dialogText = "مقدار وارد شده از سقف نمره ارزیابی بزرگتر است.";
                            infoDialogId.open();
                            return;
                        }

                        // normalise
                        if(dbMan.studentEvalNormalise(normalisedDialog.eval_id, norm))
                        {
                            normaliseGradeTF.text = "";
                            normalisedDialog.close();
                            infoDialogId.dialogSuccess = true;
                            infoDialogId.dialogTitle = "عملیات موفق";
                            infoDialogId.dialogText = "نمرات دانش‌آموزان نرمالایز گردید.";
                            infoDialogId.open();
                            Methods.updateClassStudentsEval(evalStudentsPage.class_id, evalStudentsPage.eval_id );
                        }
                        else
                        {
                            normaliseGradeTF.text = "";
                            normalisedDialog.close();
                            infoDialogId.dialogSuccess = false;
                            infoDialogId.dialogTitle = "خطا";
                            infoDialogId.dialogText = "عملیات با خطا مواجه شد.";
                            infoDialogId.open();
                        }

                    }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                }
            }
        }

    }


}
