pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Evals.js" as Methods
import "./../public" as DialogBox


Page {
    id: evalStudentsPage

    required property StackView appStackView;

    required property string branch
    required property string step
    required property string base
    required property string period

    required property int step_id;
    required property int base_id;
    required property int period_id;

    required property string eval_cat
    //required property int eval_cat_id
    required property bool test_flag
    required property bool final_flag

    required property int eval_id
    required property int course_id
    required property string course_name
    required property int class_id
    required property string class_name
    required property int max_grade
    required property int included



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
            onClicked: evalStudentsPage.appStackView.pop();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: evalStudentsPage.eval_cat
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
            elide: Text.ElideRight
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
                implicitHeight : centerBox.implicitHeight + 40
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"

                ColumnLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    // branch
                    Label
                    {
                        Layout.fillWidth: true
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        color: "royalblue"
                        text:"شعبه " + evalStudentsPage.branch
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                    }
                    //step base
                    Label
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        color: "royalblue"
                        text: {
                            if(evalStudentsPage.base.indexOf("پایه") == -1)
                            return evalStudentsPage.step + " - پایه " + evalStudentsPage.base;
                            else
                            return evalStudentsPage.step + " - " + evalStudentsPage.base;
                        }
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                    }
                    Label
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        color: "royalblue"
                        text:"سال تحصیلی " + evalStudentsPage.period
                        font.family: "B Yekan"
                        font.pixelSize: 18
                        font.bold: true
                    }
                    // course class
                    Label
                    {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        horizontalAlignment: Label.AlignHCenter
                        verticalAlignment: Label.AlignVCenter
                        color: "darkmagenta"
                        text:"عنوان درس " + evalStudentsPage.course_name + " - " + "کلاس " + evalStudentsPage.class_name
                        font.family: "B Yekan"
                        font.pixelSize: 20
                        font.bold: true
                    }

                    Rectangle{Layout.fillWidth: true; Layout.preferredHeight: 2; Layout.maximumHeight: 2; color: "royalblue";}

                    RowLayout
                    {
                        Layout.preferredHeight: 64
                        Layout.fillWidth: true

                        Button
                        {
                            Layout.preferredHeight: 64
                            Layout.preferredWidth: 64
                            background: Item{}
                            icon.source: "qrc:/assets/images/add.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked: evalStudentsPage.appStackView.push(insertComponent)
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }

                        Button
                        {
                            id: refreshBtn
                            Layout.preferredWidth: 64
                            Layout.preferredHeight: 64
                            background: Item{}
                            icon.source: "qrc:/assets/images/refresh.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked:
                            {
                                if(evalStudentsPage.base_id > -1)
                                {
                                    // update class students
                                    if(dbMan.updateEvalStudents(evalStudentsPage.step_id, evalStudentsPage.base_id, evalStudentsPage.period_id, evalStudentsPage.class_id, evalStudentsPage.eval_id))
                                    {
                                        infoDialogId.dialogSuccess = true;
                                        infoDialogId.dialogTitle = "عملیات موفق"
                                        infoDialogId.dialogText = "بروزرسانی با موفقیت انجام شد."
                                        Methods.updateClassStudentsEval(evalStudentsPage.class_id, evalStudentsPage.eval_id );
                                    }
                                    else
                                    {
                                        infoDialogId/open();
                                    }
                                }
                                else
                                {
                                    infoDialogId.dialogText = "برای دروس دوره، لازم است دانش‌آموزان به صورت دستی اضافه گردند."
                                    infoDialogId.open();
                                }

                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }

                        Item{Layout.fillWidth: true; Layout.preferredHeight:64;}

                        Button
                        {

                            Layout.preferredWidth: 64
                            Layout.preferredHeight: 64
                            background: Item{}
                            icon.source: "qrc:/assets/images/info.png"
                            icon.width: 64
                            icon.height: 64
                            opacity: 0.5
                            onClicked:
                            {
                            }
                            hoverEnabled: true
                            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
                        }
                    }

                    GridView
                    {
                        id: evalStudentGV
                        Layout.columnSpan: 2
                        implicitHeight: 600;
                        Layout.fillWidth: true
                        Layout.margins: 20
                        flickableDirection: Flickable.AutoFlickDirection
                        cellWidth: 320
                        cellHeight: 370 // 20 spacing
                        clip: true
                        model: ListModel{id: evalStudentsModel; }
                        highlight: Item{}
                        delegate: evalsDelegate
                        Component.onCompleted: Methods.updateClassStudentsEval(evalStudentsPage.class_id, evalStudentsPage.eval_id );

                        function closeSwipeHandler()
                        {
                            for (var i = 0; i <= evalStudentGV.count; i++)
                            {
                                var item = evalStudentGV.contentItem.children[i];
                                if(item.swipe)
                                {
                                    item.swipe.close();
                                    item.checked = false;
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    // delegate
    Component
    {
        id: evalsDelegate

        SwipeDelegate
        {
            id: recDel
            required property var model;
            property bool isFemale: (model.Gender === "خانم")? true : false;
            height: 350
            width: 300
            checkable: true
            checked: recDel.swipe.complete
            onCheckedChanged: { if(!recDel.checked) recDel.swipe.close();}
            clip: true

            background: Rectangle{color: (recDel.highlighted)? "snow" : "whitesmoke";}

            contentItem: Rectangle
            {
                //se.id, se.student_id, se.eval_id, se.student_grade, se.normalised_grade, s.student, s.fathername, s.gender, s.photo

                width: parent.width
                height: parent.height

                ColumnLayout
                {
                    anchors.fill: parent

                    Image {
                        source:{
                            if(recDel.model.Photo == "")
                            {
                                if(recDel.isFemale) return "qrc:/assets/images/female.png"; else return "qrc:/assets/images/user.png";
                            }
                            else
                            {
                                return "file://"+recDel.model.Photo;
                            }

                        }
                        Layout.preferredWidth: 128
                        Layout.preferredHeight: 128
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: recDel.model.Student + " ( " + recDel.model.Fathername + " )"
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "royalblue"
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 50
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text {
                        text: (evalStudentsPage.test_flag)? "نمره اخذ شده: " + recDel.model.Student_grade + "%" : "نمره اخذ شده: " + recDel.model.Student_grade
                        visible: (recDel.model.Student_grade > -1)? true :  false
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "mediumvioletred"
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 50
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text {
                        text: (evalStudentsPage.test_flag)? "نمره با اعمال نمودار: " + recDel.model.Normalised_grade + "%"  :  "نمره با اعمال نمودار: " + recDel.model.Normalised_grade;
                        visible: (recDel.model.Normalised_grade > -1)? true :  false
                        font.family: "B Yekan"
                        font.pixelSize: 16
                        font.bold: true
                        color: "mediumvioletred"
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 50
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Item{Layout.preferredWidth: parent.width; Layout.fillHeight: true;}
                }


            }

            onClicked: {recDel.swipe.close();}
            onPressed: { evalStudentGV.currentIndex = model.index; evalStudentGV.closeSwipeHandler();}
            highlighted: (model.index === evalStudentGV.currentIndex)? true: false;

            swipe.right:Column{
                width: 48
                height: 250
                anchors.left: parent.left

            }
        }
    }


    //eval insert
    Component
    {
        id: insertComponent
        EvalInsert
        {
            onPopStackSignal: evalStudentsPage.appStackView.pop();
            onInsertedSignal: Methods.updateEvals(evalStudentsPage.eval_cat_id);

            branch: evalStudentsPage.branch
            step: evalStudentsPage.step
            base: evalStudentsPage.base
            period: evalStudentsPage.period

            step_id: evalStudentsPage.step_id;
            base_id: evalStudentsPage.base_id;
            period_id: evalStudentsPage.period_id;

            eval_cat: evalStudentsPage.eval_cat
            eval_cat_id: evalStudentsPage.eval_cat_id
            test_flag : evalStudentsPage.test_flag
            final_flag: evalStudentsPage.final_flag
        }
    }

    //eval delete
    Component
    {
        id: deleteComponent
        EvalDelete
        {
            onPopStackSignal: evalStudentsPage.appStackView.pop();
            onDeletedSignal: Methods.updateEvals(evalStudentsPage.eval_cat_id);

            branch: evalStudentsPage.branch
            step: evalStudentsPage.step
            base: evalStudentsPage.base
            period: evalStudentsPage.period

            eval_cat: evalStudentsPage.eval_cat
            test_flag : evalStudentsPage.test_flag
            final_flag: evalStudentsPage.final_flag
        }
    }

    //eval update
    Component
    {
        id: updateComponent
        EvalUpdate
        {
            onPopStackSignal: evalStudentsPage.appStackView.pop();
            onUpdatedSignal: Methods.updateEvals(evalStudentsPage.eval_cat_id);

            branch: evalStudentsPage.branch
            step: evalStudentsPage.step
            base: evalStudentsPage.base
            period: evalStudentsPage.period

            step_id: evalStudentsPage.step_id;
            base_id: evalStudentsPage.base_id;
            period_id: evalStudentsPage.period_id;

            eval_cat: evalStudentsPage.eval_cat
            test_flag : evalStudentsPage.test_flag
        }
    }

    // DialogButtonBox
    DialogBox.BaseDialog
    {
        id: infoDialogId
        dialogTitle: "خطا"
        dialogText: "بروزرسانی با خطا مواجه شد."
        dialogSuccess: false
    }


}
