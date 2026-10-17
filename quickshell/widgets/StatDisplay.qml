import QtQuick
import "../Services"
import "../config"

Item{
    id: root
    property bool inverseColor: false
    property int value: 0
    property string unit: "%"
    property string state : ""
    property var icon: "X"

    //exposing the basic functionalities of the innerText element
    property alias text: innerText.text
    property alias color: innerText.color
    property alias font: innerText.font
    
    property alias horizontalAlignment: innerText.horizontalAlignment
    property alias verticalAlignment: innerText.verticalAlignment
    
    property alias elide: innerText.elide
    property alias wrapMode: innerText.wrapMode

    function getCurrentIcon() {
            // If the user passed a single string, just return it directly
            if (typeof icon === "string") {
                return icon;
            }

            if (!Array.isArray(icon) || icon.length === 0) return "";
            
            let clampedVal = Math.max(0, Math.min(100, value));
            
            let index = Math.floor((clampedVal / 100) * icon.length);
            if (index >= icon.length) {
                index = icon.length - 1;
            }
            
            return icon[index];
        }

    Text {
        id: innerText

        anchors.fill: parent
        
        font.pixelSize: Config.fontSizeText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment : Text.AlignVCenter
        lineHeight: Config.lineHeight

        color: Helpers.getHeatMapColor(inverseColor ? 100 - root.value : root.value)
        text: root.state + getCurrentIcon() + root.value + root.unit
    }
}