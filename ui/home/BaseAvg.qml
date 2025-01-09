import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./../public" as DialogBox

Page {
    id: baseAvgPage

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text:{
                var temp = baseAvgPage.step
                if(! temp.includes("دوره"))
                    temp = " دوره " + baseAvgPage.step

                return "شعبه " + baseAvgPage.branch + " - " + temp
            }
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: {
                var temp = "رشته " +  baseAvgPage.field
                if(baseAvgPage.field_based)
                    return temp + "سال‌تحصیلی " + baseAvgPage.period
                else
                    return  "سال‌تحصیلی " + baseAvgPage.period
            }

            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
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
            text: "ثبت میانگین پایه دروس"
            font.family: "Kalameh"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
        }

        Row{
            Layout.preferredHeight: 80
            Layout.preferredWidth: 450
            Layout.alignment: Qt.AlignHCenter
            spacing: 0

            Label{
                width: 300
                height: 80
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color:"black"
                background: Rectangle{color: "powderblue"; border.width: 1; border.color:"gray"}
                text: "عنوان درس"
            }

            Label{
                width: 150
                height: 80
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color:"black"
                background: Rectangle{color: "powderblue"; border.width: 1; border.color:"gray"}
                text: "میانگین پایه"
            }
        }

        Rectangle{
            id: mainBox
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 600
            Layout.topMargin: 0
            color: "transparent"

            Flickable{
                anchors.fill: parent
                contentHeight: lv.contentHeight
                contentWidth: lv.contentWidth
                clip: true

                ListView
                {
                    id: lv
                    height: lv.contentHeight
                    width: 450
                    anchors.centerIn: parent
                    model: ListModel{id: lvModel;}
                    clip: true
                    delegate:lvDelegate
                    Component.onCompleted: {
                        lvModel.clear();
                        var jsonarray = dbMan.getBase_CourseAverages();
                        for(var obj of jsonarray)
                        {
                            lvModel.append(obj);
                        }
                    }
                    populate: Transition {
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
            height: 80
            width: lv.width

            // ba.id, ba.base_id, ba.period_id, ba.course_id, co.course_name, co.course_coefficient, ba.average
            required property var model;
            color: (recdel.model.index % 2 == 0)? "aliceblue" : "mintcream"

            function doneEdit()
            {
                avgRec.edit = false
                var v = parseFloat(te.text);

                if(te.text === "")
                {
                    if(!dbMan.updateBaseAverage(recdel.model.id))
                    {
                        infoDialogId.open();
                    }
                    else
                    {
                        avgRec.value = v;
                    }
                }
                else{
                    if(!dbMan.updateBaseAverage(recdel.model.id, v))
                    {
                        infoDialogId.open();
                    }
                    else
                    {
                        avgRec.value = v;
                    }
                }
            }

            RowLayout{
                spacing: 0
                width: parent.width
                height: 50
                anchors.centerIn: parent
                // course_name
                Rectangle{
                    Layout.preferredWidth: 300
                    Layout.preferredHeight: 50
                    color: "transparent"
                    Label{
                        anchors.fill: parent
                        font.family: "Kalameh"
                        font.pixelSize: 20
                        font.bold: true
                        horizontalAlignment: Qt.AlignLeft
                        verticalAlignment: Qt.AlignVCenter
                        text: "  " + recdel.model.course_name
                        color: "darkmagenta"
                    }
                }
                // avg value

                Rectangle{
                    id: avgRec
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 150
                    Layout.preferredHeight: 50
                    Layout.margins: 0

                    color:"transparent"
                    border.width: 1
                    border.color: "gray"

                    property bool edit : false
                    property real value : {
                        if(typeof recdel.model["average"] != "undefined"){
                            if(recdel.model["average"] !== "")
                                return recdel.model["average"];
                            else
                                return -1000;
                        }
                        else return -1000;
                    }

                    TextField{
                        id: te
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 18
                        font.bold: true
                        color:"darkmagenta"
                        text:(avgRec.value > -1000)? avgRec.value :"";
                        visible: avgRec.edit
                        Rectangle{height:2; width: parent.width; color: "olivedrab"; anchors.bottom:parent.bottom;}
                        validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                            regularExpression: /^-?\d*\.?\d+$/
                        }

                        //onEditingFinished:recdel.doneEdit(); // it calles funtion on any clicks
                        //onFocusChanged: parent.doneEdit();
                        Keys.onReturnPressed: recdel.doneEdit();

                        Button{
                            height: 24
                            width: 24
                            background: Rectangle{color:"transparent"}
                            icon.source: "qrc:/assets/images/tick.png"
                            icon.width: 24
                            icon.height: 24
                            icon.color:"transparent"
                            opacity: 0.5
                            onClicked: recdel.doneEdit();
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
                                avgRec.edit = false
                                te.text = (avgRec.value > -1000)? avgRec.value : ""
                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                            anchors.left:parent.left
                            anchors.top: parent.top
                        }
                    }

                    Label{
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 18
                        font.bold: true
                        color:"black"
                        background: Item{}
                        text:{
                            if(avgRec.value > -1000)
                            {
                                    return avgRec.value;
                            }
                            else return ""
                        }
                        visible: !avgRec.edit
                        MouseArea{
                            anchors.fill: parent
                            onDoubleClicked:{
                                avgRec.edit = true
                                te.focus = true
                            }
                        }
                    }

                }

                Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
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
