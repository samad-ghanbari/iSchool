import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./../public" as BaseDialog

Page {
    id: commentsPageId

    required property string branch;
    required property string step;
    required property string field;
    required property string base;
    required property bool field_based;
    required property string period;
    required property string class_name;
    required property int class_id;
    required property int student_id;
    required property string student;
    required property string student_photo;

    required property StackView appStackView;

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"}

    function updateCommentsModel()
    {
        commentsModel.clear();

        var jsondata = dbMan.getComments(commentsPageId.student_id, commentsPageId.class_id);
        commentsModel.clear();

        if(jsondata.length === 0)
            noComment.visible = true;
        else
            noComment.visible = false;

        for(var obj of jsondata)
        {
            commentsModel.append(obj);
        }
    }

    ColumnLayout
    {
        anchors.fill: parent


        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: commentsPageId.branch + " - " + commentsPageId.step
            font.family: "Kalameh"
            font.pixelSize: 18
            font.bold: true
            color: "darkmagenta"
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight:  100

            Image {
                source:commentsPageId.student_photo
                Layout.preferredWidth: 100
                Layout.preferredHeight: 100
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }
            Column{
                Layout.fillWidth: true
                Layout.preferredHeight: 100

                Text {
                    width: parent.width
                    height: 50
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignLeft
                    text: commentsPageId.student
                    font.family: "Kalameh"
                    font.pixelSize: 20
                    font.bold: true
                    color: "darkmagenta"
                }

                Text {
                    width: parent.width
                    height: 50
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment: Qt.AlignLeft
                    text: (commentsPageId.field_based) ? commentsPageId.field + " - " + commentsPageId.base :   commentsPageId.base
                    font.family: "Kalameh"
                    font.pixelSize: 18
                    font.bold: true
                    color: "darkmagenta"
                }
            }
        }
        Row{
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignHCenter

            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: commentsPageId.class_name + " - " + "سال‌تحصیلی "
                font.family: "Kalameh"
                font.pixelSize: 18
                font.bold: true
                color: "darkmagenta"
            }
            Text {
                height: 30
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: commentsPageId.period
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

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight:  50
            Layout.alignment: Qt.AlignRight

            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignLeft
                text: "نظرات مشاور"
                font.family: "Kalameh"
                font.pixelSize: 20
                font.bold: true
                color: "mediumvioletred"
            }

            Item{Layout.fillWidth: true; Layout.preferredHeight: 50;}

            Button
            {
                visible: !dbMan.idPeriodPassed()
                height: 50
                background: Item{}
                icon.source: "qrc:/assets/images/add.png"
                icon.width: 32
                icon.height: 32
                text: "افزودن نظر"
                font.family: "Kalameh"
                font.pixelSize: 14
                font.bold: false
                display: AbstractButton.TextUnderIcon
                icon.color:"transparent"
                opacity: 0.5
                onClicked: {
                    commentsPageId.appStackView.push(insertComponent, {});
                }
                hoverEnabled: true
                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
            }
        }


        Rectangle{
            id: mainBox
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 20
            color: "transparent"

            ListView{
                id: commentsLV
                model: ListModel{id: commentsModel;}
                anchors.fill: parent
                anchors.topMargin: 20
                clip: true
                spacing: 20
                flickableDirection: Flickable.AutoFlickDirection
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                delegate: Column{
                    id: recdel;
                    width: commentsLV.width - 100
                    anchors.margins: 20
                    padding: 20
                    required property var model;

                    Row{
                        width: parent.width
                        height: 30
                        Label{
                            height: parent.height
                            font.family: "Kalameh"
                            font.pixelSize: 16
                            font.bold: true
                            color: "darkslategray"
                            text: recdel.model.advisor
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                            visible: (recdel.model.advisor === "")? false : true;
                        }
                        Item{width: 20; height: parent.height; visible: (recdel.model.advisor === "")? false : true;}
                        Label{
                            height: parent.height
                            font.family: "Kalameh"
                            font.pixelSize: 14
                            font.bold: true
                            color: "skyblue"
                            text: (recdel.model.semester === 1)? "نیمسال اول" : "نیمسال دوم";
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }
                        Item{width: 10; height: parent.height; }
                        Label{
                            height: parent.height
                            font.family: "Kalameh"
                            font.pixelSize: 14
                            font.bold: true
                            color: "skyblue"
                            text: recdel.model.date
                            horizontalAlignment: Label.AlignLeft
                            verticalAlignment: Label.AlignVCenter
                        }

                    }

                    TextArea{
                        width: parent.width
                        height: 150
                        text: recdel.model.comment
                        readOnly: true
                        font.pixelSize: 16
                        font.family: "Kalameh"
                        wrapMode: TextArea.Wrap
                        background: Rectangle {
                            color: "#f3f3f3"
                            border.color: "#2196F3"
                            border.width: 1
                            radius: 8
                        }


                        Row{
                            anchors.bottom: parent.bottom
                            Button
                            {
                                visible: !dbMan.idPeriodPassed()
                                height: 25
                                background: Item{}
                                icon.source: "qrc:/assets/images/edit.png"
                                icon.width: 24
                                icon.height: 24
                                icon.color:"transparent"
                                opacity: 0.5
                                onClicked: {
                                    commentsPageId.appStackView.push(updateComponent, {

                                                                         id: recdel.model.id,
                                                                         jDate: recdel.model.date,
                                                                         semester: recdel.model.semester,
                                                                         advisor: recdel.model.advisor,
                                                                         comment: recdel.model.comment

                                                                     });
                                }
                                hoverEnabled: true
                                onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                            }
                            Button
                            {
                                visible: !dbMan.idPeriodPassed()
                                height: 25
                                background: Item{}
                                icon.source: "qrc:/assets/images/cross.png"
                                icon.width: 24
                                icon.height: 24
                                icon.color:"transparent"
                                opacity: 0.5
                                onClicked: {

                                    deleteDialogBox.comment_id = recdel.model.id
                                    deleteDialogBox.open();
                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }
                }

            }

            Component.onCompleted: commentsPageId.updateCommentsModel();
        }

        Label{
            id: noComment
            width: parent.width
            height: 50
            font.family: "Kalameh"
            font.pixelSize: 20
            font.bold: true
            color: "mediumvioletred"
            text: "نظر مشاور برای دانش‌‌آموز ثبت نشده است."
            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
            visible: false;
        }
    }
}

// insert
Component
{
    id: insertComponent
    CommentInsert{
        onPopSignal: commentsPageId.appStackView.pop();
        onInsertedSignal: commentsPageId.updateCommentsModel();
        branch: commentsPageId.branch
        step: commentsPageId.step
        base: commentsPageId.base
        field : commentsPageId.field
        field_based: commentsPageId.field_based
        period: commentsPageId.period
        class_name: commentsPageId.class_name
        class_id: commentsPageId.class_id
        student_id: commentsPageId.student_id
        student: commentsPageId.student
        student_photo: commentsPageId.student_photo
        jDate: dbMan.getCurrentDate()
    }
}

// update
Component
{
    id: updateComponent
    CommentUpdate{
        onPopSignal: commentsPageId.appStackView.pop();
        onUpdatedSignal: commentsPageId.updateCommentsModel();
        branch: commentsPageId.branch
        step: commentsPageId.step
        base: commentsPageId.base
        field : commentsPageId.field
        field_based: commentsPageId.field_based
        period: commentsPageId.period
        class_name: commentsPageId.class_name
        class_id: commentsPageId.class_id
        student_id: commentsPageId.student_id
        student: commentsPageId.student
        student_photo: commentsPageId.student_photo
    }
}

// confirm delete
BaseDialog.DeleteDialog{
    id: deleteDialogBox
    property int comment_id;
    dialogText: "آیا از حذف نظر مشاور مطمئن می‌باشید؟"
    onDeletedSignal: {
        if(dbMan.deleteComment(deleteDialogBox.comment_id))
        {
            commentsPageId.updateCommentsModel();
            deleteDialogBox.close();
        }
        else
            errorDialogId.open();
    }
}


BaseDialog.BaseDialog
{
    id: errorDialogId
    dialogTitle: "خطا"
    dialogText: "عملیات با خطا مواجه شد."
    dialogSuccess: false
}

}
