import QtQuick
import "../services"
import "../config"

Text {
    id: root

    NetworkService {
        id: netService
    }

    font.pixelSize: Config.fontSizeText
    anchors.verticalCenter: parent.verticalCenter
    color: Colors.window_fg

    //fixed width
    width: Config.barWidthUnit*3
    horizontalAlignment: Text.AlignHCenter

    function formatSpeed(bytes) {
        if (bytes < 1024) return (bytes).toFixed(0) + " B/s";
        if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(0) + " KB/s";
        return (bytes / (1024 * 1024)).toFixed(1) + " MB/s";
    }

    function getNetworkIcon() {
        if (netService.connectionType === "wifi") return "󰤨";
        if (netService.connectionType === "ethernet") return "󰈀";
        return "󰤭"; // Disconnected
    }

    text: getNetworkIcon() + "  󰇚 " + formatSpeed(netService.downloadBytes) + "  󰕒 " + formatSpeed(netService.uploadBytes)
}