//@ pragma IconTheme Papirus

import QtQuick
import Quickshell
import "bar" // Import the bar directory so QML can see Bar.qml


ShellRoot {
    // Instantiate your modular bar
    id: root

    Scope {
        id: mainScope
        //TODO : replace with a loader later, with variants and such
        Bar {}

    }
    
    
    // Later, you can easily add other modular pieces here, e.g.:
    // AppLauncher {}
    // NotificationPopups {}
}