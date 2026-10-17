import QtQuick

ListView {
    id: root

    // Expose the model to the outside world
    property alias model: root.model

    // Visual configuration
    clip: true // Prevents items from rendering outside the container bounds

    // Custom highlight style when using arrow keys
    highlightMoveDuration: 100

    // Delegate defines what each application row looks like
    delegate: Rectangle {
        id: delegateItem
        width: root.width
        height: 48
        radius: 6

        // Dynamic background: highlighted via keyboard OR hovered via mouse
        color: {
            if (ListView.isCurrentItem) return "#313244";
            if (mouseArea.containsMouse) return "#252736";
            return "transparent";
        }

        Behavior on color { ColorAnimation { duration: 100 } }

        Row {
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            spacing: 12

            // App Icon Placeholder (You can swap this with an Image or Quickshell Icon if available)
            Rectangle {
                width: 28
                height: 28
                anchors.verticalCenter: parent.verticalCenter
                color: "#45475a"
                radius: 4

                Text {
                    anchors.centerIn: parent
                    text: model.name ? model.name.charAt(0).toUpperCase() : "?"
                    color: "#cdd6f4"
                    font.bold: true
                    font.pointSize: 10
                }
            }

            // App Name & Details
            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 2

                Text {
                    text: model.name ?? "Unknown App"
                    color: "#cdd6f4"
                    font.pointSize: 11
                    font.bold: true
                }

                Text {
                    text: model.comment ?? model.exec ?? ""
                    color: "#6c7086"
                    font.pointSize: 9
                    elide: Text.ElideRight
                    width: 280
                }
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                // Set this item as the active selection
                root.currentIndex = index;
                // Trigger your launch function here
                console.log("Launching: " + model.exec);
            }
        }
    }

    // Allow clicking empty space to clear focus or handle scrolling physics
    flickableDirection: Flickable.AutoFlickIfNeeded
}