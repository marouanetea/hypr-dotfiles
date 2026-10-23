import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

import "../Services"
import "../config"
import "../widgets"

MyCard {
    id: root
    color : "transparent"
    horizontalPadding: 0
    verticalPadding: 0
    anchors.fill: parent
    ListView {
        id: mainListView
        //positioning
        anchors.fill: parent
        orientation: ListView.Horizontal
        clip: true
        spacing: 0 //set to 0 to make animations smooth
        leftMargin : Math.max((width - contentWidth) / 2 , 0 )

        boundsBehavior: Flickable.StopAtBounds

        //Active workspace selection
        currentIndex: {
            for (let i = 0; i < model.count; i++)
                if (model.get(i).wsId === HyprService.activeWorkspaceId) return i;
            return -1; // Fallback if none are active
        }

        //highlight for selected workspace
        highlight : Rectangle {
            color: Colors.accent_bg_primary
            radius : 5
        }
        highlightMoveDuration : 300
        highlightMoveVelocity : -1
        highlightResizeDuration : 300
        highlightResizeVelocity : -1

        // For every workspaces
        model: HyprService.workspaceModel

        //actual workspace
        delegate : MyCard {
            id: workspace
            //color
            color : "transparent"

            //positioning
            horizontalPadding: Config.ws_hSpacing
            verticalPadding: Config.workspacePaddin
            //automatic growth on width, fixed on height
            implicitWidth:  (content.implicitWidth + (horizontalPadding * 2) )* created * alive
            implicitHeight: root.height
            clip : true

            // WorkSpace functionality
            property bool isActive: HyprService.activeWorkspaceId === wsId
            property bool created : false
            property bool alive : ttd < 0
           
            Component.onCompleted: { created = true;}
            
            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 250 // duration in milliseconds
                    easing.type: Easing.Linear // smooth deceleration curve
                }
            }
            Column {
                //top indicator
                Rectangle{
                    color: workspace.isActive ? Colors.accent_fg_primary : Colors.accent
                    implicitWidth : wsListView.visible ? wsListView.implicitWidth : emptyPlaceHolder.implicitWidth
                    implicitHeight : 2
                }
                //One empty button to swithc to the workspace
                MyButton {
                //one empty button
                    id: emptyPlaceHolder
                    normalColor: "transparent"
                    hoverColor: "transparent"
                    visible : !wsListView.visible
                    horizontalPadding : 0
                    verticalPadding : 0

                    implicitWidth : 10
                    implicitHeight : workspace.height - 2

                    onClicked: {
                        HyprService.focusWorkspace(wsId);
                    }
                }
                //Icons
                ListView {
                    id: wsListView
                    orientation: ListView.Horizontal
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    spacing : 0
                    model: HyprService.windowsForWorkspace(wsId)
                    implicitWidth : Math.min(contentWidth,mainListView.width * 0.7)
                    implicitHeight : workspace.height - 4

                    visible : (model.length > 0)

                    currentIndex: {
                        for (let i = 0; i < model.length; i++)
                            if (HyprService.isActiveWindow(model[i])) return i;
                        return -1; // Fallback if none are active
                    }

                    //transparent highlight to force animations
                    highlight : Rectangle {
                        color: "transparent";
                    }
                    highlightMoveVelocity : 1000

                    delegate: MyButton {
                        id: appIconButton

                        required property var modelData
                        property bool isActive: HyprService.isActiveWindow(modelData)

                        normalColor: "transparent"
                        hoverColor: "transparent"

                        horizontalPadding : height / 2 * (1-scale)
                        verticalPadding : 0

                        //animated icon scale
                        property real scale : (isActive || hovered) ? 1 : 0.6
                        Behavior on scale {
                            NumberAnimation {
                                duration: 500 // duration in milliseconds
                                easing.type: Easing.OutCubic // smooth deceleration curve
                            }
                        }

                        //fill vertically, and stay square
                        height : wsListView.implicitHeight
                        width : height

                        anchors.verticalCenter : parent.verticalCenter

                        topLeftRadius: Config.appIconButtonBorderRadius
                        topRightRadius: Config.appIconButtonBorderRadius
                        bottomLeftRadius: Config.appIconButtonBorderRadius
                        bottomRightRadius: Config.appIconButtonBorderRadius

                        property string appIcon: {
                            let __ = retryTick;
                            return HyprService.iconForWindow(modelData);
                        }
                        
                        //retrying to fetch the appIcon
                        property int retryTick: 0
                        property Timer retryTimer : Timer{
                            id: appIconLookup
                            interval : 100
                            running : true
                            repeat : appIconButton.appIcon === Config.defaultAppIcon && appIconButton.retryTick < 200
                            onTriggered: {
                                appIconButton.retryTick++;
                            }
                        }
                        
                        onClicked: {
                            HyprService.focusWindow(modelData);
                        }

                        //content :
                        IconImage { source : "image://icon/" + appIcon }
                    }
                }
            }
        }
    }

}