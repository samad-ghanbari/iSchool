import QtQuick
import QtQuick.Controls

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
        source: "qrc:/assets/images/background/back4.jpg"
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
            from: "#88DDCCFF"
            to: "#3300FF00"
        }

        PropertyAnimation {
            target: loginFormRecId
            property: "color"
            duration: 200
            easing.type: Easing.InOutQuad
            from: "#3300FF00"
            to: "#88DDCCFF"
        }
    }

    Rectangle
    {
        id: loginFormRecId
        width: 400; // parent.width
        height:  500; //Qt.binding(function(){ return loginFormColumnId.height+100;})
        anchors.centerIn: parent
        color: "#88DDCCFF"
        radius: 5
        border.width: 1
        border.color: "#555"


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
                color: "slategray"
                font.bold: true
                font.pixelSize: 20
                font.family: "Far.Afaaq"
                horizontalAlignment:  Text.AlignHCenter
            }

            TextField
            {
                id: usernameField
                height: 50
                width : parent.width
                placeholderText: "کد‌ملی"
                font.family: "B Yekan"
                KeyNavigation.tab: passwordField
                focus: true
            }

            TextField
            {
                id: passwordField
                height: 50
                width : parent.width
                font.family: "B Yekan"
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
                    font.family: "B Yekan"
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
                    font.family: "B Yekan"
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
                font.family: "B Yekan"
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
    }

    Component.onCompleted: usernameField.forceActiveFocus();
}
