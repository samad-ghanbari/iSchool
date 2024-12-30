//pragma ComponentBehavior: Bound

import QtQuick 2.15
import QtQuick.Controls 2.15

Item
{
    id: loginInitialItem
    anchors.fill: parent
    signal userLoggedIn();
    signal closeApp();

    function initialLogin()
    {
        // database connection
        var dbConnected = dbMan.isDbConnected();
        if(dbConnected === false)
            return noConnectionComponent;
        // on maintenance mode
        var onMaintenance = dbMan.isOnMaintenance();
        if(onMaintenance === true)
            return onMaintenanceComponent
        // new realease check
        var newRelease = dbMan.newRelease();
        if(newRelease === true)
            return newReleaseComponent
        //login to App
        return loginComponent
    }

    StackView {
        id: stackview
        anchors.fill: parent
        initialItem: loginInitialItem.initialLogin()
    }

    Component
    {
        id: noConnectionComponent
        NoConnection{}
    }

    Component
    {
        id: onMaintenanceComponent
        OnMaintenance{}
    }

    Component
    {
        id: newReleaseComponent
        NewRelease{}
    }

    Component
    {
        id: loginComponent
        LoginForm{
            onUserLoggedIn:
            {
                loginInitialItem.visible=false;
                loginInitialItem.enabled=false;
                loginInitialItem.destroy();
                loginInitialItem.userLoggedIn();
                backend.loadHome();
            }

            onCloseApp: loginInitialItem.closeApp();
        }
    }

}

