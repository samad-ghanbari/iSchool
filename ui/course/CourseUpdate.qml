pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: updatePage

    signal popStackSignal();
    signal updatedSignal();

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property string period;
    required property bool field_based

    required property int course_id;
    required property int step_id;
    required property int base_id;
    required property int period_id;

    required property string course_name;
    required property real final_weight;
    required property real course_coefficient;
    required property real test_coefficient;
    required property var shared_coefficient;
    required property int sort_priority;
    required property bool course_flag;
    required property bool test_flag;
    required property real shared_weight;



    property var courseSharedArray : updatePage.shared_coefficient["ids"]

    property var existsCourses : dbMan.getAllCoursesMinimised(updatePage.step_id, updatePage.base_id, updatePage.period_id, updatePage.course_id);

    background: Rectangle{anchors.fill: parent; color: "honeydew"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ویرایش درس"
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
                        source:  "qrc:/assets/images/edit.png"
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }

                    //branch
                    Text {
                        width: parent.width
                        height: 50
                        text: "شعبه " + updatePage.branch + " - " + updatePage.step
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text {
                        text: (updatePage.field_based) ? "رشته " + updatePage.field + " - " +  updatePage.base :  updatePage.base
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
                        text: "سال تحصیلی " + updatePage.period
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
                            text: updatePage.course_name
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
                            text :  updatePage.final_weight
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
                            text: updatePage.course_coefficient
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
                            text: updatePage.test_coefficient
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
                            value: updatePage.sort_priority
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
                        checked: updatePage.course_flag
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
                        checked: updatePage.test_flag
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
                            text : updatePage.shared_weight
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
                            checked: (updatePage.courseSharedArray.indexOf(rec.model.id) > -1)? true : false;
                            height: 50;
                            width: sharedCourseLV.width
                            text:  rec.model.course_name;
                            font.family: "Kalameh"
                            font.pixelSize: 14
                            onToggled:
                            {
                                var index = updatePage.courseSharedArray.indexOf(model.id);

                                if(checked)
                                {
                                    //push step
                                    if(index < 0)
                                    updatePage.courseSharedArray.push(model.id);
                                }
                                else
                                {
                                    if(index > -1)
                                    updatePage.courseSharedArray.splice(index, 1);
                                }
                            }
                        }

                        Component.onCompleted:{
                            for(var obj of updatePage.existsCourses)
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
                            course["id"] = updatePage.course_id;
                            course["course_name"] = courseNameTF.text
                            course["course_coefficient"] = parseFloat(courseCoefTF.text)
                            course["test_coefficient"] = parseFloat(testCoefTF.text)
                            course["final_weight"] = parseFloat(finalWeightTF.text)
                            course["shared_weight"] = parseFloat(sharedWeightTF.text)
                            course["sort_priority"] = sortSB.value
                            course["course_flag"] = courseFlagSW.checked
                            course["test_flag"] = testFlagSW.checked

                            course["shared_coefficient"] = {"ids":updatePage.courseSharedArray}

                            if(dbMan.courseUpdate(course))
                            {
                                updatePage.updatedSignal();
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
        dialogText: "ویرایش درس با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ویرایش درس با موفقیت انجام شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            updatePage.popStackSignal();
        }

    }
}
