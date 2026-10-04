
pragma Singleton

import Quickshell
import Quickshell.Bluetooth as QsBluetooth

Singleton {
    id: root

    readonly property var adapter:
        QsBluetooth.Bluetooth.defaultAdapter

    readonly property bool available:
        root.adapter !== null

    readonly property bool enabled:
        root.available && root.adapter.enabled

    readonly property bool discovering:
        root.available && root.adapter.discovering

    function togglePower(): void {
        if (root.adapter)
            root.adapter.enabled = !root.adapter.enabled;
    }

    function toggleDiscovery(): void {
        if (root.adapter && root.adapter.enabled)
            root.adapter.discovering =
                !root.adapter.discovering;
    }
}
