#!/bin/bash

# 取得第一個螢幕目前的 dpms 狀態 (回傳 true 或 false)
STATE=$(swaymsg -t get_outputs | jq -r '.[0].dpms')

if [ "$STATE" = "true" ]; then
    # 如果螢幕是亮著的，就關閉螢幕
    swaymsg "output DP-2 dpms off"
else
    # 如果螢幕是暗的，就開啟螢幕
    swaymsg "output DP-2 dpms on"
    
    # 稍微暫停一下，等螢幕硬體真正亮起後再發出通知
    # (如果你的外接螢幕喚醒比較慢，可以把 0.5 改成 1 或 2)
    sleep 0.5 
    
    # 發送通知，顯示 3000 毫秒 (3秒)
    notify-send "系統提示" "螢幕正在開啟 🖥️" -t 3000
fi
