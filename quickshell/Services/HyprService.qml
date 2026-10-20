pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../config"

QtObject {
    id: root

    property var workspaces: Hyprland.workspaces.values || [];
    property var focusedWorkspace: Hyprland.focusedWorkspace
    property int activeWorkspaceId: focusedWorkspace ? focusedWorkspace.id : 1
    property var focusedMonitor: Hyprland.focusedMonitor
    property var windows: Hyprland.toplevels.values

    // Stable ListModel for the taskbar ListView
    property ListModel workspaceModel : ListModel {}

    // Automatically sync whenever Hyprland workspaces change
    onWorkspacesChanged: {
        syncWorkspaces();
    }

    // Incremental sync function: adds, removes, or moves items in-place 
    // without destroying existing delegate references.
    function syncWorkspaces() {
        let min_ws = 1 // workspaces start at 1
        let max_ws = 0

        //compute min and max workspaces
        for (let i=0; i<workspaces.length ; i++){
            if(min_ws > workspaces[i].id)
                min_ws = workspaces[i].id
            if(max_ws < workspaces[i].id)
                max_ws = workspaces[i].id
        }
        
        //remove extra workspaces
        for (let i = 0; i<workspaceModel.count; i++){
            if (workspaceModel.get(i).id<min_ws || workspaceModel.get(i).id>max_ws )
                workspaceModel.remove(i)
        }

        for (let id = min_ws; id<= max_ws; id++){
            //find where and if to insert new id
            let wsExists = false
            let wsIndex = -1
            for (let i = 0; i<workspaceModel.count; i++){
                if(workspaceModel.get(i).tokill) continue //ignore dead stuff
                if (id === workspaceModel.get(i).id){
                    wsExists = true;
                    break;
                }
                if(id < workspaceModel.get(i).id)
                    wsIndex = i
            }
            //console.log("for id = " + id + " we have wsExists = " + wsExists + " and wsIndex = " + wsIndex)
            //Do the insersion
            if(!wsExists){
                if (wsIndex >= 0)
                    workspaceModel.insert(wsIndex, {id : id})
                else
                    workspaceModel.append({id: id})
            }
                
        }
    }

    property int workspacesCount: workspaceModel.count

    function windowsForWorkspace(id: int): var {
        let list = windows || [];
        return [...list.filter(w => w.workspace && w.workspace.id === id)];
    }

    function classForWindow(window: HyprlandToplevel): string {
        if (window.lastIpcObject.class === undefined || window.lastIpcObject.class === null) {
            Hyprland.refreshToplevels();
            Hyprland.refreshWorkspaces();
        }
        return window.lastIpcObject.class;
    }

    function iconForWindow(window: HyprlandToplevel): string {
        let windowClass = classForWindow(window);
        if (DesktopEntries.heuristicLookup(windowClass) === null)
            return Config.defaultAppIcon;
        return DesktopEntries.heuristicLookup(windowClass).icon;
    }

    function isActiveWindow(window: HyprlandToplevel): bool {
        return window.activated;
    }

    function dispatch(command: string) {
        Hyprland.dispatch(command);
    }
    
    function focusWorkspace(id: int) {
        Hyprland.dispatch("hl.dsp.focus({ workspace = " + id + " })");
    }
    
    function focusWindow(window: HyprlandToplevel) {
        Hyprland.dispatch("hl.dsp.focus({ window = 'address:0x" + window.address + "' })");
    }
}