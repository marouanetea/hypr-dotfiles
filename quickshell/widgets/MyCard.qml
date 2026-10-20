import QtQuick
import Quickshell.Widgets
import "../config" 

// A simple card with inner padding

Rectangle {

    id: root

    //default values
    color: Colors.window_bg
    border.color: Colors.accent
    border.width: 0

    topLeftRadius: Config.defaultRadius
    topRightRadius: Config.defaultRadius
    bottomLeftRadius: Config.defaultRadius
    bottomRightRadius: Config.defaultRadius

    property int horizontalPadding: Config.cardPadding
    property int verticalPadding: Config.cardPadding

    default property alias content: wrapperItem.child
    property alias rootChildren: root.data

    WrapperItem {
        id: wrapperItem
        anchors.fill: parent

        anchors.topMargin: verticalPadding
        anchors.bottomMargin: verticalPadding
        anchors.leftMargin: horizontalPadding
        anchors.rightMargin: horizontalPadding
    }
}