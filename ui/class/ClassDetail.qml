pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Class.js" as Methods

Page {
    id: classDetailPage
    property int classId;
    property int branchId;
    property int periodId;
    property string branchText
    property string className;
    property string classDesc;
    property string periodText;

    required property StackView appStackView;

    signal classDetailUpdatedSignal();

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
            onClicked: classDetailPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "جزئیات کلاس"
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

                    Text {
                        Layout.columnSpan: 2
                        text: "شعبه " + classDetailPage.branchText
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
                        Layout.columnSpan: 2
                        text: "سال تحصیلی " + classDetailPage.periodText
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
                        Layout.columnSpan: 2
                        text: "کلاس " + classDetailPage.className
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
                        Layout.columnSpan: 2
                        text: "سال تحصیلی " + classDetailPage.periodText
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
                        Layout.columnSpan: 2
                        text: classDetailPage.classDesc
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }

                    Button
                    {
                        Layout.preferredHeight:   64
                        Layout.preferredWidth: 64
                        Layout.alignment: Qt.AlignRight
                        background: Item{}
                        icon.source: "qrc:/assets/images/add.png"
                        icon.width: 64
                        icon.height: 64
                        opacity: 0.5
                        onClicked: classDetailPage.appStackView.push(classDetailInsertComponent);
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }

                    GridView
                    {
                        id: classDetailGV
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.margins: 10
                        Layout.columnSpan: 2
                        flickableDirection: Flickable.AutoFlickDirection
                        clip: true
                        cellWidth: 320
                        cellHeight: 140
                        model: ListModel{id: classDetailModel}
                        highlight: Item{}
                        delegate: classDetailDelegate

                        function closeSwipeHandler()
                        {
                            for (var i = 0; i <= classDetailGV.count; i++)
                            {
                                var item = classDetailGV.contentItem.children[i];
                                if(item.swipe)
                                {
                                    item.swipe.close();
                                    item.checked = false;
                                }
                            }
                        }

                        Component.onCompleted: Methods.updateClassDetailModel(classDetailPage.classId);

                    }


                }

            }
        }
    }


    //Insert
    Component
    {
        id: classDetailInsertComponent
        Item{


        }
    }

    // swipe delegate
    Component
    {
        id: classDetailDelegate
        SwipeDelegate
        {
            id: recDelg
            required property var model;

            // id, cd.class_id, cd.course_id, cd.teacher_id, co.course_name, t.teacher
            height: 120
            width: 300
            checkable: true
            checked: recDelg.swipe.complete
            onCheckedChanged: { if(!recDelg.checked) recDelg.swipe.close();}
            clip: true

            background: Rectangle{color: (recDelg.highlighted)? "snow" : "whitesmoke";}

            contentItem: Rectangle
            {
                color: (recDelg.highlighted)? "snow" : "whitesmoke";
                border.color: (recDelg.highlighted)? "mediumvioletred" : "lightgray"

                Column
                {
                    id: recDelgCol
                    anchors.fill: parent
                    Item{ width: parent.width;height: 10;}
                    spacing: 0
                    Label {
                        text:  recDelg.model.Course_name
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDelg.highlighted)? 20 :16
                        font.bold: (recDelg.highlighted)? true : false
                        color: (recDelg.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: recDelg.model.Teacher
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDelg.highlighted)? 20 :16
                        font.bold: (recDelg.highlighted)? true : false
                        color: (recDelg.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Item{ width: parent.width;height: 10;}
                }
            }

            onClicked: {recDelg.swipe.close();}
            onPressed: { classDetailGV.currentIndex = model.index; classDetailGV.closeSwipeHandler();}
            highlighted: (model.index === classDetailGV.currentIndex)? true: false;

            swipe.right: Column{
                width: 60
                height: 120
                anchors.left: parent.left


                Button
                {
                    height: 32
                    width: 32
                    background:  Rectangle{id:editBtnBg; color: "royalblue"}
                    hoverEnabled: true
                    onHoveredChanged: editBtnBg.color=(hovered)? Qt.darker("royalblue", 1.1):"royalblue"
                    //text: "ویرایش"
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
                        if(recDelg.swipe.complete)
                            recDelg.swipe.close();

                        classDetailPage.appStackView.push(updateClassDetailComponent, {
                                                        Id: recDelg.model.Id,
                                                        Class_id: recDelg.model.Class_id,
                                                        Course_name: recDelg.model.Course_name,
                                                        Teacher: recDelg.model.Teacher,
                                                        Course_id: recDelg.model.Course_id,
                                                        Teacher_id: branchCB.Teacher_id
                                                    });

                    }
                }

                Button
                {
                    height: 32
                    width: 32
                    background: Rectangle{id:trashBtnBg; color: "crimson"}
                    hoverEnabled: true
                    onHoveredChanged: trashBtnBg.color=(hovered)? Qt.darker("crimson", 1.1):"crimson"
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
                        if(recDelg.swipe.complete)
                            recDelg.swipe.close();

                        classDetailPage.appStackView.push(deleteClassDetailComponent, {
                                                              Id: recDelg.model.Id,
                                                              Class_id: recDelg.model.Class_id,
                                                              Course_name: recDelg.model.Course_name,
                                                              Teacher: recDelg.model.Teacher,
                                                              Course_id: recDelg.model.Course_id,
                                                              Teacher_id: branchCB.Teacher_id
                                                          });
                    }
                }
            }


        }
    }

    //update
    Component
    {
        id: updateClassDetailComponent
        Item
        {
        }
    }


    //delete
    Component
    {
        id: deleteClassDetailComponent
        Item
        {
        }
    }

}
