import QtQuick
import "../services"
import "../config"
import "../widgets"

Button {
    anchors.verticalCenter: parent.verticalCenter
    id: root
    Text {
        font.pixelSize: Config.fontSizeText
        color: textColor

        // Fixed width
        width: Config.barWidthUnit 
        horizontalAlignment: Text.AlignHCenter

        text: KeyboardLayoutService.currentLayout
    }
    //functionality
    onClicked: {
        KeyboardLayoutService.cycleLayout();
    }
    onRightClicked : {
        KeyboardLayoutService.cycleLayout();
    }
    onScrollUp : {
        
    }
    onScrollDown : {
        
    }
}