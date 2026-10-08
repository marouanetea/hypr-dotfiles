import QtQuick
import Quickshell.Io
import "../config"

QtObject {
    id: root

    property int usagePercent: 0
    property string usedGb: "0.0"
    property string totalGb: "0.0"

    property Process ramProc: Process {
        running: true
        // Grabs MemTotal and MemAvailable in kilobytes from /proc/meminfo
        command: ["sh", "-c", "awk '/MemTotal/ {total=$2} /MemAvailable/ {avail=$2} END {print total, avail}' /proc/meminfo"]

        stdout: StdioCollector {
            onStreamFinished: {
                let output = this.text.trim();
                let parts = output.split(/\s+/);
                if (parts.length >= 2) {
                    let totalKb = parseFloat(parts[0]) || 1;
                    let availKb = parseFloat(parts[1]) || 0;
                    let usedKb = totalKb - availKb;

                    root.usagePercent = Math.round((usedKb / totalKb) * 100);
                    root.usedGb = (usedKb / (1024 * 1024)).toFixed(1);
                    root.totalGb = (totalKb / (1024 * 1024)).toFixed(1);
                }
            }
        }
    }

    // Refresh RAM usage every 3 seconds
    property Timer pollTimer: Timer {
        interval: Config.timerInterval
        running: true
        repeat: true
        onTriggered: root.ramProc.running = true
    }
}