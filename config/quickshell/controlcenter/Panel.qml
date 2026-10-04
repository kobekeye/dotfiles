import Quickshell
import QtQuick
import qs.wifi as Wifi
import qs.bluetooth as Bluetooth
import "pages" as Pages

PopupWindow {
    id: root

    property string currentPage: "overview"
    implicitWidth: 340
    implicitHeight: content.implicitHeight + 32

    color: "transparent"
    // grabFocus: true

    Shortcut {
        sequence: "Escape"

        onActivated: {
            root.visible = false;
        }
    }
    onVisibleChanged: {
        if (!visible)
            currentPage = "overview";
    }

    Rectangle {
        anchors.fill: parent

        radius: 16
        color: "#d02c363d"

        border.width: 1
        border.color: "#18ffffff"

        Item {
            id: content

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 16
            }

            implicitHeight: overview.visible
                ? overview.implicitHeight
                : wifiPage.implicitHeight

            Column {
                id: overview

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                visible: root.currentPage === "overview"
                spacing: 16

                Text {
                    text: "Control Center"
                    color: "#eeeae1"

                    font {
                        family: "Geist"
                        pixelSize: 18
                        weight: Font.Medium
                    }
                }

                Row {
                    spacing: 10

                    Tile {
                        icon: ""
                        title: "Wi-Fi"

                        active: Wifi.Backend.enabled
                        subtitle: Wifi.Backend.statusText

                        enabled:
                            Wifi.Backend.available
                            && Wifi.Backend.hardwareEnabled

                        showDetails: Wifi.Backend.available

                        onClicked: {
                            Wifi.Backend.toggle();
                        }

                        onDetailsClicked: {
                            root.currentPage = "wifi";
                        }
                    }

                    Tile {
                        icon: "󰂯"
                        title: "Bluetooth"

                        active: Bluetooth.Backend.enabled
                        enabled: Bluetooth.Backend.available

                        subtitle: {
                            if (!Bluetooth.Backend.available)
                                return "Unavailable";

                            return Bluetooth.Backend.enabled
                                ? "On"
                                : "Off";
                        }

                        onClicked: {
                            Bluetooth.Backend.togglePower();
                        }
                    }
                }
            }

            Pages.WifiPage {
                id: wifiPage

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                visible: root.currentPage === "wifi"

                onBackRequested: {
                    root.currentPage = "overview";
                }
            }
        }
    }
}
