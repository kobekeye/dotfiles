import Quickshell
import QtQuick

PopupWindow {
    id: root

    implicitWidth: 180
    implicitHeight: content.implicitHeight + 24

    color: "transparent"

    // 點其他地方時關閉
    grabFocus: true

    anchor {
        edges: Edges.Bottom | Edges.Right
        gravity: Edges.Bottom | Edges.Left

        margins {
            top: 6
        }
    }

    onVisibleChanged: {
        if (visible) {
            enterAnimation.restart()
        } else {
            enterAnimation.stop()
            menuSurface.opacity = 0
            menuSurface.scale = 0.96
        }
    }

    ParallelAnimation {
        id: enterAnimation

        NumberAnimation {
            target: menuSurface
            property: "opacity"
            from: 0
            to: 1
            duration: 180
            easing.type: Easing.OutCubic
        }

        NumberAnimation {
            target: menuSurface
            property: "scale"
            from: 0.96
            to: 1
            duration: 180
            easing.type: Easing.OutCubic
        }
    }

    Rectangle {
        anchors.fill: parent
        id: menuSurface
        opacity: 0
        scale: 0.96
        transformOrigin: Item.TopRight

        radius: 12
        color: "#e62c363d"

        border.width: 1
        border.color: "#18ffffff"

        Column {
            id: content

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                margins: 12
            }

            spacing: 4

            PowerMenuItem {
                icon: "󰤄"
                text: "Suspend"

                onClicked: {
                    root.visible = false
                    Quickshell.execDetached([
                        "systemctl",
                        "suspend"
                    ])
                }
            }

            PowerMenuItem {
                icon: "󰍃"
                text: "Logout"

                onClicked: {
                    root.visible = false
                    Quickshell.execDetached([
                        "hyprctl",
                        "dispatch",
                        "exit"
                    ])
                }
            }

            PowerMenuItem {
                icon: "󰜉"
                text: "Reboot"

                onClicked: {
                    root.visible = false
                    Quickshell.execDetached([
                        "systemctl",
                        "reboot"
                    ])
                }
            }

            PowerMenuItem {
                icon: ""
                text: "Shutdown"

                onClicked: {
                    root.visible = false
                    Quickshell.execDetached([
                        "systemctl",
                        "poweroff"
                    ])
                }
            }
        }
    }
}
