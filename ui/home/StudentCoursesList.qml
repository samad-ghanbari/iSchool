import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./../public" as DialogBox

Page {
    id: studentCoursesPageId

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;
    required property string class_name;
    required property int class_id;
    required property int student_id;
    required property string student;
    required property string student_photo;

    required property StackView appStackView;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
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
                text: "شعبه " + studentCoursesPageId.branch + " - " + studentCoursesPageId.step
                font.family: "B Yekan"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }

            Button
            {
                height: 64
                width: 64
                anchors.right: parent.right
                background: Item{}
                icon.source: "qrc:/assets/images/refresh.png"
                icon.width: 64
                icon.height: 64
                icon.color:"transparent"
                opacity: 0.5
                onClicked: {
                    if(dbMan.refreshStudentEvals(studentCoursesPageId.class_id, studentCoursesPageId.student_id))
                    {
                        infoDialogId.dialogSuccess = true
                        infoDialogId.dialogTitle = "عملیات موفق"
                        infoDialogId.dialogText = "آزمون‌های دانش‌آموز با موفقیت به روزرسانی شد."
                        infoDialogId.open();

                        lvModel.clear();
                        var register_id = dbMan.getRegisterId(studentCoursesPageId.class_id, studentCoursesPageId.student_id);
                        var jsonarray = dbMan.getStudentCourses_evals(register_id);
                        for(var obj of jsonarray)
                        {
                            lvModel.append(obj);
                        }
                    }
                    else
                        infoDialogId.open();
                }
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight:  150

            Image {
                source:studentCoursesPageId.student_photo
                Layout.preferredWidth: 150
                Layout.preferredHeight: 150
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }
            Column{
                Layout.fillWidth: true
                Layout.preferredHeight: 150

                Text {
                    width: parent.width
                    height: 50
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignLeft
                    text: studentCoursesPageId.student
                    font.family: "B Yekan"
                    font.pixelSize: 20
                    font.bold: true
                    color: "darkmagenta"
                }

                Text {
                    width: parent.width
                    height: 50
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignLeft
                    text: (studentCoursesPageId.field_based) ? "رشته " + studentCoursesPageId.field + " - " + " پایه " + studentCoursesPageId.base :  " پایه " + studentCoursesPageId.base
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                }

                Text {
                    width: parent.width
                    height: 50
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignLeft
                    text: " سال تحصیلی " +  studentCoursesPageId.period + " - " + " کلاس " + studentCoursesPageId.class_name
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                }
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
            text: " دروس دانش‌آموز "
            font.family: "B Yekan"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
        }


        Rectangle{
            id: mainBox
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 600
            Layout.topMargin: 20
            color: "transparent"

            Flickable{
                anchors.fill: parent
                contentHeight: lv.contentHeight
                contentWidth: lv.contentWidth

                ListView
                {
                    id: lv
                    anchors.fill: parent
                    model: ListModel{id: lvModel;}
                    clip: true
                    delegate:lvDelegate
                    Component.onCompleted: {
                        lvModel.clear();
                        var register_id = dbMan.getRegisterId(studentCoursesPageId.class_id, studentCoursesPageId.student_id);
                        var jsonarray = dbMan.getStudentCourses_evals(register_id);
                        //0sc.id, 1sc.register_id, 2sc.course_id, 3co.course_name, 4co.step_id, 5co.base_id, 6co.period_id,
                        //7co.course_coefficient, 8co.test_coefficient, 9co.shared_coefficient, 10co.final_weight, 11co.shared_weight
                        // evals [{}, {}] : {sce.student_course_eval_id, sce.student_course_id, sce.eval_id, e.eval_name, e.base_id, e.period_id, e.test_flag, e.final_flag,e.max_grade, sce.grade, sce.eval_time, sce.included}
                        for(var obj of jsonarray)
                        {
                            lvModel.append(obj);
                        }
                    }
                    populate: Transition {
                        // NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 1000 }
                        NumberAnimation { properties: "x,y"; duration: 1000 }
                    }
                }
            }


        }
    }

    Component{
        id: lvDelegate
        Rectangle{
            id: recdel;
            height: 110
            width: lv.width

            required property var model;
            color: (recdel.model.index % 2 == 0)? "aliceblue" : "mintcream"
            RowLayout{
                spacing: 10
                anchors.fill: parent
                Rectangle{
                    Layout.preferredWidth: 300
                    Layout.preferredHeight: 100
                    color: "transparent"
                    Label{
                        anchors.fill: parent
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        font.bold: true
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                        text: recdel.model.course_name
                        color: "darkmagenta"
                    }
                }

                Rectangle{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 100
                    color: "transparent"
                    Rectangle{
                        width: parent.width
                        height: 50
                        color: "transparent"
                        anchors.top: parent.top
                        RowLayout{
                            anchors.fill: parent
                            spacing: 20
                            Label{
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text: "ضریب درس: " + recdel.model.course_coefficient
                                color: "darkslategray"
                                visible: (recdel.model.course_coefficient > 0)? true : false
                            }
                            Label{
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text: "ضریب تست: " + recdel.model.test_coefficient
                                color: "darkslategray"
                                visible: (recdel.model.test_coefficient > 0)? true : false
                            }
                            Label{
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text: "وزن آزمون نهایی: " + recdel.model.final_weight
                                color: "darkslategray"
                                visible: (recdel.model.final_weight > 0)? true : false
                            }
                            Label{
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text: "وزن ضریب اشتراکی: " + recdel.model.shared_weight
                                color: "darkslategray"
                                visible: (recdel.model.shared_weight > 0)? true : false
                            }

                            Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                        }

                        Rectangle{
                            width: parent.width
                            height: 1
                            color: "gainsboro"
                            anchors.bottom: parent.bottom
                        }
                    }
                    // evals & grade
                    Rectangle{
                        width: parent.width
                        height: 50
                        color: "transparent"
                        anchors.bottom: parent.bottom

                        RowLayout{
                            height: parent.height
                            width: parent.width
                            // evals
                            Repeater{
                                id: rowEvalRep
                                model: (typeof recdel.model["evals"] != "undefined")? recdel.model["evals"] : [] // [{},{}]
                                delegate:
                                    Rectangle{
                                    id: evalRecDel
                                    required property var model;
                                    Layout.alignment: Qt.AlignLeft
                                    Layout.preferredHeight: 50
                                    Layout.preferredWidth:titlerec.implicitWidth + 120
                                    Layout.margins: 0

                                    color:"floralwhite"
                                    border.width: 1
                                    border.color: "gray"


                                    property bool edit : false
                                    property real value : {
                                        if(typeof evalRecDel.model["grade"] != "undefined"){
                                            if(evalRecDel.model["grade"] !== "")
                                                return evalRecDel.model["grade"];
                                            else
                                                return -1000;
                                        }
                                        else return -1000;
                                    }

                                    Row{
                                        anchors.fill: parent
                                        anchors.margins: 5
                                        //title
                                        Label{
                                            id: titlerec
                                            height: 50
                                            horizontalAlignment: Text.AlignRight
                                            verticalAlignment: Text.AlignVCenter
                                            font.family: "B Yekan"
                                            font.pixelSize: 16
                                            font.bold: true
                                            color:"black"
                                            text: evalRecDel.model.eval_name +": "
                                            //background: Rectangle{color:"blue"}
                                        }
                                        //content
                                        Rectangle{
                                            height: 50
                                            width: 100
                                            color: "transparent"

                                            function doneEdit()
                                            {
                                                evalRecDel.edit = false
                                                evalRecDel.edit = false
                                                var v = parseFloat(te.text);
                                                var scei = parseInt(evalRecDel.model["student_course_eval_id"]);
                                                if(v > evalRecDel.model.max_grade)
                                                {
                                                    te.text = ""
                                                    infoDialogId.dialogSuccess = false
                                                    infoDialogId.dialogTitle = "خطا"
                                                    infoDialogId.dialogText = "مقدار وارد شده از بیشترین نمره مجاز بالاتر است."
                                                    infoDialogId.open();
                                                    return;
                                                }

                                                if(te.text === "")
                                                {
                                                    if(!dbMan.setStudentCourseEvalGrade(scei))
                                                    {
                                                        infoDialogId.open();
                                                    }
                                                    else
                                                    {
                                                        evalRecDel.value = v;
                                                    }
                                                }
                                                else{
                                                    if(!dbMan.setStudentCourseEvalGrade(scei, v))
                                                    {
                                                        infoDialogId.open();
                                                    }
                                                    else
                                                    {
                                                        evalRecDel.value = v;
                                                    }
                                                }
                                            }

                                            TextField{
                                                id: te
                                                height: 40
                                                width: 100
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                font.family: "B Yekan"
                                                font.pixelSize: 18
                                                font.bold: true
                                                color:"darkmagenta"
                                                text:(evalRecDel.value > -1000)? evalRecDel.value :"";
                                                visible: evalRecDel.edit
                                                Rectangle{height:2; width: parent.width; color: "olivedrab"; anchors.bottom:parent.bottom;}
                                                validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                                                    regularExpression: /^-?\d*\.?\d+$/
                                                }

                                                //onEditingFinished:parent.doneEdit();
                                                //onFocusChanged: parent.doneEdit();
                                                Keys.onReturnPressed: parent.doneEdit();

                                                Button{
                                                    height: 24
                                                    width: 24
                                                    background: Rectangle{color:"transparent"}
                                                    icon.source: "qrc:/assets/images/tick.png"
                                                    icon.width: 24
                                                    icon.height: 24
                                                    icon.color:"transparent"
                                                    opacity: 0.5
                                                    onClicked: parent.parent.doneEdit();
                                                    hoverEnabled: true
                                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                                    anchors.right:parent.right
                                                    anchors.top: parent.top
                                                }
                                                Button{
                                                    height: 24
                                                    width: 24
                                                    background: Rectangle{color:"transparent"}
                                                    icon.source: "qrc:/assets/images/cross.png"
                                                    icon.width: 24
                                                    icon.height: 24
                                                    icon.color:"transparent"
                                                    opacity: 0.5
                                                    onClicked: {
                                                        evalRecDel.edit = false
                                                        te.text = (evalRecDel.value > -1000)? evalRecDel.value : ""
                                                    }
                                                    hoverEnabled: true
                                                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                                    anchors.left:parent.left
                                                    anchors.top: parent.top
                                                }
                                            }

                                            Label{
                                                width: 100
                                                height: 50
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                font.family: "B Yekan"
                                                font.pixelSize: 18
                                                font.bold: true
                                                color:"black"
                                                background: Item{}
                                                text:{
                                                    if(evalRecDel.value > -1000)
                                                    {
                                                        if(evalRecDel.model["test_flag"])
                                                        {
                                                            return evalRecDel.value + " % "
                                                        }
                                                        else
                                                            return evalRecDel.value;
                                                    }
                                                    else return ""
                                                }
                                                visible: !evalRecDel.edit
                                                MouseArea{
                                                    anchors.fill: parent
                                                    onDoubleClicked:{
                                                        evalRecDel.edit = true
                                                        te.focus = true
                                                    }
                                                }
                                            }

                                        }

                                    }
                                }



                            }

                            Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}

                        }
                    }
                }
            }

            Rectangle{width: parent.width; height: 5; color: "gainsboro"; anchors.bottom: parent.bottom;}

        }
    }

    //dialog error
    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "عملیات با خطا مواجه شد."
        dialogSuccess: false
    }
}
