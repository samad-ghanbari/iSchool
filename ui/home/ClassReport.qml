import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts
import QtQuick.Dialogs

import "./../public" as DialogBox

Page {
    id: classReportPage

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;
    required property string class_name;
    required property int class_id;
    required property bool summer_semester;

    property string evalType : "per_month" // midterm semester period
    property int semester_number : 1

    property var allEvals: dbMan.getEvals(); // [{eval-1}, {eval-2}]


    signal popSignal();
    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    function updateRefModel(){

        refModel.clear();
        testRefModel.clear();
        var final_value = -1;

        if(semester_number == 0)
        {
            refModel.append({text: "میانگین نهایی اول/دوم", value: -500});
            refModel.append({text: "میانگین نیمسال اول/دوم", value: -612});
            refModel.append({text: "نیمسال اول", value: -601});
            refModel.append({text: "نیمسال دوم", value: -602});

            for( var obj of allEvals)
            {
                if(obj["test_flag"] === false)
                {
                    if( (obj["formative"] === true) || (obj["final_flag"] === true) )
                    {
                        if(obj["semester"] === 1)
                            refModel.append({text: "آزمون " + obj.eval_name +" نیمسال اول ", value: obj.id});
                        else if(obj["semester"] === 2)
                            refModel.append({text: "آزمون " + obj.eval_name +" نیمسال دوم ", value: obj.id});
                    }
                }
                else
                {
                    if(obj["semester"] === 1)
                        testRefModel.append({text: "آزمون " + obj.eval_name +" نیمسال اول ", value: obj.id});
                    else if(obj["semester"] === 2)
                        testRefModel.append({text: "آزمون " + obj.eval_name +" نیمسال دوم ", value: obj.id});
                }
            }

            compareRef.currentIndex = compareRef.indexOfValue(-500)
            if(testRefModel.count > 0)
                compareTestRef.currentIndex = 0;
        }
        else
        {
            if(evalType === "per_month")
            {
                for(obj of allEvals)
                {
                        if( (obj["per_month"] === true) && (obj["semester"] === semester_number) )
                        {
                            if(obj["test_flag"] === false)
                            {
                                if(obj["semester"] === 1)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                else if(obj["semester"] === 2)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});
                                else if(obj["semester"] === 3)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال تابستان ", value: obj.id});
                            }
                            else
                            {
                                if(obj["semester"] === 1)
                                    testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                else if(obj["semester"] === 2)
                                    testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});
                                else if(obj["semester"] === 3)
                                    testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال تابستان ", value: obj.id});
                            }
                        }

                }

                refModel.append({text: "میانگین ماهیانه", value: -12});
                compareRef.currentIndex = 0

                if(testRefModel.count > 0)
                    compareTestRef.currentIndex = 0;
            }
            else if(evalType === "midterm")
            {
                for(obj of allEvals)
                {
                    if(obj["semester"] === semester_number)
                    {
                        if( (obj["per_month"] === true) ||  (obj["midterm"] === true))
                        {
                            if(obj["test_flag"] === false)
                            {
                                if(obj["semester"] === 1)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                else if(obj["semester"] === 2)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});

                                if(final_value == -1)
                                    if((obj["midterm"] === true))
                                        final_value = obj["id"];
                            }
                            else
                            {
                                if(obj["semester"] === 1)
                                    testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                else if(obj["semester"] === 2)
                                    testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});
                            }
                        }
                    }
                }

                refModel.append({text: "میانگین ماهیانه", value: -12});
                compareRef.currentIndex = compareRef.indexOfValue(final_value);

                if(testRefModel.count > 0)
                    compareTestRef.currentIndex = 0;
            }
            else if(evalType === "semester")
            {
                final_value = -1;

                for(obj of allEvals)
                {
                    if(obj["semester"] === semester_number)
                    {
                        if( (obj["formative"] === true) ||  (obj["final_flag"] === true) ||  ( (obj["per_month"] === false) && (obj["midterm"] === false) ) )
                        {
                            if(obj["test_flag"] === false)
                            {
                                if(obj["semester"] === 1)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                else if(obj["semester"] === 2)
                                    refModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});

                                if(final_value == -1)
                                    if((obj["final_flag"] === true) && (obj["test_flag"] === false))
                                        final_value = obj["id"];
                            }
                            else
                            {
                                if(obj["semester"] === 1)
                                    testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال اول ", value: obj.id});
                                else if(obj["semester"] === 2)
                                    testRefModel.append({text: "آزمون " + obj.eval_name + " نیمسال دوم ", value: obj.id});
                            }

                        }
                    }
                }

                compareRef.currentIndex = compareRef.indexOfValue(final_value);

                if(testRefModel.count > 0)
                    compareTestRef.currentIndex = 0;
            }
        }
    }

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: classReportPage.branch + " - " + classReportPage.step
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
        }

        Row{
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignHCenter

            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: (classReportPage.field_based) ? classReportPage.field + " - " + " سال‌تحصیلی "  :  " سال‌تحصیلی "
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: classReportPage.period
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }

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
            text: "گزارش کلی دانش‌آموزان " + classReportPage.class_name
            font.family: "Kalameh"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
        }

        Flickable{
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentHeight: centerBox.height
            clip: true

            Rectangle{
                width: (parent.width > 700)? 700 : parent.width
                height: centerBox.height + 100
                anchors.horizontalCenter: parent.horizontalCenter
                color: "snow"

                AverageReportModule
                {
                    id: centerBox
                    width: parent.width
                    onPopSignal: classReportPage.popSignal();

                    class_base_report: "class"
                    branch: classReportPage.branch
                    step: classReportPage.step
                    field: classReportPage.field
                    base: classReportPage.base
                    field_based: classReportPage.field_based
                    period: classReportPage.period
                    semester_number: classReportPage.summer_semester

                    class_name: classReportPage.class_name
                    class_id: classReportPage.class_id
                }
            }
        }
    }



}
