pragma Singleton

import QtQuick
import Quickshell.Io
import "../config"

QtObject {
    id: root

    property int temp: 0

    property Process tempProc: Process {
        running: true
        // Grabs the CPU core temperature from thermal zone files
        command: ["sh", "-c", "cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | head -n 1"]

        stdout: StdioCollector {
            onStreamFinished: {
                let output = this.text.trim();
                if (output !== "") {
                    let millidegrees = parseInt(output) || 0;
                    root.temp = Math.round(millidegrees / 1000);
                }
            }
        }
    }

    // Refresh temperature every 4 seconds
    property Timer pollTimer: Timer {
        interval: Config.timerInterval
        running: true
        repeat: true
        onTriggered: root.tempProc.running = true
    }
}