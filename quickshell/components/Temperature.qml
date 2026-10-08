import QtQuick
import "../services"
import "../config"

Text {
    id: root

    TempService {
        id: tempService
    }

    font.pixelSize: Config.fontSizeText
    anchors.verticalCenter: parent.verticalCenter

    //fixed width
    width: Config.barWidthUnit 
    horizontalAlignment: Text.AlignHCenter

    color: {
        if (tempService.temp >= 80) return Colors.red;
        if (tempService.temp >= 65) return Colors.orange;
        if (tempService.temp >= 50) return Colors.yellow;
        if (tempService.temp >= 40) return Colors.green;
        return Colors.blue;
    }

    text: "󰔏 " + tempService.temp + "°C"
}