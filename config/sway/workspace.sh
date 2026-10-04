#!/bin/bash
TARGET=$1
ACTION=$2

# 取得目前所在的螢幕名稱
FOCUSED=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')

# 你的外接螢幕名稱
EXTERNAL="DP-2"

# 如果目前在外接螢幕，將目標數字加上 5 (1變6, 2變7...)
if [ "$FOCUSED" == "$EXTERNAL" ]; then
    TARGET=$((TARGET + 5))
fi

# 執行動作：切換工作區 或 移動視窗
if [ "$ACTION" == "move" ]; then
    swaymsg move container to workspace $TARGET
else
    swaymsg workspace $TARGET
fi
