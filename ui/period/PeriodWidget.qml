pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import "./Period.js" as Methods

SwipeDelegate
{
    //s.id, s.branch_id, s.period_name, b.city, b.branch_name
    id: periodDelegate
    required property StackView appStackView
    required property int index

    property int periodId
    property int branchId
    property string studyPeriod
    property bool passed;
    property string city
    property string branchName

    signal periodDeleted(var index);

    height: 110
    checkable: true
    checked: periodDelegate.swipe.complete
    onCheckedChanged: { if(!periodDelegate.checked) periodDelegate.swipe.close();}
    clip: true

    background: Rectangle{color: (periodDelegate.highlighted)? "snow" : "whitesmoke";}

    contentItem: Rectangle
    {
        color: {
            if(periodDelegate.passed)
            {
                if(periodDelegate.highlighted) return "lightpink"; else return "lavenderblush";
            }
            else
            {
                if(periodDelegate.highlighted) return "snow"; else return "whitesmoke";
            }
        }

        Column
        {
            id: periodDelegateCol
            anchors.fill: parent

            spacing: 0
            Label {
                text: "سال‌تحصیلی " + periodDelegate.studyPeriod
                padding: 0
                font.family: "B Yekan"
                font.pixelSize: (periodDelegate.highlighted)? 20 :16
                font.bold: (periodDelegate.highlighted)? true : false
                color: (periodDelegate.highlighted)? "royalblue":"black"
                horizontalAlignment: Label.AlignHCenter
                width: parent.width
                height: 50
                elide: Text.ElideRight
            }
            Label {
                text: "شعبه " + periodDelegate.city + " - " + periodDelegate.branchName
                padding: 0
                font.family: "B Yekan"
                font.pixelSize: 14
                font.bold: (periodDelegate.highlighted)? true : false
                color: (periodDelegate.highlighted)? "darkcyan": "black"
                width: parent.width
                height: 50
                horizontalAlignment: Label.AlignHCenter
                elide: Text.ElideRight
            }

            Rectangle{width: 400; height:5; color: (periodDelegate.highlighted)? "mediumvioletred" : "whitesmoke"; anchors.horizontalCenter: parent.horizontalCenter }
        }
    }

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
                if(periodDelegate.swipe.complete)
                periodDelegate.swipe.close();
                var branchText =  periodDelegate.city + " - " + periodDelegate.branchName;
                periodDelegate.appStackView.push(deletePeriodComponent, {periodId: periodDelegate.periodId, periodIndex: periodDelegate.index,  studyPeriod: periodDelegate.studyPeriod, passed: periodDelegate.passed, branchText: branchText});
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
                if(periodDelegate.swipe.complete)
                periodDelegate.swipe.close();
                var branchText =  periodDelegate.city + " - " + periodDelegate.branchName;
                periodDelegate.appStackView.push(updatePeriodComponent, {periodId: periodDelegate.periodId, studyPeriod: periodDelegate.studyPeriod, passed: periodDelegate.passed, branch: branchText });
            }
        }
    }

    onClicked: {periodDelegate.swipe.close();}

    Component
    {
        id: updatePeriodComponent
        PeriodUpdate{
            appStackView: periodDelegate.appStackView;
            onPeriodUpdatedSignal: (periodObj) => Methods.updateWidget(periodObj);
        }
    }
    Component
    {
        id: deletePeriodComponent
        PeriodDelete{
            appStackView: periodDelegate.appStackView;
            onPeriodDeleted: (pIndex)=>{ periodDelegate.periodDeleted(pIndex);}
        }
    }

}
