import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./../public" as DialogBox

Page {
    id: courseStudentsPageId

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;
    required property string class_name;
    required property int class_id;
    required property int course_id;
    required property string course_name;

    required property StackView appStackView;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            color:"transparent"
            // Button
            // {
            //     height: 64
            //     width: 64
            //     anchors.left: parent.left
            //     background: Item{}
            //     icon.source: "qrc:/assets/images/arrow-right.png"
            //     icon.width: 64
            //     icon.height: 64
            //     icon.color:"transparent"
            //     opacity: 0.5
            //     onClicked: courseStudentsPageId.appStackView.pop();
            //     hoverEnabled: true
            //     onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            // }
            Text {
                width: parent.width
                height: parent.height
                Layout.preferredHeight: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "شعبه " + courseStudentsPageId.branch + " - " + courseStudentsPageId.step
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
                    if(dbMan.refreshCourseEvals(courseStudentsPageId.class_id, courseStudentsPageId.course_id))
                    {
                        infoDialogId.dialogSuccess = true
                        infoDialogId.dialogTitle = "عملیات موفق"
                        infoDialogId.dialogText = "آزمون‌های درس برای دانش‌آموزان بروزرسانی شد.";
                        // update model
                        lvModel.clear();
                        var jsonarray = dbMan.getCourseStudents_evals(courseStudentsPageId.class_id, courseStudentsPageId.course_id);
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

        Column{
            Layout.fillWidth: true
            Layout.preferredHeight: 150

            Text {
                width: parent.width
                height: 50
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: courseStudentsPageId.course_name
                font.family: "B Yekan"
                font.pixelSize: 24
                font.bold: true
                color: "darkmagenta"
            }

            Text {
                width: parent.width
                height: 50
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: (courseStudentsPageId.field_based) ? "رشته " + courseStudentsPageId.field + " - " + " پایه " + courseStudentsPageId.base :  " پایه " + courseStudentsPageId.base
                font.family: "B Yekan"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }

            Text {
                width: parent.width
                height: 50
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: " سال تحصیلی " +  courseStudentsPageId.period + " - " + " کلاس " + courseStudentsPageId.class_name
                font.family: "B Yekan"
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
            text: "ارزیابی درس دانش‌آموزان"
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
                        // register_id, r.student_id, r.class_id, s.student, s.fathername, s.photo, evals[]
                        var jsonarray = dbMan.getCourseStudents_evals(courseStudentsPageId.class_id, courseStudentsPageId.course_id);
                        for(var obj of jsonarray)
                        {
                            lvModel.append(obj);
                        }
                    }
                    populate: Transition {
                        //NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 1000 }
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
                //user
                spacing: 10
                anchors.fill: parent
                Image {
                    source:recdel.model.photo
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 100
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
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
                        // top rect
                        RowLayout{
                            anchors.fill: parent
                            spacing: 20

                            //Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}

                            Label{
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 20
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text:  recdel.model.student
                                color: "darkslategray"
                            }
                            Label{
                                Layout.preferredHeight: 50
                                font.family: "B Yekan"
                                font.pixelSize: 14
                                font.bold: true
                                horizontalAlignment: Qt.AlignHCenter
                                verticalAlignment: Qt.AlignVCenter
                                text:  "نام پدر: " + recdel.model.fathername
                                color: "darkslategray"
                                visible: (recdel.model.fathername !== "")? true : false
                            }


                            Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                        }
                        // line
                        Rectangle{
                            width: parent.width
                            height: 1
                            color: "gainsboro"
                            anchors.bottom: parent.bottom
                        }
                    }
                    // bottom rect
                    //evals & grade
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
