import QtQuick
import "../Services"
import "../config"

MyButton {
    id: root
    
    //exposing the basic functionalities of the innerText element
    property alias text: innerText.text
    property alias fgcolor: innerText.color
    property alias bgcolor : root.color
    property alias font: innerText.font
    
    property alias horizontalAlignment: innerText.horizontalAlignment
    property alias verticalAlignment: innerText.verticalAlignment
    
    property alias elide: innerText.elide
    property alias wrapMode: innerText.wrapMode

    Text {
        id: innerText

        anchors.fill: parent
        
        font.pixelSize: Config.fontSizeText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment : Text.AlignVCenter
        lineHeight: Config.lineHeight

        color: root.textColor
    }
}