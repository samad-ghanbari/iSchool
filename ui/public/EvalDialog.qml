import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Dialog
{
    id : evalDialogBox

    required property var model; // [{}]
    property int selected_semester : 1;
    closePolicy:Popup.NoAutoClose
    signal evalSelected(var eval_id);

    function fillComboBox(){
        //
        evalModel.clear();
        let sem;
        for(var obj of evalDialogBox.model){
            sem = (obj.semester === 1)? "نیمسال اول" : "نیمسال دوم";
            if( obj.semester === evalDialogBox.selected_semester )
                evalModel.append({"text": obj.eval_name + " - " + sem, "value": obj.id });
        }
        cb.currentIndex = -1;
        okBtn.enabled = false
    }


    width: (parent.width > 400)? 400 : parent.width
    height: 250
    modal: true
    dim: true
    anchors.centerIn: parent;

    header: Rectangle{
        width: parent.width;
        height: 50;
        color: "darkcyan"
        Text{ text: "انتخاب ارزیابی"; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "Kalameh"; font.pixelSize: 16}
    }

    contentItem:
        ColumnLayout
    {
        width: parent.width
        height: 250

        Item{Layout.preferredHeight:  10; Layout.fillWidth: true;}

        Text {
            Layout.preferredWidth: parent.width
            horizontalAlignment: Text.AlignLeft
            text: "ارزیابی مورد نظر خود را انتخاب نمایید"
            font.family: "Kalameh"
            font.pixelSize: 16
            wrapMode: Text.WrapAnywhere
            color: "darkslategray"
        }
        ComboBox
        {
            id: cb
            Layout.preferredHeight:  50
            Layout.fillWidth: true
            editable: false
            font.family: "Kalameh"
            font.pixelSize: 16
            model: ListModel{id: evalModel}
            textRole: "text"
            valueRole: "value"
            onActivated: okBtn.enabled = true
        }


        Item{Layout.fillHeight: true;  Layout.fillWidth: true;}
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
                font.family: "Kalameh"
                font.pixelSize: 14
                onClicked: evalDialogBox.close();
                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "crimson"}
            }
            Button
            {
                id: okBtn
                text: "تایید"
                enabled: false
                Layout.preferredHeight:  40
                Layout.preferredWidth:  100
                font.family: "Kalameh"
                font.pixelSize: 14
                onClicked: evalDialogBox.evalSelected(cb.currentValue)
                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
            }
            Item{Layout.fillWidth: true}
        }
    }
}
