pragma Singleton

import QtQuick
import Quickshell.Io
import "../config"

QtObject {
    id: root

    // Assuming value ranges from 0 to 100
    function getHeatMapColor(val) {
        // Define your color stops (Position 0.0 to 1.0, and their corresponding colors)
        let stops = [
            { pos: 0.0, color: Colors.green }, 
            { pos: 0.33, color: Colors.yellow }, 
            { pos: 0.66, color: Colors.orange },
            { pos: 1.0, color: Colors.red }
        ];

        // Normalize value from 0-100 to 0.0-1.0 range
        let t = Math.max(0.0, Math.min(1.0, val / 100.0));

        // Find the lower and upper stops
        let lower = stops[0];
        let upper = stops[stops.length - 1];

        for (let i = 0; i < stops.length - 1; i++) {
            if (t >= stops[i].pos && t <= stops[i+1].pos) {
                lower = stops[i];
                upper = stops[i+1];
                break;
            }
        }

        // Calculate local progress between the two surrounding stops
        let range = upper.pos - lower.pos;
        let localT = range === 0 ? 0 : (t - lower.pos) / range;

        // Linear interpolate (lerp) RGBA channels
        let r = lower.color.r + (upper.color.r - lower.color.r) * localT;
        let g = lower.color.g + (upper.color.g - lower.color.g) * localT;
        let b = lower.color.b + (upper.color.b - lower.color.b) * localT;
        let a = lower.color.a + (upper.color.a - lower.color.a) * localT;

        return Qt.rgba(r, g, b, a);
    }
    
}