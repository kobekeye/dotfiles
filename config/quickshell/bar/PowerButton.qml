import QtQuick

Rectangle {
    id: root

    signal clicked()

    implicitWidth: 20
    implicitHeight: 20
    radius: 6

    color: mouseArea.containsMouse
        ? "#20ffffff"
        : "transparent"

    Text {
        anchors.centerIn: parent

        text: ""
        color: "white"

        font.pixelSize: 14
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            powerMenu.visible = !powerMenu.visible
        }
    }

    PowerMenu {
        id: powerMenu

        anchor.item: root
    }
}
