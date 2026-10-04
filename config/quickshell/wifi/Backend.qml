pragma Singleton

import Quickshell
import Quickshell.Networking
import QtQml

Singleton {
    id: root

    readonly property var device: {
        const devices = Networking.devices.values;

        for (const device of devices) {
            if (device.type === DeviceType.Wifi)
                return device;
        }

        return null;
    }

    readonly property bool available: device !== null
    readonly property bool hardwareEnabled: Networking.wifiHardwareEnabled
    readonly property bool enabled:
        available && hardwareEnabled && Networking.wifiEnabled
    readonly property bool scanning:
        device !== null && device.scannerEnabled

    readonly property var connectedNetwork: {
        if (!device)
            return null;

        for (const network of device.networks.values) {
            if (network.connected)
                return network;
        }

        return null;
    }

    readonly property string statusText: {
        if (!available)
            return "Unavailable";
        if (!hardwareEnabled)
            return "Blocked";
        if (!Networking.wifiEnabled)
            return "Off";
        if (connectedNetwork)
            return connectedNetwork.name;

        return "Not connected";
    }

    property int scanRequestCount: 0

    function updateScanning(): void {
        if (!device)
            return;

        const shouldScan = scanRequestCount > 0 && enabled;

        if (device.scannerEnabled !== shouldScan)
            device.scannerEnabled = shouldScan;
    }

    function acquireScanner(): void {
        scanRequestCount += 1;
        updateScanning();
    }

    function releaseScanner(): void {
        scanRequestCount = Math.max(0, scanRequestCount - 1);
        updateScanning();
    }
    function toggle(): void {
        if (available && hardwareEnabled)
            Networking.wifiEnabled = !Networking.wifiEnabled;
    }

    function startScanning(): void {
        if (device && Networking.wifiEnabled)
            device.scannerEnabled = true;
    }

    function stopScanning(): void {
        if (device)
            device.scannerEnabled = false;
    }
}
