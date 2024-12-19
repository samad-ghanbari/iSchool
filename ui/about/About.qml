pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: aboutPage

    signal popStackViewSignal();

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
            opacity: 0.5
            onClicked: aboutPage.popStackViewSignal();
            hoverEnabled: true
            onHoveredChanged: this.opacity=(hovered)? 1 : 0.5;
        }
        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "درباره برنامه"
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
            color: "ghostwhite"
            ColumnLayout{
                anchors.fill: parent

                Item{
                    Layout.fillHeight: true; Layout.preferredWidth: 1;
                }

                Label{
                    Layout.fillWidth: true
                    Layout.maximumWidth: 500
                    Layout.preferredHeight: 50
                    Layout.alignment: Qt.AlignHCenter
                    font.family: "B Yekan"
                    font.pixelSize: 20
                    font.bold: true
                    color: "darkmagenta"
                    horizontalAlignment : Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    text: "Roshangaran School Management Application \n This application was developed with \n Qt LTS 6.8 release "
                    NumberAnimation on scale{
                        from: 0.2; to: 1;
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }

                Label{
                    Layout.fillWidth: true
                    Layout.maximumWidth: 500
                    Layout.preferredHeight: 50
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 50
                    font.family: "B Yekan"
                    font.pixelSize: 16
                    font.bold: true
                    color: "darkmagenta"
                    horizontalAlignment : Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    text: "Developer Contact: Ghanbari.Samad@Gmail.com "
                    NumberAnimation on scale{
                        from: 10; to: 1;
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
                Label{
                    Layout.fillWidth: true
                    Layout.maximumWidth: 500
                    Layout.preferredHeight: 50
                    Layout.alignment: Qt.AlignHCenter
                    font.family: "B Yekan"
                    font.pixelSize: 14
                    font.bold: true
                    color: "darkslategray"
                    horizontalAlignment : Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    text: "All Rights reserved"
                }

                Item{
                    Layout.fillHeight: true; Layout.preferredWidth: 1;
                }
            }
        }
    }
}
