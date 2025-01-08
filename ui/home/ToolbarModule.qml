pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ToolBar {
    id:toolbarId;
    position: ToolBar.Header
    width: parent.width

    required property StackView appStackView;



    ToolButton {
        id: menuHomeId
        width: parent.width
        text: "صفحه‌اصلی"
        font.family: "B Yekan"
        font.pixelSize: 16
        onClicked:
        {
            toolbarId.appStackView.pop(null);
        }
        icon.source: "qrc:/assets/images/home2.png"
        icon.width: 32
        icon.height: 32
        icon.color:"transparent"
        hoverEnabled: true
    }


}

