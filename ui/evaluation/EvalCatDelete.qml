pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: deletePage

    required property int eval_cat_id;
    required property string eval_cat;
    required property bool test_flag;
    required property bool final_flag;


    required property string branch
    required property string step
    required property string base
    required property string period

    signal popStackSignal();
    signal deletedSignal();


    background: Rectangle{anchors.fill: parent; color: "lavenderblush"}

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
            onClicked: deletePage.popStackSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "حذف دسته ارزیابی"
            font.family: "B Yekan"
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
                width: (parent.width > 700)? 700 : parent.width
                implicitHeight : centerBox.implicitHeight + 40
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"

                GridLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20
                    columns: 2

                    Image
                    {
                        Layout.columnSpan: 2
                        Layout.preferredWidth: 128
                        Layout.preferredHeight: 128
                        Layout.alignment: Qt.AlignHCenter
                        source:  "qrc:/assets/images/evalcat.png"
                    }

                    // branch
                    Text {
                        text: "شعبه"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: deletePage.branch
                    }
                    //step
                    Text {
                        text: "دوره"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: deletePage.step
                    }

                    //base
                    Text {
                        text: "پایه تحصیلی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                        visible: (deletePage.base == "")? false : true
                    }
                    Text
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: deletePage.base
                        visible: (deletePage.base == "")? false : true
                    }

                    //base
                    Text {
                        text: "سال تحصیلی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: deletePage.period
                    }


                    //eval name
                    Text {
                        text: "نام دسته ارزیابی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Text
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        text: deletePage.eval_cat
                    }

                    //test flag
                    Text {
                        text: "آزمون تستی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Switch
                    {
                        id: testSW
                        enabled: false
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignLeft
                        checked: deletePage.test_flag
                    }

                    //final flag
                    Text {
                        text: "آزمون نهایی"
                        Layout.minimumWidth: 150
                        Layout.maximumWidth: 150
                        Layout.preferredHeight: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "black"
                    }
                    Switch
                    {
                        id: finalSW
                        enabled: false
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignLeft
                        checked: deletePage.final_flag
                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                    }

                    Button
                    {
                        text: "تایید"
                        Layout.columnSpan: 2
                        Layout.preferredWidth: 200
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignHCenter
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "mediumvioletred"}
                        onClicked: delDialog.open();
                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.preferredHeight: 50
                    }


                }
            }
        }
    }

    DialogBox.BaseDialog
    {
        id: delDialog
        dialogTitle:  "حذف دسته ارزیابی"
        dialogText: "آیا از حذف دسته ارزیابی مطمئن می‌باشید؟"
        acceptVisible: true
        rejectVisible: true

        onDialogAccepted: {
            if(dbMan.evalCatDelete(deletePage.eval_cat_id))
                successDialogId.open();
            else
            {
                var errorString = dbMan.getLastError();
                infoDialogId.dialogText = errorString
                infoDialogId.width = parent.width
                infoDialogId.height = 500
                infoDialogId.open();
            }
        }
    }

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "حذف دسته ارزیابی با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "دسته ارزیابی با موفقیت حذف شد."
        dialogSuccess: true
        onDialogAccepted: function(){
            successDialogId.close();
            deletePage.popStackSignal();
            deletePage.deletedSignal();
        }

    }
}
