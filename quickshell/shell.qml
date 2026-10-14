//@ pragma IconTheme Papirus

import QtQuick
import Quickshell
import Quickshell.Wayland
import "bar" // Import the bar directory so QML can see Bar.qml

ShellRoot {
    id: root

    // Variants iterates over connected screens/monitors automatically
    Variants {
        model: Quickshell.screens

        Scope {
            id: barScope
            required property var modelData // Represents the current screen

            // Pass the screen context to your bar if needed, 
            // or instantiate it directly per screen variant:
            Bar {
                screen: barScope.modelData // Uncomment if your Bar accepts a screen property
            }
        }
    }
}