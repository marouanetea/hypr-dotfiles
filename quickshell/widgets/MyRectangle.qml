
import QtQuick
import "../config" 


Rectangle{
    id:rectRoot
    Behavior on color { ColorAnimation {duration: Config.colorAnimDuration; easing.type: Config.colorAnimType }}
}