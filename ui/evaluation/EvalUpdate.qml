pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Evals.js" as Methods

Page {
    id: updatePage

    required property string branch
    required property string step
    required property string base
    required property string period

    required property int    step_id;
    required property int    base_id;
    required property int    period_id;

    required property string eval_cat;
    required property int    course_id
    required property int    class_id
    required property int eval_id;
    required property string eval_time;
    required property double max_grade;
    required property bool test_flag;
    required property bool final_flag;
    required property bool included;


    signal popStackSignal();
    signal updatedSignal();


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
            text: "ویرایش ارزیابی"
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
                        source:  "qrc:/assets/images/evaluation.png"
                    }

                    // branch
                    Text {
                        text: "شعبه" + " " + updatePage.branch
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }

                    //step
                    Text {
                        text: {
                            if(updatePage.base.indexOf("پایه") == -1)
                            return updatePage.step + " - پایه " + updatePage.base;
                            else
                            return updatePage.step + " - " + updatePage.base;
                        }
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }


                    //period
                    Text {
                        text: "سال تحصیلی" + " " + updatePage.period
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }


                    Text {
                        text: "عنوان درس"
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
                    ComboBox
                    {
                        id: courseCB
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        model:ListModel { id: courseCBoxModel; }
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted:{
                            Methods.updateCourseCB(updatePage.step_id, updatePage.base_id, updatePage.period_id);
                            courseCB.currentIndex = courseCB.indexOfValue(updatePage.course_id)
                        }
                    }

                    //class
                    Text {
                        text: "کلاس"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                        visible: (updatePage.base_id > -1)? true : false;
                    }
                    ComboBox
                    {
                        id: classCB
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        model:ListModel { id: classCBoxModel; }
                        textRole: "text"
                        valueRole: "value"
                        visible: (updatePage.base_id > -1)? true : false;
                        Component.onCompleted:{
                            Methods.updateClassCB(updatePage.course_id);
                            classCB.currentIndex = classCB.indexOfValue(updatePage.class_id)
                        }
                    }


                    //eval time
                    Text {
                        text: "زمان ارزیابی"
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
                    TextField
                    {
                        id: evaltimeTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        placeholderText: "1403/08/10"
                        validator: RegularExpressionValidator
                        {
                            regularExpression: /^\d{4}\/\d{2}\/\d{2}$/
                            // Regex pattern to match date in yyyy/MM/dd format
                        }
                        text: updatePage.eval_time
                    }

                    //max grade
                    Text {
                        text: "بالاترین نمره"
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
                    TextField
                    {
                        id: maxGradeTF
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        placeholderText: "مقدار عددی مانند ۲۰"
                        validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                            regularExpression: /^-?\d*\.?\d+$/
                        }
                        text: updatePage.max_grade
                    }



                    //report included
                    Text {
                        text: "تاثیر در ارزیابی"
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
                    Switch
                    {
                        id: includedSW
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignLeft
                        checked: updatePage.included

                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                    }

                    Button
                    {
                        text: "تایید"
                        Layout.columnSpan: 2
                        Layout.preferredWidth: 200
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                        onClicked:
                        {

                            var Eval = {};
                            Eval["id"] = updatePage.eval_id;
                            Eval["course_id"] =courseCB.currentValue
                            if(updatePage.base_id > -1)
                            Eval["class_id"] = classCB.currentValue
                            else
                            Eval["class_id"] = -1;
                            Eval["eval_time"] = evaltimeTF.text
                            Eval["max_grade"] = parseFloat(maxGradeTF.text)
                            Eval["included"] = includedSW.checked


                            if(dbMan.evalUpdate(Eval))
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
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
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
        dialogText: "ویرایش ارزیابی با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ویرایس ارزیابی با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            updatePage.popStackSignal();
            updatePage.updatedSignal();
        }

    }
}
