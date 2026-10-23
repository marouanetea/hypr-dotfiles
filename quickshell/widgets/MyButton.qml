import QtQuick
import "../config"

MyCard {
    id: root

    // Custom signals for expanded mouse functionality
    signal clicked()
    signal rightClicked()
    signal scrollUp()
    signal scrollDown()
    signal mouseEntered()
    signal mouseExited()

    border.width: 0

    property color normalColor: "transparent"
    property color hoverColor: Colors.accent_bg_primary

    property color normalTextColor: Colors.window_fg
    property color hoverTextColor: Colors.accent_fg_primary

    property color normalBorderColor: Colors.window_fg
    property color hoverBorderColor: Colors.accent_fg_primary

    readonly property bool hovered : mouseArea.containsMouse

    // Bind colors to mouse state
    color: mouseArea.containsMouse ? hoverColor : normalColor
    border.color: mouseArea.containsMouse ? hoverBorderColor : normalBorderColor
    property color textColor: mouseArea.containsMouse ? hoverTextColor : normalTextColor

    // Padding
    horizontalPadding: Config.buttonPadding
    verticalPadding: Config.buttonPadding

    rootChildren: [
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            
            // Listen for both Left and Right mouse clicks
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: event => {
                if (event.button === Qt.RightButton) {
                    root.rightClicked();
                } else {
                    root.clicked();
                }
            }
            // Handle vertical scroll wheel movements
            onWheel: wheel => {
                if (wheel.angleDelta.y > 0) {
                    root.scrollUp();
                } else if (wheel.angleDelta.y < 0) {
                    root.scrollDown();
                }
            }
            onEntered: {
                root.mouseEntered();
            }

            onExited: {
                root.mouseExited();
            }
        }
    ]
}