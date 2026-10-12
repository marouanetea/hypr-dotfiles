import QtQuick
import "../services"
import "../config"

Text {
    id: root

    RamService {
        id: ramService
    }

    font.pixelSize: Config.fontSizeText
    anchors.verticalCenter: parent.verticalCenter

    //fixed width
    width: Config.barWidthUnit 
    horizontalAlignment: Text.AlignHCenter

    color: {
        if (ramService.usagePercent >= 80) return Colors.red;
        if (ramService.usagePercent >= 65) return Colors.orange;
        if (ramService.usagePercent >= 50) return Colors.yellow;
        if (ramService.usagePercent >= 25) return Colors.green;
        return Colors.blue;
    }

    text: "   " + ramService.usagePercent + "%"
}