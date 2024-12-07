pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//import "./../public" as DialogBox;
import "Class.js" as Methods

Page {
    id: classPage
    required property StackView appStackView;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    GridLayout
    {
        anchors.fill: parent
        columns:2

        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/arrow-right.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: classPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "لیست کلاس‌های شعبه"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Flow
        {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            layoutDirection: Qt.LeftToRight
            Layout.alignment: Qt.AlignHCenter

            // branch
            Rectangle
            {
                height: 50
                width: 400
                color: "transparent"

                RowLayout
                {
                    anchors.fill: parent

                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"شعبه:"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignRight
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
                height: 50
                width: 400
                color: "transparent"
                RowLayout
                {
                    anchors.fill: parent
                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"دوره:"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignRight
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
                height: 50
                width: 400
                color: "transparent"
                RowLayout
                {
                    anchors.fill: parent
                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"پایه تحصیلی:"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignRight
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
                height: 50
                width: 400
                color: "transparent"
                RowLayout
                {
                    anchors.fill: parent
                    Label
                    {
                        Layout.preferredHeight:  50
                        Layout.preferredWidth: 100
                        text:"سال تحصیلی:"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignRight
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
                        Component.onCompleted: periodCB.currentIndex = -1

                        onActivated: Methods.updateClassModel(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue)
                    }
                }
            }
        }

        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "ghostwhite"
            ColumnLayout
            {
                anchors.fill: parent

                Button
                {
                    Layout.preferredHeight:   64
                    Layout.preferredWidth: 64
                    Layout.alignment: Qt.AlignRight
                    background: Item{}
                    visible: (periodCB.currentIndex >=0)? true : false;
                    icon.source: "qrc:/assets/images/add.png"
                    icon.width: 64
                    icon.height: 64
                    opacity: 0.5
                    onClicked:
                    {
                        var bid = branchCB.currentValue;
                        if(bid >= 0)
                            classPage.appStackView.push(classInsertComponent);
                    }
                    hoverEnabled: true
                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                }

                GridView
                {
                    id: classGV
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: 10
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    cellWidth: 320
                    cellHeight: 170
                    model: ListModel{id: classModel}
                    highlight: Item{}
                    delegate: classDelegate

                    function closeSwipeHandler()
                    {
                        for (var i = 0; i <= classGV.count; i++)
                        {
                            var item = classGV.contentItem.children[i];
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


    // swipe delegate
    Component
    {
        id: classDelegate
        SwipeDelegate
        {
            id: classRecDel
            required property var model;

            //c.id, c.step_id, c.study_base_id, c.study_period_id, c.class_name, c.class_desc, c.sort_priority, st.step_name, sb.study_base, sp.study_period
            height: 150
            width: 300
            checkable: true
            checked: classRecDel.swipe.complete
            onCheckedChanged: { if(!classRecDel.checked) classRecDel.swipe.close();}
            clip: true

            background: Rectangle{color: (classRecDel.highlighted)? "snow" : "whitesmoke";}

            contentItem: Rectangle
            {
                color: (classRecDel.highlighted)? "snow" : "whitesmoke";
                border.color: (classRecDel.highlighted)? "mediumvioletred" : "lightgray"

                Column
                {
                    id: classRecDelCol
                    anchors.fill: parent
                    Item{ width: parent.width;height: 10;}
                    spacing: 0
                    Label {
                        text: "کلاس " + classRecDel.model.Class_name
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (classRecDel.highlighted)? 20 :16
                        font.bold: (classRecDel.highlighted)? true : false
                        color: (classRecDel.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: classRecDel.model.Class_desc
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (classRecDel.highlighted)? 20 :16
                        font.bold: (classRecDel.highlighted)? true : false
                        color: (classRecDel.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Item{ width: parent.width;height: 10;}
                }
            }

            onClicked: {classRecDel.swipe.close();}
            onPressed: { classGV.currentIndex = model.index; classGV.closeSwipeHandler();}
            highlighted: (model.index === classGV.currentIndex)? true: false;

            swipe.right: Column{
                width: 60
                height: 150
                anchors.left: parent.left

                Button
                {
                    height: 32
                    width: 32
                    //background:  Rectangle{id:detailBtnBg; color: "palegreen"}
                    hoverEnabled: true
                    //onHoveredChanged: detailBtnBg.color=(hovered)? Qt.darker("palegreen", 1.1):"palegreen"
                    //text: "جزئیات"
                    //font.bold: true
                    //font.family: "B Yekan"
                    //font.pixelSize: 14
                    //palette.buttonText:  "white"
                    icon.source: "qrc:/assets/images/course.png"
                    icon.width: 32
                    icon.height: 32
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(classRecDel.swipe.complete)
                            classRecDel.swipe.close();

                        classPage.appStackView.push(classDetailComponent, {
                                                        class_id: classRecDel.model.Id,
                                                        class_name: classRecDel.model.Class_name,
                                                        class_desc: classRecDel.model.Class_desc,
                                                    });

                    }
                }
                // class student
                Button
                {
                    height: 32
                    width: 32
                    hoverEnabled: true
                    icon.source: "qrc:/assets/images/users.png"
                    icon.width: 32
                    icon.height: 32
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(classRecDel.swipe.complete)
                            classRecDel.swipe.close();

                        classPage.appStackView.push(classStudentsComponent, {
                                                        class_id: classRecDel.model.Id,
                                                        class_name: classRecDel.model.Class_name,
                                                        class_desc: classRecDel.model.Class_desc,
                                                    });

                    }
                }
                Button
                {
                    height: 32
                    width: 32
                    //background:  Rectangle{id:editBtnBg; color: "royalblue"}
                    hoverEnabled: true
                    //onHoveredChanged: editBtnBg.color=(hovered)? Qt.darker("royalblue", 1.1):"royalblue"
                    //text: "ویرایش"
                    //font.bold: true
                    //font.family: "B Yekan"
                    //font.pixelSize: 14
                    //palette.buttonText:  "white"
                    icon.source: "qrc:/assets/images/edit.png"
                    icon.width: 32
                    icon.height: 32
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(classRecDel.swipe.complete)
                            classRecDel.swipe.close();

                        classPage.appStackView.push(updateClassComponent, {
                                                        class_id: classRecDel.model.Id,
                                                        class_name: classRecDel.model.Class_name,
                                                        class_desc: classRecDel.model.Class_desc,
                                                        sort_priority: classRecDel.model.Sort_priority,
                                                        branch_text: branchCB.currentText,
                                                        period_text : periodCB.currentText
                                                    });

                    }
                }

                Button
                {
                    height: 32
                    width: 32
                    //background: Rectangle{id:trashBtnBg; color: "crimson"}
                    hoverEnabled: true
                    //onHoveredChanged: trashBtnBg.color=(hovered)? Qt.darker("crimson", 1.1):"crimson"
                    //text: "حذف"
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
                        if(classRecDel.swipe.complete)
                            classRecDel.swipe.close();

                        classPage.appStackView.push(deleteClassComponent, {
                                                        class_id: classRecDel.model.Id,
                                                        class_name: classRecDel.model.Class_name,
                                                        class_desc: classRecDel.model.Class_desc,
                                                        branch_text: branchCB.currentText,
                                                        period_text : periodCB.currentText
                                                    });
                    }
                }
            }


        }
    }

    //Insert
    Component
    {
        id: classInsertComponent
        ClassInsert{
            onPopStackSignal: classPage.appStackView.pop();
            onClassInsertedSignal: Methods.updateClassModel(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue)

            step_id: stepCB.currentValue
            base_id: baseCB.currentValue
            period_id: periodCB.currentValue

            branch_text: branchCB.currentText;
            step_text: stepCB.currentText
            base_text: baseCB.currentText
            period_text: periodCB.currentText;
        }
    }

    //update
    Component
    {
        id: updateClassComponent
        ClassUpdate
        {
            onPopStackSignal: classPage.appStackView.pop();
            onClassUpdatedSignal : Methods.updateClassModel(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue)

            branch_text: branchCB.currentText;
            step_text: stepCB.currentText
            base_text : baseCB.currentText;
            period_text: periodCB.currentText;
        }
    }

    //detail
    Component
    {
        id: classDetailComponent
        ClassDetail
        {
            appStackView : classPage.appStackView;

            branch_id: branchCB.currentValue
            step_id: stepCB.currentValue;
            base_id: baseCB.currentValue;
            period_id: periodCB.currentValue;

            branch_text: branchCB.currentText;
            step_text: stepCB.currentText
            base_text : baseCB.currentText;
            period_text: periodCB.currentText;
        }
    }

    // class students
    Component
    {
        id: classStudentsComponent
        ClassStudents{
            appStackView : classPage.appStackView;

            branch_id: branchCB.currentValue
            step_id: stepCB.currentValue;
            base_id: baseCB.currentValue;
            period_id: periodCB.currentValue;

            branch_text: branchCB.currentText;
            step_text: stepCB.currentText
            base_text : baseCB.currentText;
            period_text: periodCB.currentText;
        }
    }

    //delete
    Component
    {
        id: deleteClassComponent
        ClassDelete
        {
            onPopStackSignal: classPage.appStackView.pop();
            onDeletedSignal : Methods.updateClassModel(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);

            branch_text: branchCB.currentText;
            step_text: stepCB.currentText
            base_text : baseCB.currentText;
            period_text: periodCB.currentText
        }
    }

}
