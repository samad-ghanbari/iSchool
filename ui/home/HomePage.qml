import QtQuick
import QtQuick.Controls

Page {
    id: homePageId
    background: Image {
        id: bgHomePage
        source: "qrc:/Assets/images/background/back3.jpg"
        anchors.fill: parent
    }

    Image {
        id: logoHomePage
        source: "qrc:/Assets/images/logo/logo1024.png"
        anchors.centerIn: parent
        height: parent.height/2
        width: height

        NumberAnimation on scale
        {
            duration: 3000
            from: 10
            to: 1
            easing.type: Easing.OutElastic
            easing.period: 1
        }
    }

    Text {
        id: userInfoId
        width: parent.width
        text: dbMan.getUserName() + " عزیز به سامانه روشنگران خوش آمدید"
        anchors.bottom: parent.bottom
        font.family: yekanFont.font.family
        font.pixelSize: 16
        font.bold: true
        color: "black"
        horizontalAlignment: Text.AlignHCenter
        style: Text.Outline
        styleColor: "silver"
    }

}
