pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./Users.js" as JS

Page {
    id: usersPage
    required property StackView appStackView;

    property int limit : 25
    property int offset: 0
    property int usersCount
    property int pageNumber: 1
    // offset shoud be less or equal than limit

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignLeft
            text: "مدیریت کاربران سامانه"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
            style: Text.Outline
            styleColor: "white"
        }

        Flickable{
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentHeight: centerBox.implicitHeight

            Column{
                id: centerBox
                width: parent.width

                RowLayout
                {
                    width: parent.width
                    height: 64

                    Button
                    {
                        background: Item{}
                        Layout.preferredHeight: 64
                        Layout.alignment: Qt.AlignLeft
                        icon.source: "qrc:/assets/images/add.png"
                        icon.width: 40
                        icon.height: 40
                        text: "کاربر جدید"
                        font.pixelSize: 14
                        font.family: "Kalameh"
                        display: AbstractButton.TextUnderIcon
                        font.bold: true
                        icon.color:"transparent"
                        opacity: 0.5
                        //onClicked:  usersPage.appStackView.push(insertComponent);
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }
                    Label{
                        id: usersCountLbl
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        font.bold: true
                        color: "darkcyan"
                        Layout.preferredHeight: 64
                        Layout.alignment: Qt.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        horizontalAlignment: Label.AlignHCenter
                        text: ""
                    }

                    Button
                    {
                        Layout.preferredHeight: 64
                        Layout.alignment: Qt.AlignRight
                        background: Item{}
                        icon.source: "qrc:/assets/images/filter.png"
                        icon.width: 40
                        icon.height: 40
                        text: "فیلتر"
                        font.pixelSize: 14
                        font.family: "Kalameh"
                        display: AbstractButton.TextUnderIcon
                        icon.color:"transparent"
                        opacity: 0.5
                        onClicked: searchDrawer.open();
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }
                }

                // filter box
                Flickable{
                    height:  32
                    width: parent.width
                    contentWidth: (filterBox.implicitWidth > width)?  filterBox.implicitWidth : width


                    RowLayout{
                        anchors.fill: parent
                        Row{
                            id: filterBox
                            Layout.preferredHeight: parent.height
                            spacing: 10
                            Layout.alignment: Qt.AlignHCenter

                            Repeater{
                                model: ListModel{id:filterModel}
                                delegate: UserFilterDelegate{
                                    id:delg
                                    required property var model;
                                    _key : delg.model._key
                                    _value: delg.model._value
                                    _type: delg.model._type
                                    widgetHeight: 32
                                    onRemoveSignal: (_type)=>{
                                        if(_type === "name")
                                        nameTF.text = "";
                                        else if(_type === "lastname")
                                        lastnameTF.text = "";
                                        else if(_type === "gender")
                                        genderCB.text = "";
                                        else if(_type === "nat_id")
                                        natIdTF.text = "";
                                        else if(_type === "job_position")
                                        jobPositionTF.text = "";
                                        else if(_type === "telephone")
                                        telephoneTF.text = "";
                                        else if(_type === "admin")
                                        adminCB.currentIndex = -1;
                                        else if(_type === "superadmin")
                                        superadminCB.currentIndex = -1;
                                        else if(_type === "enabled")
                                        enabledCB.currentIndex = -1;

                                        searchBtn.clicked();
                                    }
                                }
                            }
                        }
                    }

                }

                RowLayout
                {
                    height:   40
                    width:  parent.width
                    Item{Layout.fillWidth: true; Layout.preferredHeight: 10;}
                    Button
                    {
                        background: Item{}
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
                        icon.source: "qrc:/assets/images/toRight.png" // previous
                        icon.width: 40
                        icon.height: 40
                        icon.color:"transparent"
                        opacity: 0.5
                        visible: (usersPage.offset == 0)? false : true
                        onClicked:
                        {
                            usersModel.clear();

                            var cond = {}
                            usersPage.offset = usersPage.offset - usersPage.limit;
                            usersPage.pageNumber = usersPage.pageNumber - 1;
                            if(usersPage.offset  < 0 ) { usersPage.offset = 0; usersPage.pageNumber = 1;}
                            var jsondata = dbMan.getUsers(cond, usersPage.limit, usersPage.offset);

                            for(var obj of jsondata){
                                usersModel.append(obj);
                            }
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }

                    Label{
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        font.bold: true
                        color: "darkcyan"
                        height: 40
                        verticalAlignment: Label.AlignVCenter
                        horizontalAlignment: Label.AlignHCenter
                        text: usersPage.pageNumber
                        visible: (usersPage.usersCount > 25)? true : false;
                    }

                    Button
                    {
                        visible: (usersPage.offset + usersPage.limit >= usersPage.usersCount)? false : true;
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
                        background: Item{}
                        icon.source: "qrc:/assets/images/toLeft.png" //next
                        icon.width: 40
                        icon.height: 40
                        icon.color:"transparent"
                        opacity: 0.5
                        onClicked:
                        {
                            usersModel.clear();

                            usersPage.offset = usersPage.offset + usersPage.limit;
                            usersPage.pageNumber = usersPage.pageNumber + 1;
                            if(usersPage.offset >= usersPage.usersCount ){ usersPage.offset = usersPage.offset - usersPage.limit; usersPage.pageNumber = usersPage.pageNumber - 1;}

                            var cond = {}
                            var jsondata = dbMan.getUsers(cond, usersPage.limit, usersPage.offset);

                            for(var obj of jsondata){
                                usersModel.append(obj);
                            }
                        }
                        hoverEnabled: true
                        onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                    }
                    Item{Layout.fillWidth: true; Layout.preferredHeight: 10;}
                }

                Item{width: parent.width; height: 10;}

                GridView {
                    id: usersGV
                    width: parent.width
                    height: usersGV.contentHeight
                    cellWidth: 300
                    cellHeight: 340
                    clip: true
                    model: ListModel{id: usersModel}
                    delegate: userDelegate
                    layoutDirection: Qt.LeftToRight
                    Component.onCompleted: JS.loadUsers();
                }
            }
        }
    }

    // delegate
    Component
    {
        id: userDelegate
        Rectangle {
            id: rec
            required property var model;

            width: 256
            height: 300
            color:(rec.model.enabled)? "white" : "lightpink"
            opacity: 0.8
            radius: 10
            border.width: 2
            border.color: "lavenderblush"

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                // onClicked:{
                //     usersPage.appStackView.push(userComponent, {
                //                                     id: rec.model.id,
                //                                     name: rec.model.name,
                //                                     lastname: rec.model.lastname,
                //                                     gender: rec.model.gender,
                //                                     nat_id  : rec.model.nat_id,
                //                                     job_position: rec.model.job_position,
                //                                     telephone: rec.model.telephone,
                //                                     permissions: rec.model.permissions,
                //                                     enabled: rec.model.enabled,
                //                                     admin: rec.model.admin,
                //                                     superadmin: rec.model.superadmin
                //                                 }
                //                                 );
                // }
                onHoveredChanged:{
                    if(containsMouse){
                        parent.opacity=1;
                        rec.border.color = "pink"
                    }
                    else
                    {
                        rec.border.color = "lavenderblush"
                        parent.opacity=0.8
                    }
                }

            }

            Item
            {
                anchors.fill: parent
                anchors.margins: 5
                ColumnLayout
                {
                    anchors.fill: parent

                    Image {
                        source: "qrc:/assets/images/user.png";
                        Layout.preferredWidth: 64
                        Layout.preferredHeight: 64
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: rec.model.name + " " + rec.model.lastname
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkcyan"
                        Layout.preferredWidth: parent.width
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text {
                        text: "سمت شغلی" + " : " + rec.model.job_position
                        font.family: "Kalameh"
                        font.pixelSize: 14
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.fillWidth: true
                    }

                    Item{Layout.preferredWidth:  1; Layout.preferredHeight: 10;}

                    Text {
                        text: (rec.model.enabled)? "کاربر فعال" : "کاربر غیرفعال"
                        font.family: "Kalameh"
                        font.pixelSize: 10
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.fillWidth: true
                        color: "darkslategray"
                    }
                    Text {
                        text:  "کاربر ادمین"
                        visible: (rec.model.admin)? true : false
                        font.family: "Kalameh"
                        font.pixelSize: 10
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.fillWidth: true
                        color: "darkslategray"
                    }
                    Text {
                        text:  "کاربر سوپرادمین"
                        visible: (rec.model.superadmin)? true : false
                        font.family: "Kalameh"
                        font.pixelSize: 10
                        font.bold: true
                        Layout.alignment: Qt.AlignLeft
                        Layout.fillWidth: true
                        color: "darkslategray"
                    }

                    Item{Layout.preferredWidth:  1; Layout.fillHeight: true;}

                    Row{
                        Layout.alignment: Qt.AlignRight
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 80
                        Button
                        {
                            width: 40
                            height: 32
                            background: Item{}
                            icon.source: "qrc:/assets/images/trash.png"
                            icon.width: 32
                            icon.height: 32
                            icon.color:"transparent"
                            opacity: 0.5
                            // onClicked: {
                            //     usersPage.appStackView.push(deleteComponent, {
                            //                                     id: rec.model.id,
                            //                                     name: rec.model.name,
                            //                                     lastname: rec.model.lastname,
                            //                                     gender: rec.model.gender,
                            //                                     nat_id  : rec.model.nat_id,
                            //                                     job_position: rec.model.job_position,
                            //                                     telephone: rec.model.telephone,
                            //                                     permissions: rec.model.permissions,
                            //                                     enabled: rec.model.enabled,
                            //                                     admin: rec.model.admin,
                            //                                     superadmin: rec.model.superadmin
                            //                                 }
                            //                                 );
                            // }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                        Button
                        {
                            width: 40
                            height: 32
                            background: Item{}
                            icon.source: "qrc:/assets/images/edit.png"
                            icon.width: 32
                            icon.height: 32
                            icon.color:"transparent"
                            opacity: 0.5
                            // onClicked: {

                            //     usersPage.appStackView.push(updateComponent, {
                            //                                     id: rec.model.id,
                            //                                     name: rec.model.name,
                            //                                     lastname: rec.model.lastname,
                            //                                     gender: rec.model.gender,
                            //                                     nat_id  : rec.model.nat_id,
                            //                                     job_position: rec.model.job_position,
                            //                                     telephone: rec.model.telephone,
                            //                                     permissions: rec.model.permissions,
                            //                                     enabled: rec.model.enabled,
                            //                                     admin: rec.model.admin,
                            //                                     superadmin: rec.model.superadmin
                            //                                 }
                            //                                 );
                            // }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }
                }

            }


        }
    }

    // //user
    // Component
    // {
    //     id: userComponent
    //     // InsertUser
    //     // {
    //     //     step_id : stepCB.currentValue
    //     //     step: stepCB.currentText
    //     //     branch: branchCB.currentText
    //     //     onPopStackSignal: usersPage.appStackView.pop();
    //     //     onInsertedSignal: JS.loadUsers();
    //     // }
    // }

    // //Insert
    // Component
    // {
    //     id: insertComponent
    //     // InsertUser
    //     // {
    //     //     step_id : stepCB.currentValue
    //     //     step: stepCB.currentText
    //     //     branch: branchCB.currentText
    //     //     onPopStackSignal: usersPage.appStackView.pop();
    //     //     onInsertedSignal: JS.loadUsers();
    //     // }
    // }

    // //update
    // Component
    // {
    //     id: updateComponent
    //     // UpdateUser
    //     // {
    //     //     step: stepCB.currentText
    //     //     branch: branchCB.currentText
    //     //     onPopStackSignal: usersPage.appStackView.pop();
    //     //     onUpdatedSignal:
    //     //     {
    //     //         JS.loadStudents();
    //     //         // usersModel.clear();
    //     //         // var cond = {}
    //     //         // usersPage.offset = 0;
    //     //         // usersPage.pageNumber = 1

    //     //         // usersPage.usersCount = dbMan.getusersCount(stepCB.currentValue, cond);
    //     //         // userCountLbl.text = usersPage.usersCount + " نفر "
    //     //         // var jsondata = dbMan.getStudents(stepCB.currentValue, cond, usersPage.limit, usersPage.offset);

    //     //         // for(var obj of jsondata){
    //     //         //     usersModel.append(obj);
    //     //         // }
    //     //     }
    //     // }
    // }

    // // delete
    // Component
    // {
    //     id: deleteComponent
    //     // DeleteUser
    //     // {
    //     //     step: stepCB.currentText
    //     //     branch: branchCB.currentText
    //     //     onPopStackSignal: usersPage.appStackView.pop();
    //     //     onDeletedSignal:
    //     //     {
    //     //         JS.loadStudents();
    //     //         // usersModel.clear();
    //     //         // var cond = {}
    //     //         // usersPage.offset = 0;
    //     //         // usersPage.pageNumber = 1

    //     //         // usersPage.usersCount = dbMan.getusersCount(stepCB.currentValue, cond);
    //     //         // userCountLbl.text = usersPage.usersCount + " نفر "
    //     //         // var jsondata = dbMan.getStudents(stepCB.currentValue, cond, usersPage.limit, usersPage.offset);

    //     //         // for(var obj of jsondata){
    //     //         //     usersModel.append(obj);
    //     //         // }
    //     //     }
    //     // }
    // }

    //drawer
    Drawer
    {
        id: searchDrawer
        modal: true
        height: parent.height
        width: 300
        dragMargin: 0
        //interactive: false


        ScrollView
        {
            id: drawerSV
            anchors.fill: parent

            ColumnLayout
            {
                width: drawerSV.width

                Rectangle
                {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 110
                    color: "darkcyan"

                    Image {
                        id: searchImage
                        source: "qrc:/assets/images/search.png"
                        width: 64
                        height: 64
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        width: parent.width
                        height: 40
                        anchors.top: searchImage.bottom
                        horizontalAlignment: Qt.AlignHCenter
                        anchors.topMargin: 10
                        text: "جستجوی کاربران "
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignHCenter
                        font.bold: true
                        color:"white"
                    }
                }



                Text {
                    text: "نام"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: nameTF
                    placeholderText: "نام کاربر"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }

                //lastname
                Text {
                    text: "نام‌‌خانوادگی"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: lastnameTF
                    placeholderText: "نام ‌خانوادگی کاربر"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }
                // gender
                Text {
                    text: "جنسیت"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                ComboBox
                {
                    id: genderCB
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                    editable: false
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    model: ListModel{id: genderModel}
                    textRole: "text"
                    valueRole: "value"
                    Component.onCompleted:
                    {
                        genderModel.clear();
                        genderModel.append({text: "", value:""});
                        genderModel.append({text: "آقا", value:"آقا"});
                        genderModel.append({text: "خانم", value:"خانم"});
                    }
                }

                //nat_id
                Text {
                    text: "کد ملی"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: natIdTF
                    placeholderText: "کد ملی کاربر"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }


                //job position
                Text {
                    text: "سمت شغلی"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: jobPositionTF
                    placeholderText: "سمت شغلی کاربر"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }

                //telephone
                Text {
                    text: "شماره تماس"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                TextField
                {
                    id: telephoneTF
                    placeholderText: "شماره تماس کاربر"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                }

                // enabled
                Text {
                    text: "وضعیت کاربر"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                ComboBox
                {
                    id: enabledCB
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                    editable: false
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    model: ListModel{id: enabledModel}
                    textRole: "text"
                    valueRole: "value"
                    Component.onCompleted:
                    {
                        enabledModel.clear();
                        enabledModel.append({text: "", value:-1});
                        enabledModel.append({text: "فعال", value: 1});
                        enabledModel.append({text: "غیرفعال", value: 0});
                    }
                }


                // admin
                Text {
                    text: "کاربر ادمین"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                ComboBox
                {
                    id: adminCB
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                    editable: false
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    model: ListModel{id: adminModel}
                    textRole: "text"
                    valueRole: "value"
                    Component.onCompleted:
                    {
                        adminModel.clear();
                        adminModel.append({text: "", value:-1});
                        adminModel.append({text: "ادمین", value:1});
                        adminModel.append({text: "غیر ادمین", value:0});

                    }
                }


                // superadmin
                Text {
                    text: "کاربر سوپرادمین"
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    color: "darkcyan"
                    Layout.fillWidth: true
                    horizontalAlignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                }
                ComboBox
                {
                    id: superadminCB
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.margins: 10
                    Layout.topMargin: -5
                    editable: false
                    font.family: "Kalameh"
                    font.pixelSize: 16
                    model: ListModel{id: superadminModel}
                    textRole: "text"
                    valueRole: "value"
                    Component.onCompleted:
                    {
                        superadminModel.clear();
                        superadminModel.append({text: "", value:-1});
                        superadminModel.append({text: "سوپرادمین", value:1});
                        superadminModel.append({text: "غیر سوپرادمین", value:0});

                    }
                }



                // button

                Button
                {
                    id: searchBtn
                    text: "جستجو"
                    font.family: "Kalameh"
                    font.pixelSize: 14
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 100
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    icon.source: "qrc:/assets/images/search.png"
                    icon.width: 32
                    icon.height: 32
                    icon.color:"transparent"

                    onClicked: JS.loadUsers();

                    Rectangle{width: parent.width; height: 4; color:"darkcyan"; anchors.bottom: parent.bottom}
                }
            }
        }
    }
}
