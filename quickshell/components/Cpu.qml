import QtQuick
import "../services"
import "../config"

Text {
    id: root

    CpuService {
        id: cpuService
    }

    font.pixelSize: Config.fontSizeText
    anchors.verticalCenter: parent.verticalCenter

    //fixed width
    width: Config.barWidthUnit 
    horizontalAlignment: Text.AlignHCenter

    color: {
        if (cpuService.usage > 80) return Colors.red;
        if (cpuService.usage > 60) return Colors.orange;
        if (cpuService.usage > 40) return Colors.yellow;
        if (cpuService.usage > 20) return Colors.green;
        return Colors.blue;
    }

    text: "   " + cpuService.usage + "%"
}