// ~/.config/quickshell/bar/Bar.qml
import QtQuick
import Quickshell
import Quickshell.Wayland
import "../components" 
import "../widgets" 
import "../config" 

PanelWindow {
    id: root
    
    //screen: root.targetScreen
    implicitWidth: screen ? screen.width : 800
    implicitHeight: Config.barHeight

    anchors {
        top: true
        left: true
        right: true
    }

    color: "transparent"

    // Use a plain Item container for absolute left, center, and right anchoring
    Item {
        anchors.fill: parent
        anchors.margins: 4

        // --- Left Widget (Stats Leaf) ---
        Card {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            radiusTopLeft: 0
            radiusTopRight: 8
            radiusBottomLeft: 8
            radiusBottomRight: 0
            color: Colors.window_bg

            Row {
                height: root.height - Config.cardPadding*2
                spacing: 6
                Battery{}
                Cpu{}
                Temperature{}
                Ram{}
                Network{}
            }
        }

        // --- Center Widget (Dead-Centered Workspaces) ---
        Card {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            radiusTopLeft: 8
            radiusTopRight: 8
            radiusBottomLeft: 8
            radiusBottomRight: 8
            color: Colors.window_bg

            Row {
                height: root.height - Config.cardPadding*2
                spacing: 6
                Workspace {} // Make sure this matches your component file name
            }
        }

        // --- Right Widget (Optional: e.g., Clock or Controls) ---
        /*
        Card {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            // ...
        }
        */
    }
}