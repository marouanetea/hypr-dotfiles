import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../config"

QtObject {
    id: root

    property var workspaces: Hyprland.workspaces
    property var focusedWorkspace: Hyprland.focusedWorkspace
    property int activeWorkspaceId: focusedWorkspace ? focusedWorkspace.id : 1
    property var focusedMonitor: Hyprland.focusedMonitor
    property var windows: Hyprland.toplevels.values

    property var workspacesCount: {
        let maxId = 0
         for (let i = 0; i < Hyprland.workspaces.values.length; i++) {
            if(maxId < Hyprland.workspaces.values[i].id) maxId = Hyprland.workspaces.values[i].id;
         }
        return maxId
    }

    function windowsForWorkspace(wsId: int): var {
        let list = windows || [];
        // Return a new array instance so the Repeater detects the change
        return [...list.filter(w => w.workspace && w.workspace.id === wsId)];
    }

    function classForWindow(window: HyprlandToplevel): string{
       // If you are targeting a specific HyprlandToplevel object (e.g., named toplevelData)
        if (window.lastIpcObject.class === undefined || window.lastIpcObject.class === null) {
            console.log("found null class, updating...");
            Hyprland.refreshToplevels();
            Hyprland.refreshWorkspaces();
        }
        return window.lastIpcObject.class;
    }

    function iconForWindow(window: HyprlandToplevel): string{
        let windowClass = classForWindow(window);
        if(DesktopEntries.heuristicLookup(windowClass) === null)
            return Config.defaultAppIcon;
        return DesktopEntries.heuristicLookup(windowClass).icon;
    }

    function isActiveWindow(window: HyprlandToplevel): bool{
        return window.activated;
    }

    // Clean wrapper to execute any hyprland command/dispatcher
    function dispatch(command: string) {
        Hyprland.dispatch(command);
    }
    function focusWorkspace(id: int) {
        Hyprland.dispatch("hl.dsp.focus({ workspace = " + id + " })");
    }
    function focusWindow(window: HyprlandToplevel){
        Hyprland.dispatch("hl.dsp.focus({ window = 'address:0x" + window.address + "' })");
    }

}