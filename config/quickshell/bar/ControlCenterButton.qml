import Quickshell
import QtQuick
import qs.controlcenter as ControlCenter

Rectangle {
    id: root

    width: 70
    height: 19
    radius: 6

    color: mouseArea.containsMouse
        ? "#20ffffff"
        : "transparent"

    Text {
        anchors.centerIn: parent

        text: "Control"
        color: "white"

        font {
            family: "Geist"
            pixelSize: 14
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            controlCenter.visible = !controlCenter.visible
        }
    }

    ControlCenter.Panel {
        id: controlCenter

        anchor {
            item: root
            edges: Edges.Bottom | Edges.Right
            gravity: Edges.Bottom | Edges.Left

            rect {
                x: 0
                y: 6
                width: root.width
                height: root.height
            }
        }
    }
}
