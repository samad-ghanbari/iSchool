pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import "./Period.js" as Methods

SwipeDelegate
{
    // p.id, p.step_id, p.period_name, p.passed, s.step_name, s.branch_id, br.city, br.branch_name, s.numeric_graded, s.field_based, p.sort_priority
    id: periodDelegate
    required property StackView appStackView
    required property int index

    property var periodModel

    signal periodDeleted(var index);

    height: 160
    checkable: true
    checked: periodDelegate.swipe.complete
    onCheckedChanged: { if(!periodDelegate.checked) periodDelegate.swipe.close();}
    clip: true

    background: Rectangle{color: (periodDelegate.highlighted)? "snow" : "whitesmoke";}

    contentItem: Rectangle
    {
        color: {
            if(periodDelegate.periodModel.passed)
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
                text: "سال‌تحصیلی " + periodDelegate.periodModel.period_name
                padding: 0
                font.family: "Kalameh"
                font.pixelSize: (periodDelegate.highlighted)? 20 :16
                font.bold: (periodDelegate.highlighted)? true : false
                color: (periodDelegate.highlighted)? "royalblue":"black"
                horizontalAlignment: Label.AlignHCenter
                width: parent.width
                height: 50
                elide: Text.ElideRight
            }
            Label {
                text: "شعبه " + periodDelegate.periodModel.city + " - " + periodDelegate.periodModel.branch_name
                padding: 0
                font.family: "Kalameh"
                font.pixelSize: 14
                font.bold: (periodDelegate.highlighted)? true : false
                color: (periodDelegate.highlighted)? "darkcyan": "black"
                width: parent.width
                height: 50
                horizontalAlignment: Label.AlignHCenter
                elide: Text.ElideRight
            }

            Label {
                text:{
                    var temp = periodDelegate.periodModel.step_name ;
                    if(temp.includes("دوره"))
                        return temp;
                    else
                        return "دوره " + periodDelegate.periodModel.step_name
                }
                padding: 0
                font.family: "Kalameh"
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
        height: 150
        anchors.left: parent.left

        Button
        {
            height: 150
            width: 75
            background: Rectangle{id:trashBtnBg; color: "crimson"}
            hoverEnabled: true
            onHoveredChanged: trashBtnBg.color=(hovered)? Qt.darker("crimson", 1.1):"crimson"
            text: "حذف"
            font.bold: true
            font.family: "Kalameh"
            font.pixelSize: 14
            palette.buttonText:  "white"
            icon.source: "qrc:/assets/images/trash.png"
            icon.width: 32
            icon.height: 32
            icon.color:"transparent"
            display: AbstractButton.TextUnderIcon
            SwipeDelegate.onClicked:
            {
                if(periodDelegate.swipe.complete)
                periodDelegate.swipe.close();
                periodDelegate.appStackView.push(deletePeriodComponent, { periodIndex: periodDelegate.index, model: periodDelegate.periodModel});
            }
        }
        Button
        {
            height: 150
            width: 75
            background:  Rectangle{id:editBtnBg; color: "royalblue"}
            hoverEnabled: true
            onHoveredChanged: editBtnBg.color=(hovered)? Qt.darker("royalblue", 1.1):"royalblue"
            text: "ویرایش"
            font.bold: true
            font.family: "Kalameh"
            font.pixelSize: 14
            palette.buttonText:  "white"
            icon.source: "qrc:/assets/images/edit.png"
            icon.width: 32
            icon.height: 32
            icon.color:"transparent"
            display: AbstractButton.TextUnderIcon
            SwipeDelegate.onClicked:
            {
                if(periodDelegate.swipe.complete)
                periodDelegate.swipe.close();
                periodDelegate.appStackView.push(updatePeriodComponent, {model: periodDelegate.periodModel });
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
