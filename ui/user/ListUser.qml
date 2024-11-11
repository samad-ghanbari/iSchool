pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "ListUser.js" as ListUserJS

Page {
    id: userListPage
    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    required property StackView appStackView;

    GridLayout
    {
        anchors.fill: parent
        columns: 3

        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/arrow-right.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: userListPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            text: "لیست کاربران سامانه"
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
        }
        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/search.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: userSearchDrawer.open();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }

        Button
        {
            Layout.columnSpan: 3
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            Layout.alignment: Qt.AlignHCenter
            background: Item{}
            icon.source: "qrc:/assets/images/add.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: userListPage.appStackView.push(newUserPageComponent, {objectName: "NewUserON"})
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }


        GridView {
            id: lugview
            Layout.columnSpan: 3
            Layout.alignment: Qt.AlignHCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 20
            cellWidth: 300
            cellHeight: 300
            model: ListModel{id: userListModel}
            delegate:
                UsersListWidget{
                required property var model;

                appStackView: userListPage.appStackView;
                onUserDeleted:
                {
                    userListPage.appStackView.pop();
                    userListPage.appStackView.pop();
                    ListUserJS.updateUsersModel();
                }
                onUserUpdated: ListUserJS.updateUsersModel();

                userId: model.Id; userName: model.Name; userLastname: model.Lastname; userNatId: model.Nat_id; userJobPosition: model.Job_position;
                userEnabled: model.Enabled; userAdmin: model.Admin; userIsFemale: model.UserFemale;
            }

            layoutDirection: Qt.LeftToRight
            Component.onCompleted: { ListUserJS.updateUsersModel();}
        }
    }

    Drawer
    {
        id: userSearchDrawer
        modal: true
        height: parent.height
        width: 300 //(parent.width > 300)? 300 : parent.width;
        dragMargin: 0

        ScrollView
        {
            id: userListDrawerSV
            anchors.fill: parent

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ColumnLayout
            {
                width: userListDrawerSV.width
                //height: userListDrawerSV.height

                Rectangle
                {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 110
                    color: "lavender"

                    Image {
                        id: searchUserListImage
                        source: "qrc:/assets/images/search.png"
                        width: 64
                        height: 64
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        width: parent.width
                        height: 40
                        anchors.top: searchUserListImage.bottom
                        horizontalAlignment: Qt.AlignHCenter
                        anchors.topMargin: 10
                        text: "جستجوی کاربران"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignHCenter
                        font.bold: true
                        color:"royalblue"
                    }
                }

                //Rectangle{Layout.fillWidth: true; height: 4; color:"royalblue"}
                // name lastname natid tel email position admin en admin
                //name
                Text {
                    text: "نام کاربر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "royalblue"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: searchUserNameTF
                    placeholderText: "نام کاربر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -10
                }

                //lastname
                Text {
                    text: "نام ‌خانوادگی کاربر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "royalblue"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: searchUserLastNameTF
                    placeholderText: "نام ‌خانوادگی کاربر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -10
                }

                //natid
                Text {
                    text: "کد‌ملی کاربر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "royalblue"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: searchUserNatidTF
                    placeholderText: "کد‌ملی کاربر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -10
                }

                //tel
                Text {
                    text: "شماره ‌تماس کاربر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "royalblue"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: searchUserTelTF
                    placeholderText: "شماره ‌تماس کاربر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -10
                }

                //Position
                Text {
                    text: "سمت ‌شغلی کاربر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    color: "royalblue"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: searchUserPositionTF
                    placeholderText: "سمت ‌شغلی کاربر"
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -10
                }

                // button

                Button
                {
                    text: "جستجو"
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 100
                    Layout.alignment: Qt.AlignHCenter
                    icon.source: "qrc:/assets/images/search.png"
                    icon.width: 32
                    icon.height: 32

                    onClicked: {

                        var userFilter = {};
                        userFilter["name"] = searchUserNameTF.text;
                        userFilter["lastname"] = searchUserLastNameTF.text;
                        userFilter["nat_id"] = searchUserNatidTF.text;
                        userFilter["telephone"] = searchUserTelTF.text;
                        userFilter["job_position"] = searchUserPositionTF.text;

                        ListUserJS.filterUsersModel(userFilter);

                    }

                    Rectangle{width: parent.width; height: 4; color:"royalblue"; anchors.bottom: parent.bottom}
                }
            }
        }
    }

    Component
    {
        id: newUserPageComponent
        NewUser{
            appStackView: userListPage.appStackView;
            onUserInsertedSignal:
            {
                ListUserJS.updateUsersModel();
            }
        }
    }
}

