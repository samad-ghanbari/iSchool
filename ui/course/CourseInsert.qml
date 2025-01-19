pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: insertPage

    signal popStackSignal();
    signal insertedSignal();

    required property int step_id;
    required property int base_id;
    required property int period_id;
    required property bool field_based;

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property string period;

    property var courseSharedCoef : []

    property var existsCourses : dbMan.getAllCoursesMinimised(insertPage.step_id, insertPage.base_id, insertPage.period_id);// id course_name array of objects

    background: Rectangle{anchors.fill: parent; color: "honeydew"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن درس جدید"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        Flickable{
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            contentHeight: centerBox.implicitHeight

            Rectangle
            {
                width: (parent.width > 700)? 700 : parent.width
                height:  centerBox.implicitHeight + 100
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"
                anchors.margins: 10

                Column{
                    id: centerBox
                    width : parent.width
                    anchors.margins: 10

                    Image
                    {
                        width: 64
                        height: 64
                        anchors.horizontalCenter: parent.horizontalCenter
                        source:  "qrc:/assets/images/course.png"
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }

                    //branch
                    Text {
                        width: parent.width
                        height: 50
                        text: "شعبه " + insertPage.branch + " - " + insertPage.step
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text {
                        text: (insertPage.field_based) ? "رشته " + insertPage.field + " - " +  insertPage.base :  insertPage.base
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text {
                        text: "سال تحصیلی " + insertPage.period
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }

                    // course name
                    RowLayout{
                        width: parent.width
                        height: 50
                        //Course name
                        Text {
                            text: "نام درس"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        TextField
                        {
                            id: courseNameTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "نام درس"
                        }
                    }
                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    // final weight
                    RowLayout{
                        width: parent.width
                        height: 50
                        //final weight
                        Text {
                            text: "وزن ارزیابی نهایی"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        TextField
                        {
                            id: finalWeightTF
                            Layout.fillWidth: true
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text : "2"
                            placeholderText: "وزن ارزیابی نهایی"
                            validator: RegularExpressionValidator{regularExpression:  /^-?\d*\.?\d+$/; }
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    // course coeff
                    RowLayout{
                        width: parent.width
                        height: 50
                        //Course coef
                        Text {
                            text: "ضریب درس"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        TextField
                        {
                            id: courseCoefTF
                            Layout.fillWidth: true
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "ضریب درس"
                            validator: RegularExpressionValidator{regularExpression: /^-?\d*\.?\d+$/ }
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }
                    // test Coeff
                    RowLayout{
                        width: parent.width
                        height: 50
                        //test coefficient
                        Text {
                            text: "ضریب تست"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        TextField
                        {
                            id: testCoefTF
                            Layout.fillWidth: true
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            placeholderText: "ضریب تست"
                            validator: RegularExpressionValidator{regularExpression: /^-?\d*\.?\d+$/ }
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }
                    // sort priority
                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "اولویت نمایش"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        SpinBox
                        {
                            id: sortSB
                            Layout.fillWidth: true
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            value: dbMan.getCourseMaxSort(insertPage.step_id, insertPage.base_id, insertPage.period_id) + 1;
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    Item{width: parent.width; height: 5;}
                    Rectangle{
                        width: parent.width
                        height: 1
                        color: "darkgray"
                    }

                    // course flag
                    Switch{
                        id: courseFlagSW
                        width: parent.width
                        height:  50
                        text: "واحد درسی"
                        checked: true
                        Layout.alignment: Qt.AlignLeft
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        onCheckedChanged: {
                            if(!checked){
                                if(!testFlagSW.checked)
                                    courseFlagSW.checked = true;
                            }
                        }
                    }
                    // test flag
                    Switch{
                        id: testFlagSW
                        width: parent.width
                        height:  50
                        text: "واحد تستی"
                        checked: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        onCheckedChanged: {
                            if(!checked){
                                if(!courseFlagSW.checked)
                                    testFlagSW.checked = true;
                            }
                        }
                    }

                    Rectangle{
                        width: parent.width
                        height: 1
                        color: "darkgray"
                    }
                    Item{width: parent.width; height: 5;}

                    // shared weight
                    RowLayout{
                        width: parent.width
                        height: 50
                        //final weight
                        Text {
                            text: "وزن اشتراکی "
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                        }
                        TextField
                        {
                            id: sharedWeightTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            Layout.maximumWidth: 150
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text : "1"
                            placeholderText: "وزن دروس اشتراکی "
                            validator: RegularExpressionValidator{regularExpression:  /^-?\d*\.?\d+$/; }
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    // shared
                    Text
                    {
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                        text:" دروس اشتراکی"
                    }
                    ListView
                    {
                        id: sharedCourseLV
                        width: parent.width
                        height: sharedCourseLV.contentHeight + 50
                        clip: true
                        model: ListModel{id: courseCoefModel;}
                        delegate:
                        Switch{
                            id: rec
                            required property var model
                            checked: (insertPage.courseSharedCoef.indexOf(rec.model.id) > -1)? true : false;
                            height: 50;
                            width: sharedCourseLV.width
                            text:  rec.model.course_name;
                            font.family: "Kalameh"
                            font.pixelSize: 14
                            onToggled:
                            {
                                var index = insertPage.courseSharedCoef.indexOf(model.id);

                                if(checked)
                                {
                                    //push step
                                    if(index < 0)
                                    insertPage.courseSharedCoef.push(model.id);
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
                            courseCoefModel.append(obj);
                        }
                    }

                    Item
                    {
                        width: parent.width
                        height: 10
                    }

                    Button
                    {
                        text: "تایید"
                        width: 200
                        height: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Kalameh"
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
                            course["shared_weight"] = parseFloat(sharedWeightTF.text)
                            course["sort_priority"] = sortSB.value
                            course["course_flag"] = courseFlagSW.checked
                            course["test_flag"] = testFlagSW.checked

                            course["shared_coefficient"] = {"ids":insertPage.courseSharedCoef}

                            if(dbMan.courseInsert(course))
                            {
                                insertPage.insertedSignal();
                                successDialogId.open();
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
                        width: parent.width
                        height: 10
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
}
