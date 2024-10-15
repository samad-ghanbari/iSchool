import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {

    id: appWindowId
    minimumWidth: 400
    minimumHeight: 400
    visibility: Window.Maximized
    visible: true
    color: "lavender"
    title: qsTr("مدارس روشنگران")
    LayoutMirroring.enabled: true
    LayoutMirroring.childrenInherit: true
    //flags: Qt.WindowSystemMenuHint | ~Qt.WindowCloseButtonHint;

    FontLoader { id: yekanFont; source: "qrc:/Assets/font/yekan.ttf" }

    menuBar: MenubarModule{id: menubarId;}
    header : ToolbarModule{id:toolbarId; }

    StackView {
            id: homeStackViewId
            initialItem: HomePage{ objectName: "homePageON"}
            anchors.fill: parent
        }

}
