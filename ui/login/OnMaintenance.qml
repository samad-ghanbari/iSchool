import QtQuick
import QtQuick.Controls.Basic

Page {
    id: onMaintenanceWindowId

    Image {
        id: backgroundNoConnId
        source: "qrc:/Assets/images/logo/logo512.png"
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
            source: "qrc:/Assets/images/login/maintenance.png"
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
            font.family: yekanFont.font.family
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#FFF"
            anchors.top: backimageId.bottom
        }
    }



}
