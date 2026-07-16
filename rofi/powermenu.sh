#!/usr/bin/env bash

# Opsi pilihan menu dengan ikon Nerd Font
shutdown="  Shutdown"
reboot="  Reboot"
sleep="󰤄  Sleep"

# Gabungkan semua opsi
options="$shutdown\n$reboot\n$sleep"

# Panggil Rofi dengan layout minimalis dan horizontal
chosen="$(echo -e "$options" | rofi -dmenu \
    -i \
    -p "" \
    -theme-str 'window {width: 350px;} listview {lines: 3;}')"

# Eksekusi perintah berdasarkan pilihan
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
