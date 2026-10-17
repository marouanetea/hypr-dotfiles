import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../Services"
import "../config"
import "../widgets"

RowLayout {
    spacing: Config.itemSpacing
    property int mediumSize : 100 //set this to whatever, it works as a hint for RowLayout
    property int smallSize : 50
    property int bigSize: 150
    
    //Audio
    MyTextButton {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: mediumSize

        text:   (AudioService.muted ? "󰝟  " : "󰕾  ") + AudioService.volume + "%"
        //functionality
        onClicked: {AudioService.toggleMute();}
        onRightClicked : {AudioService.toggleMute();}
        onScrollUp : {AudioService.volumeUp();}
        onScrollDown : {AudioService.volumeDown();}
    }

    //Brightness
    MyTextButton {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: mediumSize

        text:   "󰃠  " + BrightnessService.brightness + "%"
        //functionality
        onScrollUp : { BrightnessService.brightnessUp();}
        onScrollDown : { BrightnessService.brightnessDown();}
    }

    //Keyboard Layout
    MyTextButton {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: mediumSize

        text:   KeyboardLayoutService.currentLayout
        //functionality
        onClicked: {KeyboardLayoutService.cycleLayout();}
        onRightClicked : {KeyboardLayoutService.cycleLayout();}
    }

    //blueTooth
    MyTextButton {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: smallSize

        text: " "
        //functionality
        property Process bluetoothProc : Process{
            command: ["sh", "-c", "overskride >/dev/null 2>&1 &"] 
            }
        onClicked: {bluetoothProc.running = true;}
        onRightClicked : {bluetoothProc.running = true;}
    }

    //Wifi
    MyTextButton {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: smallSize

        text: "󰖩 "
        //functionality
        property Process wifiProc : Process{
            command: ["setsid", "-f", "nmgui"]
            }
        onClicked: {wifiProc.running = true;}
        onRightClicked : {wifi.running = true;}
    }

    //Notification center aka SwayNC
    MyTextButton {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: smallSize

        text: "󰂚 "
        //functionality
        property Process swayncProc : Process{
            command: ["sh", "-c", "swaync-client -t -sw >/dev/null 2>&1 &"]
            }
        onClicked: {swayncProc.running = true;}
        onRightClicked : {swayncProc.running = true;}
    }

    //Clock:
    MyTextCard {
        id: clockCard
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredWidth: bigSize
        // Store the live date object
        property var dateTime: new Date()

        // Update interval: 1000ms for seconds, 60000ms for minutes only
        property Timer tickTimer : Timer {
            interval: Config.timerInterval
            running: true
            repeat: true
            onTriggered: clockCard.dateTime = new Date()
        }

        // Format using Qt's built-in formatting utilities
        text: Qt.formatTime(dateTime, "hh:mm") + "\n" +Qt.formatDate(dateTime, "dd MMM yyyy")
    }
}