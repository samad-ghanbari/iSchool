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

    required property int step_id;
    required property int base_id;
    required property int period_id;

    required property string eval_cat
    required property int eval_cat_id
    required property bool test_flag
    required property bool final_flag


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
            text: "ارزیابی " + evalsPage.eval_cat
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
            elide: Text.ElideRight
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

                ColumnLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    // branch
                    Label
                    {
                        Layout.fillWidth: true
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        color: "royalblue"
                        text:"شعبه " + evalsPage.branch
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                    }
                    //step base
                    Label
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        color: "royalblue"
                        text: {
                            if(evalsPage.base.indexOf("پایه") == -1)
                            return evalsPage.step + " - پایه " + evalsPage.base;
                            else
                            return evalsPage.step + " - " + evalsPage.base;
                        }
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        font.bold: true
                    }
                    Label
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        color: "royalblue"
                        text:"سال تحصیلی " + evalsPage.period
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                    }

                    Rectangle{Layout.fillWidth: true; Layout.preferredHeight: 2; Layout.maximumHeight: 2; color: "royalblue";}

                    //class
                    RowLayout
                    {
                        Layout.fillWidth: true;
                        Layout.maximumWidth: 400;
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignHCenter

                        Label
                        {
                            Layout.preferredWidth: 100;
                            horizontalAlignment: Label.AlignRight
                            verticalAlignment: Label.AlignVCenter
                            color: "royalblue"
                            text:"کلاس: "
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            font.bold: true
                        }
                        ComboBox
                        {
                            id: allClassCB
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            model:ListModel { id: allClassCBoxModel; }
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted: Methods.updateAllClassesCB(evalsPage.step_id, evalsPage.base_id, evalsPage.period_id);
                            onActivated: Methods.updateEvals(evalsPage.eval_cat_id, allClassCB.currentValue);
                        }

                    }

                    Button
                    {
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
                        cellHeight: 320 // 20 spacing
                        clip: true
                        model: ListModel{id: evalsModel}
                        highlight: Item{}
                        delegate: evalsDelegate

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


    // delegate
    Component
    {
        id: evalsDelegate

        SwipeDelegate
        {
            id: recDel
            required property var model;
            height: 300
            width: 300
            checkable: true
            checked: recDel.swipe.complete
            onCheckedChanged: { if(!recDel.checked) recDel.swipe.close();}
            clip: true

            background: Rectangle{color: (recDel.highlighted)? "snow" : "whitesmoke";}
            // e.id, e.eval_cat_id, e.course_id, e.eval_time, e.max_grade, e.included,
            // co.course_name, co.course_coefficient, co.test_coefficient, co.shared_coefficient, co.final_weight, cl.class_name


            contentItem: Rectangle
            {

                color: (recDel.highlighted)? "snow" : "whitesmoke";
                border.width: (recDel.highlighted)? 2 : 1;
                border.color: (recDel.highlighted)? "mediumvioletred" : "gray";

                Column
                {
                    width: 30
                    height: 80

                    anchors.top: parent.top
                    anchors.right: parent.right

                    Label
                    {
                        id: courseCoefLbl
                        width: 30
                        height: 40
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        text: recDel.model.Course_coefficient
                        color: "white"
                        background: Rectangle{anchors.fill: parent; color:"mediumvioletred"}
                    }
                    Label
                    {
                        width: 30
                        height: 40
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        text: recDel.model.Test_coefficient
                        color: "white"
                        background: Rectangle{anchors.fill: parent; color:"darkmagenta"}
                    }
                }

                Column
                {
                    id: recDelCol
                    anchors.fill: parent

                    spacing: 0
                    Image
                    {
                        width: 32
                        height: 32
                        anchors.horizontalCenter: parent.horizontalCenter
                        source:  "qrc:/assets/images/evaluation.png"
                    }

                    Label {
                        text: evalsPage.eval_cat
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDel.highlighted)? 18 :16
                        font.bold: (recDel.highlighted)? true : false
                        color: (recDel.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: recDel.model.Course_name
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDel.highlighted)? 18 :16
                        font.bold: (recDel.highlighted)? true : false
                        color: (recDel.highlighted)? "darkmagenta":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: "کلاس " + recDel.model.Class_name
                        visible: (recDel.model.Class_id > -1)? true : false;
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: (recDel.highlighted)? 18 :16
                        font.bold: (recDel.highlighted)? true : false
                        color: (recDel.highlighted)? "darkmagenta":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: recDel.model.Eval_time
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: (recDel.highlighted)? true : false
                        color: (recDel.highlighted)? "royalblue":"black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text:{
                            if(evalsPage.test_flag)
                            return "نمره آزمون " +  recDel.model.Max_grade + "%";
                            else
                            return "نمره آزمون " +  recDel.model.Max_grade;
                        }
                        padding: 0
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: (recDel.highlighted)? true : false
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }

                }
                Row
                {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 32
                    Image
                    {
                        source: "qrc:/assets/images/stop32.png"
                        width: 32
                        height: 32
                        visible: (recDel.model.Included)? false : true;
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
                    background: Item{}
                    hoverEnabled: true
                    opacity: 0.5
                    onHoveredChanged:(hovered)? this.opacity=1 : this.opacity=0.5
                    icon.source: "qrc:/assets/images/users.png"
                    icon.width: 48
                    icon.height: 48
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(recDel.swipe.complete)
                        recDel.swipe.close();

                        evalsPage.appStackView.push(usersEvalComponent,  {

                                                        eval_id: recDel.model.Id,
                                                        course_id: recDel.model.Course_id,
                                                        class_id: recDel.model.Class_id,
                                                        class_name: recDel.model.Class_name,
                                                        course_name: recDel.model.Course_name,
                                                        max_grade: recDel.model.Max_grade,
                                                        included: recDel.model.Included

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
                                                        course_id: recDel.model.Course_id,
                                                        class_id: recDel.model.Class_id,
                                                        eval_time: recDel.model.Eval_time,
                                                        max_grade: recDel.model.Max_grade,
                                                        included: recDel.model.Included,
                                                    });
                    }
                }

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
                                                        course_name: recDel.model.Course_name,
                                                        eval_time: recDel.model.Eval_time,
                                                        max_grade: recDel.model.Max_grade,
                                                        included: recDel.model.Included,
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
            onInsertedSignal: Methods.updateEvals(evalsPage.eval_cat_id);

            branch: evalsPage.branch
            step: evalsPage.step
            base: evalsPage.base
            period: evalsPage.period

            step_id: evalsPage.step_id;
            base_id: evalsPage.base_id;
            period_id: evalsPage.period_id;

            eval_cat: evalsPage.eval_cat
            eval_cat_id: evalsPage.eval_cat_id
            test_flag : evalsPage.test_flag
            final_flag: evalsPage.final_flag
        }
    }

    //eval delete
    Component
    {
        id: deleteComponent
        EvalDelete
        {
            onPopStackSignal: evalsPage.appStackView.pop();
            onDeletedSignal: Methods.updateEvals(evalsPage.eval_cat_id);

            branch: evalsPage.branch
            step: evalsPage.step
            base: evalsPage.base
            period: evalsPage.period

            eval_cat: evalsPage.eval_cat
            test_flag : evalsPage.test_flag
            final_flag: evalsPage.final_flag
        }
    }

    //eval update
    Component
    {
        id: updateComponent
        EvalUpdate
        {
            onPopStackSignal: evalsPage.appStackView.pop();
            onUpdatedSignal: Methods.updateEvals(evalsPage.eval_cat_id);

            branch: evalsPage.branch
            step: evalsPage.step
            base: evalsPage.base
            period: evalsPage.period

            step_id: evalsPage.step_id;
            base_id: evalsPage.base_id;
            period_id: evalsPage.period_id;

            eval_cat: evalsPage.eval_cat
            eval_id: evalsPage.eval_cat_id
            test_flag : evalsPage.test_flag
            final_flag: evalsPage.final_flag
        }
    }

    //users eval
    Component
    {
        id: usersEvalComponent
        EvalStudents
        {
            appStackView: evalsPage.appStackView

            branch: evalsPage.branch
            step: evalsPage.step
            base: evalsPage.base
            period: evalsPage.period

            step_id: evalsPage.step_id;
            base_id: evalsPage.base_id;
            period_id: evalsPage.period_id;

            eval_cat: evalsPage.eval_cat
            eval_id: evalsPage.eval_cat_id
            test_flag : evalsPage.test_flag
            final_flag: evalsPage.final_flag
        }
    }

}
