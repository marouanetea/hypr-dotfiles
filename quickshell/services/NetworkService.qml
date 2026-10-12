import QtQuick
import Quickshell.Io
import "../config"

QtObject {
    id: root

    property string connectionType: "disconnected"
    property real downloadBytes: 0
    property real uploadBytes: 0

    property real _lastRx: 0
    property real _lastTx: 0
    property real _lastTime: 0

    property Process netProc: Process {
        running: true
        command: ["sh", "-c", "
            iface=$(ip route | awk '/default/ {print $5; exit}')
            if [ -z \"$iface\" ]; then
                iface=$(ls /sys/class/net/ | grep -E '^wl|^en|^eth' | head -n1)
            fi
            
            if [ -z \"$iface\" ] || [ ! -f /proc/net/dev ]; then
                echo 'disconnected 0 0'
                exit 0
            fi

            if echo \"$iface\" | grep -q '^wl'; then
                type='wifi'
            else
                type='ethernet'
            fi

            # Changed variable name from 'if' to 'netif' to avoid awk keyword collision
            stats=$(awk -v netif=\"$iface:\" '$1==netif {print $2, $10}' /proc/net/dev)
            if [ -z \"$stats\" ]; then
                echo 'disconnected 0 0'
            else
                read rx tx <<< \"$stats\"
                echo \"$type ${rx:-0} ${tx:-0}\"
            fi
        "]

        stdout: StdioCollector {
            onStreamFinished: {
                let output = this.text.trim();
                let parts = output.split(/\s+/);
                if (parts.length >= 3) {
                    let type = parts[0];
                    let currentRx = parseFloat(parts[1]) || 0;
                    let currentTx = parseFloat(parts[2]) || 0;
                    let currentTime = Date.now();

                    root.connectionType = type;

                    if (root._lastTime > 0) {
                        let elapsed = (currentTime - root._lastTime) / 1000.0;
                        if (elapsed > 0 && currentRx >= root._lastRx && currentTx >= root._lastTx) {
                            root.downloadBytes = (currentRx - root._lastRx) / elapsed;
                            root.uploadBytes = (currentTx - root._lastTx) / elapsed;
                        }
                    }

                    root._lastRx = currentRx;
                    root._lastTx = currentTx;
                    root._lastTime = currentTime;
                }
            }
        }
    }

    property Timer pollTimer: Timer {
        interval: Config.timerInterval
        running: true
        repeat: true
        onTriggered: root.netProc.running = true
    }
}