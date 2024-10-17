pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Window
import QtQuick.Controls

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

    menuBar: MenubarModule{ id: menubarId; }
    header : ToolbarModule{id:toolbarId; }

    StackView {
            id: homeStackViewId
            initialItem: HomePage{ objectName: "homePageON"}
            anchors.fill: parent
        }

}
