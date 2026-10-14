pragma Singleton
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQml

QtObject {
    id: root

    property string currentLayout: ""

    Component.onCompleted: {
        // Listen to the central bridge signal
        HyprConnectionsService.layoutChanged.connect(layout => {
            root.currentLayout = layout;
        });

        // Initial fetch on startup
        updateLayout();
    }

    function updateLayout() {
        if (!devicesProc.running) {
            devicesProc.running = true;
        }
    }

    function cycleLayout() {
        if (!switchProc.running) {
            switchProc.command = ["hyprctl", "switchxkblayout", "current", "next"];
            switchProc.running = true;
        }
    }

    // Initial fetch to populate layout state on startup
    property Process devicesProc : Process {
        command: ["sh", "-c", "hyprctl devices | grep 'keyd-virtual-keyboard' -A 3 | grep 'active keymap' -P | cut -d: -f2-"]
        stdout: SplitParser {
            onRead: data => {
                let layout = data.trim();
                if (layout.length > 0) {
                    root.currentLayout = layout;
                }
            }
        }
    }

    property Process switchProc : Process  {
    }
}