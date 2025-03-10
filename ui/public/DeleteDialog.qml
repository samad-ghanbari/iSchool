import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog
{
    id : deleteDialogBox
    property string dialogText
    closePolicy:Popup.NoAutoClose
    signal deletedSignal();

    width: (parent.width > 400)? 400 : parent.width
    height: 250
    modal: true
    dim: true
    anchors.centerIn: parent;
    //standardButtons: Dialog.Ok
    title: "حذف"


    header: Rectangle{
        width: parent.width;
        height: 50;
        color:  "crimson";
        Text{ text: "حذف"; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "Kalameh"; font.pixelSize: 16}
    }

    background: Rectangle{color:"lavenderblush"}

    contentItem:
        Column
    {
        width: parent.width
        height: 150

        Item{height:  10; width: parent.width}

        Text {
            id: dialogContent
            width: parent.width
            height: 50
            horizontalAlignment: Text.AlignLeft
            text: deleteDialogBox.dialogText
            font.family: "Kalameh"
            font.pixelSize: 16
            wrapMode: Text.WrapAnywhere
            color:"crimson";
        }

        Item{height:  50;  width: parent.width;}


        RowLayout{
            width: parent.width
            height: 20
            CheckBox {
                id: confirmChB
                Layout.preferredHeight: 20
                Layout.preferredWidth:  20
                checked: false
                indicator: Rectangle {
                    width: 20
                    height: 20
                    radius: 2
                    color: "white"
                    border.width: 1
                    border.color:"gray"

                    Rectangle{
                        width: 10
                        height: 10
                        anchors.centerIn: parent
                        color: confirmChB.checked ? "green" : "red"
                    }
                }

                onCheckedChanged: okBtn.enabled = checked
            }
            Label
            {
                Layout.preferredHeight: 20
                verticalAlignment: Label.AlignVCenter
                text: "تایید حذف"
                font.family: "Kalameh"
                font.pixelSize: 14
                color: (confirmChB.checked) ? "green" : "red";
                MouseArea{
                    anchors.fill: parent
                    onClicked: confirmChB.toggle();
                }
            }

            Item{Layout.fillWidth: true; Layout.preferredHeight: 20}
        }

    }


    footer:
        RowLayout{
            width: parent.width;
            height: 50
            Item{Layout.fillWidth: true; Layout.preferredHeight: 50}
            Button{
                text: "انصراف"
                Layout.preferredHeight:  50
                Layout.preferredWidth:  100
                font.family: "Kalameh"
                font.pixelSize: 14
                onClicked: deleteDialogBox.close();
                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
            }
            Button
            {
                id: okBtn
                text: "تایید"
                Layout.preferredHeight:  50
                Layout.preferredWidth:  100
                font.family: "Kalameh"
                font.pixelSize: 14
                onClicked: {
                    confirmChB.checked = false;
                    deleteDialogBox.deletedSignal();
                }
                enabled: false
                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
            }

        }


}
