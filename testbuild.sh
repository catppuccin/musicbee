#!/bin/bash

# TODO: get xdotool to direct key presses towards only correct window?

theme_names=("mocha" "macchiato" "frappe" "latte")
palette_names=("rosewater" "flamingo" "pink" "mauve" "red" "maroon" "peach" "yellow" "green" "teal" "sky" "sapphire" "blue" "lavender")

mocha_palettes=("245,224,220" "242,205,205" "245,194,231" "203,166,247" "243,139,168" "235,160,172" "250,179,135" "249,226,175" "166,227,161" "148,226,213" "137,220,235" "116,199,236" "137,180,250" "180,190,254")
macchiato_palettes=("244,219,214" "240,198,198" "245,189,230" "198,160,246" "237,135,150" "238,153,160" "245,169,127" "238,212,159" "166,218,149" "139,213,202" "145,215,227" "125,196,228" "138,173,244" "183,189,248")
frappe_palettes=("242,213,207" "238,190,190" "244,184,228" "202,158,230" "231,130,132" "234,153,156" "239,159,118" "229,200,144" "166,209,137" "129,200,190" "153,209,219" "133,193,220" "140,170,238" "186,187,241")
latte_palettes=("220,138,120" "221,120,120" "234,118,203" "136,57,239" "210,15,57" "230,69,83" "254,100,11" "223,142,29" "64,160,43" "23,146,153" "4,165,229" "32,159,181" "30,102,245" "114,135,253")

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
    current_pallete_name=${theme_names[$theme_index]}_palettes
    declare -n current_theme_palettes="$current_pallete_name"
    for colour_index in {0..13}; do
        check_exit

        sed -i "s/theme-palette-placeholder/theme-${theme_names[$theme_index]}/g"   ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
        sed -i "s/accent-placeholder/accent-${palette_names[$colour_index]}/g"      ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
        sed -i "s/Accent=\"placeholder\"/Accent=\"${current_theme_palettes[colour_index]}\"/g"   ./catppuccin-base.xml

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
        sed -i "s/Accent=\"${current_theme_palettes[colour_index]}\"/Accent=\"placeholder\"/g"   ./catppuccin-base.xml
    done
done

cd ..