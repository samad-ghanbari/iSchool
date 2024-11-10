import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Base.js" as Methods

Page {
    id: insertBasePage

    property int branchId;
    property string branchText

    required property StackView appStackView
    signal baseInsertedSignal(var branchId);

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
            onClicked: insertBasePage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن پایه تحصیلی"
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
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            id: baseInsertCL
                            width: parent.width
                            Image {
                                source: "qrc:/assets/images/add.png"
                                Layout.alignment: Qt.AlignHCenter
                                Layout.preferredHeight:  64
                                Layout.preferredWidth:  64
                                Layout.margins: 20
                                NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                            }

                            GridLayout
                            {
                                id: baseInsertGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Text {
                                    Layout.columnSpan: 2
                                    text: "شعبه " + insertBasePage.branchText
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
                                    text: "نام پایه تحصیلی"
                                    Layout.minimumWidth: 100
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
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
                                    placeholderText: "نام پایه تحصیلی"

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
                                    Base["branch_id"] = insertBasePage.branchId
                                    Base["study_base"] = baseTF.text

                                    var check = true
                                    // check entries
                                    if(!Methods.checkBaseInsertEntries(Base))
                                    {
                                        baseInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.insertStudyBase(Base))
                                    {
                                        insertBasePage.baseInsertedSignal(insertBasePage.branchId);
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
        dialogText: "افزودن دوره جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: baseSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "دوره جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){baseSuccessDialogId.close(); insertBasePage.appStackView.pop();}

    }
}
