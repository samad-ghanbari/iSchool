pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Evals.js" as Methods

Page {
    id: evalCatPage

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
            icon.color:"transparent"
            opacity: 0.5
            onClicked: evalCatPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "دسته ارزیابی‌ها"
            font.family: "Kalameh"
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

                ColumnLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20

                    Flow
                    {
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
                                    font.family: "Kalameh"
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
                                    font.family: "Kalameh"
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

                                    onActivated:Methods.updateEvalCatsModel(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue)
                                }
                            }
                        }
                    }

                    Rectangle
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 4
                        color: "skyblue"
                        Layout.topMargin: 10
                        Layout.bottomMargin: 10
                    }

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
                        icon.color:"transparent"
                        opacity: 0.5
                        onClicked:
                        {
                            var pid = periodCB.currentValue;
                            if(pid >= 0)
                                evalCatPage.appStackView.push(insertComponent);
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }

                    GridView
                    {
                        id: evalCatsGV
                        implicitHeight: 600;
                        Layout.fillWidth: true
                        Layout.margins: 20
                        flickableDirection: Flickable.AutoFlickDirection
                        cellWidth: 320
                        cellHeight: 270 // 20 spacing
                        clip: true
                        model: ListModel{ id: evalCatsModel }
                        highlight: Item{}
                        delegate: evalCatsDelegate

                        function closeSwipeHandler()
                        {
                            for (var i = 0; i <= evalCatsGV.count; i++)
                            {
                                var item = evalCatsGV.contentItem.children[i];
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
        id: evalCatsDelegate
         //id, eval_cat, step_id, study_base_id, study_period_id, test_flag, final_flag
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

                Column
                {
                    id: recDelCol
                    anchors.fill: parent
                    anchors.margins: 20

                    spacing: 0
                    Item{
                        width: parent.width
                        height: 64
                        Image
                        {
                            width: 64
                            height: 64
                            anchors.horizontalCenter: parent.horizontalCenter
                            source:  "qrc:/assets/images/evalcat.png"
                        }
                    }

                    Label {
                        text: recDel.model.Eval_cat
                        padding: 0
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }
                    Label {
                        text: {

                            if(recDel.model.Final_flag && recDel.model.Test_flag) return "آزمون تستی نهایی";
                            else if(recDel.model.Final_flag && !recDel.model.Test_flag) return "آزمون نهایی";
                            else if(!recDel.model.Final_flag && recDel.model.Test_flag) return "آزمون تستی";
                            else return "آزمون"
                        }
                        padding: 0
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        horizontalAlignment: Label.AlignHCenter
                        width: parent.width
                        height: 50
                        elide: Text.ElideRight
                    }

                }

                Row{
                    width: parent.width;
                    height: 32
                    anchors.bottom: bottomBar.top
                    // final
                    Image
                    {
                        source: "qrc:/assets/images/certified32.png"
                        width: 32
                        height: 32
                        visible: (recDel.model.Final_flag)? true : false;
                    }
                    Image
                    {
                        source: "qrc:/assets/images/check32.png"
                        width: 32
                        height: 32
                        visible: (recDel.model.Test_flag)? true : false;
                    }

                }
                Rectangle
                {
                    id: bottomBar
                    width: parent.width
                    height: 30
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    color:{
                        if(recDel.model.Study_base_id > -1)
                        {
                            if(recDel.highlighted)
                            return "purple";
                            else return  "gray";
                        }
                        else
                        {
                            if(recDel.highlighted)
                            return "deeppink";
                            else return  "midnightblue";
                        }
                    }
                    Text
                    {
                        anchors.centerIn: parent
                        text: (recDel.model.Study_base_id > -1)? "آزمون پایه" : "آزمون دوره";
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "white"
                    }
                }
           }

            onClicked: {recDel.swipe.close();}
            onPressed: { evalCatsGV.currentIndex = model.index; evalCatsGV.closeSwipeHandler();}
            highlighted: (model.index === evalCatsGV.currentIndex)? true: false;

            swipe.right:Column{
                width: 48
                height: 250
                anchors.left: parent.left


                //evals
                Button
                {
                    height: 48
                    width: 48
                    background: Item{}
                    hoverEnabled: true
                    opacity: 0.5
                    onHoveredChanged:(hovered)? this.opacity=1 : this.opacity=0.5
                    icon.source: "qrc:/assets/images/info.png"
                    icon.width: 48
                    icon.height: 48
                    icon.color:"transparent"
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(recDel.swipe.complete)
                        recDel.swipe.close();

                        evalCatPage.appStackView.push(evalsComponent, {
                                                          eval_cat_id: recDel.model.Id,
                                                          eval_cat: recDel.model.Eval_cat,
                                                          test_flag: recDel.model.Test_flag,
                                                          final_flag: recDel.model.Final_flag,
                                                      });
                    }
                }

                //update
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
                    icon.color:"transparent"
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(recDel.swipe.complete)
                        recDel.swipe.close();

                        evalCatPage.appStackView.push(updateComponent, {
                                                          eval_cat_id: recDel.model.Id,
                                                          eval_cat: recDel.model.Eval_cat,
                                                          test_flag: recDel.model.Test_flag,
                                                          final_flag: recDel.model.Final_flag,
                                                          sort_priority: recDel.model.Sort_priority
                                                      });
                    }
                }

                //delete
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
                    icon.color:"transparent"
                    display: AbstractButton.TextUnderIcon
                    SwipeDelegate.onClicked:
                    {
                        if(recDel.swipe.complete)
                        recDel.swipe.close();

                        evalCatPage.appStackView.push(deleteComponent, {
                                                          eval_cat_id: recDel.model.Id,
                                                          eval_cat: recDel.model.Eval_cat,
                                                          test_flag: recDel.model.Test_flag,
                                                          final_flag: recDel.model.Final_flag
                                                      });

                    }
                }
            }
        }
    }

    //evals components
    Component
    {
        id: evalsComponent
        Evals
        {
            appStackView: evalCatPage.appStackView

            branch: branchCB.currentText
            step: stepCB.currentText
            base: baseCB.currentText
            period: periodCB.currentText

            step_id:   stepCB.currentValue
            base_id:   baseCB.currentValue
            period_id: periodCB.currentValue
        }
    }

    // insert
    Component
    {
        id: insertComponent
        EvalCatInsert
        {
            onPopStackSignal: evalCatPage.appStackView.pop();
            onInsertedSignal: Methods.updateEvalCatsModel(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);

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
        EvalCatDelete
        {
            onPopStackSignal : evalCatPage.appStackView.pop();
            onDeletedSignal : Methods.updateEvalCatsModel(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);

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
        EvalCatUpdate
        {
            onPopStackSignal : evalCatPage.appStackView.pop();
            onUpdatedSignal : Methods.updateEvalCatsModel(stepCB.currentValue, baseCB.currentValue, periodCB.currentValue);

            branch: branchCB.currentText
            step: stepCB.currentText
            base: baseCB.currentText
            period: periodCB.currentText
        }
    }

}
