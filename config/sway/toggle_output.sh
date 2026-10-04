#!/bin/bash

# 取得目前焦點所在的螢幕名稱
FOCUSED=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')

# 判斷並把焦點切換到另一個螢幕
if [ "$FOCUSED" == "eDP-1" ]; then
    swaymsg focus output DP-2
else
    swaymsg focus output eDP-1
fi
