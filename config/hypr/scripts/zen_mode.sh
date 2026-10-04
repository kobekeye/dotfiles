#!/bin/bash

# 定義一個狀態檔案的路徑，用來記錄是否處於禪模式
STATE_FILE="/tmp/hypr_zen_mode_active"

if [ ! -f "$STATE_FILE" ]; then
    # 【進入禪模式】
    # 建立狀態檔
    touch "$STATE_FILE"
    
    # 關閉間隙、邊框、陰影和模糊，但**保留動畫**
    hyprctl --batch "\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword decoration:rounding 0;\
        keyword general:border_size 0;\
        keyword misc:background_color \"0xffe6e6e6\";\
        keyword general:col.active_border rgba(666666ff);\
        keyword general:col.inactive_border rgba(222222ff)"
    
    # 隱藏 Waybar
    killall -SIGUSR1 waybar
else
    # 【退出禪模式】
    # 刪除狀態檔
    rm "$STATE_FILE"
    
    # 重新讀取 hyprland.conf 設定，恢復原本的樣貌
    hyprctl reload
    
    # 恢復顯示 Waybar
    killall -SIGUSR1 waybar
fi
