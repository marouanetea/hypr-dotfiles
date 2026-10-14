pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import "../config"

QtObject {
    id: root
    property int brightness: {
        let  curr = parseInt(brightnessFile.text().trim()) || 0;
        let  max = parseInt(maxFile.text().trim()) || 100;
        return max > 0 ? Math.round((curr / max) * 100) : 0;
    }

    // Natively watch the active kernel backlight file
    property FileView brightnessFile : FileView{
        path: "/sys/class/backlight/intel_backlight/brightness"
        watchChanges: true
        onFileChanged: this.reload()
    }

    // Read the maximum possible brightness value once on load
    property FileView maxFile : FileView {
        path: "/sys/class/backlight/intel_backlight/max_brightness"
    }

    property Process setProc : Process {}

    function setBrightness(val) {
        let target = Math.max(1, Math.min(val, 100));
        setProc.command = ["brightnessctl", "set", target + "%"];
        setProc.running = true;
    }

    function brightnessUp(){
        setBrightness(brightness + Config.scrollUnitIncrement);
    }

    function brightnessDown(){
        setBrightness(brightness - Config.scrollUnitIncrement);
    }
}