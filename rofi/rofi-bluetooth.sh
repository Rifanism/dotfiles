#!/usr/bin/env bash

# Cek status power bluetooth
power_status=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [[ "$power_status" == "yes" ]]; then
    toggle="󰂲  Turn Bluetooth Off"
    # Ambil daftar perangkat yang sudah berpasangan (paired)
    devices=$(bluetoothctl devices | awk '{print substr($0, index($0,$3))}')
    options="$toggle\n$devices"
else
    toggle="󰂯  Turn Bluetooth On"
    options="$toggle"
fi

# Panggil Rofi
chosen=$(echo -e "$options" | rofi -dmenu -i -p "" -theme-str 'window {width: 400px;} listview {lines: 5;}')

# Proses pilihan
if [[ "$chosen" == "󰂲  Turn Bluetooth Off" ]]; then
    bluetoothctl power off
elif [[ "$chosen" == "󰂯  Turn Bluetooth On" ]]; then
    bluetoothctl power on
elif [[ -n "$chosen" ]]; then
    # Cari MAC Address dari nama perangkat yang dipilih
    mac=$(bluetoothctl devices | grep "$chosen" | awk '{print $2}')
    if [[ -n "$mac" ]]; then
        # Cek apakah sedang terkoneksi
        info=$(bluetoothctl info "$mac" | grep "Connected:" | awk '{print $2}')
        if [[ "$info" == "yes" ]]; then
            bluetoothctl disconnect "$mac"
        else
            bluetoothctl connect "$mac"
        fi
    fi
fi
