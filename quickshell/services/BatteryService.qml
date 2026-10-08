import QtQuick
import Quickshell.Io
import "../config"

QtObject {
    id: root

    property int capacity: 100
    property string status: "Discharging"

    property Process batteryProc: Process {
        running: true
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/capacity 2>/dev/null; cat /sys/class/power_supply/BAT*/status 2>/dev/null"]

        stdout: StdioCollector {
            onStreamFinished: {
                let output = this.text.trim();
                if (output !== "") {
                    let lines = output.split("\n");
                    if (lines.length >= 2) {
                        root.capacity = parseInt(lines[0]) || 100;
                        root.status = lines[1].trim();
                    }
                }
            }
        }
    }

    property Timer pollTimer: Timer {
        interval: config.timerInterval
        running: true
        repeat: true
        onTriggered: root.batteryProc.running = true
    }
}