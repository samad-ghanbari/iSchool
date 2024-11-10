pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Course.js" as Methods

Page {
    id: coursesPage

    required property StackView appStackView;
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
            onClicked: coursesPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "دروس ارائه شده"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        // branch
        Rectangle
        {
            Layout.columnSpan: 2
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            Layout.maximumWidth: 400
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 10
            color: "transparent"

            RowLayout
            {
                anchors.fill: parent

                Label
                {
                    Layout.preferredHeight:  50
                    Layout.preferredWidth: 120
                    text:"شعبه"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                }
                ComboBox
                {
                    id: branchCB
                    Layout.preferredHeight:  50
                    Layout.fillWidth: true
                    editable: false
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    model: ListModel{id: branchCBoxModel}
                    textRole: "text"
                    valueRole: "value"
                    Component.onCompleted:
                    {
                        Methods.updateBranchCB();
                        branchCB.currentIndex = -1
                    }

                    onActivated: Methods.updateStepCB(branchCB.currentValue)
                }
            }

        }

        // step
        Rectangle
        {
            Layout.columnSpan: 2
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            Layout.maximumWidth: 400
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 10
            color: "transparent"
            RowLayout
            {
                anchors.fill: parent
                Label
                {
                    Layout.preferredHeight:  50
                    Layout.preferredWidth: 120
                    text:"دوره"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                }
                ComboBox
                {
                    id: stepCB
                    Layout.preferredHeight:  50
                    Layout.fillWidth: true
                    editable: false
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    model: ListModel{id: stepCBoxModel}
                    textRole: "text"
                    valueRole: "value"
                    Component.onCompleted: stepCB.currentIndex = -1

                    onActivated: Methods.updateBaseCB(branchCB.currentValue)
                }
            }
        }

        // base
        Rectangle
        {
            Layout.columnSpan: 2
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            Layout.maximumWidth: 400
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 10
            color: "transparent"
            RowLayout
            {
                anchors.fill: parent
                Label
                {
                    Layout.preferredHeight:  50
                    Layout.preferredWidth: 120
                    text:"پایه‌تحصیلی"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                }
                ComboBox
                {
                    id: baseCB
                    Layout.preferredHeight:  50
                    Layout.fillWidth: true
                    editable: false
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    model: ListModel{id: baseCBoxModel}
                    textRole: "text"
                    valueRole: "value"
                    Component.onCompleted:
                    {
                        baseCB.currentIndex = -1
                    }

                    onActivated: Methods.updatePeriodCB(branchCB.currentValue);
                }
            }
        }

        // period
        Rectangle
        {
            Layout.columnSpan: 2
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            Layout.maximumWidth: 400
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: 10
            color: "transparent"
            RowLayout
            {
                anchors.fill: parent
                Label
                {
                    Layout.preferredHeight:  50
                    Layout.preferredWidth: 120
                    text:"سال‌تحصیلی"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    horizontalAlignment: Label.AlignLeft
                    verticalAlignment: Label.AlignVCenter
                }
                ComboBox
                {
                    id: periodCB
                    Layout.preferredHeight:  50
                    Layout.fillWidth: true
                    editable: false
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    model: ListModel{id: periodCBoxModel}
                    textRole: "text"
                    valueRole: "value"
                    Component.onCompleted: stepCB.currentIndex = -1

                    onActivated: Methods.updateCourse(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);
                }
            }
        }

        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.preferredHeight: 4
            color: "skyblue"
            Layout.topMargin: 10
            Layout.bottomMargin: 10
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
                width: parent.width
                implicitHeight : centerBox.implicitHeight + 40
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"

                GridLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20
                    columns: 2

                    Button
                    {
                        Layout.columnSpan: 2
                        Layout.preferredWidth: 64
                        Layout.preferredHeight: 64
                        Layout.alignment: Qt.AlignRight
                        visible: (periodCB.currentValue > -1)? true : false;
                        background: Item{}
                        icon.source: "qrc:/assets/images/add.png"
                        icon.width: 64
                        icon.height: 64
                        opacity: 0.5
                        onClicked: coursesPage.appStackView.push(insertCourseComponent);
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;

                    }

                    Text {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignLeft
                        text: "دروس پایه‌تحصیلی"
                        font.family: "B Yekan"
                        font.pixelSize: 24
                        font.bold: true
                        color: "mediumvioletred"
                        style: Text.Outline
                        styleColor: "white"
                        visible : (baseCB.currentValue > 0)? true : false;
                    }

                    ListView
                    {
                        id: baseCoursesLV
                        Layout.columnSpan: 2
                        implicitHeight: baseCoursesModel.count*120;
                        Layout.fillWidth: true
                        Layout.margins: 10
                        flickableDirection: Flickable.AutoFlickDirection
                        clip: true
                        spacing: 5
                        model: ListModel{id: baseCoursesModel}
                        visible : (baseCB.currentValue > 0)? true : false;
                        highlight: Item{}
                        delegate: baseDelegate

                        function closeSwipeHandler()
                        {
                            for (var i = 0; i <= baseCoursesLV.count; i++)
                            {
                                var item = baseCoursesLV.contentItem.children[i];
                                if(item.swipe)
                                {
                                    item.swipe.close();
                                    item.checked = false;
                                }
                            }
                        }
                    }

                    Item{Layout.columnSpan: 2; Layout.fillWidth: true; Layout.preferredHeight: 50;}

                    Rectangle{ Layout.columnSpan: 2; Layout.fillWidth: true; Layout.preferredHeight: 50; color: "ghostwhite"}

                    Text {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignLeft
                        text: "دروس مشترک دوره"
                        font.family: "B Yekan"
                        font.pixelSize: 24
                        font.bold: true
                        color: "mediumvioletred"
                        style: Text.Outline
                        styleColor: "white"
                        visible : (stepCB.currentValue > -1)? true : false;
                    }
                    ListView
                    {
                        id: stepCoursesLV
                        Layout.columnSpan: 2
                        implicitHeight: stepCoursesModel.count*120;
                        Layout.fillWidth: true
                        Layout.margins: 10
                        flickableDirection: Flickable.AutoFlickDirection
                        clip: true
                        spacing: 5
                        model: ListModel{id: stepCoursesModel}
                        visible : (stepCB.currentValue > -1)? true : false;
                        highlight: Item{}
                        delegate: stepDelegate

                        function closeSwipeHandler()
                        {
                            for (var i = 0; i <= stepCoursesLV.count; i++)
                            {
                                var item = stepCoursesLV.contentItem.children[i];
                                if(item.swipe)
                                {
                                    item.swipe.close();
                                    item.checked = false;
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    // delegate base courses
    Component
    {
        id: baseDelegate
        SwipeDelegate
        {
            id: recDel
            required property var model;
            height: 110
            width: baseCoursesLV.width
            checkable: true
            checked: recDel.swipe.complete
            onCheckedChanged: { if(!recDel.checked) recDel.swipe.close();}
            clip: true

            background: Rectangle{color: (recDel.highlighted)? "snow" : "whitesmoke";}

            contentItem: Rectangle
            {
                // co.id, co.course_name, co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id,
                // cl.class_name, st.branch_id, st.step_name, sb.study_base, sp.study_period, t.teacher

                // Course_name  Class_name  Teacher

                color: (recDel.highlighted)? "snow" : "whitesmoke";

                Column
                {
                    id: recDelCol
                    anchors.fill: parent

                    spacing: 0
                    Label {
                        text: recDel.model.Course_name
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDel.highlighted)? 20 :16
                        font.bold: (recDel.highlighted)? true : false
                        color: (recDel.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: recDel.model.Class_name + " - " + recDel.model.Teacher
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDel.highlighted)? 20 :16
                        font.bold: (recDel.highlighted)? true : false
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }

                    Rectangle{width: 400; height:5; color: (recDel.highlighted)? "mediumvioletred" : "whitesmoke"; anchors.horizontalCenter: parent.horizontalCenter }
                }
            }

            onClicked: {recDel.swipe.close();}
            onPressed: { baseCoursesLV.currentIndex = model.index; baseCoursesLV.closeSwipeHandler();}
            highlighted: (model.index === baseCoursesLV.currentIndex)? true: false;

            swipe.right: Row{
                width: 75
                height: 100
                anchors.left: parent.left

                Button
                {
                    height: 100
                    width: 75
                    background: Rectangle{id:trashBtnBg; color: "crimson"}
                    hoverEnabled: true
                    onHoveredChanged: trashBtnBg.color=(hovered)? Qt.darker("crimson", 1.1):"crimson"
                    text: "حذف"
                    font.bold: true
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    palette.buttonText:  "white"
                    icon.source: "qrc:/assets/images/trash.png"
                    icon.width: 32
                    icon.height: 32
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(recDel.swipe.complete)
                            recDel.swipe.close();

                        //coursesPage.appStackView.push(deleteComponent, {regId: recDel.model.Id, regStep: recDel.model.Step_name, regBase: recDel.model.Study_base, regPeriod: recDel.model.Study_period });
                    }
                }
            }
        }
    }


    //delegate step courses
    Component
    {
        id: stepDelegate
        SwipeDelegate
        {
            id: recDel
            required property var model;
            height: 110
            width: stepCoursesLV.width
            checkable: true
            checked: recDel.swipe.complete
            onCheckedChanged: { if(!recDel.checked) recDel.swipe.close();}
            clip: true

            background: Rectangle{color: (recDel.highlighted)? "snow" : "whitesmoke";}

            contentItem: Rectangle
            {
                // co.id, co.course_name, co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id,
                // cl.class_name, st.branch_id, st.step_name, sb.study_base, sp.study_period, t.teacher

                // Course_name  Class_name  Teacher

                color: (recDel.highlighted)? "snow" : "whitesmoke";

                Column
                {
                    id: recDelCol
                    anchors.fill: parent

                    spacing: 0
                    Label {
                        text: recDel.model.Course_name
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDel.highlighted)? 20 :16
                        font.bold: (recDel.highlighted)? true : false
                        color: (recDel.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: recDel.model.Class_name + " - " + recDel.model.Teacher
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDel.highlighted)? 20 :16
                        font.bold: (recDel.highlighted)? true : false
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }

                    Rectangle{width: 400; height:5; color: (recDel.highlighted)? "mediumvioletred" : "whitesmoke"; anchors.horizontalCenter: parent.horizontalCenter }
                }
            }

            onClicked: {recDel.swipe.close();}
            onPressed: { stepCoursesLV.currentIndex = model.index; stepCoursesLV.closeSwipeHandler();}
            highlighted: (model.index === stepCoursesLV.currentIndex)? true: false;

            swipe.right: Row{
                width: 75
                height: 100
                anchors.left: parent.left

                Button
                {
                    height: 100
                    width: 75
                    background: Rectangle{id:trashBtnBg; color: "crimson"}
                    hoverEnabled: true
                    onHoveredChanged: trashBtnBg.color=(hovered)? Qt.darker("crimson", 1.1):"crimson"
                    text: "حذف"
                    font.bold: true
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    palette.buttonText:  "white"
                    icon.source: "qrc:/assets/images/trash.png"
                    icon.width: 32
                    icon.height: 32
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(recDel.swipe.complete)
                            recDel.swipe.close();

                        //coursesPage.appStackView.push(deleteComponent, {regId: recDel.model.Id, regStep: recDel.model.Step_name, regBase: recDel.model.Study_base, regPeriod: recDel.model.Study_period });

                    }
                }
            }
        }
    }

    Component
    {
        id: insertCourseComponent
        CourseInsert
        {
            onPopStackSignal: coursesPage.appStackView.pop();
            onInsertedSignal: Methods.updateCourse(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);

            branch_id: branchCB.currentValue
            step_id: stepCB.currentValue
            base_id: baseCB.currentValue
            period_id: periodCB.currentValue

            branch: branchCB.currentText
            step: stepCB.currentText
            base: baseCB.currentText
            period: periodCB.currentText
        }
    }

}
