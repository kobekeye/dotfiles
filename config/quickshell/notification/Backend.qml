// notification/Backend.qml
pragma Singleton

import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    readonly property var notifications:
        server.trackedNotifications

    function initialize(): void {
        // 呼叫這個函式的目的，是讓 singleton 在啟動時被建立。
    }

    NotificationServer {
        id: server

        onNotification: notification => {
            notification.tracked = true;
        }
    }
}
