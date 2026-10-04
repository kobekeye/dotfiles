import Quickshell
import QtQuick

Text {
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(clock.date, "MM/dd  hh:mm")
    color: "#eeeae1"
    font.family: "Geist"
    font.pixelSize: 14
}
