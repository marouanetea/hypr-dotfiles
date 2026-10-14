pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "../config"

QtObject {
    id: root

    property int volume: 0
    property bool muted: false

    Component.onCompleted: updateAudio()

    function updateAudio() {
        if (!audioProc.running) {
            audioProc.running = true;
        }
    }

    function setVolume(val) {
        let newVal = Math.max(0, Math.min(val, 100));
        setProc.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", (newVal / 100).toFixed(2)];
        setProc.running = true;
    }

    function toggleMute() {
        muteProc.running = true;
    }

    function volumeUp() {
        setVolume(volume + Config.scrollUnitIncrement);
    }

    function volumeDown() {
        setVolume(volume - Config.scrollUnitIncrement);
    }

    // Passively listen for sound server events with zero polling overhead
    property Process subscribeProc : Process {
        command: ["pactl", "subscribe"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                // Whenever a sink changes (volume, mute, routing), update instantly
                if (data.includes("sink")) {
                    root.updateAudio();
                }
            }
        }
    }

    property Process audioProc : Process {
        id: audioProc
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        stdout: SplitParser {
            onRead: data => {
                let text = data.trim();
                root.muted = text.includes("[MUTED]");
                
                let match = text.match(/Volume:\s+([0-9.]+)/);
                if (match) {
                    root.volume = Math.round(parseFloat(match[1]) * 100);
                }
            }
        }
    }

    property Process setProc : Process {
        onExited: root.updateAudio()

    }

    property Process muteProc : Process {

        command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]
        onExited: root.updateAudio()
    }
}