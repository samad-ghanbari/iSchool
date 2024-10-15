import QtQuick
import QtQuick.Controls.Basic

Page {
    id: newReleaseWindowId

    Image {
        id: backgroundNoConnId
        source: "qrc:/Assets/images/logo/logo512.png"
        anchors.fill: parent;
    }

    Rectangle
    {
        anchors.fill: parent
        color: "#ef00dda8"
    }

    Item{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: backimageId
            source: "qrc:/Assets/images/login/release.png"
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
            id: updatetctId
            text: qsTr("لطفا نسبت به نصب ورژن جدید برنامه اقدام فرمایید")
            font.pixelSize: 36
            font.family: yekanFont.font.family
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#FFF"
            anchors.top: backimageId.bottom
        }
        Text {
            id: currentVersionId
            text: qsTr("ورژن فعلی نرم‌افزار شما ") + dbMan.getAppVersion();
            font.pixelSize: 24
            font.family: yekanFont.font.family
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#FFF"
            anchors.top: updatetctId.bottom
        }
        Text {
            id: newVersionId
            text: qsTr("ورژن جدید نرم‌افزار ") + dbMan.getVersion()
            font.pixelSize: 36
            font.family: yekanFont.font.family
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#050"
            anchors.top: currentVersionId.bottom
            ScaleAnimator on scale {
                    from: 0.5;
                    to: 1;
                    duration: 1000
                }
        }
    }



}
