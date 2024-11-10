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

    InitialLogin{
        onUserLoggedIn: appLoginWindowId.hide();
        onCloseApp: appLoginWindowId.close();
    }

}

