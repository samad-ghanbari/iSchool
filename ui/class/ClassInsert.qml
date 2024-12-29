import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as DialogBox

Page {
    id: insertPage

    property int step_id;
    property int base_id;
    property int period_id;
    property string branch_text
    property string step_text
    property string base_text
    property string period_text

    signal classInsertedSignal();
    signal popStackSignal();

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    GridLayout
    {
        anchors.fill: parent
        columns:2

        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/arrow-right.png"
            icon.width: 64
            icon.height: 64
            icon.color:"transparent"
            opacity: 0.5
            onClicked: insertPage.popStackSignal(); //insertPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "افزودن کلاس جدید"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Rectangle
        {
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "honeydew"

            ScrollView
            {
                height: parent.height
                width: parent.width
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                Rectangle
                {
                    id: centerBoxId
                    color:"snow"
                    width:  (parent.width < 700)? parent.width : 700
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: 10
                    implicitHeight: parent.height

                    radius: 10
                    Item {
                        anchors.fill: parent
                        anchors.margins: 10

                        ColumnLayout
                        {
                            id: periodInsertCL
                            width: parent.width
                            Image {
                                source: "qrc:/assets/images/add.png"
                                Layout.alignment: Qt.AlignHCenter
                                Layout.preferredHeight:  64
                                Layout.preferredWidth:  64
                                Layout.margins: 20
                                NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                            }

                            GridLayout
                            {
                                id: classInsertGL
                                columns: 2
                                rows: 5
                                rowSpacing: 20
                                columnSpacing: 10
                                Layout.preferredWidth:  parent.width

                                Text {
                                    Layout.columnSpan: 2
                                    text: "شعبه " + insertPage.branch_text
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text {
                                    Layout.columnSpan: 2
                                    text: insertPage.step_text + " - " + insertPage.base_text
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text {
                                    Layout.columnSpan: 2
                                    text: insertPage.period_text
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "royalblue"
                                }


                                Text {
                                    text: "نام کلاس"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                TextField
                                {
                                    id: classNameTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "نام کلاس"

                                }

                                Text {
                                    text: "توضیحات کلاس"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                TextField
                                {
                                    id: classDescTF
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    placeholderText: "موقعیت کلاس"
                                }

                                Text {
                                    text: "اولویت نمایش"
                                    Layout.minimumWidth: 150
                                    Layout.maximumWidth: 150
                                    Layout.preferredHeight: 50
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                SpinBox
                                {
                                    id: classSortSB
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 100
                                    Layout.preferredHeight: 50
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    value: dbMan.getClassMaxSortPriority(insertPage.step_id, insertPage.base_id,insertPage.period_id,) + 1;
                                }
                            }

                            Item
                            {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 50
                            }

                            Button
                            {
                                text: "تایید"
                                Layout.preferredWidth: 200
                                Layout.preferredHeight: 50
                                Layout.alignment: Qt.AlignHCenter
                                font.family: "B Yekan"
                                font.pixelSize: 16
                                Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                                onClicked:
                                {
                                    var classObj = {};
                                    classObj["step_id"] = insertPage.step_id;
                                    classObj["study_base_id"] = insertPage.base_id;
                                    classObj["study_period_id"] = insertPage.period_id;
                                    classObj["class_name"] = classNameTF.text;
                                    classObj["class_desc"] = classDescTF.text;
                                    classObj["sort_priority"] = classSortSB.value;


                                    if(dbMan.classInsert(classObj))
                                    {
                                        // class_detail : class_id, course_id, teacher_id
                                        var class_id = dbMan.getLastInsertedId();
                                        var classes = dbMan.getClassesBrief(insertPage.step_id, insertPage.base_id, insertPage.period_id );
                                        //c.id, c.class_name, c.class_desc

                                        insertPage.classInsertedSignal();

                                        if(classes.length > 1)
                                        {
                                            doneDialog.period = insertPage.period_text;
                                            doneDialog.base = insertPage.base_text;
                                            doneDialog.class_name = classNameTF.text;
                                            doneDialog.class_id = class_id;
                                            doneDialog.classesModel.append({id: -1, class_name:"بدون الگو"});
                                            for(var c of classes)
                                            {
                                                if(c.id !== class_id)
                                                {
                                                    doneDialog.classesModel.append(c);
                                                    console.log(c.id, class_id)
                                                }
                                            }

                                            doneDialog.open();
                                        }
                                        else
                                        {
                                            successDialogId.open();
                                        }
                                    }
                                    else
                                    {
                                        var errorString = dbMan.getLastError();
                                        classInfoDialogId.dialogText = errorString
                                        classInfoDialogId.width = parent.width
                                        classInfoDialogId.height = 500
                                        classInfoDialogId.dialogSuccess = false

                                        classInfoDialogId.open();
                                    }
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

    }

    DialogBox.BaseDialog
    {
        id: classInfoDialogId
        dialogTitle: "خطا"
        dialogText: "افزودن کلاس جدید با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "کلاس جدید با موفقیت افزوده شد."
        dialogSuccess: true
        onDialogAccepted: {
            successDialogId.close();
            insertPage.popStackSignal();
        }

    }

    // update class detail
    // use exists class as template
    Dialog
    {
        id: doneDialog
        property string period;
        property string base;
        property string class_name;
        property int class_id;
        property alias classesModel : classCBModel;

        closePolicy:Popup.NoAutoClose
        modal: true
        dim: true
        anchors.centerIn: parent;
        width: (parent.width > 500)? 500 : parent.width
        height: 400
        header: Rectangle{
            width: parent.width;
            height: 50;
            color: "mediumvioletred"
            Text{ text: "تعیین کلاس الگو"; anchors.centerIn: parent; color: "white";font.bold:true; font.family: "B Yekan"; font.pixelSize: 16}
        }

        ListModel{id: classCBModel;} // supports index=-1 and not selectable

        contentItem:
            ScrollView{
            id: dialogSV
            width: parent.width
            height: parent.height

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ColumnLayout
            {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: "سال‌تحصیلی " + doneDialog.period
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                    Layout.preferredWidth: dialogSV.width
                    Layout.preferredHeight: 50
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    text: "پایه تحصیلی: " + doneDialog.base
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                    Layout.preferredWidth: dialogSV.width
                    Layout.preferredHeight: 50
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    text: doneDialog.class_name
                    font.family: "B Yekan"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                    Layout.preferredWidth: dialogSV.width
                    Layout.preferredHeight: 50
                    horizontalAlignment: Text.AlignHCenter
                }
                RowLayout{
                    Layout.preferredHeight: 50
                    Layout.fillWidth: true
                    spacing: 10
                    Text {
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "darkmagenta"
                        Layout.preferredWidth: 150
                        Layout.preferredHeight: 50
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        text: "کلاس الگو "
                    }
                    ComboBox
                    {
                        id: templateClass
                        Layout.preferredHeight:  50
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft
                        editable: false
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        model: classCBModel
                        textRole: "class_name"
                        valueRole: "id"
                        Component.onCompleted: currentIndex = -1;
                        onActivated: okBtn.enabled = (templateClass.currentIndex > -1)? true : false;

                    }
                }

                Item{Layout.preferredWidth: dialogSV.width; Layout.fillHeight: true;}
            }
        }
        footer:
            Item{
            width: parent.width;
            height: 50
            RowLayout
            {
                width: parent.width
                height: 50
                spacing: 10

                Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}

                Button{
                    text: "انصراف"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    onClicked: { doneDialog.close(); }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "red"}
                }
                Button
                {
                    id: okBtn
                    text: "تایید"
                    Layout.preferredHeight:  40
                    Layout.preferredWidth:  100
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    enabled: false;

                    onClicked:
                    {
                        var templateClass_id = templateClass.currentValue;
                        if(templateClass_id == -1)
                        {
                            successDialogId.dialogText = "کلاس جدید با موفقیت افزوده شد."
                            successDialogId.open();
                        }
                        else
                        {
                            if(dbMan.classDetailsInsert(doneDialog.class_id, templateClass_id))
                            {
                                successDialogId.dialogText = "کلاس جدید با موفقیت افزوده شد. \n دروس کلاس بروزرسانی شد."
                                successDialogId.open();
                            }
                            else
                            {
                                successDialogId.dialogText = "کلاس جدید با موفقیت افزوده شد."
                                successDialogId.open();
                            }
                        }

                        doneDialog.close();
                    }
                    Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                }
            }
        }

    }


}
