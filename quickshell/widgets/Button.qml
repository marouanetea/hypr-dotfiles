import QtQuick

Card {
    id: root

    // Custom signals and properties for button behavior
    signal clicked()

    property color normalColor: "#2e3440"
    property color hoverColor: "#3b4252"

    // Bind background color to mouse state
    color: mouseArea.containsMouse ? hoverColor : normalColor

    // Optional: change cursor to pointer on hover
    //cursorShape: Qt.PointingHandCursor
    rootChildren: [
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: root.clicked()
            }
    ]
}