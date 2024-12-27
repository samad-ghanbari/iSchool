pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: updatePage

    signal popStackSignal();
    signal updatedSignal();

    required property int course_id;

    required property int branch_id;
    required property int base_id;
    required property int step_id;
    required property int period_id;
    required property real course_coefficient
    required property real test_coefficient
    required property var shared_coefficient
    required property real final_weight;


    required property string branch;
    required property string step;
    required property string base;
    required property string period;
    required property string course_name;

    property var courseSharedCoef : shared_coefficient["course"]
    property var testSharedCoef : shared_coefficient["test"]

    property var existsCourses : dbMan.getAllCoursesMinimised(updatePage.step_id, updatePage.base_id, updatePage.period_id, updatePage.course_id );// id course_name array of objects


    background: Rectangle{anchors.fill: parent; color: "mintcream"}


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
            onClicked: updatePage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ویرایش درس"
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
                        text: updatePage.branch
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
                        text: updatePage.step
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
                        visible: (updatePage.base_id > 0)? true : false;
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
                        text:  updatePage.base
                        visible: (updatePage.base_id > 0)? true : false;
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
                        text:  updatePage.period
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
                        text: updatePage.course_name

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
                        text: updatePage.final_weight
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
                        text: updatePage.course_coefficient
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
                        text: updatePage.test_coefficient
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
                            checked: (updatePage.courseSharedCoef.indexOf(model.Id) > -1)? true : false;
                            height: 50;
                            width: courseCoefLV.width
                            text:  model.Course_name;
                            font.family: "B Yekan"
                            font.pixelSize: 14
                            onToggled:
                            {
                                var index = updatePage.courseSharedCoef.indexOf(model.Id);

                                if(checked)
                                {
                                    //push step
                                    if(index < 0)
                                    updatePage.courseSharedCoef.push(model.Id);
                                }
                                else
                                {
                                    if(index > -1)
                                    updatePage.courseSharedCoef.splice(index, 1);
                                }
                            }

                        }

                        Component.onCompleted:{

                            for(var obj of updatePage.existsCourses)
                            {
                                courseCoefModel.append({ Id: obj.id, Course_name: obj.course_name});
                                courseCoefLV.height = courseCoefLV.contentHeight + 100
                            }
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
                            checked: (updatePage.testSharedCoef.indexOf(model.Id) > -1)? true : false;
                            height: 50;
                            width: testCoefLV.width
                            text:  model.Course_name;
                            font.family: "B Yekan"
                            font.pixelSize: 14
                            onToggled:
                            {
                                var index = updatePage.testSharedCoef.indexOf(model.Id);

                                if(checked)
                                {
                                    //push step
                                    if(index < 0)
                                    updatePage.testSharedCoef.push(model.Id);
                                }
                                else
                                {
                                    if(index > -1)
                                    updatePage.testSharedCoef.splice(index, 1);
                                }
                            }
                        }

                        Component.onCompleted:{

                            for(var obj of updatePage.existsCourses)
                            {
                                testCoefModel.append({ Id: obj.id, Course_name: obj.course_name });
                                testCoefLV.height = testCoefLV.contentHeight + 100
                            }
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

                            course["id"] = updatePage.course_id;
                            course["course_name"] = courseNameTF.text
                            course["course_coefficient"] = parseFloat(courseCoefTF.text)
                            course["test_coefficient"] = parseFloat(testCoefTF.text)
                            course["final_weight"] = parseFloat(finalWeightTF.text)

                            course["shared_coefficient"] = { "course": updatePage.courseSharedCoef, "test": updatePage.testSharedCoef };

                            if(dbMan.courseUpdate(course))
                            {
                                successDialogId.close();
                                updatePage.popStackSignal();
                                updatePage.updatedSignal();
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
            updatePage.updatedSignal();
        }

    }
}
