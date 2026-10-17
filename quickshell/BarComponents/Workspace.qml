import QtQuick
import Quickshell
import Quickshell

import "../Services"
import "../config"
import "../widgets"

Row {
    id: root

    spacing: Config.hSpacing

    Repeater {
        // For every workspace
        model: HyprService.workspacesCount
        Card {
            id: workspace
            required property int index
            property int wsId: index + 1
            property bool isActive: HyprService.activeWorkspaceId === wsId
            color: "transparent"
            horizontalPadding: 0
            verticalPadding: 0
            Column{
                spacing : Config.vSpacing
                Row {
                    id: workspaceIcons
                    spacing : Config.hSpacing
                    Button {
                    //one empty button
                        id: emptyPlaceHolder
                        normalColor: "transparent"
                        hoverColor: "transparent"
                        visible : HyprService.windowsForWorkspace(wsId).length === 0
                        horizontalPadding : 0
                        verticalPadding : Config.appIconButtonPadding
                        Rectangle{
                            width : Config.hSpacing
                            height : Config.appIconSize
                            color: "transparent"
                        }
                        onClicked: {
                            HyprService.focusWorkspace(wsId);
                        }
                    }
                    Repeater {
                    // for every icon within the workspace
                        model: HyprService.windowsForWorkspace(wsId)

                        delegate: MyImageButton {
                            id: appIconButton

                            required property var modelData
                            property bool isActive: HyprService.isActiveWindow(modelData)

                            normalColor:  isActive ? Colors.accent : "transparent"
                            hoverColor: isActive ? Colors.accent : Colors.accent_fg_primary

                            horizontalPadding : Config.appIconButtonPadding
                            verticalPadding : Config.appIconButtonPadding

                            width : 28
                            height : 28

                            property int retryTick: 0

                            imageSource : "image://icon/" + appIcon

                            property Timer retryTimer : Timer{
                                id: appIconLookup
                                interval : 100
                                running : true
                                repeat : appIconButton.appIcon === Config.defaultAppIcon && appIconButton.retryTick < 200
                                onTriggered: {
                                    appIconButton.retryTick++;
                                }
                            }
                            
                            property string appIcon: {
                                let __ = retryTick;
                                return HyprService.iconForWindow(modelData);
                            }
                            onClicked: {
                                HyprService.focusWindow(modelData);
                            }
                        }
                    }
                }
                MyRectangle{
                    id: wsIndicator
                    color : {
                        if (workspace.isActive) return Colors.accent;
                        return Qt.alpha(Colors.accent,0.2);
                    }
                    height: Config.wsIndicatorHeight
                    width: workspaceIcons.width
                }
            }

        }
    }
}