import QtQuick
import Quickshell
import "../widgets"

MyCard{
    id: root

    Column{
        Input{
            id: searchInput
            width : 400
            height : 40
        }
        AppListView {
        id: appListView
        width: parent.width
        height: 480 // Fill remaining space roughly

        // Sample data model (Later, you can populate this by parsing desktop entries)
        model: ListModel {
            ListElement { name: "Terminal"; comment: "System terminal emulator"; exec: "kitty" }
            ListElement { name: "Files"; comment: "Manage files and folders"; exec: "nautilus" }
            ListElement { name: "Text Editor"; comment: "Edit text files"; exec: "vscodium" }
            ListElement { name: "Browser"; comment: "Web browser"; exec: "firefox" }
        }
    }
    }
}