pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


// drawer - student stat
Drawer
{
    id:studentStatDrawer
    modal: true
    height: parent.height
    width:  parent.width;
    dragMargin: 0
    edge: Qt.RightEdge

    property int step_id;
    property int base_id;
    property int period_id;
    property int register_id;
    property string student;
    property string photo;
    property string baseClass;
    property string period;
    property var evalCats: []
    property var evalCatsList : dbMan.getEvalCatsBrief(step_id, base_id, period_id);

    property var courseHeaders : []
    property var courseRows : []
    property var testHeaders:[] // {title, width}
    property var testRows:[]
    property var courseTotal : {}
    property var testTotal: {}

    function drawerInit()
    {
        evalCats = [];
        evalCatModel.clear();

        for(var obj of studentStatDrawer.evalCatsList)
        {
            evalCats.push(obj.id)
            evalCatModel.append(obj);
        }


        statCalculation();

    }

    function statCalculation()
    {
        var stat = dbMan.getStudentStat(studentStatDrawer.register_id, studentStatDrawer.evalCats);
        /*
            {
                 course:{rows:[], headers:[], width:[] },
                 test:  {rows:[], headers:[], width:[] },
                 total:{}
             }

            course > rows : [  {course1_stat} , {}, {}, ]
            {
               course_id, row_number, course_name, coefficient, shared_coefficient, final_weight, teacher
               evals:[{cat_id, category,test, final, avg, navg },{}], eval_count, semester, class_rank, base_rank
               class_avg, base_avg,  class_min, class_max, base_min, base_max
            }

            total:
            {   course:{total_stat}  , test:{total_stat}   }

            total_stat:
            {
              shared_string, coefficient, evals, semester
            }

             */

        courseHeaders = stat["course"]["headers"];
        courseRows = stat["course"]["rows"];

        testHeaders = stat["test"]["headers"];
        testRows = stat["test"]["rows"];

        courseTotal = stat["total"]["course"];
        testTotal = stat["total"]["test"];

        courseTotalRp.model = courseTotal["evals"];
        courseTotalCoeffLbl.text = "مجموع ضرایب" + "\n" + studentStatDrawer.courseTotal["coefficient"]
        if(studentStatDrawer.courseTotal["semester"] > -1)
            courseTotalSemesterLbl.text = "معدل نیمسال" + "\n" + studentStatDrawer.courseTotal["semester"]
        else
            courseTotalSemesterLbl.text = "-";
        courseTotalStudentCount.text = "نعداد دانش‌آموزان کلاس " + "\n" + stat["total"]["class_member_count"]

        studentCourseStatLV.model = courseRows
        studentTestStatLV.model = testRows

        testTotalRp.model = testTotal["evals"];
        testTotalCoeffLbl.text = "مجموع ضرایب" + "\n" + studentStatDrawer.testTotal["coefficient"]
        testTotalStudentCount.text = "نعداد دانش‌آموزان کلاس " + "\n" + stat["total"]["class_member_count"]

        //shared coeff list
        sharedCourseRp.model = courseTotal["shared_string"];
        sharedListCol.visible = (courseTotal["shared_string"].length > 0)? true : false;

        // test shared
        sharedTestRp.model = testTotal["shared_string"];
        sharedtestListCol.visible = (testTotal["shared_string"].length > 0)? true : false;


        // stat {course , test, total}
        if( (studentStatDrawer.courseRows.length == 0) && (studentStatDrawer.testRows.length == 0) )
            emptyStudentStatText.visible = true
        else
            emptyStudentStatText.visible = false
    }

    function getBgColor(value, test=false)
    {
        if(parseFloat(value) > -1)
        {
            if(test)
            {
                value = value.replace("%", "");
                if(value >= 50 || value==="")
                    return "transparent";
                if(value < 50 && value >= 40)
                    return "mistyrose"
                if(value < 40 && value >= 20)
                    return "pink";
                if(value < 20)
                    return "salmon";
            }
            else
            {
                if(value >= 15 || value==="")
                    return "transparent";
                if(value < 15 && value >= 12)
                    return "mistyrose"
                if(value < 12 && value >= 10)
                    return "pink";
                if(value < 10)
                    return "salmon";
            }
        }
        else return "transparent";
    }

    GridLayout
    {
        columns: 3
        anchors.fill: parent

        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            Layout.alignment: Qt.AlignLeft
            background: Item{}
            icon.source: "qrc:/assets/images/arrow-right.png"
            icon.width: 64
            icon.height: 64
            icon.color:"transparent"
            opacity: 0.5
            onClicked: studentStatDrawer.close();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            textFormat: Text.RichText
            text: "ارزیابی دانش‌آموز"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Item{
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
            Image{
                width: 80
                height: 80
                anchors.centerIn: parent
                source: {
                    if(studentStatDrawer.photo == "")
                    {
                        return "qrc:/assets/images/stat.png";
                    }
                    else
                    {
                        return studentStatDrawer.photo;
                    }
                }
            }
        }
        Text{
            Layout.preferredHeight: 100
            Layout.preferredWidth: 400
            text: studentStatDrawer.student
            font.bold: true
            font.family: "B Yekan"
            font.pixelSize: 20
            color: "darkmagenta"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        Column
        {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            Text{
                width: parent.width;
                height: 50
                text: studentStatDrawer.baseClass
                font.bold: true
                font.family: "B Yekan"
                font.pixelSize: 20
                color: "royalblue"
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }
            Text{
                width: parent.width;
                height: 50
                text: studentStatDrawer.period
                font.bold: true
                font.family: "B Yekan"
                font.pixelSize: 20
                color: "royalblue"
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }
        }


        Rectangle{
            Layout.columnSpan: 3
            Layout.fillWidth: true
            Layout.preferredHeight: 2
            color: "dodgerblue"
            Layout.margins: 20
        }

        Text{
            id: emptyStudentStatText
            Layout.fillWidth: true
            Layout.columnSpan: 3
            Layout.preferredHeight: 50
            text: "نمرات دانش‌آموز به صورت کامل وارد نشده است."
            font.bold: true
            font.family: "B Yekan"
            font.pixelSize: 16
            color: "dodgerblue"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.columnSpan: 3
            visible: emptyStudentStatText.visible
        }

        Column{
            Layout.columnSpan: 1
            Layout.preferredWidth: 200
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignLeft
            visible: !emptyStudentStatText.visible
            Layout.topMargin: 10
            Layout.leftMargin: 5
            Label{
                //background:Rectangle{color: "lavender"}
                font.bold: true
                font.family: "B Yekan"
                font.pixelSize: 16
                color: "black"
                text: "انتخاب دسته ارزیابی"
                height: 50
                width: parent.width
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }
            Rectangle{width: parent.width; height: 2; color: "slategray";}
            Rectangle
            {
                width: parent.width
                height: parent.height
                color: "snow"

                ListView
                {
                    id: evalCatLV
                    anchors.fill: parent
                    height: evalCatLV.contentHeight + 100
                    clip: true
                    model: ListModel{id: evalCatModel;}
                    delegate:
                    Switch{
                        required property var model
                        checked: (studentStatDrawer.evalCats.indexOf(model.id) > -1)? true : false;
                        height: 50;
                        width: evalCatLV.width
                        text:  model.eval_cat;
                        font.family: "B Yekan"
                        font.pixelSize: 14
                        onToggled:
                        {
                            var index = studentStatDrawer.evalCats.indexOf(model.id);

                            if(checked)
                            {
                                //push
                                if(index < 0)
                                studentStatDrawer.evalCats.push(model.id);
                            }
                            else
                            {
                                if( index > -1 && (studentStatDrawer.evalCats.length > 1) )
                                studentStatDrawer.evalCats.splice(index, 1);
                                else
                                this.checked = true
                            }


                            studentStatDrawer.statCalculation();

                        }
                    }

                }
            }
        }
        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: !emptyStudentStatText.visible
            ScrollView{
                anchors.fill: parent
                Column
                {
                    id: mainBox
                    // course stat
                    // total : {shared_string, coefficient, evals, semester}
                    // total_evals : [{cat_id, category, test, final, avg}, {}, {} ]
                    width: parent.width

                    RowLayout{
                        width: parent.width;
                        height: 100
                        visible: (headerRepeater.count > 0)? true : false

                        Label{
                            id: courseTotalSemesterLbl
                            Layout.fillWidth: true
                            Layout.preferredHeight: 100
                            background:Rectangle{color: "darkmagenta";}
                            color:"white"
                            font.bold: true
                            font.family: "B Yekan"
                            font.pixelSize: 18
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                            text: ""
                        }
                        Label{
                            id: courseTotalCoeffLbl
                            Layout.preferredWidth: 200
                            Layout.preferredHeight: 100
                            background:Rectangle{color: "whitesmoke"; border.width:1; border.color:"hotpink"}
                            color:"black"
                            font.bold: true
                            font.family: "B Yekan"
                            font.pixelSize: 18
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                            text: ""
                        }
                        Label{
                            id: courseTotalStudentCount
                            Layout.preferredWidth: 250
                            Layout.preferredHeight: 100
                            background:Rectangle{color: "whitesmoke"; border.width:1; border.color:"hotpink"}
                            color:"black"
                            font.bold: true
                            font.family: "B Yekan"
                            font.pixelSize: 18
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                            text: ""
                        }
                        Repeater
                        {
                            id: courseTotalRp
                            delegate:Label{
                                required property var model;
                                Layout.preferredWidth: 200
                                Layout.preferredHeight: 100
                                background:Rectangle{color: "whitesmoke"; border.width:1; border.color:"hotpink"}
                                color:"black"
                                font.bold: true
                                font.family: "B Yekan"
                                font.pixelSize: 18
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                                text: (Object.keys(model).length > 0)?  "معدل " + model["category"] + "\n" + model["avg"] : ""
                            }
                        }
                    }

                    Item{width: parent.width; height: 20;}

                    // course stat
                    //header row
                    Rectangle{
                        width: mainBox.width
                        height: 80
                        color: "darkslategray"
                        visible: (headerRepeater.count > 0)? true : false
                        RowLayout{
                            anchors.fill: parent
                            spacing: 2
                            anchors.margins: 5
                            // row-course-teacher-coeff-evals-semester-rank-avg-min-max
                            Repeater{
                                id: headerRepeater
                                model: studentStatDrawer.courseHeaders
                                delegate:Label{
                                    id: hdel
                                    required property var model;
                                    Layout.preferredWidth: (typeof hdel.model["width"] != "undefined")? hdel.model["width"] : 0
                                    Layout.preferredHeight: 80
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    color: "white"
                                    //background:Rectangle{color: "darkslategray"}
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text:(typeof hdel.model["title"] == "undefined")? "" :  hdel.model["title"];
                                }
                            }
                        }
                    }

                    ListView{
                        id: studentCourseStatLV
                        width: mainBox.width
                        interactive: true
                        height: 500
                        flickableDirection: Flickable.AutoFlickDirection
                        clip: true
                        spacing: 5
                        visible : (studentStatDrawer.courseRows.length > 0)? true : false;
                        highlight:Item{}
                        delegate:Rectangle{
                            id: recdel
                            required property var model;
                            width: studentCourseStatLV.width
                            height: 70
                            color: (recdel.model.index % 2 == 0)? "snow" : "floralwhite"

                            RowLayout{
                                anchors.fill: parent;
                                spacing: 2

                                // row_number-course-teacher-coeff-evals-semester-rank-avg-min-max
                                // item 0
                                Label{
                                    Layout.preferredWidth: (typeof studentStatDrawer.courseHeaders[0]  != "undefined")? studentStatDrawer.courseHeaders[0]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text: (typeof recdel.model["row_number"] != "undefined")? recdel.model["row_number"] : ""
                                }
                                // item 1
                                Label{
                                    Layout.preferredWidth:(typeof studentStatDrawer.courseHeaders[1]  != "undefined")?  studentStatDrawer.courseHeaders[1]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text: (typeof recdel.model["course_name"] != "undefined")?  recdel.model["course_name"] : ""
                                }
                                // item 2
                                Label{
                                    Layout.preferredWidth: (typeof studentStatDrawer.courseHeaders[2]  != "undefined")?  studentStatDrawer.courseHeaders[2]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text: (typeof recdel.model["teacher"] != "undefined")? recdel.model["teacher"] : ""
                                }
                                // item 3
                                Label{
                                    Layout.preferredWidth:(typeof studentStatDrawer.courseHeaders[3]  != "undefined")?  studentStatDrawer.courseHeaders[3]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text: (typeof recdel.model["coefficient"] != "undefined")? recdel.model["coefficient"] : ""
                                }
                                // item 4
                                //evals
                                Repeater{
                                    id: courseRowRp
                                    model:recdel.model["evals"]
                                    delegate:Label{
                                        id: rpDel
                                        required property var model;
                                        Layout.preferredWidth: (typeof studentStatDrawer.courseHeaders[4+model.index]  != "undefined")?  studentStatDrawer.courseHeaders[4+model.index]["width"] : 0
                                        Layout.preferredHeight: 70
                                        Layout.margins: 0
                                        color:"black"
                                        background: Rectangle{color: studentStatDrawer.getBgColor(rpDel.text);}
                                        font.bold: true
                                        font.family: "B Yekan"
                                        font.pixelSize: 16
                                        horizontalAlignment: Label.AlignHCenter
                                        verticalAlignment: Label.AlignVCenter
                                        text:{
                                            if(typeof rpDel.model["navg"] != "undefined")
                                            {
                                                if(parseFloat(rpDel.model["navg"]) > -1)
                                                return "  "+rpDel.model["navg"];
                                                else return "-";
                                            }
                                            else return "-";
                                        }
                                    }
                                }
                                Label{
                                    id: courseSemesterLbl
                                    Layout.preferredWidth:(typeof studentStatDrawer.courseHeaders[3+courseRowRp.count + 1]  != "undefined")?  studentStatDrawer.courseHeaders[3+courseRowRp.count + 1]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"midnightblue"
                                    font.bold: true
                                    background: Rectangle{color: studentStatDrawer.getBgColor(courseSemesterLbl.text);}
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text: {
                                        if(typeof recdel.model["semester"] != "undefined")
                                        {
                                            if(parseFloat(recdel.model["semester"]) > -1){
                                                return "  "+recdel.model["semester"];
                                            }else return "-";
                                        }
                                        else return "-";
                                    }
                                }
                                Label{
                                    Layout.preferredWidth: (typeof studentStatDrawer.courseHeaders[3+courseRowRp.count + 2]  != "undefined")?  studentStatDrawer.courseHeaders[3+courseRowRp.count + 2]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text:{
                                        if(typeof  recdel.model["class_rank"] != "undefined")
                                        {
                                            if(parseFloat(recdel.model["semester"]) > -1){
                                                return recdel.model["class_rank"] + " \u2506 "  + recdel.model["base_rank"];
                                            }
                                            else return "-";
                                        }
                                        else return "-";
                                    }
                                }
                                Label{
                                    Layout.preferredWidth: (typeof studentStatDrawer.courseHeaders[3+courseRowRp.count + 3]  != "undefined")?  studentStatDrawer.courseHeaders[3+courseRowRp.count + 3]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text:{
                                        if(typeof recdel.model["base_avg"] != "undefined"){
                                            if(parseFloat(recdel.model["semester"]) > -1){
                                                return  recdel.model["class_avg"] + " \u2506 "  + recdel.model["base_avg"];
                                            }
                                            else return "-";
                                        }
                                        else return "-";
                                    }
                                }
                                Label{
                                    Layout.preferredWidth:(typeof studentStatDrawer.courseHeaders[3+courseRowRp.count + 4]  != "undefined")?  studentStatDrawer.courseHeaders[3+courseRowRp.count + 4]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text: {
                                        if(typeof recdel.model["base_min"] != "undefined"){
                                            if(parseFloat(recdel.model["semester"]) > -1){
                                                return recdel.model["class_min"] + " \u2506 "  + recdel.model["base_min"];
                                            }
                                            return "-";
                                        }
                                        else return "-";
                                    }
                                }
                                Label{
                                    Layout.preferredWidth: (typeof studentStatDrawer.courseHeaders[3+courseRowRp.count + 5]  != "undefined")?  studentStatDrawer.courseHeaders[3+courseRowRp.count + 5]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text:{
                                        if(typeof recdel.model["base_max"]  != "undefined"){
                                            if(parseFloat(recdel.model["semester"]) > -1){
                                                return recdel.model["class_max"] + " \u2506 "  + recdel.model["base_max"];
                                            }
                                            else return "-";
                                        }
                                        else return "-";
                                    }
                                }

                            }
                        }
                    }
                    Item{width: parent.width; height: 20;visible : (studentStatDrawer.courseRows.length > 0)? true : false;}
                    // shared string
                    Rectangle{
                        width: parent.width
                        height: sharedListCol.implicitHeight

                        Column{
                            id: sharedListCol
                            width: parent.width
                            height: 300
                            Label{
                                width: parent.width
                                height: 40
                                font.bold: true
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                color: "darkslategray"
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                                text:"دروس زیر دارای ضرایب مشترک می‌باشند"
                            }
                            Repeater{
                                id: sharedCourseRp
                                delegate:Text{
                                    required property string modelData
                                    width: sharedListCol.width
                                    height: 30
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    color: "slategray"
                                    horizontalAlignment: Text.AlignLeft
                                    verticalAlignment: Text.AlignVCenter
                                    text: "          . " + modelData
                                }
                            }
                            Label{
                                width: parent.width
                                height: 40
                                font.bold: true
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                color: "darkslategray"
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                                text:"دروس با علامت # در معدل محاسبه نمی‌شوند."
                            }
                            Label{
                                width: parent.width
                                height: 40
                                font.bold: true
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                color: "darkslategray"
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                                text:"ستون‌های رتبه و میانگین بر اساس نمره پایانی محاسبه می‌شوند."
                            }
                        }
                    }

                    Item{width: parent.width; height: 50;visible : (studentStatDrawer.courseRows.length > 0)? true : false;}

                    // test stat
                    Label{
                        width: parent.width
                        height: 100
                        background: Rectangle{color: "palevioletred"}
                        color: "white"
                        visible: (testHeaderRepeater.count > 0)? true : false
                        font.bold: true
                        font.family: "B Yekan"
                        font.pixelSize: 24
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        text:"ارزیابی تست"

                    }
                    Item{width: parent.width; height: 20;}

                    RowLayout{
                        width: parent.width;
                        height: 100
                        visible: (testHeaderRepeater.count > 0)? true : false

                        Label{
                            id: testTotalCoeffLbl
                            Layout.preferredWidth: 200
                            Layout.preferredHeight: 100
                            background:Rectangle{color: "whitesmoke"; border.width:1; border.color:"lightcoral"}
                            color:"black"
                            font.bold: true
                            font.family: "B Yekan"
                            font.pixelSize: 18
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                            text: ""
                        }
                        Label{
                            id:  testTotalStudentCount
                            Layout.preferredWidth: 250
                            Layout.preferredHeight: 100
                            background:Rectangle{color: "whitesmoke"; border.width:1; border.color:"lightcoral"}
                            color:"black"
                            font.bold: true
                            font.family: "B Yekan"
                            font.pixelSize: 18
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                            text: ""
                        }
                        Repeater
                        {
                            id: testTotalRp
                            delegate:Label{
                                required property var model;
                                Layout.preferredWidth: 200
                                Layout.preferredHeight: 100
                                background:Rectangle{color: "whitesmoke"; border.width:1; border.color:"lightcoral"}
                                color:"black"
                                font.bold: true
                                font.family: "B Yekan"
                                font.pixelSize: 18
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                                text: (Object.keys(model).length > 0)?  "معدل " + model["category"] + "\n" + model["avg"] + " % " : ""
                            }
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    Item{width: parent.width; height: 20;}

                    //header row
                    Rectangle{
                        width: mainBox.width
                        height: 80
                        color: "darkslategray"
                        visible: (testHeaderRepeater.count > 0)? true : false
                        RowLayout{
                            anchors.fill: parent
                            spacing: 2
                            anchors.margins: 5
                            // row_number - course - coeff - evals - rank - avg - min - max
                            Repeater{
                                id: testHeaderRepeater
                                model: studentStatDrawer.testHeaders
                                delegate:Label{
                                    id: htdel
                                    required property var model;
                                    Layout.preferredWidth: (typeof htdel.model["width"] != "undefined")? htdel.model["width"] : 0
                                    Layout.preferredHeight: 80
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    color: "white"
                                    //background:Rectangle{color: "darkslategray"}
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text:(typeof htdel.model["title"] == "undefined")? "" :  htdel.model["title"];
                                }
                            }
                        }
                    }
                    ListView{
                        id: studentTestStatLV
                        width: parent.width
                        height: 500
                        flickableDirection: Flickable.AutoFlickDirection
                        clip: true
                        spacing: 5
                        visible : (studentStatDrawer.testRows.length > 0)? true : false;
                        highlight:Item{}
                        delegate:Rectangle{
                            id: trecdel
                            required property var model;
                            width: studentTestStatLV.width
                            height: 70
                            color: (trecdel.model.index % 2 == 0)? "ghostwhite" : "snow"

                            RowLayout{
                                anchors.fill: parent;
                                spacing: 2
                                // row_number-course-coeff-evals-semester-rank-avg-min-max
                                // item 0
                                Label{
                                    Layout.preferredWidth: (typeof studentStatDrawer.testHeaders[0]  != "undefined")? studentStatDrawer.testHeaders[0]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text: (typeof trecdel.model["row_number"] != "undefined")? trecdel.model["row_number"] : ""
                                }
                                // item 1
                                Label{
                                    Layout.preferredWidth:(typeof studentStatDrawer.testHeaders[1]  != "undefined")?  studentStatDrawer.testHeaders[1]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text: (typeof trecdel.model["course_name"] != "undefined")?  trecdel.model["course_name"] : ""
                                }
                                // item 2
                                Label{
                                    Layout.preferredWidth:(typeof studentStatDrawer.testHeaders[2]  != "undefined")?  studentStatDrawer.testHeaders[2]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text: (typeof trecdel.model["coefficient"] != "undefined")? trecdel.model["coefficient"] : ""
                                }
                                // item 3
                                //evals
                                Repeater{
                                    id: testRowRp
                                    model:trecdel.model["evals"]
                                    delegate:Label{
                                        id: trpDel
                                        required property var model;
                                        Layout.preferredWidth: (typeof studentStatDrawer.testHeaders[3+model.index]  != "undefined")?  studentStatDrawer.testHeaders[3+model.index]["width"] : 0
                                        Layout.preferredHeight: 70
                                        Layout.margins: 0
                                        color:"midnightblue"
                                        background: Rectangle{color: studentStatDrawer.getBgColor(trpDel.text, true);}
                                        font.bold: true
                                        font.family: "B Yekan"
                                        font.pixelSize: 18
                                        horizontalAlignment: Label.AlignHCenter
                                        verticalAlignment: Label.AlignVCenter
                                        text: {
                                            if(typeof trpDel.model["navg"] != "undefined")
                                            {
                                                if(parseFloat(trpDel.model["navg"]) > -1)
                                                return "  "+trpDel.model["navg"] +" % ";
                                                else return "-";
                                            }
                                            else return "-";
                                        }
                                    }
                                }

                                Label{
                                    Layout.preferredWidth: (typeof studentStatDrawer.testHeaders[2+testRowRp.count + 1]  != "undefined")?  studentStatDrawer.testHeaders[2+testRowRp.count + 1]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text:{
                                        if(typeof  trecdel.model["class_rank"] != "undefined")
                                        {
                                            if(parseFloat(trecdel.model["class_rank"]) > -1)
                                            {
                                                return  trecdel.model["class_rank"] + " \u2506 "  + trecdel.model["base_rank"];
                                            }
                                            else return "-";
                                        }
                                        else
                                        return "-";
                                    }
                                }
                                Label{
                                    Layout.preferredWidth: (typeof studentStatDrawer.testHeaders[2+testRowRp.count + 2]  != "undefined")?  studentStatDrawer.testHeaders[2+testRowRp.count + 2]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text:{
                                        if(typeof trecdel.model["base_avg"] != "undefined")
                                        {
                                            if( parseFloat(trecdel.model["base_avg"]) > -1)
                                            {
                                                return trecdel.model["class_avg"] + " %   \u2506 " + trecdel.model["base_avg"] + " %";
                                            }
                                            else return "-";

                                        }
                                        else return "-";
                                    }
                                }
                                Label{
                                    Layout.preferredWidth:(typeof studentStatDrawer.testHeaders[2+testRowRp.count + 3]  != "undefined")?  studentStatDrawer.testHeaders[2+testRowRp.count + 3]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text:{

                                        if(typeof trecdel.model["base_min"] != "undefined")
                                        {
                                            if(parseFloat(trecdel.model["class_min"]) > -1)
                                            return trecdel.model["class_min"] + " % \u2506 " + trecdel.model["base_min"] + " %";
                                            else return "-";
                                        }
                                        else return "-";
                                    }
                                }
                                Label{
                                    Layout.preferredWidth: (typeof studentStatDrawer.testHeaders[2+testRowRp.count + 4]  != "undefined")?  studentStatDrawer.testHeaders[2+testRowRp.count + 4]["width"] : 0
                                    Layout.preferredHeight: 70
                                    color:"black"
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    text: {
                                        if(typeof trecdel.model["base_max"]  != "undefined")
                                        {
                                            if(parseFloat(trecdel.model["base_max"]) > -1)
                                            return trecdel.model["class_max"] + " % \u2506 " + trecdel.model["base_max"] + " %";
                                            else return "-";
                                        }
                                        else return "-";
                                    }
                                }

                            }
                        }
                    }
                    Item{width: parent.width; height: 20;}
                    // shared
                    Rectangle{
                        width: parent.width
                        height: sharedListCol.implicitHeight

                        Column{
                            id: sharedtestListCol
                            width: parent.width
                            height: 300
                            Label{
                                width: parent.width
                                height: 40
                                font.bold: true
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                color: "darkslategray"
                                horizontalAlignment: Label.AlignLeft
                                verticalAlignment: Label.AlignVCenter
                                text:"دروس زیر دارای ضرایب مشترک می‌باشند"
                            }
                            Repeater{
                                id: sharedTestRp
                                delegate:Text{
                                    required property string modelData
                                    width: sharedListCol.width
                                    height: 30
                                    font.bold: true
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    color: "slategray"
                                    horizontalAlignment: Text.AlignLeft
                                    verticalAlignment: Text.AlignVCenter
                                    text: "          . " + modelData
                                }
                            }
                        }
                    }

                    Item{width: parent.width; height: 20;}
                }
            }
        }
    }
}

