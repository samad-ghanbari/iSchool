import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//import "Student.js" as Methods
import "./../public" as DialogBox

Page {
    id: registerPage

    required property string branch
    required property string step
    required property int step_id
    required property int student_id
    required property bool field_based
    required property string name
    required property string lastname
    required property string fathername
    required property string photo

    signal popStackSignal();
    signal registeredSignal();

    background: Rectangle{anchors.fill: parent; color: "honeydew"}


    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "ثبت‌نام جدید دانش‌آموز"
            font.family: "Kalameh"
            font.pixelSize: 24
            font.bold: true
            color: "darkcyan"
        }

        Flickable{
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentHeight: centerBox.implicitHeight

            Rectangle{
                width: (parent.width > 700)? 700 : parent.width
                height : centerBox.implicitHeight + 100
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"

                Column{
                    id: centerBox
                    width: parent.width

                    Image {
                        source: registerPage.photo
                        anchors.horizontalCenter: parent.horizontalCenter
                        height:  128
                        width:  128
                        NumberAnimation on scale { from: 0; to: 1; duration: 2000;}
                    }

                    //branch-step
                    Text {
                        text: "شعبه " + registerPage.branch + " - " + registerPage.step
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 18
                        font.bold: true
                        color: "darkcyan"
                    }

                    Item{width: parent.width; height: 10;}

                    //student
                    Text {
                        text: registerPage.name + " " + registerPage.lastname + " ( " + registerPage.fathername + " ) "
                        width: parent.width
                        height: 50
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Kalameh"
                        font.pixelSize: 20
                        font.bold: true
                        color: "mediumvioletred"
                    }

                    Item{width: parent.width; height: 10;}

                    //field
                    RowLayout{
                        width: parent.width
                        height: 50
                        visible: (registerPage.field_based)? true : false
                        Text {
                            text: "رشته تحصیلی "
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        ComboBox
                        {
                            id: fieldCB
                            Layout.preferredHeight:  50
                            Layout.fillWidth: true
                            Layout.maximumWidth: 400
                            editable: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            model: ListModel{id: fieldModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                fieldModel.clear();
                                var jsondata = dbMan.getFields(registerPage.step_id);

                                for(var obj of jsondata)
                                {
                                    fieldModel.append({value: obj.id,  text: obj.field_name })
                                }

                                fieldCB.currentIndex = -1;
                            }

                            onActivated: {
                                if(registerPage.field_based){
                                    baseModel.clear();
                                    var jsondata = dbMan.getFieldBases(fieldCB.currentValue, false);

                                    for(var obj of jsondata)
                                    {
                                        baseModel.append({value: obj.id,  text: obj.base_name })
                                    }

                                    baseCB.currentIndex = -1
                                }
                            }
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    //base
                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "پایه تحصیلی "
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        ComboBox
                        {
                            id: baseCB
                            Layout.preferredHeight:  50
                            Layout.fillWidth: true
                            Layout.maximumWidth: 400
                            editable: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            model: ListModel{id: baseModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                if(! registerPage.field_based){
                                    baseModel.clear();
                                    var jsondata = dbMan.getStepBases(registerPage.step_id, false);

                                    for(var obj of jsondata)
                                    {
                                        baseModel.append({value: obj.id,  text: obj.base_name })
                                    }

                                    periodCB.currentIndex = -1
                                }
                            }

                            onActivated: periodCB.currentIndex = -1;
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    //period
                    RowLayout{
                        width: parent.width
                        height: 50
                        Text {
                            text: "سال تحصیلی "
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        ComboBox
                        {
                            id: periodCB
                            Layout.preferredHeight:  50
                            Layout.fillWidth: true
                            Layout.maximumWidth: 400
                            Layout.alignment: Qt.AlignLeft
                            editable: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true

                            model: ListModel{id: periodModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                periodModel.clear();
                                var jsondata = dbMan.getStepPeriods(registerPage.step_id, false);
                                for(var obj of jsondata)
                                {
                                    if(!obj.passed)
                                        periodModel.append({value: obj.period_id,  text: obj.period_name })
                                }
                                periodCB.currentIndex = -1;
                            }

                            onActivated : {
                                classModel.clear();
                                var jsondata = dbMan.getBaseClasses(baseCB.currentValue, periodCB.currentValue);
                                for(var obj of jsondata)
                                {
                                    if(!obj.passed)
                                        classModel.append({value: obj.class_id,  text: obj.class_name })
                                }
                                classCB.currentIndex = -1;
                            }
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    //class
                    RowLayout{
                        width: parent.width
                        height: 50

                        Text {
                            text: "کلاس"
                            Layout.minimumWidth: 150
                            Layout.maximumWidth: 150
                            Layout.preferredHeight: 50
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkcyan"
                        }
                        ComboBox
                        {
                            id: classCB
                            Layout.preferredHeight:  50
                            Layout.fillWidth: true
                            Layout.maximumWidth: 400
                            Layout.alignment: Qt.AlignLeft
                            editable: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ListModel{id: classModel;}
                            textRole: "text"
                            valueRole: "value"
                        }
                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}
                    }

                    Item{height: 20; width:parent.width;}

                    Button
                    {
                        height: 60
                        width: 400
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        font.bold: true
                        text: "ثبت نام"
                        enabled: (classCB.currentValue > -1 )? true : false
                        onClicked: confirmDialogId.open();
                        Rectangle{width: parent.width;  height: 4; color:"skyblue"; anchors.bottom: parent.bottom;}
                    }

                    Item{height: 20; width:parent.width;}


                }
            }
        }
    }

    //confirm register
    DialogBox.BaseDialog
    {
        id: confirmDialogId
        dialogTitle: "تایید ثبت نام"
        dialogText: "آیا از ثبت نام جدید دانش‌آموز مطمئن می‌باشید؟"
        dialogSuccess: true
        rejectVisible: true
        onDialogAccepted: {

            if(dbMan.registerStudent(registerPage.student_id, classCB.currentValue))
            {
                successDialogId.dialogText = "ثبت‌نام با موفقیت انجام شد."
                successDialogId.open();
            }
            else
            {
                var errorString = dbMan.getLastError();
                infoDialogId.dialogText = errorString
                infoDialogId.width = parent.width
                infoDialogId.height = 500
                infoDialogId.open();
            }

        }
    }

    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "ثبت‌نام دانش‌آموز با خطا مواجه شد."
        dialogSuccess: false
    }

    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: "ثبت‌نام با موفقیت انجام شد."
        dialogSuccess: true
        onDialogAccepted: {
            registerPage.popStackSignal();
            registerPage.registeredSignal();
        }

    }
}
