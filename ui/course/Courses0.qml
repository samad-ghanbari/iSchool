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

                    GridView
                    {
                        id: baseCoursesGV
                        Layout.columnSpan: 2
                        implicitHeight: 600;
                        Layout.fillWidth: true
                        Layout.margins: 20
                        flickableDirection: Flickable.AutoFlickDirection
                        cellWidth: 320  // 20 spacing
                        cellHeight: 270
                        clip: true
                        model: ListModel{id: baseCoursesModel}
                        visible : (baseCB.currentValue > 0)? true : false;
                        highlight: Item{}
                        delegate: baseDelegate

                        function closeSwipeHandler()
                        {
                            for (var i = 0; i <= baseCoursesGV.count; i++)
                            {
                                var item = baseCoursesGV.contentItem.children[i];
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
                    GridView
                    {
                        id: stepCoursesGV
                        Layout.columnSpan: 2
                        implicitHeight: 600;
                        Layout.fillWidth: true
                        Layout.margins: 10
                        flickableDirection: Flickable.AutoFlickDirection
                        clip: true
                        cellWidth: 300
                        cellHeight: 250
                        model: ListModel{id: stepCoursesModel}
                        visible : (stepCB.currentValue > -1)? true : false;
                        highlight: Item{}
                        delegate: stepDelegate

                        function closeSwipeHandler()
                        {
                            for (var i = 0; i <= stepCoursesGV.count; i++)
                            {
                                var item = stepCoursesGV.contentItem.children[i];
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
        // co.id, co.course_name, co.step_id, co.study_base_id, co.study_period_id, co.course_coefficient,
        // co.test_coefficient,  co.shared_coefficient, co.final_weight, st.branch_id, st.step_name, sb.study_base, sp.study_period

        SwipeDelegate
        {
            id: recDel
            required property var model;
            height: 250
            width: 300
            checkable: true
            checked: recDel.swipe.complete
            onCheckedChanged: { if(!recDel.checked) recDel.swipe.close();}
            clip: true

            background: Rectangle{color: (recDel.highlighted)? "snow" : "whitesmoke";}

            contentItem: Rectangle
            {
                color: (recDel.highlighted)? "snow" : "whitesmoke";
                border.width: (recDel.highlighted)? 2 : 1;
                border.color: (recDel.highlighted)? "mediumvioletred" : "gray";

                //coefficient
                Rectangle
                {
                    id: cBaseCoefLabel
                    width: 30
                    height: 30
                    anchors.top: parent.top
                    anchors.right: parent.right
                    color: (recDel.highlighted)? "mediumvioletred" : "gray";
                    Text
                    {
                        anchors.centerIn: parent
                        text: recDel.model.Course_coefficient
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "white"
                    }
                }
                Rectangle
                {
                    width: 30
                    height: 30
                    anchors.top: cBaseCoefLabel.bottom
                    anchors.right: parent.right
                    color: (recDel.highlighted)? "darkmagenta" : "gray";
                    Text
                    {
                        anchors.centerIn: parent
                        text:  recDel.model.Test_coefficient
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                    }
                }

                Column
                {
                    id: recDelCol
                    anchors.fill: parent

                    spacing: 0
                    Image
                    {
                        width: 64
                        height: 64
                        anchors.horizontalCenter: parent.horizontalCenter
                        source:  "qrc:/assets/images/course.png"
                    }

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

                }
            }

            onClicked: {recDel.swipe.close();}
            onPressed: { baseCoursesGV.currentIndex = model.index; baseCoursesGV.closeSwipeHandler();}
            highlighted: (model.index === baseCoursesGV.currentIndex)? true: false;

            swipe.right:Column{
                width: 48
                height: 250
                anchors.left: parent.left

                Button
                {
                    height: 48
                    width: 48
                    background:Item{}
                    hoverEnabled: true
                    opacity: 0.5
                    onHoveredChanged: (hovered)? this.opacity=1 : this.opacity=0.5
                    icon.source: "qrc:/assets/images/trash.png"
                    icon.width: 48
                    icon.height: 48
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(recDel.swipe.complete)
                            recDel.swipe.close();

                        coursesPage.appStackView.push(deleteComponent, {
                                                          course_id: recDel.model.Id,
                                                          course_name: recDel.model.Course_name,
                                                          course_coefficient: recDel.model.Course_coefficient,
                                                          test_coefficient: recDel.model.Test_coefficient,
                                                          teacher: recDel.model.Teacher,
                                                          class_name: recDel.model.Class_name
                                                      });

                    }
                }

                Button
                {
                    height: 48
                    width: 48
                    background: Item{} //Rectangle{id:editBtnBg; color: "crimson"}
                    hoverEnabled: true
                    opacity: 0.5
                    onHoveredChanged:(hovered)? this.opacity=1 : this.opacity=0.5
                    //text: "ویرایش"
                    //font.bold: true
                    //font.family: "B Yekan"
                    //font.pixelSize: 14
                    //palette.buttonText:  "white"
                    icon.source: "qrc:/assets/images/edit.png"
                    icon.width: 48
                    icon.height: 48
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(recDel.swipe.complete)
                            recDel.swipe.close();

                        coursesPage.appStackView.push(updateComponent, {
                                                          course_id: recDel.model.Id,
                                                          course_name: recDel.model.Course_name,
                                                          course_coefficient: recDel.model.Course_coefficient,
                                                          test_coefficient: recDel.model.Test_coefficient,
                                                          shared_coefficient: recDel.model.Shared_coefficient,
                                                          final_weight:  recDel.model.Final_weight,
                                                          teacher_id: recDel.model.Teacher_id,
                                                          class_id: recDel.model.Class_id
                                                      });
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
            height: 250
            width: 300
            checkable: true
            checked: recDel.swipe.complete
            onCheckedChanged: { if(!recDel.checked) recDel.swipe.close();}
            clip: true

            background: Rectangle{color: (recDel.highlighted)? "snow" : "whitesmoke";}

            contentItem: Rectangle
            {
                color: (recDel.highlighted)? "snow" : "whitesmoke";
                border.width: (recDel.highlighted)? 2 : 1;
                border.color: (recDel.highlighted)? "mediumvioletred" : "gray";

                //coefficient course-test
                Rectangle
                {
                    id:cStepCoefLabel
                    width: 30
                    height: 30
                    anchors.top: parent.top
                    anchors.right: parent.right
                    color: (recDel.highlighted)? "mediumvioletred" : "gray";
                    Text
                    {
                        anchors.centerIn: parent
                        text: recDel.model.Course_coefficient
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                    }
                }
                Rectangle
                {
                    width: 30
                    height: 30
                    anchors.top: cStepCoefLabel.bottom
                    anchors.right: parent.right
                    color: (recDel.highlighted)? "darkmagenta" : "gray";
                    Text
                    {
                        anchors.centerIn: parent
                        text:  recDel.model.Test_coefficient
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "white"
                    }
                }

                Column
                {
                    id: recDelCol
                    anchors.fill: parent

                    spacing: 0
                    Image
                    {
                        width: 64
                        height: 64
                        anchors.horizontalCenter: parent.horizontalCenter
                        source:  "qrc:/assets/images/course.png"
                    }

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

                }
            }

            onClicked: {recDel.swipe.close();}
            onPressed: { stepCoursesGV.currentIndex = model.index; stepCoursesGV.closeSwipeHandler();}
            highlighted: (model.index === stepCoursesGV.currentIndex)? true: false;

            swipe.right: Column{
                width: 48
                height: 250
                anchors.left: parent.left

                Button
                {
                    height: 48
                    width: 48
                    background: Item{}
                    hoverEnabled: true
                    opacity: 0.5
                    onHoveredChanged: (hovered)? this.opacity=1 : this.opacity=0.5
                    icon.source: "qrc:/assets/images/trash.png"
                    icon.width: 48
                    icon.height: 48
                    SwipeDelegate.onClicked:
                    {
                        if(recDel.swipe.complete)
                            recDel.swipe.close();

                        coursesPage.appStackView.push(deleteComponent, {
                                                          course_id: recDel.model.Id,
                                                          course_name: recDel.model.Course_name,
                                                          course_coefficient: recDel.model.Course_coefficient,
                                                          test_coefficient: recDel.model.Test_coefficient,
                                                          //shared_coefficient: recDel.model.Shared_coefficient,
                                                          //final_weight:  recDel.model.Final_weight,
                                                      });
                    }
                }

                Button
                {
                    height: 48
                    width: 48
                    background: Item{}// Rectangle{id:trashBtnBg; color: "crimson"}
                    hoverEnabled: true
                    opacity: 0.5
                    onHoveredChanged: (hovered)? this.opacity=1 : this.opacity=0.5
                    icon.source: "qrc:/assets/images/edit.png"
                    icon.width: 48
                    icon.height: 48
                    SwipeDelegate.onClicked:
                    {
                        if(recDel.swipe.complete)
                            recDel.swipe.close();

                        coursesPage.appStackView.push(updateComponent, {
                                                          course_id: recDel.model.Id,
                                                          course_name: recDel.model.Course_name,
                                                          course_coefficient: recDel.model.Course_coefficient,
                                                          test_coefficient: recDel.model.Test_coefficient,
                                                          shared_coefficient: recDel.model.Shared_coefficient,
                                                          final_weight:  recDel.model.Final_weight,
                                                      });
                    }
                }
            }
        }
    }

    // insert
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

    // delete
    Component
    {
        id: deleteComponent
        CourseDelete
        {
            onPopStackSignal : coursesPage.appStackView.pop();
            onDeletedSignal : Methods.updateCourse(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);

            branch: branchCB.currentText
            step: stepCB.currentText
            base: baseCB.currentText
            period: periodCB.currentText

        }
    }
    //update
    Component
    {
        id: updateComponent
        CourseUpdate
        {
            onPopStackSignal : coursesPage.appStackView.pop();
            onUpdatedSignal : Methods.updateCourse(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);

            branch_id: branchCB.currentValue
            base_id: baseCB.currentValue
            step_id: stepCB.currentValue
            period_id: periodCB.currentValue

            branch: branchCB.currentText
            step: stepCB.currentText
            base: baseCB.currentText
            period: periodCB.currentText
        }
    }
}
