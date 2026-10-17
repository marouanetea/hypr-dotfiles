import QtQuick
import Quickshell.Io
import "../config"
import "../widgets"

Button {
    id: root 

    anchors.verticalCenter: parent.verticalCenter

    Text {
        font.pixelSize: Config.fontSizeText
        color: textColor 

        // Fixed width
        width: Config.barWidthUnit / 2
        horizontalAlignment: Text.AlignHCenter

        text: "󰣇 "
    }
}