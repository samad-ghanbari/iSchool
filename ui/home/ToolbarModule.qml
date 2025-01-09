pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ToolBar {
    id:toolbarId;
    position: ToolBar.Header
    width: parent.width
    height: 64

    required property StackView appStackView;

    RowLayout{
        width: toolbarId.width
        height: 64

        ToolButton
        {
            Layout.preferredHeight:  64
            Layout.preferredWidth:  64
            Layout.alignment: Qt.AlignLeft
            background: Item{}
            icon.source: (toolbarId.appStackView.depth > 1)?  "qrc:/assets/images/arrow-right.png" :""
            icon.width: 64
            icon.height: 64
            icon.color:"transparent"
            opacity: 0.5
            onClicked: toolbarId.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }

        ToolButton {
            id: menuHomeId
            Layout.preferredWidth: 64
            Layout.preferredHeight:  64
            Layout.alignment: Qt.AlignHCenter
            // text: "صفحه‌اصلی"
            // font.family: "Kalameh"
            // font.pixelSize: 16
            background: Item{}
            onClicked:
            {
                toolbarId.appStackView.pop(null);
            }
            icon.source: "qrc:/assets/images/home2.png"
            icon.width: 64
            icon.height: 64
            icon.color:"transparent"
            hoverEnabled: true
            opacity: 0.5
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }

        ToolButton
        {
            Layout.preferredHeight:  64
            Layout.preferredWidth:  64
            Layout.alignment: Qt.AlignRight
            background: Item{}
            icon.source: "qrc:/assets/images/info.png"
            icon.width: 64
            icon.height: 64
            icon.color:"transparent"
            opacity: 0.5
            onClicked: toolbarId.appStackView.push("qrc:/resources/About.qml",{objectName: "aboutON"});
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
    }
}

