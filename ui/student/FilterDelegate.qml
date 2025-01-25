pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle{

    id: widgetItem

    required property int widgetHeight
    required property string _key; // {key value}
    required property string _value; // {key value}

    height: widgetHeight
    width: wrow.implicitWidth+ 10
    color: "#55b0e0e6"

    signal removeSignal()

    Row{
        id: wrow
        height: parent.height
        spacing: 10

        Label{
            id: keyLabel
            height:  widgetItem.widgetHeight
            text: widgetItem._key + ": "
            font.family: "Kalameh"
            font.pixelSize: 12
            font.bold: false
            color:"darkcyan"
            horizontalAlignment: Label.AlignRight
            verticalAlignment: Label.AlignVCenter
        }

        Label{
            id: valueLabel
            height:  widgetItem.widgetHeight
            text: widgetItem._value
            font.family: "Kalameh"
            font.pixelSize: 12
            font.bold: false
            color:"darkcyan"
            horizontalAlignment: Label.AlignRight
            verticalAlignment: Label.AlignVCenter
        }

        Item{
            height: widgetItem.widgetHeight
            width: height
            Image{
                id: rmBtn
                width: parent.width/2
                height: parent.height/2
                anchors.centerIn: parent
                source: "qrc:/assets/images/cross.png"
                opacity: 0.2
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: rmBtn.opacity = 1
                    onExited: rmBtn.opacity = 0.2
                    onClicked: widgetItem.removeSignal()
                }
            }
        }
    }

}
