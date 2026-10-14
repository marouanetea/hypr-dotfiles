pragma Singleton
import Quickshell
import Quickshell.Hyprland
import QtQml

QtObject {
    id: root

    // Centralized signals for your shell services to consume
    signal layoutChanged(string layout)
    //signal activeWindowChanged(string windowClass, string windowTitle)
    //signal workspaceChanged(int workspaceId)

    property Connections hyprConnections : Connections{
        target: Hyprland

        function onRawEvent(event) {
            switch (event.name) {
                case "activelayout": {
                    let parts = event.data.split(",");
                    if (parts.length >= 2) {
                        root.layoutChanged(parts[1].trim());
                    }
                    break;
                }
                /*case "activewindow": {
                    let parts = event.data.split(">>");
                    if (parts.length >= 2) {
                        let winParts = parts[1].split(",");
                        root.activeWindowChanged(winParts[0]?.trim() || "", winParts.slice(1).join(",").trim());
                    }
                    break;
                }
                case "workspace": {
                    root.workspaceChanged(parseInt(event.data.trim()) || 1);
                    break;
                }*/
            }
        }
    }
}