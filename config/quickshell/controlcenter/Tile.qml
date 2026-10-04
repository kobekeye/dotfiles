import QtQuick

Rectangle {
    id: root

    property string icon: ""
    property string title: ""
    property string subtitle: ""
    property bool active: false
    property bool showDetails: false

    signal clicked()
    signal detailsClicked()

    implicitWidth: 145
    implicitHeight: 45

    radius: 50
    opacity: enabled ? 1 : 0.45

    color: active
        ? "#b99b80"
        : "#30ffffff"

    Row {
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            right: detailsButton.visible
                ? detailsButton.left
                : parent.right

            margins: 12
        }

        spacing: 10

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: root.icon
            color: "white"
            font.pixelSize: 18
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            Text {
                text: root.title
                color: "white"
                font.pixelSize: 13
            }

            Text {
                text: root.subtitle
                color: "#eee2d9"
                font.pixelSize: 11
            }
        }
    }

    MouseArea {
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            right: detailsButton.visible
                ? detailsButton.left
                : parent.right
        }

        cursorShape: Qt.PointingHandCursor
        enabled: root.enabled

        onClicked: root.clicked()
    }

    Rectangle {
        id: detailsButton

        visible: root.showDetails

        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }

        width: 32

        topLeftRadius: 0
        bottomLeftRadius: 0
        topRightRadius: root.radius
        bottomRightRadius: root.radius

        color: detailsMouse.containsMouse
            ? Qt.rgba(0, 0, 0, 0.07)
            : "transparent"

        Behavior on color {
            ColorAnimation {
                duration: 120
            }
        }

        Text {
            anchors.centerIn: parent

            text: "󰅂"
            color: "white"
            font.pixelSize: 20
        }

        MouseArea {
            id: detailsMouse

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: root.detailsClicked()
        }
    }
}
