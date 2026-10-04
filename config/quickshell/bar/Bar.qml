import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        delegate: Component {
            Scope {
                id: screenRoot

                required property var modelData

                PanelWindow {
                    id: bar

                    screen: screenRoot.modelData

                    anchors {
                        top: true
                        left: true
                        right: true
                    }

                    implicitHeight: 34
                    color: "transparent"

                    Rectangle {
                        anchors.fill: parent
                        color: "#802b303b"

                        Workspace {
                            anchors {
                                left: parent.left
                                verticalCenter: parent.verticalCenter
                                leftMargin: 12
                            }

                            screen: bar.screen
                        }

                        Text {
                            anchors.centerIn: parent

                            text: Hyprland.activeToplevel
                                ? Hyprland.activeToplevel.title
                                : ""

                            color: "white"
                        }

                        Row {
                            anchors {
                                right: parent.right
                                verticalCenter: parent.verticalCenter
                            }

                            spacing: 12

                            ControlCenterButton {}
                            Clock {}
                            PowerButton {}
                        }
                    }
                }
            }        
        }
    }
}
