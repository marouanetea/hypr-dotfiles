import QtQuick
import "../config"

Text {
    id: root

    font.pixelSize: Config.fontSizeText

    lineHeight: 0.7

    anchors.verticalCenter: parent.verticalCenter
    color: Colors.window_fg

    width: Config.barWidthUnit *1.2
    horizontalAlignment: Text.AlignHCenter

    // Store the live date object
    property var dateTime: new Date()

    // Update interval: 1000ms for seconds, 60000ms for minutes only
    Timer {
        interval: Config.timerInterval
        running: true
        repeat: true
        onTriggered: root.dateTime = new Date()
    }

    // Format using Qt's built-in formatting utilities
    text: Qt.formatTime(root.dateTime, "hh:mm") + "\n" +Qt.formatDate(root.dateTime, "dd MMM yyyy")
}