import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: appLoginWindowId
    width: 400
    height: 400;
    visibility: Window.Maximized;
    minimumWidth: 400
    minimumHeight: 400
    visible: true;
    color: "skyblue";
    title: "روشنگران";

    //flags: Qt.WindowSystemMenuHint | ~Qt.WindowCloseButtonHint;

    InitialLogin{
        onUserLoggedIn: appLoginWindowId.hide();
        onCloseApp: appLoginWindowId.close();
    }

}

