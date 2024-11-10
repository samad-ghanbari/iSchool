import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox
import "Period.js" as Methods

Page {
    id: insertPeriodPage

    property int branchId;
    property string branchText

    required property StackView appStackView
    signal periodInsertedSignal(var branchId);

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
            onClicked: insertPeriodPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن سال تحصیلی"
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
                            id: periodInsertCL
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
                                id: periodInsertGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Text {
                                    Layout.columnSpan: 2
                                    text: "شعبه " + insertPeriodPage.branchText
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
                                    text: "سال تحصیلی"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                TextField
                                {
                                    id: periodTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "سال تحصیلی"

                                }

                                Text {
                                    text: "وضعیت سال تحصیلی"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                ComboBox
                                {
                                    id: periodPassedCB
                                    Layout.preferredHeight:  50
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 400
                                    editable: false
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    model: [
                                        {value:true, text:"سال تحصیلی مختومه"},
                                        {value:false, text:"سال تحصیلی جاری"}
                                    ]
                                    textRole: "text"
                                    valueRole: "value"
                                    Component.onCompleted:
                                    {
                                        periodPassedCB.currentIndex = 0
                                    }
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
                                    var period = {};
                                    period["branch_id"] = insertPeriodPage.branchId
                                    period["study_period"] = periodTF.text
                                    period["passed"] = periodPassedCB.currentValue;

                                    var check = true
                                    // check entries
                                    if(!Methods.checkPeriodInsertEntries(period))
                                    {
                                        periodInfoDialogId.open();
                                        return;
                                    }

                                    if(dbMan.periodInsert(period))
                                    {
                                        insertPeriodPage.periodInsertedSignal(insertPeriodPage.branchId);
                                        periodSuccessDialogId.open();

                                    }
                                    else
                                    {
                                        var errorString = dbMan.getLastError();
                                        periodInfoDialogId.dialogTitle = "خطا"
                                        periodInfoDialogId.dialogText = errorString
                                        periodInfoDialogId.width = parent.width
                                        periodInfoDialogId.height = 500
                                        periodInfoDialogId.dialogSuccess = false
                                        periodInfoDialogId.open();
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
        id: periodInfoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن دوره جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: periodSuccessDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "سال تحصیلی جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: function(){periodSuccessDialogId.close(); insertPeriodPage.appStackView.pop();}

    }
}
