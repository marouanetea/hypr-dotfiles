import QtQuick
import QtQuick.Layouts
import "../Services"
import "../config"
import "../widgets"

RowLayout {
    spacing: Config.itemSpacing
    property int dumSize : 100 //set this to whatever, it works as a hint for RowLayout
    //Battery
    StatDisplay {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: dumSize

        value: BatteryService.capacity
        icon: ["󰂎 ", "󰁻 ","󰁼 ","󰁽 ","󰁾 ","󰁿 ","󰂀 ","󰂁 ","󰂂 ","󰁹 "]
        state : (BatteryService.status === "Charging") ? "󰚥  " : "󰚦  "
        inverseColor : true
    }

    //CPU
    StatDisplay {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: dumSize

        icon: "   "
        value: CpuService.usage
    }

    //Temperature
    StatDisplay {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: dumSize

        value: TempService.temp
        icon: "󰔏 "
        unit: "°C"
    }

    //Ram
    StatDisplay {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: dumSize

        icon: "   "
        value: RamService.usagePercent
    }

    //network Down and up
    StatDisplay {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: dumSize*3

        color: Colors.window_fg
        text:   networkIcon()
                + "  󰇚 " + formatNetworkSpeed(NetworkService.downloadBytes) + formatNetworkUnit(NetworkService.downloadBytes)
                + "  󰕒 " + formatNetworkSpeed(NetworkService.uploadBytes) + formatNetworkUnit(NetworkService.uploadBytes)

        function networkIcon(){
            if (NetworkService.connectionType === "wifi") return "󰖩 ";
            if (NetworkService.connectionType === "ethernet") return "󰈀 ";
            return "󰖪 "; // Disconnected
        }
        function formatNetworkSpeed(bytes) {
        if (bytes < 1024) return (bytes).toFixed(0);
        if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(0);
        return (bytes / (1024 * 1024)).toFixed(1) ;
        }
        function formatNetworkUnit(bytes) {
            if (bytes < 1024) return " B/s";
            if (bytes < 1024 * 1024) return " KB/s";
            return " MB/s";
        }
    }
    
}