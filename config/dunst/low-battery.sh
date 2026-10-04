#!/usr/bin/env bash

battery="/sys/class/power_supply/BAT1"
threshold=20
interval=60
warned=false

# 避免腳本被重複啟動
exec 9>"${XDG_RUNTIME_DIR:-/tmp}/low-battery-monitor.lock"
flock -n 9 || exit 0

while true; do
    if [[ -r "$battery/capacity" && -r "$battery/status" ]]; then
        capacity=$(<"$battery/capacity")
        status=$(<"$battery/status")

        if [[ "$status" == "Discharging" ]] && (( capacity <= threshold )); then
            if [[ "$warned" == false ]]; then
                dunstify \
                    -a battery-warning \
                    -u critical \
                    -t 0 \
                    -r 99120 \
                    "電量過低" \
                    "目前剩餘 ${capacity}%，請接上電源。"

                warned=true
            fi
        else
            warned=false
        fi
    fi

    sleep "$interval"
done
