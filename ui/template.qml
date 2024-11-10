import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: templatePage

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
            onClicked: console.log(1)
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "عنوان"
            font.family: "B Yekan"
            font.pixelSize: 24
            font.bold: true
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
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
                width: (parent.width > 700)? 700 : parent.width
                implicitHeight : centerBox.implicitHeight + 40
                anchors.horizontalCenter : parent.horizontalCenter
                color: "snow"

                GridLayout
                {
                    id: centerBox
                    anchors.fill: parent
                    anchors.margins: 20
                    columns: 2

                    Rectangle{implicitWidth: 100;implicitHeight: 200; color: "red"; border.width: 4}
                    Rectangle{Layout.fillWidth: true; implicitHeight: 100; color: "red"; border.width: 4}

                    Rectangle{implicitWidth: 100;implicitHeight: 200; color: "red"; border.width: 4}
                    Rectangle{Layout.fillWidth: true; implicitHeight: 200; color: "red"; border.width: 4}

                    Rectangle{implicitWidth: 100;implicitHeight: 200; color: "red"; border.width: 4}
                    Rectangle{Layout.fillWidth: true; implicitHeight: 100; color: "red"; border.width: 4}

                    Rectangle{implicitWidth: 100;implicitHeight: 100; color: "red"; border.width: 4}
                    Rectangle{Layout.fillWidth: true; implicitHeight: 100; color: "red"; border.width: 4}

                    Rectangle{implicitWidth: 100;implicitHeight: 200; color: "red"; border.width: 4}
                    Rectangle{Layout.fillWidth: true; implicitHeight: 100; color: "red"; border.width: 4}

                    Rectangle{implicitWidth: 100;implicitHeight: 200; color: "red"; border.width: 4}
                    Rectangle{Layout.fillWidth: true; implicitHeight: 100; color: "red"; border.width: 4}

                    Rectangle{implicitWidth: 100;implicitHeight: 200; color: "red"; border.width: 4}
                    Rectangle{Layout.fillWidth: true; implicitHeight: 100; color: "red"; border.width: 4}

                    Rectangle{implicitWidth: 100;implicitHeight: 200; color: "red"; border.width: 4}
                    Rectangle{Layout.fillWidth: true; implicitHeight: 100; color: "red"; border.width: 4}

                    Rectangle{implicitWidth: 100;implicitHeight: 200; color: "red"; border.width: 4}
                    Rectangle{Layout.fillWidth: true; implicitHeight: 100; color: "red"; border.width: 4}

                    Rectangle{implicitWidth: 100;implicitHeight: 200; color: "red"; border.width: 4}
                    Rectangle{Layout.fillWidth: true; implicitHeight: 100; color: "red"; border.width: 4}
                }
            }
        }



    }
}
