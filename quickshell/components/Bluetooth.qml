import QtQuick
import Quickshell.Io
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
        width: Config.barWidthUnit / 2
        horizontalAlignment: Text.AlignHCenter

        text: " "
    }
    property Process bluetoothProc : Process{
        // Using setsid ensures the app detaches cleanly from the shell lifecycle
        command: ["sh", "-c", "overskride >/dev/null 2>&1 &"]
    }
    //functionality
    onClicked: {
        bluetoothProc.running = true;
    }
    onRightClicked : {
        
    }
    onScrollUp : {
    }
    onScrollDown : {
    }
}