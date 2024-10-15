import QtQuick
import QtQuick.Window
import QtQuick.Controls.Basic

Window {
    id: appNoConnWindow

    Image {
        id: backgroundNoConnId
        source: "qrc:/Assets/images/logo/logo512.png"
        anchors.fill: parent;
    }

    Rectangle
    {
        anchors.fill: parent
        color: "#efffabab"
    }

    Item{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: backimageId
            source: "qrc:/Assets/images/login/disconnection.png"
            opacity: 1
            width: 256
            height: width
            anchors.centerIn: parent
            ScaleAnimator on scale {
                    from: 0.5;
                    to: 1;
                    duration: 1000
                }
        }

        Text {
            id: noConnectionId
            text: qsTr("ارتباط با دیتابیس با خطا مواجه شد")
            font.pixelSize: 36
            font.family: yekanFont.font.family
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#FFF"
            anchors.top: backimageId.bottom
        }
        Text {
            id: noConnectionDbId
            text: qsTr("ارتباط با دیتابیس را بررسی نمایید")
            font.pixelSize: 24
            font.family: yekanFont.font.family
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#800"
            anchors.top: noConnectionId.bottom
            ScaleAnimator on scale {
                    from: 0.5;
                    to: 1;
                    duration: 1000
                }
        }



    }



}
