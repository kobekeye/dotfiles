#!/usr/bin/env bash

shutdown="󰐥  Shutdown"
reboot="󰜉  Reboot"

choice=$(printf "%s\n%s\n" "$shutdown" "$reboot" | \
    rofi \
        -dmenu \
        -theme "$HOME/.config/rofi/powermenu.rasi")

case "$choice" in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
esac
