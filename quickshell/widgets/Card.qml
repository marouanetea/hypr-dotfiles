import QtQuick
import "../config" 

MyRectangle {

    id: root

    color: Colors.window_bg
    border.color: Colors.accent
    border.width: 0

    property int radiusTopLeft: Config.defaultRadius
    property int radiusTopRight: Config.defaultRadius
    property int radiusBottomLeft: Config.defaultRadius
    property int radiusBottomRight: Config.defaultRadius

    topLeftRadius: root.radiusTopLeft
    topRightRadius: root.radiusTopRight
    bottomLeftRadius: root.radiusBottomLeft
    bottomRightRadius: root.radiusBottomRight

    property int horizontalPadding: Config.cardPadding
    property int verticalPadding: Config.cardPadding

    // Dynamic sizing based on the children inside the content container
    implicitWidth: contentLayout.implicitWidth + (horizontalPadding * 2)
    implicitHeight: contentLayout.implicitHeight + (verticalPadding * 2)

    default property alias content: contentLayout.data
    property alias rootChildren: root.data

    // Use a standard Item so children can be positioned freely (Rows, Columns,anchors, etc.)
    Item {
        id: contentLayout
        
        // Position the content layout with padding offsets
        x: root.horizontalPadding
        y: root.verticalPadding

        // Dynamically compute implicit width and height based on all child items
        implicitWidth: {
            let maxW = 0
            for (let i = 0; i < children.length; i++) {
                let child = children[i]
                let rightEdge = child.x + (child.width > 0 ? child.width : child.implicitWidth)
                if (rightEdge > maxW) maxW = rightEdge
            }
            return maxW
        }

        implicitHeight: {
            let maxH = 0
            for (let i = 0; i < children.length; i++) {
                let child = children[i]
                let bottomEdge = child.y + (child.height > 0 ? child.height : child.implicitHeight)
                if (bottomEdge > maxH) maxH = bottomEdge
            }
            return maxH
        }
    }
}