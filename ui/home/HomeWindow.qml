//pragma ComponentBehavior: Bound

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
ApplicationWindow {

    id: appWindowId
    visibility: Window.Maximized
    visible: true
    color: "lavender"
    title: qsTr("مدارس روشنگران")
    LayoutMirroring.enabled: true
    LayoutMirroring.childrenInherit: true
    //flags: Qt.WindowSystemMenuHint | ~Qt.WindowCloseButtonHint;

    // contentItem: Item
    // {
    //     width: appWindowId.width
    //     height: appWindowId.height
    //     minimumWidth: 300 // Set your desired minimum width here
    // }


    // menuBar: MenubarModule{ id: menubarId; appStackView: homeStackViewId; toolbarId: toolbarId; }
    // header : ToolbarModule{id:toolbarId; appStackView: homeStackViewId; app: appWindowId; }


    // StackView {
    //         id: homeStackViewId
    //         initialItem: HomePage{ } //objectName: "homePageON"
    //         anchors.fill: parent
    //     }

}
