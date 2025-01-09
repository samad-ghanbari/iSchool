pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//import "./../public" as DialogBox;
import "Class.js" as Methods

Page {
    id: classPage
    required property StackView appStackView;

    property bool admin : dbMan.isUserAdmin()

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
            icon.color:"transparent"
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
            text: "مدیریت کلاس‌ها"
            font.family: "Kalameh"
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
                        font.family: "Kalameh"
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
                        font.family: "Kalameh"
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
                        font.family: "Kalameh"
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
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: stepCBoxModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted: stepCB.currentIndex = -1

                        onActivated: Methods.updatePeriodCB(stepCB.currentValue);
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
                        font.family: "Kalameh"
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
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        model: ListModel{id: periodCBoxModel}
                        textRole: "text"
                        valueRole: "value"
                        Component.onCompleted: periodCB.currentIndex = -1

                        onActivated: Methods.updateClassModel(stepCB.currentValue, periodCB.currentValue)
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
                    visible: (periodCB.currentIndex >=0  && classPage.admin)? true : false;
                    icon.source: "qrc:/assets/images/add.png"
                    icon.width: 64
                    icon.height: 64
                    icon.color:"transparent"
                    opacity: 0.5
                    enabled : classPage.admin
                    onClicked:
                    {
                        var sid = stepCB.currentValue;
                        if(sid >= 0)
                        classPage.appStackView.push(classInsertComponent);
                    }
                    hoverEnabled: true
                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                }

                Item{Layout.fillWidth: true; Layout.preferredHeight: 20; visible:!classPage.admin;}

                GridView
                {
                    id: classGV
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: 10
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    cellWidth: 320
                    cellHeight: 250
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
            id: rec
            required property var model;

            //cl.id, cl.base_id, b.step_id, s.step_name, s.field_based, b.base_name, b.field_id, f.field_name, cl.period_id, cl.class_name, cl.class_desc, cl.sort_priority "\

            height: 220
            width: 300
            checkable: true
            checked: rec.swipe.complete
            onCheckedChanged: { if(!rec.checked) rec.swipe.close();}
            clip: true

            background: Rectangle{
                color: (rec.highlighted)? "snow" : "whitesmoke";
                border.color: "lightgray";
                border.width: (rec.highlighted)? 4 : 0 ;
            }

            padding: 0
            contentItem: Rectangle
            {
                color: (rec.highlighted)? "snow" : "whitesmoke";
                //border.color: (rec.highlighted)? "mediumvioletred" : "lightgray"

                Column
                {
                    id: recCol
                    anchors.fill: parent
                    Item{
                        width: parent.width
                        height: 48
                        Image {
                            source: "qrc:/assets/images/classroom2.png"
                            anchors.centerIn: parent
                            height:  48
                            width:  48
                        }
                    }


                    Item{ width: parent.width;height: 10;}
                    spacing: 0
                    Label {
                        text: "کلاس " + rec.model.class_name
                        padding: 0
                        font.family: "Kalameh"
                        font.pixelSize: (rec.highlighted)? 20 :16
                        font.bold: (rec.highlighted)? true : false
                        color: (rec.highlighted)? "darkmagenta":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: {
                            var temp = rec.model.base_name;
                            if(!temp.includes("پایه")) temp = "پایه " + temp;

                            if(rec.model.field_based){
                                return rec.model.field-name + " - " + temp;
                            }
                            else{
                                return temp;
                            }
                        }
                        padding: 0
                        font.family: "Kalameh"
                        font.pixelSize: (rec.highlighted)? 20 :16
                        font.bold: (rec.highlighted)? true : false
                        color: (rec.highlighted)? "darkmagenta":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }

                    Label {
                        text: rec.model.class_desc
                        padding: 0
                        font.family: "Kalameh"
                        font.pixelSize: (rec.highlighted)? 20 :16
                        font.bold: (rec.highlighted)? true : false
                        color: (rec.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Item{ width: parent.width;height: 10;}
                }

                // bottom bar
                Rectangle{
                    height: 5;
                    width: rec.width;
                    anchors.bottom: parent.bottom;
                    anchors.margins: 0
                    color: "darkmagenta";
                }
            }

            onClicked: {rec.swipe.close();}
            onPressed: { classGV.currentIndex = model.index; classGV.closeSwipeHandler();}
            highlighted: (model.index === classGV.currentIndex)? true: false;

            swipe.right:
            Rectangle{
                width: 40
                height: 220
                anchors.left: parent.left
                color: "darkmagenta"
                Column{
                    anchors.fill: parent
                    // class student
                    Button
                    {
                        height: 40
                        width: 40
                        hoverEnabled: true
                        icon.source: "qrc:/assets/images/users.png"
                        icon.width: 40
                        icon.height: 40
                        icon.color:"transparent"
                        display: AbstractButton.TextUnderIcon
                        SwipeDelegate.onClicked:
                        {
                            if(rec.swipe.complete)
                            rec.swipe.close();

                            classPage.appStackView.push(classStudentsComponent, { model: rec.model  });

                        }
                    }

                    Button
                    {
                        height: 40
                        width: 40
                        hoverEnabled: true
                        icon.source: "qrc:/assets/images/course.png"
                        icon.width: 40
                        icon.height: 40
                        icon.color:"transparent"
                        display: AbstractButton.TextUnderIcon
                        SwipeDelegate.onClicked:
                        {
                            if(rec.swipe.complete)
                            rec.swipe.close();

                            classPage.appStackView.push(classDetailComponent, {   model: rec.model });

                        }
                    }

                    Button
                    {
                        height: 40
                        width: 40
                        hoverEnabled: true
                        icon.source: "qrc:/assets/images/edit.png"
                        icon.width: 40
                        icon.height: 40
                        icon.color:"transparent"
                        visible : classPage.admin
                        display: AbstractButton.TextUnderIcon
                        SwipeDelegate.onClicked:
                        {
                            if(rec.swipe.complete)
                            rec.swipe.close();

                            classPage.appStackView.push(updateClassComponent, {
                                                            model: rec.model
                                                        });

                        }
                    }

                    Button
                    {
                        height: 40
                        width: 40
                        hoverEnabled: true
                        font.bold: true
                        visible : classPage.admin
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        palette.buttonText:  "white"
                        icon.source: "qrc:/assets/images/trash.png"
                        icon.width: 40
                        icon.height: 40
                        icon.color:"transparent"
                        display: AbstractButton.TextUnderIcon
                        SwipeDelegate.onClicked:
                        {
                            if(rec.swipe.complete)
                            rec.swipe.close();

                            classPage.appStackView.push(deleteClassComponent, {  model: rec.model   });
                        }
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
            onClassInsertedSignal: Methods.updateClassModel(stepCB.currentValue, periodCB.currentValue)

            step_id: stepCB.currentValue
            period_id: periodCB.currentValue

            branch: branchCB.currentText;
            step: stepCB.currentText
            period: periodCB.currentText;
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
