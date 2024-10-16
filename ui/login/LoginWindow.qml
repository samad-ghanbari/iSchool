import QtQuick
import QtQuick.Window


Window {
    id: appLoginWindowId
    minimumWidth: 400
    minimumHeight: 400
    visibility: Window.Maximized
    visible: true
    color: "skyblue"
    title: qsTr("روشنگران")
    //flags: Qt.WindowSystemMenuHint | ~Qt.WindowCloseButtonHint;


    // FontLoader { id: yekanFont; source: "assets/font/yekan.ttf" }

    InitialLogin{}

}

