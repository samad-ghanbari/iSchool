import QtQuick
import QtQuick.Controls

Page {
    id: onMaintenanceWindowId

    FontLoader { id: yekanFont; source: "qrc:/assets/font/yekan.ttf" }

    Image {
        id: backgroundNoConnId
        source: "qrc:/assets/images/logo/logo512.png"
        anchors.fill: parent;
    }

    Rectangle
    {
        anchors.fill: parent
        color: "#ef00afff"
    }

    Item{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: backimageId
            source: "qrc:/assets/images/login/maintenance.png"
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
            text: qsTr("دیتابیس در حال بروزرسانی می‌باشد")
            font.pixelSize: 36
            font.family: "B Yekan"
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#FFF"
            anchors.top: backimageId.bottom
        }
    }



}
