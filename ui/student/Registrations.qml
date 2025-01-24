pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: registersPage

    required property StackView appStackView;
    property string branch
    property string step
    required property int step_id
    required property bool field_based

    required property int student_id
    required property string name
    required property string lastname
    required property string fathername
    required property string birthday
    required property string gender
    required property bool enabled
    required property string photo

    background: Rectangle{anchors.fill: parent; color: "snow"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "مدیریت ثبت‌نامی‌های دانش‌آموز"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
        }

        Image {
            source: "qrc:/assets/images/folders.png"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight:  64
            Layout.preferredWidth:  64
            Layout.margins: 10
            NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
        }

        Flickable{
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentHeight: centerBox.implicitHeight

            Column{
                id: centerBox
                width: parent.width

                RowLayout{
                    width: parent.width
                    height: 160
                    Image {
                        source: registersPage.photo
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.preferredHeight: 150
                        Layout.preferredWidth:  150
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }
                    Column{
                        Layout.fillWidth: true
                        //branch-step
                        Text {
                            text: "شعبه " + registersPage.branch + " - " + registersPage.step
                            width: parent.width
                            height: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 18
                            font.bold: true
                            color: "darkcyan"
                        }
                        Text {
                            text: registersPage.name + " - " + registersPage.lastname
                            width: parent.width
                            height: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 20
                            font.bold: true
                            color: "mediumvioletred"
                        }
                        Text {
                            text:  "نام پدر: " +registersPage.fathername
                            width: parent.width
                            height: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.family: "Kalameh"
                            font.pixelSize: 18
                            font.bold: true
                            color: "darkcyan"
                        }
                    }
                }

                Rectangle{width: parent.width; height: 1; color: "gray"}
                Item{width: parent.width; height: 10;}

                Button
                {
                    height: 64
                    background: Item{}
                    icon.source: "qrc:/assets/images/add.png"
                    icon.width: 40
                    icon.height: 40
                    text: "ثبت‌نام جدید"
                    font.pixelSize: 14
                    font.family: "Kalameh"
                    font.bold: true
                    display: AbstractButton.TextUnderIcon
                    icon.color:"transparent"
                    opacity: 0.5
                    onClicked: registersPage.appStackView.push(registerComponent);
                    hoverEnabled: true
                    onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                }

                GridView
                {
                    id: registersGV
                    height: registersGV.contentHeight
                    width: parent.width
                    flickableDirection: Flickable.AutoFlickDirection
                    clip: true
                    cellWidth: 310
                    cellHeight: 260
                    model: ListModel{id: regsModel}
                    highlight: Item{}
                    delegate: Rectangle
                    {
                        id: rec
                        width: 300
                        height: 250
                        required property var model;
                        property bool highlighted: false
                        // r.id, r.student_id, r.class_id, cl.base_id, cl.period_id, cl.class_name, b.base_name, b.step_id, b.field_id, f.field_name, p.period_name

                        color: (rec.highlighted)? "snow" : "whitesmoke";
                        MouseArea{
                            anchors.fill: parent
                            onClicked: rec.highlighted = (rec.model.index === registersGV.currentIndex)? true : false;
                        }

                        border.width: 1
                        border.color: (rec.highlighted)? "hotpink" : "pink"
                        radius: 5

                        Column
                        {
                            anchors.fill: parent
                            spacing: 0

                            Item{
                                width: parent.width
                                height: 80
                                Image{
                                    width: 64
                                    height: 64
                                    anchors.centerIn: parent
                                    source: "qrc:/assets/images/folder.png"
                                }
                            }

                            Label {
                                text: rec.model.period_name
                                padding: 0
                                font.family: "Kalameh"
                                font.pixelSize: (rec.highlighted)? 20 :16
                                font.bold: (rec.highlighted)? true : false
                                color: (rec.highlighted)? "royalblue":"black"
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                                width: parent.width
                                height: 50
                                elide: Text.ElideRight
                            }
                            Label {
                                text: (registersPage.field_based)? "رشته " + rec.model.field_name + " - " +  rec.model.base_name : " " + rec.model.base_name
                                padding: 0
                                font.family: "Kalameh"
                                font.pixelSize: (rec.highlighted)? 18 :16
                                font.bold: (rec.highlighted)? true : false
                                color: (rec.model.Passed)? "mediumvioletred":"dodgerblue"
                                horizontalAlignment: Label.AlignHCenter
                                verticalAlignment: Label.AlignVCenter
                                width: parent.width
                                height: 50
                                elide: Text.ElideRight
                            }

                            Label {
                                text: "کلاس " + rec.model.class_name
                                padding: 0
                                font.family: "Kalameh"
                                font.pixelSize: 16
                                font.bold: (rec.highlighted)? true : false
                                color: (rec.model.Passed)? "mediumvioletred":"dodgerblue"
                                horizontalAlignment: Label.AlignHCenter
                                width: parent.width
                                height: 50
                                elide: Text.ElideRight
                            }
                        }

                        Button
                        {
                            width: 32
                            height: 32
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right
                            background: Item{}
                            icon.source: "qrc:/assets/images/trash.png"
                            icon.width: 32
                            icon.height: 32
                            icon.color:"transparent"
                            opacity: 0.5
                            onClicked: {
                                registersPage.appStackView.push(deleteComponent, {
                                                                    register_id: rec.model.id,
                                                                    base: rec.model.base_name,
                                                                    period: rec.model.period_name,
                                                                    class_name: rec.model.class_name,
                                                                    field: rec.model.field_name

                                                                });
                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }
                    Component.onCompleted:
                    {
                        regsModel.clear();
                        var jsondata = dbMan.getRegisterations(registersPage.step_id, registersPage.student_id);
                        for(var obj of jsondata)
                        {
                            regsModel.append(obj);
                        }
                    }
                }

            }
        }

    }

    //register
    Component
    {
        id: registerComponent
        Register
        {
            name: registersPage.name
            lastname: registersPage.lastname
            fathername: registersPage.fathername
            photo: registersPage.photo
            branch: registersPage.branch
            step: registersPage.step
            step_id: registersPage.step_id
            student_id: registersPage.student_id
            field_based: registersPage.field_based

            onPopStackSignal: registersPage.appStackView.pop();
            onRegisteredSignal:
            {
                regsModel.clear();
                var jsondata = dbMan.getRegisterations(registersPage.step_id, registersPage.student_id);
                for(var obj of jsondata)
                {
                    regsModel.append(obj);
                }
            }
        }
    }


    //delete
    Component
    {
        id: deleteComponent
        RegisterDelete
        {
            onPopStackSignal: registersPage.appStackView.pop();
            branch: registersPage.branch
            step: registersPage.step
            field_based: registersPage.field_based

            name: registersPage.name
            lastname: registersPage.lastname
            fathername: registersPage.fathername
            photo: registersPage.photo

            onDeletedSignal :
            {
                regsModel.clear();
                var jsondata = dbMan.getRegisterations(registersPage.step_id, registersPage.student_id);
                for(var obj of jsondata)
                {
                    regsModel.append(obj);
                }
            }
        }
    }
}
