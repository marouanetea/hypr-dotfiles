pragma Singleton
import QtQuick

QtObject {
    // Fonts
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSizeText: 13
    property int fontSizeIcon: 14

    // Spacings & Layout

    property int barWidthUnit: 50
    property int barHeight: 35
    property int itemSpacing: 8
    property int generalPadding: 6

    // Radii
    property int defaultRadius: 8

    //process
    property int timerInterval: 1000
}