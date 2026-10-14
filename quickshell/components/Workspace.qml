import QtQuick
import Quickshell
import Quickshell

import "../services"
import "../config"
import "../widgets"

Row {
    id: root

    HyprService {
        id: hyprService
    }

    spacing: Config.hSpacing
    anchors.verticalCenter: parent.verticalCenter

    Repeater {
        // For every workspace
        model: hyprService.workspacesCount
        Card {
            id: workspace
            required property int index
            property int wsId: index + 1
            property bool isActive: hyprService.activeWorkspaceId === wsId
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
                        visible : hyprService.windowsForWorkspace(wsId).length === 0
                        horizontalPadding : 0
                        verticalPadding : Config.appIconButtonPadding
                        Rectangle{
                            width : Config.hSpacing
                            height : Config.appIconSize
                            color: "transparent"
                        }
                        onClicked: {
                            hyprService.focusWorkspace(wsId);
                        }
                    }
                    Repeater {
                    // for every icon within the workspace
                        model: hyprService.windowsForWorkspace(wsId)

                        delegate: Button {
                            id: appIconButton
                            required property var modelData
                            property bool isActive: hyprService.isActiveWindow(modelData)
                            normalColor:  isActive ? Colors.accent : "transparent"
                            hoverColor: isActive ? Colors.accent : Colors.accent_fg_primary

                            horizontalPadding : Config.appIconButtonPadding
                            verticalPadding : Config.appIconButtonPadding

                            radiusTopLeft: Config.appIconButtonBorderRadis
                            radiusTopRight: Config.appIconButtonBorderRadis
                            radiusBottomLeft: Config.appIconButtonBorderRadis
                            radiusBottomRight: Config.appIconButtonBorderRadis

                            property int retryTick: 0
                            Timer {
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
                                return hyprService.iconForWindow(modelData);
                            }
                            Image {
                                width : Config.appIconSize
                                height : Config.appIconSize
                                source: "image://icon/" + appIcon
                                fillMode: Image.PreserveAspectFit
                            }
                            onClicked: {
                                hyprService.focusWindow(modelData);
                            }
                        }
                    }
                }
                MyRectangle{
                    id: wsIndicator
                    color : {
                        if (workspace.isActive) return Colors.accent;
                        return Colors.accent_fg_primary;
                    }
                    height: Config.wsIndicatorHeight
                    width: workspaceIcons.width
                }
            }

        }
    }
}