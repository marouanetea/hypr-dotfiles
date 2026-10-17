import QtQuick
import "../Services"
import "../config"

MyButton {
    id: root
    
    //exposing the basic functionalities of the innerImage element
    property alias bgcolor : root.color
    property alias imageSource : innerImage.source
    
    property alias horizontalAlignment: innerImage.horizontalAlignment
    property alias verticalAlignment: innerImage.verticalAlignment

    Image {
        id: innerImage
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
    }
}