import QtQuick
import "../services"
import "../config"

Text {
    id: root

    BatteryService {
        id: batteryService
    }

    font.pixelSize: Config.fontSizeText
    anchors.verticalCenter: parent.verticalCenter

    //fixed width
    width: Config.barWidthUnit 
    horizontalAlignment: Text.AlignHCenter

    color: {
        if (batteryService.capacity <= 20) return Colors.red;
        if (batteryService.capacity <= 40) return Colors.orange;
        if (batteryService.capacity <= 60) return Colors.yellow
        if (batteryService.capacity <= 80) return Colors.green;
        return Colors.blue;
    }

    text: getBatteryIcon() + "  " + batteryService.capacity + "%"

    function getBatteryIcon() {
        if (batteryService.status === "Charging" || batteryService.status === "Full") {
            return "󰂄";
        }
        
        if (batteryService.capacity >= 90) return "󰁹";
        if (batteryService.capacity >= 80) return "󰂂";
        if (batteryService.capacity >= 70) return "󰂁";
        if (batteryService.capacity >= 60) return "󰂀";
        if (batteryService.capacity >= 50) return "󰁿";
        if (batteryService.capacity >= 40) return "󰁾";
        if (batteryService.capacity >= 30) return "󰁽";
        if (batteryService.capacity >= 20) return "󰁼";
        if (batteryService.capacity >= 10) return "󰁻";
        return "󰂎";
    }
}