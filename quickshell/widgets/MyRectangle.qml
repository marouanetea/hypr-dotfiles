
import QtQuick
import "../config" 

// Overloads <Rectangle> to make all animations go here

Rectangle{
    id:rectRoot
    Behavior on color { ColorAnimation {duration: Config.colorAnimDuration; easing.type: Config.colorAnimType }}
}