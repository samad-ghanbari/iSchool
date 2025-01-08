pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Window
import QtQuick.Controls

ApplicationWindow {

    id: appWindowId
    minimumWidth: 400
    minimumHeight: 400
    visibility: Window.Maximized
    visible: true
    color: "lavender"
    title: qsTr("مدرسه غیر دولتی روشنگران")
    LayoutMirroring.enabled: true
    LayoutMirroring.childrenInherit: true
    //flags: Qt.WindowSystemMenuHint | ~Qt.WindowCloseButtonHint;

    menuBar: MenubarModule{ id: menubarId; appStackView: homeStackViewId; }
    header : ToolbarModule{id:toolbarId; appStackView: homeStackViewId; }


    StackView {
        id: homeStackViewId
        initialItem: HomePage{
            objectName: "homePageON"
            onBranchSelected:(branch_var)=>{
                homeStackViewId.push(stepComponent, {branch: branch_var, objectName: "stepsON"})
            };
        }
        anchors.fill: parent
    }

    Component{
        id: stepComponent;
        StepsPage{
            appStackView: homeStackViewId
        }
    }

}


