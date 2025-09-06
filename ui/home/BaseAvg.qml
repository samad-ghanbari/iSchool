import QtQuick
import QtQuick.Controls.Fusion
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
    required property bool summer_semester;

    property bool onEditing : false
    property int activeCourseId : -1
    property int activeSemester : 0 // 1-2
    property var coursesId : []

    function findItemRecursive(parent, courseId_property, semester_property, test_property=false) {
        for (var i = 0; i < parent.children.length; i++) {
            var child = parent.children[i];
            if (child["coId"] === courseId_property) {
                if(child["seId"] === semester_property)
                    if(child["test"] === test_property)
                        return child;
            }
            // Recursively search in the child's children
            var found = findItemRecursive(child, courseId_property, semester_property, test_property);
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

        // study period
        Row{
            visible: !baseAvgPage.summer_semester
            Layout.preferredHeight: 80
            Layout.preferredWidth: 950
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
                width: 50
                height: 80
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color:"black"
                background: Rectangle{color: "powderblue"; border.width: 1; border.color:"gray"}
                text: "ضریب"+"\n"+"درس"
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
                text: "میانگین تست" + "\n" + "نیمسال اول"
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
                text: "میانگین تست" + "\n" + "نیمسال دوم"
            }
        }

        Rectangle{
            id: mainBox
            visible: !baseAvgPage.summer_semester
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 950
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
                    width: 950
                    anchors.horizontalCenter: parent.horizontalCenter
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


        // summer semester
        Row{
            visible: baseAvgPage.summer_semester
            Layout.preferredHeight: 80
            Layout.preferredWidth: 650
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
                width: 50
                height: 80
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color:"black"
                background: Rectangle{color: "powderblue"; border.width: 1; border.color:"gray"}
                text: "ضریب"+"\n"+"درس"
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
                text: "میانگین پایه" + "\n" + "نیمسال تابستان"
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
                text: "میانگین تست" + "\n" + "نیمسال تابستان"
            }
        }

        Rectangle{
            id: mainBox_summer
            visible: baseAvgPage.summer_semester
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 650
            Layout.topMargin: 0
            color: "transparent"

            Flickable{
                id: flk_summer
                anchors.fill: parent
                //contentHeight: lv_summer.contentHeight
                //contentWidth: lv_summer.contentWidth
                contentHeight: Math.max(lv_summer.height, flk_summer.height)
                contentWidth: Math.max(lv_summer.width, flk_summer.width)
                clip: true

                ListView
                {
                    id: lv_summer
                    height: lv_summer.contentHeight
                    width: 650
                    anchors.centerIn: parent
                    model: ListModel{id: lv_summerModel;}
                    clip: true
                    delegate:lvDelegate_summer
                    Component.onCompleted: {
                        lv_summerModel.clear();
                        var jsonarray = dbMan.getCourse_baseAverages(true);
                        for(var obj of jsonarray)
                        {
                            lv_summerModel.append(obj);
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
                        property bool test : false
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
                                let item = baseAvgPage.findItemRecursive(lv, newCoId, 1, false);

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

                        Keys.onReturnPressed: this.keyPressed();
                        Keys.onEnterPressed: this.keyPressed();
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
                // test 1
                Rectangle{
                    id: testRec1
                    width: 150
                    height: 50

                    color:"transparent"
                    border.width: 1
                    border.color: "gray"

                    property real value : {
                        if(typeof recdel.model["base_test_1"] != "undefined"){
                            if(recdel.model["base_test_1"] !== "")
                                return recdel.model["base_test_1"];
                            else
                                return -1000;
                        }
                        else return -1000;
                    }

                    TextField{
                        id: tte1

                        property int seId : 1 // semester
                        property int coId : recdel.model.id // course
                        property bool test : true
                        property bool onEditTF : false
                        function doneEdit()
                        {
                            tte1.onEditTF =  false
                            var v = parseFloat(tte1.text);

                            if(tte1.text === "")
                            {
                                if(!dbMan.updateCourse_baseTestAverage(recdel.model.id, 1))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    testRec1.value = v;
                                }
                            }
                            else{
                                if(!dbMan.updateCourse_baseTestAverage(recdel.model.id, 1, v))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    testRec1.value = v;
                                }
                            }
                        }
                        function keyPressed()
                        {
                            this.doneEdit();
                            // find next and focus
                            let index = baseAvgPage.coursesId.indexOf(tte1.coId) + 1;
                            if(index < baseAvgPage.coursesId.length)
                            {
                                let newCoId = baseAvgPage.coursesId[index];
                                let item = baseAvgPage.findItemRecursive(lv, newCoId, 1, true);

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
                        text:(testRec1.value > -1000)? testRec1.value :"";
                        visible: tte1.onEditTF
                        Rectangle{height:2; width: parent.width; color: "olivedrab"; anchors.bottom:parent.bottom;}
                        validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                            regularExpression: /^-?\d*\.?\d+$/
                        }

                        Keys.onReturnPressed: this.keyPressed()
                        Keys.onEnterPressed: this.keyPressed();
                        Keys.onTabPressed: this.keyPressed()
                        Keys.onEscapePressed: {
                            tte1.onEditTF = false
                            baseAvgPage.onEditing = false
                            tte1.text = (testRec1.value > -1000)? testRec1.value : ""
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
                            onClicked: tte1.doneEdit();
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
                                tte1.onEditTF = false
                                tte1.text = (testRec1.value > -1000)? testRec1.value : ""
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
                            if(testRec1.value > -1000)
                            {
                                return testRec1.value;
                            }
                            else return ""
                        }
                        visible: !tte1.onEditTF
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


                                tte1.onEditTF = true
                                baseAvgPage.onEditing = true
                                tte1.focus = true
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
                        property bool test : false
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
                                let item = baseAvgPage.findItemRecursive(lv, newCoId, 2, false);

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
                        Keys.onEnterPressed: this.keyPressed();
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

                // test 2
                Rectangle{
                    id: testRec2
                    width: 150
                    height: 50

                    color:"transparent"
                    border.width: 1
                    border.color: "gray"

                    property real value : {
                        if(typeof recdel.model["base_test_2"] != "undefined"){
                            if(recdel.model["base_test_2"] !== "")
                                return recdel.model["base_test_2"];
                            else
                                return -1000;
                        }
                        else return -1000;
                    }

                    TextField{
                        id: tte2

                        property int seId : 2 // semester
                        property int coId : recdel.model.id // course
                        property bool test : true
                        property bool onEditTF : false
                        function doneEdit()
                        {
                            tte2.onEditTF =  false
                            var v = parseFloat(tte2.text);

                            if(tte2.text === "")
                            {
                                if(!dbMan.updateCourse_baseTestAverage(recdel.model.id, 2))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    testRec2.value = v;
                                }
                            }
                            else{
                                if(!dbMan.updateCourse_baseTestAverage(recdel.model.id, 2, v))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    testRec2.value = v;
                                }
                            }
                        }
                        function keyPressed()
                        {
                            this.doneEdit();
                            // find next and focus
                            let index = baseAvgPage.coursesId.indexOf(tte2.coId) + 1;
                            if(index < baseAvgPage.coursesId.length)
                            {
                                let newCoId = baseAvgPage.coursesId[index];
                                let item = baseAvgPage.findItemRecursive(lv, newCoId, 2, true);

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
                        text:(testRec2.value > -1000)? testRec2.value :"";
                        visible: tte2.onEditTF
                        Rectangle{height:2; width: parent.width; color: "olivedrab"; anchors.bottom:parent.bottom;}
                        validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                            regularExpression: /^-?\d*\.?\d+$/
                        }

                        Keys.onReturnPressed: this.keyPressed()
                        Keys.onEnterPressed: this.keyPressed();
                        Keys.onTabPressed: this.keyPressed()
                        Keys.onEscapePressed: {
                            tte2.onEditTF = false
                            baseAvgPage.onEditing = false
                            tte2.text = (testRec2.value > -1000)? testRec2.value : ""
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
                            onClicked: tte2.doneEdit();
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
                                tte2.onEditTF = false
                                tte2.text = (testRec2.value > -1000)? testRec2.value : ""
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
                            if(testRec2.value > -1000)
                            {
                                return testRec2.value;
                            }
                            else return ""
                        }
                        visible: !tte2.onEditTF
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


                                tte2.onEditTF = true
                                baseAvgPage.onEditing = true
                                tte2.focus = true
                            }
                        }
                    }

                }

                Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
            }

            Rectangle{width: parent.width; height: 5; color: "gainsboro"; anchors.bottom: parent.bottom;}

        }
    }

    Component{
        id: lvDelegate_summer
        Rectangle{
            id: recdel3;
            height: 80
            width: lv_summer.width

            //id, course_name,course_coefficient, base_id, period_id, base_average
            required property var model;
            color: (recdel3.model.index % 2 == 0)? "aliceblue" : "mintcream"

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
                    text: "  " + recdel3.model.course_name
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
                    text: "  " + recdel3.model.course_coefficient
                    color: "white"
                    background: Rectangle{color:"mediumvioletred"; anchors.fill:parent}
                }

                // avg value

                // semester summer
                Rectangle{
                    id: avgRec3
                    width: 150
                    height: 50

                    color:"transparent"
                    border.width: 1
                    border.color: "gray"

                    property real value : {
                        if(typeof recdel3.model["summer_avg"] != "undefined"){
                            if(recdel3.model["summer_avg"] !== "")
                                return recdel3.model["summer_avg"];
                            else
                                return -1000;
                        }
                        else return -1000;
                    }

                    TextField{
                        id: te3

                        property int seId : 3
                        property int coId : recdel3.model.id
                        property bool test : false
                        property bool onEditTF : false
                        function doneEdit()
                        {
                            te3.onEditTF =  false
                            var v = parseFloat(te3.text);

                            if(te3.text === "")
                            {
                                if(!dbMan.updateCourse_baseAverage(recdel3.model.id, 3))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    avgRec3.value = v;
                                }
                            }
                            else{
                                if(!dbMan.updateCourse_baseAverage(recdel3.model.id, 3, v))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    avgRec3.value = v;
                                }
                            }
                        }
                        function keyPressed()
                        {
                            this.doneEdit();
                            // find next and focus
                            let index = baseAvgPage.coursesId.indexOf(te3.coId) + 1;
                            if(index < baseAvgPage.coursesId.length)
                            {
                                let newCoId = baseAvgPage.coursesId[index];
                                let item = baseAvgPage.findItemRecursive(lv_summer, newCoId, 3, false);

                                if(item)
                                {
                                    item.onEditTF = true;
                                    baseAvgPage.onEditing = true
                                    item.forceActiveFocus();

                                    item = lv_summer.itemAtIndex(recdel3.model.index +1)
                                    if(item)
                                        flk_summer.contentY = ((flk_summer.height+flk_summer.contentY-100) <= item.y )? item.y : flk_summer.contentY
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
                        text:(avgRec3.value > -1000)? avgRec3.value :"";
                        visible: te3.onEditTF
                        Rectangle{height:2; width: parent.width; color: "olivedrab"; anchors.bottom:parent.bottom;}
                        validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                            regularExpression: /^-?\d*\.?\d+$/
                        }

                        Keys.onReturnPressed: this.keyPressed();
                        Keys.onEnterPressed: this.keyPressed();
                        Keys.onTabPressed: this.keyPressed()
                        Keys.onEscapePressed: {
                            te3.onEditTF = false
                            baseAvgPage.onEditing = false
                            te3.text = (avgRec3.value > -1000)? avgRec3.value : ""
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
                            onClicked: te3.doneEdit();
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
                                te3.onEditTF = false
                                te3.text = (avgRec3.value > -1000)? avgRec3.value : ""
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
                            if(avgRec3.value > -1000)
                            {
                                return avgRec3.value;
                            }
                            else return ""
                        }
                        visible: !te3.onEditTF
                        MouseArea{
                            anchors.fill: parent
                            onDoubleClicked:{

                                if(baseAvgPage.onEditing)
                                {
                                    var item = baseAvgPage.findTF(lv_summer, "onEditTF", true);
                                    while(item)
                                    {
                                        item.doneEdit();
                                        item = baseAvgPage.findTF(lv_summer, "onEditTF", true);
                                    }
                                }


                                te3.onEditTF = true
                                baseAvgPage.onEditing = true
                                te3.focus = true
                            }
                        }
                    }

                }
                // test summer
                Rectangle{
                    id: testRec3
                    width: 150
                    height: 50

                    color:"transparent"
                    border.width: 1
                    border.color: "gray"

                    property real value : {
                        if(typeof recdel3.model["summer_test"] != "undefined"){
                            if(recdel3.model["summer_test"] !== "")
                                return recdel3.model["summer_test"];
                            else
                                return -1000;
                        }
                        else return -1000;
                    }

                    TextField{
                        id: tte3

                        property int seId : 3 // semester
                        property int coId : recdel3.model.id // course
                        property bool test : true
                        property bool onEditTF : false
                        function doneEdit()
                        {
                            tte3.onEditTF =  false
                            var v = parseFloat(tte3.text);

                            if(tte3.text === "")
                            {
                                if(!dbMan.updateCourse_baseTestAverage(recdel3.model.id, 1))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    testRec3.value = v;
                                }
                            }
                            else{
                                if(!dbMan.updateCourse_baseTestAverage(recdel3.model.id, 3, v))
                                {
                                    infoDialogId.open();
                                }
                                else
                                {
                                    testRec3.value = v;
                                }
                            }
                        }
                        function keyPressed()
                        {
                            this.doneEdit();
                            // find next and focus
                            let index = baseAvgPage.coursesId.indexOf(tte3.coId) + 1;
                            if(index < baseAvgPage.coursesId.length)
                            {
                                let newCoId = baseAvgPage.coursesId[index];
                                let item = baseAvgPage.findItemRecursive(lv_summer, newCoId, 3, true);

                                if(item)
                                {
                                    item.onEditTF = true;
                                    baseAvgPage.onEditing = true
                                    item.forceActiveFocus();

                                    item = lv_summer.itemAtIndex(recdel3.model.index +1)
                                    if(item)
                                        flk_summer.contentY = ((flk_summer.height+flk_summer.contentY-100) <= item.y )? item.y : flk_summer.contentY
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
                        text:(testRec3.value > -1000)? testRec3.value :"";
                        visible: tte3.onEditTF
                        Rectangle{height:2; width: parent.width; color: "olivedrab"; anchors.bottom:parent.bottom;}
                        validator: RegularExpressionValidator { // Regex pattern to match floating-point numbers
                            regularExpression: /^-?\d*\.?\d+$/
                        }

                        Keys.onReturnPressed: this.keyPressed()
                        Keys.onEnterPressed: this.keyPressed();
                        Keys.onTabPressed: this.keyPressed()
                        Keys.onEscapePressed: {
                            tte3.onEditTF = false
                            baseAvgPage.onEditing = false
                            tte3.text = (testRec3.value > -1000)? testRec3.value : ""
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
                            onClicked: tte3.doneEdit();
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
                                tte3.onEditTF = false
                                tte3.text = (testRec3.value > -1000)? testRec3.value : ""
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
                            if(testRec3.value > -1000)
                            {
                                return testRec3.value;
                            }
                            else return ""
                        }
                        visible: !tte3.onEditTF
                        MouseArea{
                            anchors.fill: parent
                            onDoubleClicked:{

                                if(baseAvgPage.onEditing)
                                {
                                    var item = baseAvgPage.findTF(lv_summer, "onEditTF", true);
                                    while(item)
                                    {
                                        item.doneEdit();
                                        item = baseAvgPage.findTF(lv_summer, "onEditTF", true);
                                    }
                                }


                                tte3.onEditTF = true
                                baseAvgPage.onEditing = true
                                tte3.focus = true
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
