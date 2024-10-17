import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: userChangePassPage;

    property var user;
    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent
        RowLayout
        {
            width: parent.width
            Button
            {
                background: Item{}
                icon.source: "qrc:/Assets/images/arrow-right.png"
                icon.width: 64
                icon.height: 64
                opacity: 0.5
                onClicked: homeStackViewId.pop();
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
            Item
            {
                Layout.fillWidth: true
            }

            Text {
                text: user["name"] + " " + user["lastname"]
                Layout.alignment: Qt.AlignHCenter
                font.family: yekanFont.font.family
                font.pixelSize: 24
                font.bold: true
                color: "mediumvioletred"
                style: Text.Outline
                styleColor: "white"
            }

            Item
            {
                Layout.fillWidth: true
            }
        }
        ScrollView
        {
            id: userDelSV
            Layout.fillHeight: true
            Layout.fillWidth: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            background: Rectangle{width: parent.width; height: parent.height; color: "lavenderblush";}

            PaddedRectangle
            {
                id: userBox
                color:"white"
                width:  (userDelSV.width < 700)? userDelSV.width : 700
                anchors.horizontalCenter: parent.horizontalCenter
                implicitHeight: userManColId.height
                padding: -10
                radius: 10

                ColumnLayout
                {
                    id: userManColId
                    width: parent.width

                    Text
                    {
                        text: "حذف کاربر"
                        font.family: yekanFont.font.family
                        font.pixelSize: 24
                        font.bold: true
                        color: "crimson"
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 50
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                    }

                    RowLayout
                    {
                        width: parent.width
                        Item
                        {
                            Layout.fillWidth: true
                        }
                        Button
                        {
                            background: Item{}
                            icon.source: "qrc:/Assets/images/trash3.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked: userDelDialog.open();
                            hoverEnabled: true
                            onHoveredChanged:
                            {
                                if(hovered)
                                {
                                     this.opacity = 1
                                     this.scale = 1.1
                                }
                                else
                                {
                                    this.opacity = 0.8
                                    this.scale = 1
                                }
                            }
                        }
                        Item
                        {
                            Layout.fillWidth: true
                        }
                    }
                    //id, name, lastname, nat_id, password, email, job_position, telephone, access, write_permission, enabled, admin, gender
                    GridLayout
                    {
                        id: userBasicsId
                        columns: 2
                        rows: 9
                        rowSpacing: 20
                        columnSpacing: 10
                        width: userBox.width

                        //admin
                        Rectangle
                        {
                            Layout.columnSpan: 2
                            Layout.preferredHeight: 50
                            Layout.fillWidth: true
                            color: "mediumvioletred"
                            visible: (user["admin"])? true : false;
                            Text {
                                anchors.fill: parent
                                text: "ادمین سامانه"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Qt.AlignHCenter
                                font.family: yekanFont.font.family
                                font.pixelSize: 24
                                font.bold: true
                                color: "white"
                            }
                        }

                        Text {
                            text: "نام‌کاربر "
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        Text
                        {
                            id: userNameId
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["name"]
                        }

                        Text {
                            text: "نام‌خانوادگی"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        Text
                        {
                            id: userLastNameId
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["lastname"]
                        }

                        Text {
                            text: "کدملی"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        Text
                        {
                            id: userNatidId
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["nat_id"]
                        }

                        Text {
                            text: "جنسیت"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        Text {
                            id: userGenderId
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["gender"]
                        }

                        Text {
                            text: "پست الکترونیکی"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        Text
                        {
                            id: userEmailId
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["email"]
                        }

                        Text {
                            text: "سمت‌شغلی"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        Text
                        {
                            id: userPositionId
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["job_position"]
                        }

                        Text {
                            text: "شماره‌تماس"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            font.bold: true
                            color: "royalblue"
                        }
                        Text
                        {
                            id: userTelId
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Qt.AlignLeft
                            font.family: yekanFont.font.family
                            font.pixelSize: 16
                            text: user["telephone"]
                        }

                    }

                    Item
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                    }
                }
            }
        }
    }


}


