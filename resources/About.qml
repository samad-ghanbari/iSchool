pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: aboutPage

    background: Rectangle{anchors.fill: parent; color: "ghostwhite"; Image{source:"qrc:/assets/images/bg.png"; anchors.fill: parent; opacity: 0.5}}

    ColumnLayout
    {
        anchors.fill: parent

        Text {
            Layout.fillWidth: true
            Layout.preferredHeight: 64
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            text: "About"
            font.family: "The Phamelo"
            font.pixelSize: 30
            font.bold: false
            color: "mediumvioletred"
            style: Text.Outline
            styleColor: "white"
        }

        Rectangle
        {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"
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
                    font.family: "The Phamelo"//"Daughter of Fortune"
                    font.pixelSize: 36
                    font.letterSpacing: 2
                    font.bold: false
                    color: "darkslategray"
                    horizontalAlignment : Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    text: "Roshangaran School Management Application \n This application was developed with \n Qt LTS 6.5 release "
                    NumberAnimation on scale{
                        from: 0.1; to: 1;
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                    ColorAnimation on color {
                               from: "dodgerblue"
                               to: "darkslategray"
                               duration: 5000
                               //loops: Animation.Infinite
                               running: true
                           }
                }

                Label{
                    Layout.fillWidth: true
                    Layout.maximumWidth: 500
                    Layout.preferredHeight: 50
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 50
                    font.family: "The Phamelo"//"Daughter of Fortune"
                    font.pixelSize: 30
                    font.bold: false
                    color: "slategray"
                    horizontalAlignment : Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    text: "Developer Contact: Ghanbari.Samad@Gmail.com "
                    NumberAnimation on scale{
                        from: 20; to: 1;
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                    ColorAnimation on color {
                               from: "darkcyan"
                               to: "darkslategray"
                               duration: 5000
                               //loops: Animation.Infinite
                               running: true
                           }
                }
                Label{
                    Layout.fillWidth: true
                    Layout.maximumWidth: 500
                    Layout.preferredHeight: 50
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 10
                    font.family: "The Phamelo"//"Daughter of Fortune"
                    font.pixelSize: 30
                    font.bold: false
                    color: "slategray"
                    horizontalAlignment : Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    text: "Git Repository: https://github.com/samad-ghanbari/iSchool"
                    NumberAnimation on scale{
                        from: 20; to: 1;
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                    ColorAnimation on color {
                               from: "mediumvioletred"
                               to: "darkslategray"
                               duration: 5000
                               //loops: Animation.Infinite
                               running: true
                           }
                }


                Item{
                    Layout.fillHeight: true; Layout.preferredWidth: 1;
                }

                Label{
                    Layout.fillWidth: true
                    Layout.maximumWidth: 500
                    Layout.preferredHeight: 50
                    Layout.alignment: Qt.AlignHCenter
                    font.family: "The Phamelo"
                    font.pixelSize: 18
                    font.bold: false
                    color: "slategray"
                    horizontalAlignment : Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    text: "All Rights reserved"
                }
            }
        }
    }

    Image{
        source: "qrc:/assets/images/design3.png"
        width: 100
        height: 100
        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }
}
