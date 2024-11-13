pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Evals.js" as Methods

Page {
    id: evalsPage

    required property StackView appStackView;
    required property string branch
    required property string step
    required property string base
    required property string period
    required property string course_name
    required property string teacher
    required property string class_name
    required property real course_coefficient
    required property real test_coefficient


    required property int    course_id


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
            onClicked: evalsPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ارزیابی‌های درسی"
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
                    rowSpacing: 20
                    columnSpacing: 20
                    columns: 2

                    // branch
                    Label
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        color: "royalblue"
                        text:"شعبه " + evalsPage.branch + "، " + evalsPage.step
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                    }
                    Label
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        color: "royalblue"
                        text: evalsPage.base
                        visible: (evalsPage.base == "")? false : true
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                    }
                    Label
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        color: "mediumvioletred"
                        text:"سال تحصیلی " + evalsPage.period
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        font.bold: true
                    }
                    Label
                    {
                        background: Rectangle{anchors.fill: parent; color:"royalblue"}
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 80
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        color: "white"
                        text: evalsPage.course_name + " ( " +  evalsPage.teacher + " ) "
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        font.bold: true
                        Label
                        {
                            id: courseCoefLbl
                            width: 30
                            height: 40
                            anchors.top: parent.top
                            anchors.right: parent.right
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            text: evalsPage.course_coefficient
                            color: "white"
                            background: Rectangle{anchors.fill: parent; color:"mediumvioletred"}
                        }
                        Label
                        {
                            width: 30
                            height: 40
                            anchors.top: courseCoefLbl.bottom
                            anchors.right: parent.right
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                            text: evalsPage.test_coefficient
                            color: "white"
                            background: Rectangle{anchors.fill: parent; color:"darkmagenta"}
                        }
                    }

                    Button
                    {
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 64
                        Layout.preferredWidth: 64
                        Layout.alignment: Qt.AlignRight
                        background: Item{}
                        icon.source: "qrc:/assets/images/add.png"
                        icon.width: 64
                        icon.height: 64
                        opacity: 0.5
                        onClicked: evalsPage.appStackView.push(insertComponent)
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }

                    GridView
                    {
                        id: evalsGV
                        Layout.columnSpan: 2
                        implicitHeight: 600;
                        Layout.fillWidth: true
                        Layout.margins: 20
                        flickableDirection: Flickable.AutoFlickDirection
                        cellWidth: 320
                        cellHeight: 270 // 20 spacing
                        clip: true
                        model: ListModel{id: evalsModel}
                        highlight: Item{}
                        delegate: evalsDelegate
                        Component.onCompleted: Methods.updateEvals(evalsPage.course_id);


                        function closeSwipeHandler()
                        {
                            for (var i = 0; i <= evalsGV.count; i++)
                            {
                                var item = evalsGV.contentItem.children[i];
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
        id: evalsDelegate
        // e.id, e.eval_name, e.eval_time, e.course_id, e.max_value
        // co.course_name, co.class_id, co.step_id, co.study_base_id, co.teacher_id, co.study_period_id,
        // cl.class_name, t.name, t.lastname

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

                Image
                {
                    source: "qrc:/assets/images/certified48.png"
                    width: 48
                    height: 48
                    anchors.top: parent.top
                    anchors.left : parent.left

                    visible: (recDel.model.Final_eval)? true : false;
                }
                Image
                {
                    source: "qrc:/assets/images/stop48.png"
                    width: 48
                    height: 48
                    anchors.top: parent.top
                    anchors.left : parent.left
                    visible: (recDel.model.Report_included)? false : true;
                }

                Rectangle
                {
                    width: 70
                    height: 30
                    anchors.top: parent.top
                    anchors.right : parent.right
                    color: "mediumvioletred"
                    Text
                    {
                        anchors.centerIn: parent
                        color: "white"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        text: (recDel.model.Percentage)? "%"+ recDel.model.Max_value : recDel.model.Max_value
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
                        source:  "qrc:/assets/images/evaluation.png"
                    }

                    Label {
                        text: recDel.model.Eval_name
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
                        text: recDel.model.Eval_time
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDel.highlighted)? 20 :16
                        font.bold: (recDel.highlighted)? true : false
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }

                    Label {
                        text: recDel.model.Teacher
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDel.highlighted)? 20 :16
                        font.bold: (recDel.highlighted)? true : false
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                }
            }

            onClicked: {recDel.swipe.close();}
            onPressed: { evalsGV.currentIndex = model.index; evalsGV.closeSwipeHandler();}
            highlighted: (model.index === evalsGV.currentIndex)? true: false;

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

                        evalsPage.appStackView.push(deleteComponent, {
                                                        eval_id: recDel.model.Id,
                                                        eval_name: recDel.model.Eval_name,
                                                        eval_time: recDel.model.Eval_time,
                                                        max_value: recDel.model.Max_value,
                                                        max_value: recDel.model.Max_value,
                                                        percentage: recDel.model.Percentage,
                                                        final_eval: recDel.model.Final_eval,
                                                        semester: recDel.model.Semester
                                                    });

                    }
                }

                Button
                {
                    height: 48
                    width: 48
                    background: Item{}
                    hoverEnabled: true
                    opacity: 0.5
                    onHoveredChanged:(hovered)? this.opacity=1 : this.opacity=0.5
                    icon.source: "qrc:/assets/images/edit.png"
                    icon.width: 48
                    icon.height: 48
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(recDel.swipe.complete)
                            recDel.swipe.close();

                        evalsPage.appStackView.push(updateComponent,  {
                                                        eval_id: recDel.model.Id,
                                                        eval_name: recDel.model.Eval_name,
                                                        eval_time: recDel.model.Eval_time,
                                                        max_value: recDel.model.Max_value,
                                                        percentage: recDel.model.Percentage,
                                                        final_eval: recDel.model.Final_eval,
                                                        semester: recDel.model.Semester,
                                                        report_included: recDel.model.Report_included
                                                    });
                    }
                }
            }
        }
    }


    //eval insert
    Component
    {
        id: insertComponent
        EvalInsert
        {
            onPopStackSignal: evalsPage.appStackView.pop();
            onInsertedSignal: Methods.updateEvals(evalsPage.course_id);
            branch: evalsPage.branch
            step: evalsPage.step
            base: evalsPage.base
            period: evalsPage.period
            course_id: evalsPage.course_id
            course_name: evalsPage.course_name
            teacher: evalsPage.teacher
            class_name: evalsPage.class_name
        }
    }

    //eval delete
    Component
    {
        id: deleteComponent
        EvalDelete
        {
            onPopStackSignal: evalsPage.appStackView.pop();
            onDeletedSignal: Methods.updateEvals(evalsPage.course_id);

            branch: evalsPage.branch
            step: evalsPage.step
            base: evalsPage.base
            period: evalsPage.period
            course_name: evalsPage.course_name
            teacher: evalsPage.teacher
            class_name: evalsPage.class_name
        }
    }

    //eval update
    Component
    {
        id: updateComponent
        EvalUpdate
        {
            onPopStackSignal: evalsPage.appStackView.pop();
            onUpdatedSignal: Methods.updateEvals(evalsPage.course_id);

            branch: evalsPage.branch
            step: evalsPage.step
            base: evalsPage.base
            period: evalsPage.period
            course_id: evalsPage.course_id
            course_name: evalsPage.course_name
            teacher: evalsPage.teacher
            class_name: evalsPage.class_name
        }
    }


}
