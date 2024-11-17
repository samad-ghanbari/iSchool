import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deletePage

    required property var model;
    property int studentId: model.id
    property string branchText;
    property string name: model.name
    property string lastname: model.lastname
    property string fathername: model.fathername
    property string gender: model.gender
    property string birthday: model.birthday
    property bool enabled: model.enabled
    property string photo: model.photo
    property bool isFemale : (deletePage.model.gender === "خانم")? true : false;

    signal deletedSignal();
    signal popStackSignal();

    background: Rectangle{anchors.fill: parent; color: "lavenderblush"}

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
            onClicked: deletePage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف دانش‌آموز"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "lavenderblush"

            ScrollView
            {
                height: parent.height
                width: parent.width
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                Rectangle
                {
                    id: centerBoxId
                    color:"snow"
                    width:  (parent.width < 700)? parent.width : 700
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: parent.height

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            width: parent.width

                            GridLayout
                            {
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Image {
                                    //source: "qrc:/assets/images/edit.png"
                                    source:{
                                        if(deletePage.photo == "")
                                        {
                                            if(deletePage.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                                        }
                                        else
                                        {
                                            return "file://"+deletePage.photo;
                                        }
                                    }
                                    Layout.alignment: Qt.AlignHCenter
                                    Layout.preferredHeight:  64
                                    Layout.preferredWidth:  64
                                    Layout.margins: 20
                                    Layout.columnSpan: 2
                                    NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                                }

                                Text {
                                    Layout.columnSpan: 2
                                    text: "شعبه " + deletePage.branchText
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }

                                //name
                                Text {
                                    text: "نام دانش‌آموز"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    id: nameTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: deletePage.name

                                }
                                //lastname
                                Text {
                                    text: "نام خانوادگی"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    id: lastnameTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: deletePage.lastname

                                }
                                //fathername
                                Text {
                                    text: "نام پدر"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    id: fathernameTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: deletePage.fathername

                                }
                                //gender
                                Text {
                                    text: "جنسیت"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    id: genderTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: deletePage.gender

                                }

                                //birthday
                                Text {
                                    text: "تاریخ تولد"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text
                                {
                                    id: birthdayTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    text: deletePage.birthday
                                }
                                //enabled
                                Text {
                                    text: "وضعیت فعال/غیرفعال"
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Switch
                                {
                                    id: enabledSW
                                    checked: deletePage.enabled
                                    text: checked? "فعال" : "غیرفعال";
                                    font.family: "B Yekan"
                                    palette.highlight: "royalblue"
                                    palette.text: "gray"
                                    enabled: false
                                }
                            }

                            Item
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                            }

                            Button
                            {
                                background: Item{}
                                icon.source: "qrc:/assets/images/trash3.png"
                                icon.width: 64
                                icon.height: 64
                                Layout.preferredHeight: 64
                                Layout.preferredWidth: 64
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                opacity: 0.5
                                onClicked: delDialog.open();
                                hoverEnabled: true
                                onHoveredChanged:
                                {
                                    if(hovered)
                                    {
                                        this.opacity = 1
                                        this.scale = 1.1
                                    }
                                    else
                                    {
                                        this.opacity = 0.8
                                        this.scale = 1
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

    }

    DialogBox.BaseDialog
    {
        id: delDialog
        dialogTitle:  "حذف دبیر"
        dialogText: "آیا از حذف دانش‌آموز از سامانه مطمئن می‌باشید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: function(){
            if(dbMan.studentDelete(deletePage.studentId))
                successDialogId.open();

            else
                infoDialogId.open();
        }
    }
    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "حذف دانش‌آموز با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "حذف دانش‌آموز با موفقیت انجام شد."
        dialogSuccess: true
        onDialogAccepted: {
            successDialogId.close();
            deletePage.popStackSignal();
            deletePage.deletedSignal();
        }
    }
}
