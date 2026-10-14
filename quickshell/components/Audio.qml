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

        text: (AudioService.muted ? "󰝟  " : "󰕾  ") + AudioService.volume + "%"
    }
    //functionality
    onClicked: {
        AudioService.toggleMute();
    }
    onRightClicked : {
        AudioService.toggleMute();
    }
    onScrollUp : {
        AudioService.volumeUp();
    }
    onScrollDown : {
        AudioService.volumeDown();
    }
}