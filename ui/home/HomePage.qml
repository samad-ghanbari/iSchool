import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Page {
    id: homePageId

    signal branchSelected(var branch);


    background: Image {
        id: bgHomePage
        source: "qrc:/assets/images/background/back3.jpg"
        anchors.fill: parent
    }

    Image {
        id: logoHomePage
        source: "qrc:/assets/images/logo/logo1024.png"
        anchors.centerIn: parent
        height: parent.height/2
        width: height

        NumberAnimation on scale
        {
            duration: 3000
            from: 10
            to: 0
            easing.type: Easing.OutExpo
            easing.period: 1
        }
    }

    MultiEffect {
            source: logoHomePage
            anchors.fill: logoHomePage
            blurEnabled: true
            blur: 5
            blurMax: 10
        }



    ListView{
        id: branchLV
        model: ListModel{id: branchModel;}
        anchors.fill: parent
        anchors.topMargin: 20
        opacity: 0
        spacing: 20

        clip: true
        delegate: Rectangle{
            id: recdel;
            required property var model;
            width: branchLV.width
            height: 100
            color: "transparent";
            Label{
                width: parent.width
                height: 50
                font.family: "Kalameh"
                font.pixelSize: 20
                font.bold: true
                color: "darkmagenta"
                text: "شعبه " + recdel.model.city + " " + recdel.model.branch_name
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                anchors.top: parent.top
            }
            Label{
                width: parent.width
                height: 50
                font.family: "Kalameh"
                font.pixelSize: 20
                font.bold: true
                color: "darkslategray"
                text: recdel.model.branch_address
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                anchors.bottom: parent.bottom
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.color = "lavenderblush";
                onExited: parent.color = "transparent";
                onClicked: {
                    // step page
                    var branch_id = recdel.model.id;
                    var branch = recdel.model.city + " " + recdel.model.branch_name
                    dbMan.setBranch(branch_id);
                    homePageId.branchSelected(branch);
                }
            }
        }

        NumberAnimation on opacity { to: 1; duration: 2000 }

        Component.onCompleted: {
            var jsondata = dbMan.getBranches();
            branchModel.clear();
            //id, city, branch_name, branch_address
            for(var obj of jsondata)
            {
                branchModel.append(obj);
            }
        }
    }

    Text {
        id: userInfoId
        width: parent.width
        text: dbMan.getUserName() + " عزیز به سامانه روشنگران خوش آمدید"
        anchors.bottom: parent.bottom
        font.family: "Kalameh"
        font.pixelSize: 16
        font.bold: true
        color: "black"
        horizontalAlignment: Text.AlignHCenter
        style: Text.Outline
        styleColor: "silver"
    }

}
