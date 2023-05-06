#!/bin/bash

theme_name='mocha'
theme_names=("mocha" "macchiato" "frappe" "latte")
palette_names=("rosewater" "flamingo" "pink" "mauve" "red" "maroon" "peach" "yellow" "green" "teal" "sky" "sapphire" "blue" "lavender")


check_exit () {
    evtest --query /dev/input/by-id/usb-04d9_USB-HID_Keyboard-event-kbd EV_KEY 1

    if [ $? == 10 ]; then
        echo "Esc key down, exiting!"
        exit
    fi
}


cd ./Catppuccin/

WINEPREFIX=/home/autumn/.local/share/wineprefixes/MusicBee/ wine /home/autumn/Desktop/Projects/Catppuccin-MusicBee/Catppuccin/SkinCreator.exe &

sleep 1.5
xdotool key Enter
sleep 1

for i in {0..6}; do
    xdotool key Tab
done

for theme_index in {0..3}; do
    for colour_index in {0..13}; do
        check_exit

        sed -i "s/theme-palette-placeholder/theme-${theme_names[$theme_index]}/g"   ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
        sed -i "s/accent-placeholder/accent-${palette_names[$colour_index]}/g"      ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak

        xdotool key Enter
        xdotool key Tab
        xdotool key Enter

        xdotool keydown ctrl
        for i in {0..20}; do
            xdotool key Right
        done
        xdotool key shift+Left
        xdotool key shift+Left
        xdotool keyup ctrl

        xdotool type --delay 5 \\output\\catppuccin_${theme_names[$theme_index]}_${palette_names[$colour_index]}.xmlc

        xdotool key Tab
        xdotool key Tab
        xdotool key Enter

        sleep 0.1
        xdotool key Shift+Tab

        sed -i "s/theme-${theme_names[$theme_index]}/theme-palette-placeholder/g"   ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
        sed -i "s/accent-${palette_names[$colour_index]}/accent-placeholder/g"      ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
    done
done

cd ..