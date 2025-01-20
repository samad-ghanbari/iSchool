pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Row{
    id: widgetItem

    required property int widgetHeight
    property alias key : keyLabel.text
    property alias value : valueLabel.text

    signal removeSignal()

    Label{
        id: keyLabel
        height:  widgetItem.widgetHeight
        text:""
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
        text:""
        font.family: "Kalameh"
        font.pixelSize: 12
        font.bold: false
        color:"darkcyan"
        horizontalAlignment: Label.AlignRight
        verticalAlignment: Label.AlignVCenter
    }

    Button{
        id: rmBtn

            height: widgetItem.widgetHeight
            icon.source: "qrc:/assets/images/cross.png"
            icon.width: 24
            icon.height: 24
            icon.color:"transparent"
            opacity: 0.5
            onClicked:  widgetItem.removeSignal()
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;

    }

}
