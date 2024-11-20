pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Class.js" as Methods
import "./../public" as DialogBox


Page {
    id: classDetailPage
    required property int class_id;
    required property int branch_id;
    required property int step_id;
    required property int base_id;
    required property int period_id;
    required property string branch_text
    required property string step_text
    required property string base_text
    required property string period_text
    required property string class_name
    required property string class_desc

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
                        text: "شعبه " + classDetailPage.branch_text
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
                        text: classDetailPage.step_text + " - " + classDetailPage.base_text
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
                        text:  classDetailPage.period_text
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
                        text: "کلاس " + classDetailPage.class_name + " - " + classDetailPage.class_desc
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                        color: "royalblue"
                    }



                    Item
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 64
                        Button
                        {
                            height:   64
                            width: 64
                            anchors.left: parent.left
                            background: Item{}
                            icon.source: "qrc:/assets/images/add.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked: classDetailPage.appStackView.push(classDetailInsertComponent);
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }
                    Item
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 64
                        Button
                        {
                            height:   64
                            width: 64
                            anchors.right: parent.right
                            background: Item{}
                            icon.source: "qrc:/assets/images/refresh.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked:{
                                var courses = dbMan.getClassLeftCourses(classDetailPage.class_id, classDetailPage.step_id, classDetailPage.base_id, classDetailPage.period_id);
                                for(var c in courses)
                                {
                                    teacherSelectionDialog._course_name = c.course_name;
                                    teacherSelectionDialog._course_id = c.course_id;
                                    teacherSelectionDialog.open();
                                }

                                teacherSelectionDialog.close();
                            }

                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }


                    GridView
                    {
                        id: classDetailGV
                        Layout.fillHeight: true
                        implicitHeight: 500
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

                        Component.onCompleted: Methods.updateClassDetailModel(classDetailPage.class_id);

                    }

                }

            }
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
                    hoverEnabled: true
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
                                                        class_detail_id: recDelg.model.Id,
                                                        class_id: recDelg.model.Class_id,
                                                        course_id: recDelg.model.Course_id,
                                                        teacher_id: recDelg.model.Teacher_id
                                                    });

                    }
                }

                Button
                {
                    height: 32
                    width: 32
                    hoverEnabled: true
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
                                                              class_detail_id: recDelg.model.Id,
                                                              class_id: recDelg.model.Class_id,
                                                              course_name: recDelg.model.Course_name,
                                                              teacher: recDelg.model.Teacher,
                                                          });
                    }
                }
            }


        }
    }

    //Insert
    Component
    {
        id: classDetailInsertComponent
        ClassDetailInsert{
            branch_id : classDetailPage.branch_id;
            step_id: classDetailPage.step_id;
            base_id: classDetailPage.base_id;
            period_id: classDetailPage.period_id;
            class_id: classDetailPage.class_id;

            branch_text: classDetailPage.branch_text;
            step_text: classDetailPage.step_text;
            base_text: classDetailPage.base_text;
            period_text: classDetailPage.period_text;
            class_name: classDetailPage.class_name;
            class_desc: classDetailPage.class_desc;

            onPopStackSignal: classDetailPage.appStackView.pop();
            onInsertedSignal: Methods.updateClassDetailModel(classDetailPage.class_id);
        }
    }

    //update
    Component
    {
        id: updateClassDetailComponent
        ClassDetailUpdate{
            branch_id : classDetailPage.branch_id;
            step_id: classDetailPage.step_id;
            base_id: classDetailPage.base_id;
            period_id: classDetailPage.period_id;
            class_id: classDetailPage.class_id;

            branch_text: classDetailPage.branch_text;
            step_text: classDetailPage.step_text;
            base_text: classDetailPage.base_text;
            period_text: classDetailPage.period_text;
            class_name: classDetailPage.class_name;
            class_desc: classDetailPage.class_desc;

            onPopStackSignal: classDetailPage.appStackView.pop();
            onUpdatedSignal: Methods.updateClassDetailModel(classDetailPage.class_id);
        }
    }

    //delete
    Component
    {
        id: deleteClassDetailComponent
        ClassDetailDelete{
            branch_id : classDetailPage.branch_id;
            step_id: classDetailPage.step_id;
            base_id: classDetailPage.base_id;
            period_id: classDetailPage.period_id;
            class_id: classDetailPage.class_id;

            branch_text: classDetailPage.branch_text;
            step_text: classDetailPage.step_text;
            base_text: classDetailPage.base_text;
            period_text: classDetailPage.period_text;
            class_name: classDetailPage.class_name;
            class_desc: classDetailPage.class_desc;

            onPopStackSignal: classDetailPage.appStackView.pop();
            onDeletedSignal: Methods.updateClassDetailModel(classDetailPage.class_id);
        }
    }

    DialogBox.BaseDialog
    {
        id: errorDialogId
        dialogTitle: "خطا در بروزرسانی اطلاعات"
        dialogText: "بروزرسانی اطلاعات کلاس با خطا مواجه شد."
        dialogSuccess: false
        onDialogRejected: teacherSelectionDialog.close();
    }

    Dialog
    {
        id:teacherSelectionDialog
        property string _course_name;
        property int _course_id
        width: (parent.width > 400)? 400 : parent.width
        height: 200
        modal: true
        closePolicy:Popup.NoAutoClose
        dim: true
        anchors.centerIn: parent;
        //standardButtons: Dialog.Ok
        title: "بروزرسانی کلاس"


        header: Rectangle{
            width: parent.width;
            height: 50;
            color:  "forestgreen"
            Text{ text: "انتخاب مدرس"; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "B Yekan"; font.pixelSize: 16}
        }

        contentItem:
            ColumnLayout
        {
            id: baseDialogCLId
            width: parent.width
            height: Qt.binding(function(){ return (dialogContent.height + 100);})

            Item{Layout.preferredHeight:  10; Layout.preferredWidth: baseDialogCLId.width;}

            Text {
                id: dialogContent
                Layout.preferredWidth: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: "عنوان درس: " + teacherSelectionDialog._course_name;
                font.family: "B Yekan"
                font.pixelSize: 16
                color:  "forestgreen" ;
            }
            RowLayout
            {
                Text {
                    text: "مدرس: "
                    Layout.minimumWidth: 150
                    Layout.maximumWidth: 150
                    Layout.preferredHeight: 50
                    verticalAlignment: Text.AlignVCenter
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    color: "royalblue"
                }
                ComboBox
                {
                    id: teacherCB
                    Layout.preferredHeight:  50
                    Layout.fillWidth: true
                    editable: false
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    model: ListModel{id: teacherCBoxModel}
                    textRole: "text"
                    valueRole: "value"
                    Component.onCompleted:
                    {
                        Methods.updateTeacherCB(classDetailPage.branch_id);
                    }
                }
            }
        }

        footer:
            Item{
            width: parent.width;
            height: 50
            RowLayout
            {
                Button{
                    text: "انصراف"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    onClicked: teacherSelectionDialog.close();
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
                }
                Button
                {
                    text: "تایید"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    enabled : (teacherCB.currentValue > -1)? true : false;
                    onClicked: {
                        var _class_id = classDetailPage.class_id
                        var _teacher_id = teacherCB.currentValue;
                        var _course_id = teacherSelectionDialog._course_id;

                        var obj = {}
                        obj["class_id"] = _class_id;
                        obj["course_id"] = _course_id
                        obj["teacher_id"] = _teacher_id;

                        if(!dbMan.classDetailInsert(obj))
                        {
                            errorDialogId.dialogText = "بروزرسانی درس " + teacherSelectionDialog._course_name + " با خطا مواجه شد."
                            errorDialogId.close();
                        }

                    }

                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                }
                Item{Layout.fillWidth: true}
            }
        }
    }

}
