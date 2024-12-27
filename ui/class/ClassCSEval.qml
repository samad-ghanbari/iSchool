pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts

import "./../public" as DialogBox


Page {
    id: classCSEPage // class course students evals
    required property string class_name;
    required property string course_name;
    required property int class_id;
    required property int course_id;
    required property string branch;
    required property string step;
    required property string base;
    required property string period;
    required property string teacher;
    required property int branch_id;
    required property int step_id;
    required property int base_id;
    required property int period_id;

    signal popStackViewSignal();

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
            onClicked: classCSEPage.popStackViewSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            textFormat: Text.RichText
            text: "ارزیابی واحد درسی کلاس "
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
                width: parent.width
                implicitHeight : centerBox.implicitHeight + 40
                anchors.horizontalCenter : parent.horizontalCenter
                color: "ghostwhite"

                ColumnLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20

                    Text {
                        text: "شعبه " + classCSEPage.branch
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }
                    Text {
                        text: classCSEPage.step + " - " + classCSEPage.base
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }
                    Text {
                        text:  classCSEPage.period
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }

                    //class
                    Text {
                        text: "کلاس " + classCSEPage.class_name + " - " + classCSEPage.course_name + "( دبیر " + classCSEPage.teacher+")"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        font.bold: true
                        color: "darkmagenta"
                    }
                    //line
                    Rectangle{
                        color: "royalblue";
                        Layout.fillWidth: true
                        Layout.maximumWidth: centerBox.width/2
                        Layout.preferredHeight: 4
                        Layout.alignment: Qt.AlignHCenter
                    }

                    //header
                    Rectangle{
                        id: tableHeader
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 80
                        Layout.alignment: Qt.AlignHCenter
                        color: "transparent"
                        visible: (headerRp.count > 0)? true : false;
                        RowLayout{
                            anchors.fill: parent
                            spacing: 0
                            Repeater{
                                id: headerRp
                                model: []
                                delegate:Label{
                                    id: recDel
                                    required property var model;
                                    background: Rectangle{ border.width: 1; border.color:"white";color: "mediumvioletred"}
                                    Layout.preferredWidth: (typeof recDel.model["width"] != "undefined")? recDel.model["width"] : 0
                                    Layout.margins: 0
                                    Layout.preferredHeight: 80
                                    horizontalAlignment: Label.AlignHCenter
                                    verticalAlignment: Label.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color:"white"
                                    text: (typeof recDel.model["title"] != "undefined")? recDel.model["title"] : ""
                                    // Layout.maximumWidth: {
                                    //     if(typeof recDel.model["width"] != "undefined")
                                    //     {
                                    //         if(recDel.model["width"] > 0)
                                    //             return  recDel.model["width"];
                                    //         else
                                    //             return 1000;
                                    //     }
                                    //     else return 0;
                                    // }
                                }
                            }
                            Item{Layout.fillWidth:true; Layout.preferredHeight:1}
                        }
                    }

                    ListView
                    {
                        id: lv
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: lv.contentHeight + 100
                        Layout.margins: 0
                        clip: true
                        model: ListModel{id: lvModel;}
                        delegate:lvDelegate
                        Component.onCompleted: {
                            var modelObject = dbMan.getClassCourseStudentsEvals(classCSEPage.class_id,classCSEPage.course_id);
                            // modelObject {rows, headers{title, width}}
                            headerRp.model = modelObject["headers"];
                            var rowsModel = modelObject["rows"];
                            for(var obj of rowsModel)
                            {
                                lvModel.append(obj);
                            }
                        }
                    }

                }
            }

        }
    }

    //delegate
    Component
    {
        id: lvDelegate
        Rectangle
        {
            id: tDel
            required property var model;
            required property int index;
            width: lv.width
            height: 50
            color: "transparent"
            //border.width: 1
            //border.color: "lightgray"
            property var bgColor : (tDel.index % 2 == 0)? "ghostwhite" : "mintcream";

            RowLayout{
                anchors.fill: parent
                spacing: 0

                //Row
                Label{
                    Layout.margins: 0
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 100
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    color:"black"
                    background: Rectangle{ border.width: 1; border.color:"lightgray"; color:tDel.bgColor}
                    text: (typeof tDel.model["row"] != "undefined")? tDel.model["row"] : ""
                }

                //student
                Label{
                    Layout.margins: 0
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 400
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    color:"black"
                    background: Rectangle{ border.width: 1; border.color:"lightgray"; color:tDel.bgColor}
                    text: (typeof tDel.model["student"] != "undefined")? tDel.model["student"] : ""
                }

                //class
                Label{
                    Layout.margins: 0
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 200
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    color:"black"
                    background: Rectangle{ border.width: 1; border.color:"lightgray"; color:tDel.bgColor}
                    text: (typeof tDel.model["class_name"] != "undefined")? tDel.model["class_name"] : ""
                }

                //course
                Label{
                    Layout.margins: 0
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 400
                    horizontalAlignment: Label.AlignHCenter
                    verticalAlignment: Label.AlignVCenter
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    color:"black"
                    background: Rectangle{ border.width: 1; border.color:"lightgray"; color:tDel.bgColor}
                    text: (typeof tDel.model["course_name"] != "undefined")? tDel.model["course_name"] : ""
                }

                // evals
                Repeater{
                    id: rowEvalRep
                    model: (typeof tDel.model["evals"] != "undefined")? tDel.model["evals"] : [] // [{},{}]
                    delegate:
                    Rectangle{
                        id: evalRecDel
                        required property var model;
                        property bool edit : false
                        property real value : {
                            if(typeof evalRecDel.model["student_grade"] != "undefined"){
                                if(parseFloat(evalRecDel.model["student_grade"]) > -1)
                                {
                                    return evalRecDel.model["student_grade"];
                                }
                            }
                            return -1;
                        }
                        Layout.margins: 0
                        Layout.preferredHeight: 50
                        Layout.preferredWidth: 200
                        border.width: 1; border.color:"lightgray"; color:tDel.bgColor

                        TextField{
                            id: te
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "B Yekan"
                            font.pixelSize: 18
                            font.bold: true
                            color:"darkmagenta"
                            text:(evalRecDel.value > -1)? evalRecDel.value :"";
                            visible: evalRecDel.edit
                            Rectangle{height:2; width: parent.width; color: "olivedrab"; anchors.bottom:parent.bottom;}
                            validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                                regularExpression: /^-?\d*\.?\d+$/
                            }
                            Keys.onReturnPressed: function(event){
                                evalRecDel.edit = false
                                evalRecDel.edit = false
                                var v = parseFloat(te.text);
                                var sei = parseInt(evalRecDel.model["student_eval_id"]);

                                if(!dbMan.setStudentEvalGrade(sei, v))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    evalRecDel.value = v;
                                }
                            }

                            Button{
                                height: 24
                                width: 24
                                background: Rectangle{color:"transparent"}
                                icon.source: "qrc:/assets/images/edit.png"
                                icon.width: 24
                                icon.height: 24
                                opacity: 0.5
                                onClicked: {
                                    evalRecDel.edit = false
                                    var v = parseFloat(te.text);
                                    var sei = parseInt(evalRecDel.model["student_eval_id"]);

                                    if(!dbMan.setStudentEvalGrade(sei, v))
                                    {
                                        infoDialogId.open();
                                    }
                                    else
                                    {
                                        evalRecDel.value = v;
                                    }
                                }

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
                                opacity: 0.5
                                onClicked: {
                                    evalRecDel.edit = false
                                    parent.text = (evalRecDel.value > -1)? evalRecDel.value :"";
                                }
                                hoverEnabled: true
                                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                                anchors.right:parent.right
                                anchors.bottom: parent.bottom
                            }
                        }

                        Label{
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "B Yekan"
                            //background: Rectangle{ border.width: 1; border.color:"lightgray"; color:tDel.bgColor}
                            font.pixelSize: 18
                            color:"black"
                            text:{
                                if(evalRecDel.value > -1)
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


                Item{Layout.fillWidth:true; Layout.preferredHeight:1}
            }
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
