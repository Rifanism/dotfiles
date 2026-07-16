#!/usr/bin/env bash

wifi_list=$(nmcli --terse --fields SSID device wifi list | grep -v '^\s*$' | sort -u)

wifi_state=$(nmcli radio wifi)
if [[ "$wifi_state" =~ "enabled" ]]; then
    toggle="󰖪  Turn WiFi Off"
else
    toggle="󰖩  Turn WiFi On"
fi

options="$toggle\n$wifi_list"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "" -theme-str 'window {width: 400px;} listview {lines: 6;}')

if [[ "$chosen" == "󰖪  Turn WiFi Off" ]]; then
    nmcli radio wifi off
elif [[ "$chosen" == "󰖩  Turn WiFi On" ]]; then
    nmcli radio wifi on
elif [[ -n "$chosen" ]]; then
    if nmcli connection show | grep -Fw "$chosen" > /dev/null; then
        nmcli connection up id "$chosen"
    else
        password=$(rofi -dmenu -p "Password for $chosen:" -password -theme-str 'window {width: 400px;} listview {lines: 0;}')
        if [[ -n "$password" ]]; then
            nmcli device wifi connect "$chosen" password "$password"
        else
            nmcli device wifi connect "$chosen"
        fi
    fi
fi
