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

    //timer to kill workspaceModel elements
    property Timer wsKillTimer : Timer {
        interval: 1000 // 1000ms = 1 second
        running: true
        repeat: true
        onTriggered: {
            for (let i=workspaceModel.count - 1 ; i>=0 ; i--){
                let ttd = workspaceModel.get(i).ttd
                if (ttd > 0)
                    workspaceModel.setProperty(i, "ttd", ttd-1);
                else if (ttd === 0)
                    workspaceModel.remove(i);
            }
            
        }
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
            if (workspaceModel.get(i).wsId<min_ws || workspaceModel.get(i).wsId>max_ws )
                workspaceModel.setProperty(i, "ttd", 1)
            else
                workspaceModel.setProperty(i, "ttd", -1)
        }

        for (let wsId = min_ws; wsId<= max_ws; wsId++){
            //find where and if to insert new id
            let wsExists = false
            let wsIndex = -1
            for (let i = 0; i<workspaceModel.count; i++){
                if(workspaceModel.get(i).tokill) continue //ignore dead stuff
                if (wsId === workspaceModel.get(i).wsId){
                    wsExists = true;
                    break;
                }
                if(wsId < workspaceModel.get(i).wsId)
                    wsIndex = i
            }
            //Do the insersion
            if(!wsExists){
                if (wsIndex >= 0)
                    workspaceModel.insert(wsIndex, {wsId : wsId, ttd : -1})
                else
                    workspaceModel.append({wsId: wsId, ttd : -1})
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