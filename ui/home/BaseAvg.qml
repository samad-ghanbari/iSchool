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

    property bool onEditing : false
    property int activeCourseId : -1
    property int activeSemester : 0 // 1-2
    property var coursesId : []

    function findItemRecursive(parent, courseId_property, semester_property) {
        for (var i = 0; i < parent.children.length; i++) {
            var child = parent.children[i];
            if (child["coId"] === courseId_property) {
                if(child["seId"] === semester_property)
                    return child;
            }
            // Recursively search in the child's children
            var found = findItemRecursive(child, courseId_property, semester_property);
            if (found) {
                return found;
            }
        }
        return null; // Return null if no item is found
    }
    function findTF(parent, propertyName, propertyValue) {
        for (var i = 0; i < parent.children.length; i++) {
            var child = parent.children[i];
            if (child[propertyName] === propertyValue) {
                return child;
            }
            // Recursively search in the child's children
            var found = findTF(child, propertyName, propertyValue);
            if (found) {
                return found;
            }
        }
        return null; // Return null if no item is found
    }

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text:baseAvgPage.branch + " - " + baseAvgPage.step
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
        }
        Row{
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignHCenter
            Text {
                Layout.preferredHeight: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: {
                    if(baseAvgPage.field_based)
                        return baseAvgPage.field + " - " + "سال‌تحصیلی "
                    else
                        return  "سال‌تحصیلی "
                }

                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
            Text {
                Layout.preferredHeight: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: baseAvgPage.period
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
            text: "ثبت میانگین پایه دروس"
            font.family: "Kalameh"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
        }

        Row{
            Layout.preferredHeight: 80
            Layout.preferredWidth: 650
            Layout.alignment: Qt.AlignHCenter
            spacing: 0

            Label{
                width: 350
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
                text: "میانگین پایه" + "\n" + "نیمسال اول"
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
                text: "میانگین پایه" + "\n" + "نیمسال دوم"
            }
        }

        Rectangle{
            id: mainBox
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 650
            Layout.topMargin: 0
            color: "transparent"

            Flickable{
                id: flk
                anchors.fill: parent
                //contentHeight: lv.contentHeight
                //contentWidth: lv.contentWidth
                contentHeight: Math.max(lv.height, flk.height)
                contentWidth: Math.max(lv.width, flk.width)
                clip: true

                ListView
                {
                    id: lv
                    height: lv.contentHeight
                    width: 650
                    anchors.centerIn: parent
                    model: ListModel{id: lvModel;}
                    clip: true
                    delegate:lvDelegate
                    Component.onCompleted: {
                        lvModel.clear();
                        var jsonarray = dbMan.getCourse_baseAverages();
                        for(var obj of jsonarray)
                        {
                            lvModel.append(obj);
                            baseAvgPage.coursesId.push(obj["id"]);
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

            //id, course_name,course_coefficient, base_id, period_id, base_average
            required property var model;
            color: (recdel.model.index % 2 == 0)? "aliceblue" : "mintcream"

            RowLayout{
                spacing: 0
                width: parent.width
                height: 50
                anchors.centerIn: parent
                // course_name
                Label{
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 300
                    Layout.alignment: Qt.AlignLeft
                    font.family: "Kalameh"
                    font.pixelSize: 20
                    font.bold: true
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    text: "  " + recdel.model.course_name
                    color: "darkmagenta"
                }
                Label{
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: 50
                    Layout.alignment: Qt.AlignRight
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    font.bold: true
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    text: "  " + recdel.model.course_coefficient
                    color: "white"
                    background: Rectangle{color:"mediumvioletred"; anchors.fill:parent}
                }

                // avg value

                // semester 1
                Rectangle{
                    id: avgRec1
                    width: 150
                    height: 50

                    color:"transparent"
                    border.width: 1
                    border.color: "gray"

                    property real value : {
                        if(typeof recdel.model["base_average_1"] != "undefined"){
                            if(recdel.model["base_average_1"] !== "")
                                return recdel.model["base_average_1"];
                            else
                                return -1000;
                        }
                        else return -1000;
                    }

                    TextField{
                        id: te1

                        property int seId : 1
                        property int coId : recdel.model.id
                        property bool onEditTF : false
                        function doneEdit()
                        {
                            te1.onEditTF =  false
                            var v = parseFloat(te1.text);

                            if(te1.text === "")
                            {
                                if(!dbMan.updateCourse_baseAverage(recdel.model.id, 1))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    avgRec1.value = v;
                                }
                            }
                            else{
                                if(!dbMan.updateCourse_baseAverage(recdel.model.id, 1, v))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    avgRec1.value = v;
                                }
                            }
                        }
                        function keyPressed()
                        {
                            this.doneEdit();
                            // find next and focus
                            let index = baseAvgPage.coursesId.indexOf(te1.coId) + 1;
                            if(index < baseAvgPage.coursesId.length)
                            {
                                let newCoId = baseAvgPage.coursesId[index];
                                let item = baseAvgPage.findItemRecursive(lv, newCoId, 1);

                                if(item)
                                {
                                    item.onEditTF = true;
                                    baseAvgPage.onEditing = true
                                    item.forceActiveFocus();

                                    item = lv.itemAtIndex(recdel.model.index +1)
                                    if(item)
                                        flk.contentY = ((flk.height+flk.contentY-100) <= item.y )? item.y : flk.contentY
                                }
                            }
                        }

                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 18
                        font.bold: true
                        color:"darkmagenta"
                        text:(avgRec1.value > -1000)? avgRec1.value :"";
                        visible: te1.onEditTF
                        Rectangle{height:2; width: parent.width; color: "olivedrab"; anchors.bottom:parent.bottom;}
                        validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                            regularExpression: /^-?\d*\.?\d+$/
                        }

                        Keys.onReturnPressed: this.keyPressed()
                        Keys.onTabPressed: this.keyPressed()
                        Keys.onEscapePressed: {
                            te1.onEditTF = false
                            baseAvgPage.onEditing = false
                            te1.text = (avgRec1.value > -1000)? avgRec1.value : ""
                        }

                        Button{
                            height: 24
                            width: 24
                            background: Rectangle{color:"transparent"}
                            icon.source: "qrc:/assets/images/tick.png"
                            icon.width: 24
                            icon.height: 24
                            icon.color:"transparent"
                            opacity: 0.5
                            onClicked: te1.doneEdit();
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
                                te1.onEditTF = false
                                te1.text = (avgRec1.value > -1000)? avgRec1.value : ""
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
                            if(avgRec1.value > -1000)
                            {
                                return avgRec1.value;
                            }
                            else return ""
                        }
                        visible: !te1.onEditTF
                        MouseArea{
                            anchors.fill: parent
                            onDoubleClicked:{

                                if(baseAvgPage.onEditing)
                                {
                                    var item = baseAvgPage.findTF(lv, "onEditTF", true);
                                    while(item)
                                    {
                                        item.doneEdit();
                                        item = baseAvgPage.findTF(lv, "onEditTF", true);
                                    }
                                }


                                te1.onEditTF = true
                                baseAvgPage.onEditing = true
                                te1.focus = true
                            }
                        }
                    }

                }
                // semester 2
                Rectangle{
                    id: avgRec2
                    width: 150
                    height: 50

                    color:"transparent"
                    border.width: 1
                    border.color: "gray"

                    property real value : {
                        if(typeof recdel.model["base_average_2"] != "undefined"){
                            if(recdel.model["base_average_2"] !== "")
                                return recdel.model["base_average_2"];
                            else
                                return -1000;
                        }
                        else return -1000;
                    }

                    TextField{
                        id: te2
                        property int seId : 2
                        property int coId : recdel.model.id
                        property bool onEditTF : false
                        function doneEdit()
                        {
                            te2.onEditTF = false
                            baseAvgPage.onEditing = false

                            var v = parseFloat(te2.text);

                            if(te2.text === "")
                            {
                                if(!dbMan.updateCourse_baseAverage(recdel.model.id, 2))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    avgRec2.value = v;
                                }
                            }
                            else{
                                if(!dbMan.updateCourse_baseAverage(recdel.model.id, 2, v))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    avgRec2.value = v;
                                }
                            }
                        }
                        function keyPressed()
                        {
                            this.doneEdit();
                            // find next and focus
                            let index = baseAvgPage.coursesId.indexOf(te2.coId) + 1;
                            if(index < baseAvgPage.coursesId.length)
                            {
                                let newCoId = baseAvgPage.coursesId[index];
                                let item = baseAvgPage.findItemRecursive(lv, newCoId, 2);

                                if(item)
                                {
                                    item.onEditTF = true;
                                    baseAvgPage.onEditing = true
                                    item.forceActiveFocus();

                                    item = lv.itemAtIndex(recdel.model.index +1)
                                    if(item)
                                        flk.contentY = ((flk.height+flk.contentY-100) <= item.y )? item.y : flk.contentY

                                }
                            }

                        }

                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 18
                        font.bold: true
                        color:"darkmagenta"
                        text:(avgRec2.value > -1000)? avgRec2.value :"";
                        visible: te2.onEditTF
                        Rectangle{height:2; width: parent.width; color: "olivedrab"; anchors.bottom:parent.bottom;}
                        validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                            regularExpression: /^-?\d*\.?\d+$/
                        }

                        Keys.onReturnPressed: this.keyPressed();
                        Keys.onTabPressed: this.keyPressed();
                        Keys.onEscapePressed: {
                            te2.onEditTF =  false
                            baseAvgPage.onEditing = false
                            te2.text = (avgRec2.value > -1000)? avgRec2.value : ""
                        }

                        Button{
                            height: 24
                            width: 24
                            background: Rectangle{color:"transparent"}
                            icon.source: "qrc:/assets/images/tick.png"
                            icon.width: 24
                            icon.height: 24
                            icon.color:"transparent"
                            opacity: 0.5
                            onClicked: te2.doneEdit();
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
                                te2.onEditTF = false
                                baseAvgPage.onEditing = false
                                te2.text = (avgRec2.value > -1000)? avgRec2.value : ""
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
                            if(avgRec2.value > -1000)
                            {
                                return avgRec2.value;
                            }
                            else return ""
                        }
                        visible: !te2.onEditTF
                        MouseArea{
                            anchors.fill: parent
                            onDoubleClicked:{

                                if(baseAvgPage.onEditing)
                                {
                                    var item = baseAvgPage.findTF(lv, "onEditTF", true);
                                    while(item)
                                    {
                                        item.doneEdit();
                                        item = baseAvgPage.findTF(lv, "onEditTF", true);
                                    }
                                }

                                te2.onEditTF =  true
                                baseAvgPage.onEditing = true
                                te2.focus = true
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
