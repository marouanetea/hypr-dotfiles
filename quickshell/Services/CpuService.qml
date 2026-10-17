pragma Singleton

import QtQuick
import Quickshell.Io
import "../config"

QtObject {
    id: root

    property int usage: 0

    property Process cpuProc: Process {
        running: true
        // Grabs two snapshots of /proc/stat separated by 0.3 seconds
        command: ["sh", "-c", "head -n 1 /proc/stat; sleep 0.3; head -n 1 /proc/stat"]

        stdout: StdioCollector {
            onStreamFinished: {
                let output = this.text.trim();
                let lines = output.split("\n");
                if (lines.length >= 2) {
                    let parseCpu = (line) => {
                        let parts = line.trim().split(/\s+/);
                        let user = parseFloat(parts[1]) || 0;
                        let nice = parseFloat(parts[2]) || 0;
                        let system = parseFloat(parts[3]) || 0;
                        let idle = parseFloat(parts[4]) || 0;
                        let iowait = parseFloat(parts[5]) || 0;
                        let irq = parseFloat(parts[6]) || 0;
                        let softirq = parseFloat(parts[7]) || 0;
                        let steal = parseFloat(parts[8]) || 0;
                        let total = user + nice + system + idle + iowait + irq + softirq + steal;
                        let active = user + nice + system + irq + softirq + steal;
                        return { active: active, total: total };
                    };

                    let c1 = parseCpu(lines[0]);
                    let c2 = parseCpu(lines[1]);

                    let activeDiff = c2.active - c1.active;
                    let totalDiff = c2.total - c1.total;

                    if (totalDiff > 0) {
                        root.usage = Math.round((activeDiff / totalDiff) * 100);
                    }
                }
            }
        }
    }

    // Refresh CPU usage every 3 seconds
    property Timer pollTimer: Timer {
        interval: Config.timerInterval
        running: true
        repeat: true
        onTriggered: root.cpuProc.running = true
    }
}