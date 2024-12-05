import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog
{
    id : publicDialogBox
    property string dialogTitle
    property string dialogText
    property bool dialogSuccess : false // false : warning
    property string acceptButtonText: "تایید"
    property string rejectButtonText: "انصراف"
    property bool acceptVisible : true
    property bool rejectVisible : false
    property bool textFieldVisible : false
    property alias textFieldValue : dialogTextField.text;
    property alias textFieldEcho: dialogTextField.echoMode

    closePolicy:Popup.NoAutoClose

    signal dialogAccepted();
    signal dialogRejected();
    onDialogRejected: publicDialogBox.close();
    onDialogAccepted: publicDialogBox.close();

    width: (parent.width > 400)? 400 : parent.width
    height: 200
    modal: true
    dim: true
    anchors.centerIn: parent;
    //standardButtons: Dialog.Ok
    title: publicDialogBox.dialogTitle


    header: Rectangle{
        width: parent.width;
        height: 50;
        color: (publicDialogBox.dialogSuccess)? "forestgreen" : "crimson";
        Text{ text: publicDialogBox.dialogTitle; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "B Yekan"; font.pixelSize: 16}
    }

    contentItem:
        ColumnLayout
    {
        id: baseDialogCLId
        width: parent.width
        height: Qt.binding(function(){ return (dialogContent.height + 100);})

        Item{Layout.preferredHeight:  10; Layout.preferredWidth: baseDialogCLId.width;}

        Text {
            id: dialogContent
            Layout.preferredWidth: parent.width
            horizontalAlignment: Text.AlignLeft
            text: publicDialogBox.dialogText
            font.family: "B Yekan"
            font.pixelSize: 16
            wrapMode: Text.WrapAnywhere
            color: (publicDialogBox.dialogSuccess)? "forestgreen" : "crimson";
        }
        TextField
        {
            id: dialogTextField
            font.family: "B Yekan"
            font.bold: true
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 40
            visible: publicDialogBox.textFieldVisible
        }

        Item{Layout.preferredHeight:  20;  Layout.preferredWidth: baseDialogCLId.width;}
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
                visible: publicDialogBox.rejectVisible
                onClicked: publicDialogBox.dialogRejected();
                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
            }
            Button
            {
                text: "تایید"
                Layout.preferredHeight:  40
                Layout.preferredWidth:  100
                font.family: "B Yekan"
                font.pixelSize: 14
                visible: publicDialogBox.acceptVisible
                onClicked: publicDialogBox.dialogAccepted()
                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
            }
            Item{Layout.fillWidth: true}
        }
    }
}
