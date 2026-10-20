import QtQuick
import "../config"

Rectangle {
    id: root

    property alias text: input.text
    property alias placeholderText: placeholder.text

    //color
    color: "red"
    border.color: input.activeFocus ? Colors.accent_bg_primary : Colors.accent_fg_primary
    border.width: 1
    
    //radius
    topLeftRadius: Config.defaultRadius
    topRightRadius: Config.defaultRadius
    bottomLeftRadius: Config.defaultRadius
    bottomRightRadius: Config.defaultRadius

     MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: {
            input.forceActiveFocus();
        }
    }

    TextInput {
        id: input
        anchors.fill: parent
        anchors.leftMargin: Config.cardPadding
        anchors.rightMargin: Config.cardPadding
        verticalAlignment: TextInput.AlignVCenter

        color: Colors.popover_fg
        font.pixelSize: Config.fontSizeText
        selectionColor: Colors.accent_bg_primary
        selectedTextColor: Colors.accent_fg_primary

        Text {
            id: placeholder
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            color: Colors.accent_bg_tertiary
            font.pixelSize: parent.font.pixelSize
            visible: !input.text && !input.activeFocus
            elide: Text.ElideRight
            text: "placeholder sample text"
        }
    }
}