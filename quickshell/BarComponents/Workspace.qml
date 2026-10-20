import QtQuick
import QtQuick.Layouts
import Quickshell

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
        id: listView
        anchors.fill: parent
        orientation: ListView.Horizontal
        clip: true
        spacing: 0 //set to 0 to make animations smooth
        boundsBehavior: Flickable.StopAtBounds

        //smart right margin to keep it centered
        leftMargin : (width - contentWidth) / 2

        //highlight for selected workspace
        highlight : Rectangle {
            color: "transparent";
            Rectangle {
                id: bottomBorder
                height: 2 // thickness of the line
                color: Colors.accent // your accent or border color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }
        }
        highlightMoveVelocity : 350
        highlightResizeVelocity : 300

        function selectWorkSpace(index : int){
            if(index < 0 || index > count) return;
            let indexDiff = index - currentIndex
            if(indexDiff > 0)
                for(let i=0; i<indexDiff; i++)
                    incrementCurrentIndex();
            if(indexDiff < 0)
                for (let i=0; i<-indexDiff; i++)
                    decrementCurrentIndex();
        }

        // For every workspace
        model: HyprService.workspaceModel
            

            //remove Transition
            
            //actual workspace
        delegate : MyCard {
            id: workspace
            // WorkSpace functionality
            property int wsId: id //id is available from the model
            property bool isActive: HyprService.activeWorkspaceId === wsId
            onIsActiveChanged: {if(isActive ) listView.selectWorkSpace(index);}
            Component.onCompleted: {if(isActive ) listView.selectWorkSpace(index); }
            onWidthChanged: {if(isActive ) listView.selectWorkSpace(index);}
            
            //animations
            property SequentialAnimation removeAnimation : SequentialAnimation{
                PropertyAction { target: workspace; property: "ListView.delayRemove"; value: true }
                NumberAnimation { target: workspace; property: "width"; to: 0; duration: 300; easing.type: Easing.Linear }
                PropertyAction { target: workspace; property: "ListView.delayRemove"; value: false }
            }
            property SequentialAnimation addAnimation : SequentialAnimation {
                NumberAnimation { target: workspace; property: "animationWidthScale"; from : 0; to : 1; duration: 300; easing.type: Easing.Linear }
            }
            ListView.onRemove: removeAnimation.start()
            ListView.onAdd : addAnimation.start()

            //color
            color : "transparent"

            //positioning
            horizontalPadding: Config.ws_hSpacing
            verticalPadding: Config.workspacePaddin
            //automatic growth on width, fixed on height
            property real animationWidthScale : 1
            implicitWidth:  (content.implicitWidth + (horizontalPadding * 2)) * animationWidthScale
            implicitHeight: root.height

            //Icons
            Row {
                spacing : Config.ws_hSpacing
                MyButton {
                //one empty button
                    id: emptyPlaceHolder
                    normalColor: "transparent"
                    hoverColor: "transparent"
                    visible : HyprService.windowsForWorkspace(workspace.wsId).length === 0
                    horizontalPadding : Config.appIconButtonPadding
                    verticalPadding : Config.appIconButtonPadding
                    width : Config.wsEmptyWidth
                    anchors.top : parent.top
                    anchors.bottom : parent.bottom
                    onClicked: {
                        HyprService.focusWorkspace(wsId);
                    }
                }
                Repeater {
                // for every icon within the workspace
                    model: HyprService.windowsForWorkspace(wsId)

                    delegate: MyButton {
                        id: appIconButton

                        required property var modelData
                        property bool isActive: HyprService.isActiveWindow(modelData)

                        normalColor: isActive ? Colors.accent : "transparent"
                        hoverColor: isActive ? Colors.accent : Colors.accent_fg_primary

                        horizontalPadding : Config.appIconButtonPadding
                        verticalPadding : Config.appIconButtonPadding

                        //fill vertically, and stay square
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width : height

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
                        Image {
                            id: icon
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectFit
                            source : "image://icon/" + appIcon
                        }
                    }
                }
            }
        }
    }

}