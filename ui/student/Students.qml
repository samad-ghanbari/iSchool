pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./Students.js" as JS

Page {
    id: studentsPage
    required property StackView appStackView;

    property bool fieldBased
    property int limit : 25
    property int offset: 0
    property int studentsCount
    property int pageNumber: 1
    // offset shoud be less or equal than limit

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignLeft
            text: "مدیریت دانش‌آموزان"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        Flickable{
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentHeight: centerBox.implicitHeight

            Column{
                id: centerBox
                width: parent.width
                // branch
                RowLayout
                {
                    width: 400
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"شعبه:"
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color:"darkcyan"
                        horizontalAlignment: Label.AlignRight
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: branchCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        editable: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: branchModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted:
                        {
                            branchModel.clear();
                            stepModel.clear();
                            studentModel.clear();

                            filterModel.clear();
                            filter_baseModel.clear();
                            filter_periodModel.clear();
                            filter_classModel.clear();
                            nameTF.text = "";
                            lastnameTF.text = "";

                            var jsondata = dbMan.getBranches();
                            //id, city, branch_name, address
                            var temp;
                            for(var obj of jsondata)
                            {
                                temp = obj.city + " - "+ obj.branch_name;
                                branchModel.append({value: obj.id,  text: temp })
                            }
                            branchCB.currentIndex = -1
                        }

                        onActivated: {
                            stepModel.clear();
                            studentModel.clear();

                            filterModel.clear();
                            filter_baseModel.clear();
                            filter_periodModel.clear();
                            filter_classModel.clear();
                            nameTF.text = "";
                            lastnameTF.text = "";

                            var jsondata = dbMan.getBranchSteps(branchCB.currentValue);
                            //s.id, s.branch_id, s.step_name, s.field_based, s.numeric_graded, b.city, b.branch_name
                            var temp;
                            for(var obj of jsondata)
                            {
                                stepModel.append({value: obj.id,  text: obj.step_name, field_based: obj.field_based })
                            }
                        }

                    }
                }
                //step
                RowLayout
                {
                    width: 400
                    height: 50
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"دوره: "
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color:"darkcyan"
                        horizontalAlignment: Label.AlignRight
                        verticalAlignment: Label.AlignVCenter
                    }
                    ComboBox
                    {
                        id: stepCB
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        Layout.maximumWidth: 400
                        editable: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: stepModel}
                        textRole: "text"
                        valueRole: "value"
                        onActivated: {
                            studentModel.clear();

                            filterModel.clear();
                            filter_baseModel.clear();
                            filter_periodModel.clear();
                            filter_classModel.clear();
                            nameTF.text = "";
                            lastnameTF.text = "";

                            var cond = {}
                            studentsPage.offset = 0;
                            studentsPage.pageNumber = 1

                            var step_id = stepCB.currentValue;
                            studentsPage.fieldBased = stepModel.get(stepCB.currentIndex)---

                            studentsPage.studentsCount = dbMan.getStudentsCount(step_id, cond);
                            studentCountLbl.text = studentsPage.studentsCount + " نفر "
                            var jsondata = dbMan.getStudents(step_id, cond, studentsPage.limit, studentsPage.offset);

                            for(var obj of jsondata){
                                studentModel.append(obj);
                            }

                            // upadate base-period-class
                            //base
                            jsondata = dbMan.getStepBases(stepCB.currentValue, false);
                            //b.id, b.step_id, b.field_id, s.branch_id, b.base_name, b.enabled, s.step_name, s.field_based, s.numeric_graded, f.field_name, br.branch_name, br.city, b.sort_priority
                            var temp;
                            for(obj of jsondata)
                            {
                                filter_baseModel.append({value: obj.id,  text: obj.base_name })
                            }
                            //period
                            jsondata = dbMan.getStepPeriods(step_id, false);
                            for(obj of jsondata)
                            {
                                //p.period_id, p.step_id, p.period_name, p.passed, s.step_name, s.branch_id, br.city, br.branch_name, s.numeric_graded, s.field_based, p.sort_priority
                                filter_periodModel.append({value: obj.period_id,  text: obj.period_name })
                            }

                            filter_baseCB.currentIndex = -1;
                            filter_periodCB.currentIndex = -1;
                        }

                    }
                }

                Item{width: parent.width; height: 10;}
                Rectangle{width: parent.width; height: 1; color: "darkgray";}
                Item{width: parent.width; height: 10;}

                RowLayout
                {
                    width: parent.width
                    height: 64

                    Button
                    {
                        background: Item{}
                        visible: (stepCB.currentIndex >=0)? true : false;
                        Layout.preferredHeight: 64
                        icon.source: "qrc:/assets/images/add.png"
                        icon.width: 40
                        icon.height: 40
                        text: "دانش‌آموز جدید"
                        font.pixelSize: 14
                        font.family: "Kalameh"
                        display: AbstractButton.TextUnderIcon
                        font.bold: true
                        icon.color:"transparent"
                        opacity: 0.5
                        onClicked:
                        {
                            var sid = stepCB.currentValue;
                            if(sid >= 0)
                            studentsPage.appStackView.push(studentInsertComponent);
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }
                    Item{Layout.fillWidth: true}
                    Label{
                        id: studentCountLbl
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        font.bold: true
                        color: "darkcyan"
                        height: 64
                        verticalAlignment: Label.AlignVCenter
                        horizontalAlignment: Label.AlignHCenter
                        text: ""
                    }

                    Item{Layout.fillWidth: true}
                    Button
                    {
                        visible: (stepCB.currentIndex >=0)? true : false;
                        Layout.preferredHeight: 64
                        background: Item{}
                        icon.source: "qrc:/assets/images/filter.png"
                        icon.width: 40
                        icon.height: 40
                        text: "فیلتر"
                        font.pixelSize: 14
                        font.family: "Kalameh"
                        display: AbstractButton.TextUnderIcon
                        icon.color:"transparent"
                        opacity: 0.5
                        onClicked:
                        {
                            var sid = stepCB.currentValue;
                            if(sid >= 0)
                            studentSearchDrawer.open();
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }
                }

                // filter box
                Flickable{
                    height:  32
                    width: parent.width
                    contentWidth: (filterBox.implicitWidth > width)?  filterBox.implicitWidth : width


                    RowLayout{
                        anchors.fill: parent
                        Row{
                            id: filterBox
                            Layout.preferredHeight: parent.height
                            spacing: 10
                            Layout.alignment: Qt.AlignHCenter

                            Repeater{
                                model: ListModel{id:filterModel}
                                delegate: FilterDelegate{
                                    id:delg
                                    required property var model;
                                    _key : delg.model._key
                                    _value: delg.model._value
                                    _type: delg.model._type
                                    widgetHeight: 32
                                    onRemoveSignal: (_type)=>{
                                        if(_type === "base"){
                                            filter_baseCB.currentIndex = -1;
                                            filter_classCB.currentIndex = -1;
                                        }
                                        else if(_type === "period"){
                                            filter_periodCB.currentIndex = -1;
                                            filter_classCB.currentIndex = -1;
                                        }
                                        else if(_type === "class")
                                            filter_classCB.currentIndex = -1;
                                        else if(_type === "name")
                                            nameTF.text = "";
                                        else if(_type === "lastname")
                                            lastnameTF.text = "";

                                        searchBtn.clicked();
                                    }
                                }
                            }
                        }
                    }

                }

                RowLayout
                {
                    height:   40
                    width:  parent.width
                    visible: (stepCB.currentIndex >=0)? true : false;
                    Item{Layout.fillWidth: true; Layout.preferredHeight: 10;}
                    Button
                    {
                        background: Item{}
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
                        icon.source: "qrc:/assets/images/toRight.png" // previous
                        icon.width: 40
                        icon.height: 40
                        icon.color:"transparent"
                        opacity: 0.5
                        visible: (studentsPage.offset == 0)? false : true
                        onClicked:
                        {
                            studentModel.clear();

                            var cond = {}
                            studentsPage.offset = studentsPage.offset - 24;
                            studentsPage.pageNumber = studentsPage.pageNumber - 1;
                            if(studentsPage.offset  < 0 ) { studentsPage.offset = 0; studentsPage.pageNumber = 1;}
                            var jsondata = dbMan.getStudents(stepCB.currentValue, cond, studentsPage.limit, studentsPage.offset);

                            for(var obj of jsondata){
                                studentModel.append(obj);
                            }
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }

                    Label{
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        font.bold: true
                        color: "darkcyan"
                        height: 40
                        verticalAlignment: Label.AlignVCenter
                        horizontalAlignment: Label.AlignHCenter
                        text: studentsPage.pageNumber
                    }

                    Button
                    {
                        visible: (studentsPage.offset + 24 >= studentsPage.studentsCount)? false : true;
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
                        background: Item{}
                        icon.source: "qrc:/assets/images/toLeft.png" //next
                        icon.width: 40
                        icon.height: 40
                        icon.color:"transparent"
                        opacity: 0.5
                        onClicked:
                        {
                            studentModel.clear();

                            studentsPage.offset = studentsPage.offset + 24;
                            studentsPage.pageNumber = studentsPage.pageNumber + 1;
                            if(studentsPage.offset >= studentsPage.studentsCount ){ studentsPage.offset = studentsPage.offset - 24; studentsPage.pageNumber = studentsPage.pageNumber - 1;}

                            var cond = {}
                            var jsondata = dbMan.getStudents(stepCB.currentValue, cond, studentsPage.limit, studentsPage.offset);

                            for(var obj of jsondata){
                                studentModel.append(obj);
                            }
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }
                    Item{Layout.fillWidth: true; Layout.preferredHeight: 10;}
                }

                Item{width: parent.width; height: 10;}

                GridView {
                    id: studentsGV
                    width: parent.width
                    height: studentsGV.contentHeight
                    cellWidth: 300
                    cellHeight: 340
                    clip: true
                    model: ListModel{id: studentModel}
                    delegate: studentDelegate
                    layoutDirection: Qt.LeftToRight
                }
            }
        }
    }

    // delegate
    Component
    {
        id: studentDelegate
        Rectangle {
            id: rec
            required property var model;

            width: 256
            height: 300
            color:(rec.model.enabled)? "white" : "lightpink"
            opacity: 0.8
            radius: 10
            border.width: 2
            border.color: "lavenderblush"

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged:{
                    if(containsMouse){
                        parent.opacity=1;
                        rec.border.color = "pink"
                    }
                    else
                    {
                        rec.border.color = "lavenderblush"
                        parent.opacity=0.8
                    }
                }

            }

            Item
            {
                anchors.fill: parent
                anchors.margins: 5
                ColumnLayout
                {
                    anchors.fill: parent

                    Image {
                        source:rec.model.photo;
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 100
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: rec.model.name + " " + rec.model.lastname
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                        Layout.preferredWidth: parent.width
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text {
                        text: "نام پدر" + " : " + rec.model.fathername
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.fillWidth: true
                    }
                    Text {
                        text: "تاریخ تولد" + " : " + rec.model.birthday
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.fillWidth: true
                    }

                    Item{Layout.preferredWidth:  1; Layout.fillHeight: true;}

                    Row{
                        Layout.alignment: Qt.AlignRight
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 120
                        Button
                        {
                            width: 40
                            height: 32
                            background: Item{}
                            icon.source: "qrc:/assets/images/trash.png"
                            icon.width: 32
                            icon.height: 32
                            icon.color:"transparent"
                            opacity: 0.5
                            onClicked: {
                                studentsPage.appStackView.push(studentDeleteComponent, {
                                                                   student_id: rec.model.id,
                                                                   name: rec.model.name,
                                                                   lastname: rec.model.lastname,
                                                                   fathername: rec.model.fathername,
                                                                   gender: rec.model.gender,
                                                                   birthday: rec.model.birthday,
                                                                   photo: rec.model.photo,
                                                                   enabled: rec.model.enabled
                                                               }
                                                               );
                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                        Button
                        {
                            width: 40
                            height: 32
                            background: Item{}
                            icon.source: "qrc:/assets/images/edit.png"
                            icon.width: 32
                            icon.height: 32
                            icon.color:"transparent"
                            opacity: 0.5
                            onClicked: {

                                studentsPage.appStackView.push(studentUpdateComponent, {
                                                                   student_id: rec.model.id,
                                                                   name: rec.model.name,
                                                                   lastname: rec.model.lastname,
                                                                   fathername: rec.model.fathername,
                                                                   gender: rec.model.gender,
                                                                   birthday: rec.model.birthday,
                                                                   photo: rec.model.photo,
                                                                   enabled: rec.model.enabled
                                                               }
                                                               );
                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                        Button
                        {
                            width: 40
                            height: 32
                            background: Item{}
                            icon.source: "qrc:/assets/images/folders.png"
                            icon.width: 32
                            icon.height: 32
                            icon.color:"transparent"
                            opacity: 0.5
                            onClicked: {
                                studentsPage.appStackView.push(registrationsComponent, {
                                                                   student_id: rec.model.id,
                                                                   name: rec.model.name,
                                                                   lastname: rec.model.lastname,
                                                                   fathername: rec.model.fathername,
                                                                   gender: rec.model.gender,
                                                                   birthday: rec.model.birthday,
                                                                   photo: rec.model.photo,
                                                                   enabled: rec.model.enabled
                                                               }
                                                               );
                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }
                }

            }


        }
    }

    //Insert
    Component
    {
        id: studentInsertComponent
        StudentInsert
        {
            step_id : stepCB.currentValue
            step: stepCB.currentText
            branch: branchCB.currentText
            onPopStackSignal: studentsPage.appStackView.pop();
            onInsertedSignal:
            {
                JS.loadStudents();
                // studentModel.clear();
                // var cond = {}
                // studentsPage.offset = 0;
                // studentsPage.pageNumber = 1

                // studentsPage.studentsCount = dbMan.getStudentsCount(stepCB.currentValue, cond);
                // studentCountLbl.text = studentsPage.studentsCount + " نفر "
                // var jsondata = dbMan.getStudents(stepCB.currentValue, cond, studentsPage.limit, studentsPage.offset);

                // for(var obj of jsondata){
                //     studentModel.append(obj);
                // }
            }
        }
    }

    //update
    Component
    {
        id: studentUpdateComponent
        StudentUpdate
        {
            step: stepCB.currentText
            branch: branchCB.currentText
            onPopStackSignal: studentsPage.appStackView.pop();
            onUpdatedSignal:
            {
                JS.loadStudents();
                // studentModel.clear();
                // var cond = {}
                // studentsPage.offset = 0;
                // studentsPage.pageNumber = 1

                // studentsPage.studentsCount = dbMan.getStudentsCount(stepCB.currentValue, cond);
                // studentCountLbl.text = studentsPage.studentsCount + " نفر "
                // var jsondata = dbMan.getStudents(stepCB.currentValue, cond, studentsPage.limit, studentsPage.offset);

                // for(var obj of jsondata){
                //     studentModel.append(obj);
                // }
            }
        }
    }

    // delete
    Component
    {
        id: studentDeleteComponent
        StudentDelete
        {
            step: stepCB.currentText
            branch: branchCB.currentText
            onPopStackSignal: studentsPage.appStackView.pop();
            onDeletedSignal:
            {
                JS.loadStudents();
                // studentModel.clear();
                // var cond = {}
                // studentsPage.offset = 0;
                // studentsPage.pageNumber = 1

                // studentsPage.studentsCount = dbMan.getStudentsCount(stepCB.currentValue, cond);
                // studentCountLbl.text = studentsPage.studentsCount + " نفر "
                // var jsondata = dbMan.getStudents(stepCB.currentValue, cond, studentsPage.limit, studentsPage.offset);

                // for(var obj of jsondata){
                //     studentModel.append(obj);
                // }
            }
        }
    }

    // registrations
    Component{
        id: registrationsComponent
        Registrations{
            step: stepCB.currentText
            step_id: stepCB.currentValue
            field_based: stepModel.get(stepCB.currentIndex)["field_based"];
            branch: branchCB.currentText
            appStackView: studentsPage.appStackView
        }
    }

    //drawer
    Drawer
    {
        id: studentSearchDrawer
        modal: true
        height: parent.height
        width: 300
        dragMargin: 0
        //interactive: false


        ScrollView
        {
            id: studentDrawerSV
            anchors.fill: parent

            ColumnLayout
            {
                width: studentDrawerSV.width

                Rectangle
                {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 110
                    color: "darkcyan"

                    Image {
                        id: searchImage
                        source: "qrc:/assets/images/search.png"
                        width: 64
                        height: 64
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        width: parent.width
                        height: 40
                        anchors.top: searchImage.bottom
                        horizontalAlignment: Qt.AlignHCenter
                        anchors.topMargin: 10
                        text: "جستجوی دانش‌آموزان "
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignHCenter
                        font.bold: true
                        color:"white"
                    }
                }

                // base
                Text {
                    text: "پایه تحصیلی"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                ComboBox{
                    id: filter_baseCB
                    model: ListModel{id: filter_baseModel;}
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                    textRole: "text"
                    valueRole: "value"

                    onActivated: {
                        filter_periodCB.currentIndex = -1;
                        filter_classModel.clear();

                    }
                }

                // period
                Text {
                    text: "سال تحصیلی"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                ComboBox{
                    id: filter_periodCB
                    model: ListModel{id: filter_periodModel;}
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                    textRole: "text"
                    valueRole: "value"

                    onActivated: {
                        filter_classModel.clear();
                        var jsondata = dbMan.getBaseClasses(filter_baseCB.currentValue, filter_periodCB.currentValue);
                        //
                        for(var obj of jsondata)
                        {
                            filter_classModel.append(({value: obj.class_id,  text: obj.class_name }))
                        }

                        filter_classCB.currentIndex = -1;
                    }
                }

                // class
                Text {
                    text: "کلاس"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                ComboBox{
                    id: filter_classCB
                    model: ListModel{id: filter_classModel;}
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                    textRole: "text"
                    valueRole: "value"
                }


                Text {
                    text: "نام"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: nameTF
                    placeholderText: "نام دانش‌آموز"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }

                //lastname
                Text {
                    text: "نام‌‌خانوادگی"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: lastnameTF
                    placeholderText: "نام ‌خانوادگی دانش‌آموز"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }


                // button

                Button
                {
                    id: searchBtn
                    text: "جستجو"
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 100
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    icon.source: "qrc:/assets/images/search.png"
                    icon.width: 32
                    icon.height: 32
                    icon.color:"transparent"

                    onClicked: JS.loadStudents();

                    Rectangle{width: parent.width; height: 4; color:"darkcyan"; anchors.bottom: parent.bottom}
                }
            }
        }
    }
}
