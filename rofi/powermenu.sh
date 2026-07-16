#!/usr/bin/env bash

shutdown="  Shutdown"
reboot="  Reboot"
sleep="󰤄  Sleep"

options="$shutdown\n$reboot\n$sleep"

chosen="$(echo -e "$options" | rofi -dmenu \
    -i \
    -p "" \
    -theme-str 'window {width: 350px;} listview {lines: 3;}')"

case "$chosen" in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$sleep")
        systemctl suspend
        ;;
esac
