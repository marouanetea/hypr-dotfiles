// ~/.config/quickshell/bar/Bar.qml
import QtQuick
import Quickshell
import Quickshell.Wayland
import "../BarComponents"
import "../widgets" 
import "../config" 

PanelWindow {
    id: root

    //signals
    signal launchClicked()

    //screen: root.targetScreen
    implicitWidth: screen ? screen.width : 800
    implicitHeight: Config.barHeight

    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        top : Config.barMargin
        left : Config.barMargin
        right : Config.barMargin
        bottom : Config.barMargin
    }

    color: "transparent"

    property var bg_color: Qt.alpha(Colors.window_bg, Config.barAlpha)

    // --- Left Widget (Stats Leaf) ---
    MyCard {
        anchors.left: parent.left
        color: bg_color

        horizontalPadding: Config.barHorizontalPadding
        verticalPadding: Config.barVerticalPadding

        width : 450
        height : parent.height

        SystemStats {}
    }

    // --- Center Widget (Dead-Centered Workspaces) ---
    MyCard {
        anchors.horizontalCenter: parent.horizontalCenter
        color: bg_color

        horizontalPadding: Config.barHorizontalPadding
        verticalPadding: Config.barVerticalPadding

        width : 400 
        height : parent.height
        
        Workspace {} // Make sure this matches your component file name
    }

    MyCard {
        anchors.right: parent.right
        color: bg_color

        horizontalPadding: Config.barHorizontalPadding
        verticalPadding: Config.barVerticalPadding

        width : 450
        height : parent.height

        SystemControls {}
    }

}