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

        RowLayout{
            Layout.columnSpan: 2
            Layout.preferredHeight:  50
            Layout.preferredWidth: branchLbl.width + branchCB.width
            Layout.alignment: Qt.AlignHCenter

            Label
            {
                id: branchLbl
                Layout.preferredHeight:  50
                Layout.preferredWidth: 100
                text:" انتخاب شعبه"
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
                Layout.maximumWidth: 400
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

                onActivated: Methods.classUpdate(branchCB.currentValue)
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
                    visible: (branchCB.currentIndex >=0)? true : false;
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

                ListView
                {
                    id: classLV
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: 10
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    spacing: 5
                    model: ListModel{id: classModel}
                    highlight: Item{}
                    delegate: classDelegate

                    function closeSwipeHandler()
                    {
                        for (var i = 0; i <= classLV.count; i++)
                        {
                            var item = classLV.contentItem.children[i];
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


    //Insert
    Component
    {
        id: classInsertComponent
        ClassInsert{
            onPopStackSignal: classPage.appStackView.pop();
            onClassInsertedSignal: Methods.classUpdate(branchCB.currentValue);
            branchId : branchCB.currentValue;
            branchText: branchCB.currentText;
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

            // c.id, c.branch_id, c.class_name, c.class_desc, b.city, b.branch_name
            height: 110
            width: classLV.width
            checkable: true
            checked: classRecDel.swipe.complete
            onCheckedChanged: { if(!classRecDel.checked) classRecDel.swipe.close();}
            clip: true

            background: Rectangle{color: (classRecDel.highlighted)? "snow" : "whitesmoke";}

            contentItem: Rectangle
            {
                color: (classRecDel.highlighted)? "snow" : "whitesmoke";

                Column
                {
                    id: classRecDelCol
                    anchors.fill: parent

                    spacing: 0
                    Label {
                        text: classRecDel.model.ClassName
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
                        text: classRecDel.model.ClassDesc
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

                    Rectangle{width: 400; height:5; color: (classRecDel.highlighted)? "mediumvioletred" : "whitesmoke"; anchors.horizontalCenter: parent.horizontalCenter }
                }
            }

            onClicked: {classRecDel.swipe.close();}
            onPressed: { classLV.currentIndex = model.index; classLV.closeSwipeHandler();}
            highlighted: (model.index === classLV.currentIndex)? true: false;

            swipe.right: Row{
                width: 150
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
                        if(classRecDel.swipe.complete)
                            classRecDel.swipe.close();

                        classPage.appStackView.push(deleteClassComponent, {classId: classRecDel.model.Id, className: classRecDel.model.ClassName, classDesc: classRecDel.model.ClassDesc, branchText: branchCB.currentText });
                    }
                }
                Button
                {
                    height: 100
                    width: 75
                    background:  Rectangle{id:editBtnBg; color: "royalblue"}
                    hoverEnabled: true
                    onHoveredChanged: editBtnBg.color=(hovered)? Qt.darker("royalblue", 1.1):"royalblue"
                    text: "ویرایش"
                    font.bold: true
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    palette.buttonText:  "white"
                    icon.source: "qrc:/assets/images/edit.png"
                    icon.width: 32
                    icon.height: 32
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(classRecDel.swipe.complete)
                            classRecDel.swipe.close();

                        classPage.appStackView.push(updateClassComponent, {classId: classRecDel.model.Id, className: classRecDel.model.ClassName, classDesc: classRecDel.model.ClassDesc, sortPriority: classRecDel.model.SortPriority, branchText: branchCB.currentText });

                    }
                }
            }


        }
    }
    Component
    {
        id: updateClassComponent
        ClassUpdate
        {
            onPopStackSignal: classPage.appStackView.pop();
            onClassUpdatedSignal : Methods.classUpdate(branchCB.currentValue);
        }
    }
    Component
    {
        id: deleteClassComponent
        ClassDelete
        {
            onPopStackSignal: classPage.appStackView.pop();
            onClassDeletedSignal : Methods.classUpdate(branchCB.currentValue);
        }
    }

}
