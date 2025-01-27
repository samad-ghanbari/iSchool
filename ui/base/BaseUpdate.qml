pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Base.js" as Methods

Page {
    id: updateBasePage
    property int baseId
    property string branch
    property string studyBase
    required property StackView appStackView;
    signal baseUpdatedSignal(var Base);

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
            icon.color:"transparent"
            opacity: 0.5
            onClicked: updateBasePage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ویرایش پایه تحصیلی"
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
            color: "honeydew"

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
                    Item{
                        anchors.fill: parent
                        anchors.margins: 10
                        ColumnLayout
                        {
                            id: baseUpdateCL
                            width: parent.width
                            Image {
                                source: "qrc:/assets/images/edit.png"
                                Layout.alignment: Qt.AlignHCenter
                                Layout.preferredHeight:  64
                                Layout.preferredWidth:  64
                                Layout.margins: 20
                                NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                            }

                            GridLayout
                            {
                                id: baseUpdateGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width


                                Text {
                                    text: "شعبه"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
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
                                    id: branchTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    text: updateBasePage.branch

                                }

                                Text {
                                    text: "نام پایه تحصیلی "
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                TextField
                                {
                                    id: baseTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "پایه تحصیلی"
                                    text: updateBasePage.studyBase
                                }
                            }

                            Item
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                            }

                            Button
                            {
                                text: "تایید"
                                Layout.preferredWidth: 200
                                Layout.preferredHeight: 50
                                Layout.alignment: Qt.AlignHCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                                onClicked:
                                {
                                    var Base = {};
                                    Base["id"] = updateBasePage.baseId;
                                    Base["study_base"] = baseTF.text;

                                    var check = true
                                    // check entries
                                    if(!Methods.checkBaseUpdateEntries(Base))
                                    {
                                        baseInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.updateStudyBase(Base))
                                    {
                                        Base = dbMan.getStudyBase(Base["id"]);
                                        updateBasePage.baseUpdatedSignal(Base);
                                        baseSuccessDialogId.open();

                                    }
                                    else
                                    {
                                        var errorString = dbMan.getLastError();
                                        baseInfoDialogId.dialogTitle = "خطا"
                                        baseInfoDialogId.dialogText = errorString
                                        baseInfoDialogId.width = parent.width
                                        baseInfoDialogId.height = 500
                                        baseInfoDialogId.dialogSuccess = false
                                        baseInfoDialogId.open();
                                    }
                                }
                            }

                            Item
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                            }
                        }
                    }
                }
            }
        }

    }

    DialogBox.BaseDialog
    {
        id: baseInfoDialogId
        dialogTitle: "خطا"
        dialogText: "ورود فیلد الزامی می‌باشد"
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: baseSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "اطلاعات دوره با موفقیت بروزرسانی شد"
        dialogSuccess: true
        onDialogAccepted: function(){baseSuccessDialogId.close(); updateBasePage.appStackView.pop();}
    }
}
