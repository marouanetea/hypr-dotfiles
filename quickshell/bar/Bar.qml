// ~/.config/quickshell/bar/Bar.qml
import QtQuick
import Quickshell
import Quickshell.Wayland
import "../components" 
import "../widgets" 
import "../config" 


PanelWindow {
    id: root
    
    screen: root.targetScreen
    width: screen ? screen.width : 800
    height: 35

    anchors {
        top: true
        left: true
        right: true
    }

    color: "transparent" // Let individual widgets handle their own backgrounds

    // A layout row to hold our modular widgets across the bar
    Row {
        anchors.fill: parent
        anchors.margins: 4 // Space between screen edge and widgets
        spacing: 0

        // --- Widget 1: A "Leaf" shaped Workspace/Logo box ---
        Card {
            anchors.verticalCenter: parent.verticalCenter

            // Custom asymmetric leaf radii
            radiusTopLeft: 0
            radiusTopRight: 8
            radiusBottomLeft: 8
            radiusBottomRight: 0
            color: Colors.window_bg// Accent color

            Row {
                spacing: 6
                Battery{}
                Cpu{}
                Temperature{}
                Ram{}
                Network{}
            }
        }

    }
}