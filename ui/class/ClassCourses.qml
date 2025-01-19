pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Layouts

import "Class.js" as Methods
import "./../public" as DialogBox


Page {
    id: classCoursesPage
    required property string branch
    required property string step
    required property string period
    required property string base;
    required property bool field_based
    required property string field

    required property int class_id;
    required property string class_name

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "دروس کلاس"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Flickable{
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentHeight: centerBox.implicitHeight
            clip: true

            Column{
                id: centerBox
                width: parent.width

                Text {
                    text: "شعبه " + classCoursesPage.branch + " - " + classCoursesPage.step
                    width: parent.width
                    height: 50
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "royalblue"
                }
                Text {
                    text:{
                        var base = classCoursesPage.base
                        if(!base.includes("پایه")) base = "پایه " + base;

                        if(classCoursesPage.field_based){

                            return "رشته " + classCoursesPage.field + " - " +  base
                        }
                        else{

                            return base;
                        }
                    }
                    width: parent.width
                    height: 50
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "royalblue"
                }
                Text {
                    text:  "سال تحصیلی " + classCoursesPage.period + " - " + " کلاس " + classCoursesPage.class_name
                    width: parent.width
                    height: 50
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "royalblue"
                }

                Rectangle{
                    width: parent.width
                    height: 1
                    color: "gray"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Item{width: parent.width; height: 20;}

                GridView
                {
                    id: gv
                    width: parent.width
                    implicitHeight: gv.contentHeight
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    cellWidth: 320
                    cellHeight: 120
                    model: ListModel{id: gvModel}
                    highlight: Item{}
                    delegate: gvDelegate

                    Component.onCompleted:{
                        var jsondata = dbMan.getClassCoursesArray(classCoursesPage.class_id);
                        gvModel.clear();
                        for(var obj of jsondata){
                            gvModel.append(obj);
                        }
                    }

                }

                Item{width: parent.width; height: 20;}

                Text {
                    text: "  مجموع ضرایب:  " + dbMan.getTotalCoefficient(classCoursesPage.class_id, false);
                    width: parent.width
                    height: 25
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    font.bold: true
                    color: "darkslategray"
                }
                Repeater{
                    id: rp
                    width: parent.width
                    model: ListModel {id: rpModel }
                    delegate: Text {
                        id: rpRec
                        required property var model;
                        text: {
                            var crs = rpRec.model.courses;
                            var coef = rpRec.model.coefficient
                            return "  دروس " + crs + " در مجموع " + coef + " واحد حساب می‌شوند.";
                        }

                        width: parent.width
                        height: 25
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkslategray"
                    }

                    Component.onCompleted: {
                        var jsondata = dbMan.getSharedCoefficientCourses(classCoursesPage.class_id);
                        rpModel.clear();
                        for(var obj of jsondata){
                            rpModel.append(obj);
                        }
                    }
                }

                Item{width: parent.width; height: 20;}

            }
        }
    }

    // delegate
    Component
    {
        id: gvDelegate
        Rectangle
        {
            id: recDelg
            required property var model;
            color: (recDelg.highlighted)? "snow" : "whitesmoke";
            border.color: (recDelg.highlighted)? "mediumvioletred" : "lightgray"
            width: 300
            height: 100

            //id, course_name, step_id, base_id, period_id, course_coefficient, test_coefficient, shared_coefficient, final_weight, shared_weight
            Column
            {
                id: recDelgCol
                anchors.fill: parent
                anchors.margins: 10
                Item{ width: parent.width;height: 10;}
                spacing: 0
                Label {
                    text:  recDelg.model.course_name
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: (recDelg.highlighted)? 20 :16
                    font.bold: (recDelg.highlighted)? true : false
                    color: (recDelg.highlighted)? "royalblue":"black"
                    horizontalAlignment: Label.AlignHCenter
                    width: parent.width
                    height: 50
                    elide: Text.ElideRight
                }
                Label {
                    text: "ضریب درس: " + recDelg.model.course_coefficient
                    padding: 0
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    font.bold: false
                    color: "darkslategray"
                    horizontalAlignment: Label.AlignLeft
                    width: parent.width
                    height: 20
                }
                Item{ width: parent.width;height: 10;}
            }
        }
    }

}
