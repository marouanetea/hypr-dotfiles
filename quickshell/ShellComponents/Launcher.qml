import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "../LauncherComponenents"

PanelWindow {
    id: launcher

    //Focus handling
    focusable: true

    //initial state
    visible: false

    //size to match the menu
    implicitWidth : launcherMenu.width
    implicitHeight : launcherMenu.height
    color: "transparent"

    //Hyprland Focus Grab: keeps focus locked and detects outside clicks
    HyprlandFocusGrab {
        id: focusGrab
        active: launcher.visible
        windows: [launcher]

        onCleared: {launcher.visible = false;}
    }

    function toggle() {
        visible = !visible;
    }

    //position
    anchors {
        left: true
        top: true
    }
    margins {
        left: 10
        bottom: 50 // Leave room for a bottom bar if you have one
    }

    // Ensure the window grabs active focus when it becomes visible
    onVisibleChanged: {
        if (visible) {
            startMenu.forceActiveFocus();
        }
    }

    FocusScope {
        id: launcherScope
        anchors.fill: parent
        focus: true

        Keys.onEscapePressed: {
            launcher.visible = false;
        }
        LauncherMenu{
            id: launcherMenu
        }
    }

   
}