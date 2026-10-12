pragma Singleton
import QtQuick

QtObject {
    // Fonts
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSizeText: 14
    property int fontSizeIcon: 14

    // Spacings & Layout
        // bar : 
        property int barWidthUnit: 55
        property int barHeight: 40
        property int cardPadding: 10
        property int itemSpacing: 8
        property int generalPadding: 6

        //workspaces
        property int vSpacing : 4
        property int hSpacing : 8
        property int appIconButtonPadding : 4
        property int appIconButtonBorderRadis : 40
        property int appIconSize : 18
        property int wsIndicatorHeight : 2



    // Radii
    property int defaultRadius: 8

    //process
    property int timerInterval: 1000

    //icons
    property string defaultAppIcon: "applications-all"

    //animations:
    property int colorAnimDuration: 150
    property var colorAnimType: Easing.OutQuad

}