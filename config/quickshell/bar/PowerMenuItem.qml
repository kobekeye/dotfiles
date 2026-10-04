import QtQuick

Rectangle {
    id: root

    signal clicked()

    property string icon: ""
    property string text: ""

    implicitHeight: 38
    width: parent ? parent.width : 160

    radius: 8

    color: mouseArea.containsMouse
        ? "#20ffffff"
        : "transparent"

    Row {
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter

            leftMargin: 10
        }

        spacing: 12

        Text {
            width: 20

            text: root.icon

            color: "#c99052"

            font.pixelSize: 16
        }

        Text {
            text: root.text

            color: "#eeeae1"

            font.pixelSize: 14
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            root.clicked()
        }
    }
}
