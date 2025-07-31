import QtQuick
import QtQuick.Controls.Fusion

Page {
    id: appLoginForm

    signal userLoggedIn();
    signal closeApp();

    function loginBtnClicked()
    {
        incorrectUserPassTxt.text ="";
        backgroundAnimId.start()
        var username = usernameField.text
        var password = passwordField.text
        if( (username === "") || (password === ""))
        {
            incorrectUserPassTxt.text = "نام‌کاربری و پسورد الزامی می‌باشد."
            incorrectuserPassAnim.start()
            return;
        }

        if(dbMan.userAuthenticate(username, password))
        {
            appLoginForm.userLoggedIn();
        }
        else
        {
            incorrectUserPassTxt.text = "نام‌کاربری یا پسورد اشتباه می‌باشد."
            incorrectuserPassAnim.start()
            return;
        }
    }

    Image {
        id: backimageId
        source: "qrc:/assets/images/background/back1.jpg"
        anchors.fill: parent
        opacity: 0
    }
    Image {
        id: bglogo
        source: "qrc:/assets/images/logo/logo1024.png"
        anchors.fill: parent
        opacity: 1
    }

    SequentialAnimation
    {
        id: backgroundAnimId

        PropertyAnimation {
            target: loginFormRecId
            property: "color"
            duration: 200
            easing.type: Easing.InOutQuad
            from: "#AADDCCFF"
            to: "#3300FF00"
        }

        PropertyAnimation {
            target: loginFormRecId
            property: "color"
            duration: 200
            easing.type: Easing.InOutQuad
            from: "#3300FF00"
            to: "#AADDCCFF"
        }
    }

    Rectangle
    {
        id: loginFormRecId
        width: 400; // parent.width
        height:  500; //Qt.binding(function(){ return loginFormColumnId.height+100;})
        anchors.centerIn: parent
        color: "#AADDCCFF"
        radius: 10
        border.width: 1
        border.color: "#555"
        opacity: 0


        Column
        {
            id: loginFormColumnId
            width: 300
            height: 400
            visible: true
            anchors.centerIn: parent

            Image {
                id: loginImageId
                source: "qrc:/assets/images/logo/logo128.png"
                width: 128
                height: 128
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Item{height:10;width:parent.width}

            Text{
                id: loginTextId
                width: parent.width
                height: 40
                text: "ورود به سامانه روشنگران"
                color: "snow"
                font.bold: true
                font.pixelSize: 20
                font.family: "Kalameh"
                horizontalAlignment:  Text.AlignHCenter
            }

            TextField
            {
                id: usernameField
                height: 50
                width : parent.width
                placeholderText: "کد‌ملی"
                font.family: "Kalameh"
                KeyNavigation.tab: passwordField
                focus: true
            }

            TextField
            {
                id: passwordField
                height: 50
                width : parent.width
                font.family: "Kalameh"
                placeholderText: "رمز‌عبور"
                echoMode: TextField.Password
                KeyNavigation.tab: loginBtnId
            }

            Item{height:10;width:parent.width}

            Row
            {
                width: parent.width
                spacing: 3
                Button {
                    id: loginBtnId
                    text: "ورود به سامانه"
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    height: 50
                    width : parent.width/2
                    focus: true
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "darkcyan"}

                    onClicked:
                    {
                        appLoginForm.loginBtnClicked();
                    }

                    hoverEnabled: true
                }
                Button {
                    id: closeBtnId
                    text: "خروج"
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    height: 50
                    width : parent.width/2
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "mediumvioletred"}

                    onClicked:
                    {
                        backgroundAnimId.start()
                        appLoginForm.closeApp();
                    }
                    hoverEnabled: true
                }
            }

            Item{height:10;width:parent.width}
            Text {
                id: versiontxt
                text: "Version " + dbMan.getAppVersion();
                color: "gray"
            }
            Item{height:5;width:parent.width}
            Text {
                id: incorrectUserPassTxt
                text: ""
                color:"mediumvioletred"
                font.family: "Kalameh"
                font.pixelSize: 16
                anchors.horizontalCenter: parent.horizontalCenter
                ScaleAnimator on scale {
                        id: incorrectuserPassAnim
                        from: 1.5;
                        to: 1;
                        duration: 1000
                        running: false
                    }
            }
        }

        ParallelAnimation {
                id: animation
                running: true
                animations: [
                    NumberAnimation { target: bglogo; property: "opacity";from: 1; to: 0; duration: 2000; easing.type: Easing.InOutQuad },
                    NumberAnimation { target: backimageId; property: "opacity";from:0; to: 1; duration: 2000;},
                    NumberAnimation { target: loginFormRecId; property: "opacity"; from:0; to: 1; duration: 2000;easing.type: Easing.InOutQuad },
                    NumberAnimation { target: loginFormRecId; property: "width"; from:0; to: 400; duration: 2000;easing.type: Easing.InOutQuad }
                ]
            }
    }

    Component.onCompleted: usernameField.forceActiveFocus();
    Keys.onReturnPressed: loginBtnClicked();
    Keys.onEnterPressed: loginBtnClicked();
}
