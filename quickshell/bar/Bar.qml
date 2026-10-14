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

    margins {
        top : Config.barMargin
        left : Config.barMargin
        right : Config.barMargin
        bottom : Config.barMargin
    }

    color: "transparent"

    // Use a plain Item container for absolute left, center, and right anchoring
    Item {
        anchors.fill: parent

        // --- Left Widget (Stats Leaf) ---
        Card {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            radiusTopLeft: 0
            radiusTopRight: 8
            radiusBottomLeft: 8
            radiusBottomRight: 0
            color: Qt.alpha(Colors.window_bg, Config.barAlpha)

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
            color: Qt.alpha(Colors.window_bg, Config.barAlpha)

            Row {
                height: root.height - Config.cardPadding*2
                spacing: 6
                Workspace {} // Make sure this matches your component file name
            }
        }

        Card {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            radiusTopLeft: 8
            radiusTopRight: 8
            radiusBottomLeft: 8
            radiusBottomRight: 8
            color: Qt.alpha(Colors.window_bg, Config.barAlpha)

            Row {
                height: root.height - Config.cardPadding*2
                spacing: 6
                Brightness {}
                Audio{}
                KeyboardLayout{}
                Bluetooth{}
                Wifi{}
                SwayNC{}
                Clock{}
            }
        }

    }
}