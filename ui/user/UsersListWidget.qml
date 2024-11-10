pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {

    id: userWidget
    property int userId
    property string userName
    property string userLastname
    property string userNatId
    property string userJobPosition
    property bool userEnabled
    property bool userAdmin
    property bool userIsFemale

    required property StackView appStackView;
    signal userDeleted();
    signal userUpdated();

    width: 256
    height: 230
    color:(userEnabled)? "white" : "lightpink"
    opacity: 0.8
    radius: 10

    Item
    {
        anchors.fill: parent
        anchors.margins: 5
        Image {
            source:"qrc:/assets/images/setting2.png";
            visible:  (userWidget.userAdmin)? true: false;
            width: 32
            height: 32
            anchors.top: parent.top
            anchors.right: parent.right
        }

        ColumnLayout
        {
            id: userWidgetCL
            anchors.fill: parent

            Image {
                source: (userWidget.userIsFemale)? "qrc:/assets/images/female.png" : "qrc:/assets/images/user.png"
                Layout.preferredWidth: 128
                Layout.preferredHeight: 128
                Layout.alignment: Qt.AlignHCenter
            }
            Text {
                text: userWidget.userName + " " + userWidget.userLastname
                font.family: "B Yekan"
                font.pixelSize: 16
                font.bold: true
                color: "royalblue"
                Layout.preferredWidth: parent.width
                horizontalAlignment: Text.AlignHCenter
            }
            Text {
                text: "کدملی" + " : " + userWidget.userNatId
                font.family: "B Yekan"
                font.pixelSize: 16
                font.bold: true
                Layout.alignment: Qt.AlignLeft
                Layout.fillWidth: true
            }
            Text {
                text: "پست‌شغلی" + " : " + userWidget.userJobPosition
                font.family: "B Yekan"
                font.pixelSize: 16
                font.bold: true
                Layout.alignment: Qt.AlignLeft
                Layout.fillWidth: true
            }

        }

    }

    function updatePage(User)
    {
        userName = User["name"];
        userLastname = User["lastname"]
        userNatId = User["nat_id"];
        userJobPosition = User["job_position"];
        userEnabled = User["enabled"];
        userAdmin = User["admin"];
        userIsFemale = (User["gender"] === "خانم") ? true : false;

        userWidget.userUpdated();
    }


    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        onHoveredChanged: (containsMouse)? parent.opacity=1 : parent.opacity=0.8
        onClicked: {
            userWidget.appStackView.push(userComponent, {userId: userWidget.userId, objectName: "userON"});
        }
    }

    Component
    {
        id: userComponent
        User{
            appStackView: userWidget.appStackView;
            onUserDeleted: userWidget.userDeleted();
            onUserUpdated: ()=> userWidget.userUpdated();
        }
    }

}
