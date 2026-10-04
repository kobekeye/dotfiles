import Quickshell
import QtQuick
import Quickshell.Hyprland

Row {
    id: root

    required property var screen

    readonly property var hyprMonitor:
        Hyprland.monitorFor(screen)

    spacing: 6

    Repeater {
        model: ScriptModel {
            values: Hyprland.workspaces.values.filter(
                workspace =>
                    workspace.id > 0
                    && workspace.monitor
                    && root.hyprMonitor
                    && workspace.monitor.id
                        === root.hyprMonitor.id
            )
        }

        delegate: Rectangle {
            required property HyprlandWorkspace modelData

            width: 33
            height: 30
            radius: 6

            color: "transparent"


            Text {
                anchors.centerIn: parent

                text: {
                    if (modelData.urgent)
                        return ""

                    if (modelData.active)
                        return ""

                    if (modelData.toplevels.values.length === 0)
                        return "󰫣"

                    return "󰫢"
                }

                font.pixelSize: 13

                color: modelData.focused
                    ? "#e09e58"
                    : "white"
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    modelData.activate()
                }
            }
        }
    }
}
