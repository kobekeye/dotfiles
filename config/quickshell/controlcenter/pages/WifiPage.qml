import QtQuick
import QtQml
import Quickshell.Networking
import qs.wifi as Wifi

Item {
    id: root

    signal backRequested()

    property bool scannerAcquired: false

    implicitHeight: pageContent.implicitHeight

    function syncScanner(): void {
        const shouldAcquire = visible;

        if (shouldAcquire === scannerAcquired)
            return;

        scannerAcquired = shouldAcquire;

        if (shouldAcquire)
            Wifi.Backend.acquireScanner();
        else
            Wifi.Backend.releaseScanner();
    }

    function emptyMessage(): string {
        if (!Wifi.Backend.available)
            return "No Wi-Fi device available.";

        if (!Wifi.Backend.hardwareEnabled)
            return "Wi-Fi is blocked by hardware.";

        if (!Wifi.Backend.enabled)
            return "Turn on Wi-Fi to search for networks.";

        if (Wifi.Backend.scanning)
            return "Searching for networks…";

        return "No networks found.";
    }

    onVisibleChanged: {
        syncScanner();
    }

    Component.onCompleted: {
        syncScanner();
    }

    Component.onDestruction: {
        if (scannerAcquired) {
            Wifi.Backend.releaseScanner();
            scannerAcquired = false;
        }
    }

    Column {
        id: pageContent

        width: parent.width
        spacing: 16

        Item {
            width: parent.width
            height: 28

            Rectangle {
                id: backButton

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }

                width: 28
                height: 28
                radius: 8

                color: backMouse.containsMouse
                    ? "#20ffffff"
                    : "transparent"

                Text {
                    anchors.centerIn: parent

                    text: "󰅁"
                    color: "#eeeae1"
                    font.pixelSize: 22
                }

                MouseArea {
                    id: backMouse

                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        root.backRequested();
                    }
                }
            }

            Text {
                anchors {
                    left: backButton.right
                    leftMargin: 10
                    verticalCenter: parent.verticalCenter
                }

                text: "Wi-Fi"
                color: "#eeeae1"

                font {
                    family: "Geist"
                    pixelSize: 17
                    weight: Font.Medium
                }
            }
        }

        Rectangle {
            width: parent.width
            height: 76
            radius: 12
            color: "#20ffffff"

            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    margins: 14
                }

                spacing: 5

                Text {
                    text: "Current status"
                    color: "#aaa9a4"

                    font {
                        family: "Geist"
                        pixelSize: 11
                    }
                }

                Text {
                    text: Wifi.Backend.statusText
                    color: "#eeeae1"

                    font {
                        family: "Geist"
                        pixelSize: 14
                        weight: Font.Medium
                    }
                }
            }
        }

        Text {
            width: parent.width

            text: "Available networks"
            color: "#aaa9a4"

            font {
                family: "Geist"
                pixelSize: 11
            }
        }

        ListView {
            id: networkList

            width: parent.width
            height: visible
                ? Math.min(contentHeight, 280)
                : 0

            visible:
                Wifi.Backend.enabled
                && count > 0

            model: Wifi.Backend.device
                ? Wifi.Backend.device.networks
                : null

            spacing: 8
            clip: true
            boundsBehavior: Flickable.StopAtBounds

            delegate: Rectangle {
                required property var modelData

                width: networkList.width
                height: 58
                radius: 12

                color: modelData.connected
                    ? "#35b99b80"
                    : "#18ffffff"

                border.width: modelData.connected ? 1 : 0
                border.color: "#70b99b80"

                Row {
                    anchors {
                        fill: parent
                        margins: 12
                    }

                    spacing: 10

                    Column {
                        anchors.verticalCenter: parent.verticalCenter

                        width: Math.max(
                            0,
                            parent.width
                                - networkState.implicitWidth
                                - parent.spacing
                        )

                        spacing: 4

                        Text {
                            width: parent.width

                            text: modelData.name || "Hidden network"
                            color: "#eeeae1"

                            elide: Text.ElideRight

                            font {
                                family: "Geist"
                                pixelSize: 13
                                weight: Font.Medium
                            }
                        }

                        Text {
                            width: parent.width

                            readonly property int strengthPercent:
                                Math.round(
                                    Math.max(
                                        0,
                                        Math.min(
                                            1,
                                            modelData.signalStrength
                                        )
                                    ) * 100
                                )

                            text:
                                strengthPercent
                                + "% · "
                                + (
                                    modelData.security
                                        === WifiSecurityType.Open
                                    ? "Open"
                                    : "Secured"
                                )

                            color: "#aaa9a4"
                            elide: Text.ElideRight

                            font {
                                family: "Geist"
                                pixelSize: 11
                            }
                        }
                    }

                    Text {
                        id: networkState

                        anchors.verticalCenter: parent.verticalCenter

                        text: {
                            if (modelData.connected)
                                return "Connected";

                            if (modelData.known)
                                return "Saved";

                            return "";
                        }

                        visible: text.length > 0
                        color: modelData.connected
                            ? "#eeeae1"
                            : "#aaa9a4"

                        font {
                            family: "Geist"
                            pixelSize: 11
                            weight: Font.Medium
                        }
                    }
                }
            }
        }

        Text {
            width: parent.width

            visible: !networkList.visible
            text: root.emptyMessage()

            color: "#aaa9a4"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap

            font {
                family: "Geist"
                pixelSize: 12
            }
        }
    }
}
