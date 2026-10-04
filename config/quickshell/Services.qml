import Quickshell
import QtQml
import qs.notification as Notifications

Scope {
    Component.onCompleted:
        Notifications.Backend.initialize()
}
