import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import "./../public" as DialogBox

Page {
    id: rankPage

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;

    signal popSignal();
    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    ColumnLayout
    {
        anchors.fill: parent

        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            color:"transparent"
            Text {
                width: parent.width
                height: parent.height
                Layout.preferredHeight: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: "شعبه " + rankPage.branch + " - " + rankPage.step
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }

        }

        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            color:"transparent"
            Text {
                width: parent.width
                height: parent.height
                Layout.preferredHeight: 64
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
                text: (rankPage.field_based) ? "رشته " + rankPage.field + " - " + " سال‌تحصیلی " + rankPage.period :  " سال‌تحصیلی " + rankPage.period
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }

        }

        Rectangle{
            Layout.preferredHeight: 1
            Layout.fillWidth: true
            //Layout.maximumWidth: 700
            Layout.alignment: Qt.AlignHCenter
            color: "darkgray"
        }

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 25
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "رتبه‌بندی دانش‌آموزان پایه" + rankPage.base
            font.family: "Kalameh"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
        }

        Flickable{
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentHeight: centerBox.height
            clip: true

            Rectangle{
                width: (parent.width > 700)? 700 : parent.width
                height: centerBox.height + 100
                anchors.horizontalCenter: parent.horizontalCenter
                color: "snow"

                Column
                {
                    id: centerBox
                    width: parent.width

                    Label{
                        height: 50
                        width : parent.width
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        text:"تنظیمات رتبه‌بندی"
                        color: "slategray"
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"مرجع مقایسه رتبه و میانگین: "
                        }
                        ComboBox{
                            id: compareRef
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.bold: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ListModel{id: refModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                //compareRef.currentIndex = -1
                                refModel.clear();
                                var jsondata = dbMan.getEvals();
                                var finalValue = -1
                                //id, eval_name, base_id, period_id, test_flag, final_flag, max_grade
                                refModel.append({text: "ارزیابی نیمسال " , value: 0});
                                for(var obj of jsondata)
                                {
                                    if(obj.test_flag === false)
                                        refModel.append({text: "آزمون " + obj.eval_name, value: obj.id});
                                    if(obj.final_flag === true)
                                        finalValue = obj.id
                                }
                                compareRef.currentIndex = compareRef.indexOfValue(finalValue)
                            }
                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"نیمسال: "
                        }
                        TextField{
                            id: semesterNumberTF
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            placeholderText: "اول"
                            text: "اول"
                            font.bold: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"نیمسال: "
                        }
                        TextField{
                            id: dateTE
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            placeholderText: "1403/11/11"
                            text: ""
                            font.bold: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            validator: RegularExpressionValidator
                            {
                                regularExpression: /^\d{4}\/\d{2}\/\d{2}$/
                                // Regex pattern to match date in yyyy/MM/dd format
                            }
                        }
                    }

                    Switch{
                        id: testSW
                        width: parent.width
                        height: 50
                        text: "معدل تست"
                        checked: true
                        font.family: "Kalameh"
                        font.pixelSize: 16
                    }

                    Switch{
                        id: photoSW
                        width: parent.width
                        height: 50
                        text: "تصویر دانش‌آموز"
                        checked: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                    }

                    Switch{
                        id: fathernameSW
                        width: parent.width
                        height: 50
                        text: "نام پدر"
                        checked: false
                        font.family: "Kalameh"
                        font.pixelSize: 16
                    }

                    Item{width: parent.width; height: 10;}
                    Rectangle{width: parent.width; height: 2; color: "black";}
                    Item{width: parent.width; height: 10;}


                    // printer

                    Label{
                        width: parent.width
                        height: 50
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        font.family: "Kalameh"
                        font.pixelSize: 16
                        text:"تنظیمات چاپ"
                        color: "slategray"
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"انداره صفحه: "
                        }
                        ComboBox{
                            id: paperSizeCB
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.bold: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ListModel{id: paperModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                paperModel.append({text: "A4 (8.3 inch x 11.7 inch)", value: "A4"});
                                paperModel.append({text: "A3 (11.7 inch x 16.5 inch)", value: "A3"});
                                paperSizeCB.currentIndex = paperSizeCB.indexOfValue("A4")
                            }
                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"اندازه فونت نمرات جدول: "
                        }
                        ComboBox{
                            id: contentFontSizeCB
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.bold: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ListModel{id: contentFSModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                contentFSModel.append({text: "8", value: 8});
                                contentFSModel.append({text: "10", value: 10});
                                contentFSModel.append({text: "12", value: 12});
                                contentFSModel.append({text: "14", value: 14});
                                contentFSModel.append({text: "16", value: 16});
                                contentFSModel.append({text: "18", value: 18});
                                contentFSModel.append({text: "20", value: 20});

                                contentFontSizeCB.currentIndex = contentFontSizeCB.indexOfValue(14)
                            }
                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"اندازه فونت تیتر جدول: "
                        }
                        ComboBox{
                            id: titrFontSizeCB
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.bold: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ListModel{id: titrFontModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                titrFontModel.append({text: "8 Bold", value: 8});
                                titrFontModel.append({text: "10 Bold", value: 10});
                                titrFontModel.append({text: "12 Bold", value: 12});
                                titrFontModel.append({text: "14 Bold", value: 14});
                                titrFontModel.append({text: "16 Bold", value: 16});
                                titrFontModel.append({text: "18 Bold", value: 18});
                                titrFontModel.append({text: "20 Bold", value: 20});

                                titrFontSizeCB.currentIndex = titrFontSizeCB.indexOfValue(12)
                            }
                        }
                    }

                    RowLayout{
                        width: parent.width
                        height: 50
                        Label{
                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 300
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            text:"فونت"
                        }
                        ComboBox{
                            id: fontCB
                            Layout.fillWidth: true
                            Layout.preferredHeight: 50
                            font.bold: false
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            model: ListModel{id: fontModel}
                            textRole: "text"
                            valueRole: "value"
                            Component.onCompleted:
                            {
                                fontModel.append({text: "زر", value: "Zar"});
                                fontModel.append({text: "یکان", value: "B Yekan"});
                                fontModel.append({text: "تیتر", value: "Titr"});
                                fontModel.append({text: "کلمه", value: "Kalameh"});
                                fontModel.append({text: "نازنین", value: "B Nazanin"});
                                fontModel.append({text: "میترا", value: "Mitra"});

                                fontCB.currentIndex = fontCB.indexOfValue("Zar")
                            }
                        }
                    }

                    Item{
                        width: parent.width
                        height: 20
                    }

                    // buttons

                    RowLayout
                    {
                        width: parent.width
                        height: 50
                        spacing: 10

                        Item{Layout.fillWidth: true; Layout.preferredHeight: 1;}

                        Button{
                            text: "انصراف"
                            Layout.preferredHeight:  50
                            Layout.preferredWidth:  100
                            font.family: "Kalameh"
                            font.pixelSize: 14
                            onClicked: { rankPage.popSignal();}
                            Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "mediumvioletred"}
                        }
                        Button
                        {
                            id: okBtn
                            text: "تایید"
                            Layout.preferredHeight:  50
                            Layout.preferredWidth:  200
                            font.family: "Kalameh"
                            font.pixelSize: 14
                            onClicked:
                            {
                                saveFileDialog.open();
                            }

                            Rectangle{width:parent.width; height:2; anchors.bottom: parent.bottom; color: "darkcyan"}
                        }
                    }

                    Item{
                        width: parent.width
                        height: 20
                    }
                }
            }
        }
    }


    //dialog error
    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "عملیات با خطا مواجه شد."
        dialogSuccess: false
    }

    //dialog error
    DialogBox.BaseDialog
    {
        id: successDialogId
        dialogTitle: "عملیات موفق"
        dialogText: ""
        dialogSuccess: true
        onDialogAccepted: rankPage.popSignal();
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
            var compare_ref_id = compareRef.currentValue
            var compare_ref = compareRef.currentText

            var params = {
                "compare_ref_id": compare_ref_id,
                "compare_ref" : compare_ref,
                "semester": semesterNumberTF.text,
                "date": dateTE.text,
                "include_test" : testSW.checked,
                "include_photo" : photoSW.checked,
                "include_fathername" : fathernameSW.checked,
                "paperSize": paperSizeCB.currentValue,
                "fontFamily" : fontCB.currentValue,
                "contentFontSize": contentFontSizeCB.currentValue,
                "titrFontSize": titrFontSizeCB.currentValue
            }

            if(dbMan.generateRankPdf(selectedFile, params))
            {
                successDialogId.width = 500
                successDialogId.dialogText = "فایل در مسیر زیر ذخیره گردید." + "\n" + selectedFile
                successDialogId.open();
            }
            else
            {
                infoDialogId.open();
            }
        }
        onRejected: saveFileDialog.close();
    }

}
