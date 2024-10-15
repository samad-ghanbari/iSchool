import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog
{
    property string dialogTitle
    property string dialogText
    property bool dialogSuccess : false // false : warning
    property string acceptButtonText: "تایید"
    property string rejectButtonText: "انصراف"
    property bool acceptVisible : true
    property bool rejectVisible : false
    property var acceptAction : function(){close();}
    property var rejectAction : function(){close();}
    property bool textFieldVisible : false
    property alias textFieldValue : dialogTextField.text;
    property alias textFieldEcho: dialogTextField.echoMode


    width: (parent.width > 400)? 400 : parent.width
    height: 200
    modal: true
    anchors.centerIn: parent;
    //standardButtons: Dialog.Ok
    title: dialogTitle

    onAccepted: acceptAction();
    onRejected: rejectAction();

    header: Rectangle{
        width: parent.width;
        height: 50;
        color: (dialogSuccess)? "forestgreen" : "crimson";
        Text{ text:dialogTitle; anchors.centerIn: parent; color: "white";font.bold:true; font.family: yekanFont.font.family; font.pixelSize: 16}
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
            text: dialogText
            font.family: yekanFont.font.family
            font.pixelSize: 16
            color: (dialogSuccess)? "forestgreen" : "crimson";
        }
        TextField
        {
            id: dialogTextField
            font.family: yekanFont.font.family
            font.bold: true
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 40
            visible: textFieldVisible
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
                font.family: yekanFont.font.family
                font.pixelSize: 14
                visible: rejectVisible
                onClicked: reject();
                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
            }
            Button
            {
                text: "تایید"
                Layout.preferredHeight:  40
                Layout.preferredWidth:  100
                font.family: yekanFont.font.family
                font.pixelSize: 14
                visible: acceptVisible
                onClicked: accept();
                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
            }
            Item{Layout.fillWidth: true}
        }
    }
}
