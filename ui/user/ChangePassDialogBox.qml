import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog
{
    id: changePasswordDialog
    property alias textField1Value : dialogTextField1.text;
    property alias textField1Echo: dialogTextField1.echoMode

    property alias textField2Value : dialogTextField2.text;
    property alias textField2Echo: dialogTextField2.echoMode


    width: (parent.width > 400)? 400 : parent.width
    height: 300
    modal: true
    anchors.centerIn: parent;
    title: "تغییر رمز عبور"

    signal dialogAccepted();
    signal dialogRejected();
    onDialogRejected: changePasswordDialog.close();

    header: Rectangle{
        width: parent.width;
        height: 50;
        color:  "forestgreen"
        Text{ text:"تغییر رمزعبور کاربر"; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "B Yekan"; font.pixelSize: 16}
    }

    contentItem:
        ColumnLayout
    {
        id: dialogCLId
        width: parent.width
        height: Qt.binding(function(){ return (dialogContent.height + 100);})

        Item{Layout.preferredHeight:  10; Layout.preferredWidth: dialogCLId.width;}

        Text {
            id: dialogContent
            Layout.preferredWidth: parent.width
            horizontalAlignment: Text.AlignLeft
            text: "رمزعبور جدید را وارد نمایید"
            font.family: "B Yekan"
            font.pixelSize: 16
            color:  "forestgreen"
        }
        TextField
        {
            id: dialogTextField1
            font.family: "B Yekan"
            font.bold: true
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 40
            echoMode: TextField.Password
        }


        Text {
            Layout.preferredWidth: parent.width
            horizontalAlignment: Text.AlignLeft
            font.family: "B Yekan"
            text: "رمزعبور جدید را مجدد وارد نمایید"
            font.pixelSize: 16
            color:  "forestgreen"
        }
        TextField
        {
            id: dialogTextField2
            font.family: "B Yekan"
            font.bold: true
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 40
            echoMode: TextField.Password
        }

        Item{Layout.preferredHeight:  20;  Layout.preferredWidth: dialogCLId.width;}
    }


    footer:
        Item{
        width: parent.width;
        height: 50
        RowLayout
        {
            Button{
                text: "انصراف"
                Layout.preferredHeight:  40
                Layout.preferredWidth:  100
                font.family: "B Yekan"
                font.pixelSize: 14
                onClicked: changePasswordDialog.dialogRejected();
                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
            }
            Button
            {
                text: "تایید"
                Layout.preferredHeight:  40
                Layout.preferredWidth:  100
                font.family: "B Yekan"
                font.pixelSize: 14
                onClicked: changePasswordDialog.dialogAccepted();
                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
            }
            Item{Layout.fillWidth: true}
        }
    }
}
