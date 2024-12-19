pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
//import Qt.labs.platform

import "./../public" as DialogBox

Page {
    id: pdfReport
    signal popStackViewSignal();

    required property var student;
    // Register_id, Student_id , Student, Fathername, Gender, Birthday, Photo
    required property var registerModel;
    // 0r.id,  r.student_id, r.step_id, r.study_base_id, r.study_period_id, r.class_id,  s.branch_id
    // 6br.city, br.branch_name, st.step_name, sb.study_base, sp.study_period, sp.passed, cl.class_name

    property var evalCats: []

    property bool isFemale : (pdfReport.student.gender === "خانم")? true : false;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    GridLayout
    {
        columns: 2
        anchors.fill: parent

        Button
        {
            Layout.preferredHeight: 64
            Layout.preferredWidth: 64
            background: Item{}
            icon.source: "qrc:/assets/images/arrow-right.png"
            icon.width: 64
            icon.height: 64
            opacity: 0.5
            onClicked: pdfReport.popStackViewSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            textFormat: Text.RichText
            text: "گزارش ارزیابی دانش‌آموز "
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
            elide: Text.ElideLeft
        }


        ScrollView
        {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            Rectangle
            {
                width: parent.width
                implicitHeight : centerBox.implicitHeight + 50
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"

                ColumnLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20

                    //student info
                    Rectangle
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 250
                        RowLayout
                        {
                            anchors.fill: parent
                            spacing: 10
                            Item{
                                Layout.preferredWidth: 150
                                Layout.preferredHeight: 200
                                Layout.alignment: Qt.AlignLeft
                                Image
                                {
                                    width: 150
                                    height: 150
                                    anchors.centerIn: parent
                                    source:{
                                        if(pdfReport.student.Photo == "")
                                        {
                                            if(pdfReport.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                                        }
                                        else
                                        {
                                            return "file://"+pdfReport.student.Photo;
                                        }
                                    }
                                }
                            }


                            Column{
                                Layout.fillWidth: true
                                // student
                                Text {
                                    text: pdfReport.student.Student + " ( " + pdfReport.student.Fathername + " )"
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 20
                                    font.bold: true
                                    color: "darkmagenta"
                                    elide: Text.ElideLeft
                                }
                                // branch step
                                Text {
                                    text: "شعبه " + " : " + pdfReport.registerModel.city + " - " + pdfReport.registerModel.branch_name + " - " + pdfReport.registerModel.step_name + " - " + pdfReport.registerModel.study_base
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                    elide: Text.ElideLeft
                                }
                                // class
                                Text {
                                    text: "کلاس " + " : " + pdfReport.registerModel.class_name
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                                Text {
                                    text: "سال تحصیلی " + " : " + pdfReport.registerModel.study_period
                                    height: 50
                                    width: parent.width
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    font.family: "B Yekan"
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "royalblue"
                                }
                            }
                        }
                    }

                    Rectangle
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 4
                        color: "skyblue"
                        Layout.topMargin: 10
                        Layout.bottomMargin: 10
                    }

                    Label{
                        //background:Rectangle{color: "lavender"}
                        font.bold: true
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        color: "black"
                        text: "انتخاب دسته ارزیابی‌ها جهت صدور گزارش"
                        Layout.preferredHeight: 50
                        Layout.fillWidth: true
                        Layout.maximumWidth: 500;
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                    }
                    Rectangle{Layout.fillWidth: true; Layout.maximumWidth: 500; Layout.alignment: Qt.AlignHCenter; Layout.preferredHeight: 5; color: "slategray";}

                    ListView
                    {
                        id: evalCatsLV
                        Layout.fillWidth: true
                        Layout.maximumWidth: 500
                        Layout.preferredHeight: evalCatsLV.contentHeight
                        Layout.alignment: Qt.AlignHCenter
                        clip: true
                        model: ListModel{id: evalCatsModelId;}
                        delegate:Switch{
                            required property var model
                            checked: (pdfReport.evalCats.indexOf(model.id) > -1)? true : false;
                            height: 50;
                            width: evalCatsLV.width
                            text:  model.eval_cat;
                            font.family: "B Yekan"
                            font.pixelSize: 14
                            onToggled:
                            {
                                var index = pdfReport.evalCats.indexOf(model.id);

                                if(checked)
                                {
                                    //push
                                    if(index < 0)
                                    pdfReport.evalCats.push(model.id);
                                }
                                else
                                {
                                    if( index > -1 && (pdfReport.evalCats.length > 1) )
                                    pdfReport.evalCats.splice(index, 1);
                                    else
                                    this.checked = true
                                }
                            }
                        }

                        Component.onCompleted:{
                            var step_id = pdfReport.registerModel.step_id;
                            var base_id = pdfReport.registerModel.study_base_id;
                            var period_id = pdfReport.registerModel.study_period_id;
                            var evalCatsList  = dbMan.getEvalCatsBrief(step_id, base_id, period_id);

                            for(var obj of evalCatsList)
                            {
                                pdfReport.evalCats.push(obj.id)
                                evalCatsModelId.append(obj);
                            }

                            evalCatsLV.height = evalCatsLV.contentHeight
                        }
                    }

                    Rectangle{Layout.fillWidth: true; Layout.maximumWidth: 500; Layout.alignment: Qt.AlignHCenter; Layout.preferredHeight: 5; color: "slategray";}

                    RowLayout{
                        Layout.fillWidth: true
                        Layout.maximumWidth: 500
                        Layout.preferredHeight: 50
                        Layout.alignment: Qt.AlignHCenter

                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 100
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.bold: true
                            font.family: "B Yekan"
                            font.pixelSize: 16
                            text:"نیمسال: "
                        }
                        TextField{
                            id: semesterNumberTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            placeholderText: "اول"
                            text: "اول"
                            font.bold: true
                            font.family: "B Yekan"
                            font.pixelSize: 16
                        }
                    }

                    Item{
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                    }

                    RowLayout
                    {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 500;
                        Layout.alignment: Qt.AlignHCenter

                        spacing: 10

                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}

                        Button{
                            text: "انصراف"
                            Layout.preferredHeight:  40
                            Layout.preferredWidth:  100
                            font.family: "B Yekan"
                            font.pixelSize: 14
                            onClicked: { pdfReport.popStackViewSignal();}
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
                            enabled: (semesterNumberTF.text == "")? false : true
                            onClicked:
                            {
                                saveFileDialog.open();

                            }
                            Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "forestgreen"}
                        }
                    }

                }
            }
        }
    }


    //dialog
    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "عملیات با خطا مواجه شد."
        dialogSuccess: false
        onDialogAccepted:{
            if(infoDialogId.dialogSuccess)
                pdfReport.popStackViewSignal();

            infoDialogId.close();
        }
    }

    // file dialog
    FileDialog {
        id: saveFileDialog
        title: "محل ذخیره گزارش"
        currentFolder: "file:///home/samad"
        //currentFolder: "C:/Users/YourUsername/Documents"
        nameFilters: ["PDF Files (*.pdf)", "All Files (*)"]
        fileMode: FileDialog.SaveFile
        onAccepted:{

            var semesterNumber = semesterNumberTF.text
            if(dbMan.exportStudentStatPdf(selectedFile, pdfReport.registerModel.id, pdfReport.evalCats, semesterNumber))
            {
                infoDialogId.dialogTitle = "عملیات موفق"
                infoDialogId.dialogSuccess = true
                infoDialogId.width = 500
                infoDialogId.dialogText = "فایل در مسیر زیر ذخیره گردید." + "\n" + selectedFile
                infoDialogId.open();
            }
            else
            {
                infoDialogId.open();
            }
        }
        onRejected: saveFileDialog.close();
    }
}

