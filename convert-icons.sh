#!/bin/bash

theme_names=("mocha" "macchiato" "frappe" "latte")
palette_names=("rosewater" "flamingo" "pink" "mauve" "red" "maroon" "peach" "yellow" "green" "teal" "sky" "sapphire" "blue" "lavender")

mocha_accents=("245,224,220" "242,205,205" "245,194,231" "203,166,247" "243,139,168" "235,160,172" "250,179,135" "249,226,175" "166,227,161" "148,226,213" "137,220,235" "116,199,236" "137,180,250" "180,190,254")
macchiato_accents=("244,219,214" "240,198,198" "245,189,230" "198,160,246" "237,135,150" "238,153,160" "245,169,127" "238,212,159" "166,218,149" "139,213,202" "145,215,227" "125,196,228" "138,173,244" "183,189,248")
frappe_accents=("242,213,207" "238,190,190" "244,184,228" "202,158,230" "231,130,132" "234,153,156" "239,159,118" "229,200,144" "166,209,137" "129,200,190" "153,209,219" "133,193,220" "140,170,238" "186,187,241")
latte_accents=("220,138,120" "221,120,120" "234,118,203" "136,57,239" "210,15,57" "230,69,83" "254,100,11" "223,142,29" "64,160,43" "23,146,153" "4,165,229" "32,159,181" "30,102,245" "114,135,253")
crusts=("#11111b" "#181926" "#232634" "#dce0e8")

recolour () {
    IFS='\_' read -ra file_name_split <<< "${1::-4}"
    if [ ${#file_name_split[@]} = 2 ]; then
        file_name_split[1]="_${file_name_split[1]}"
    fi
    magick "$1" -alpha extract -background "$2" -alpha shape "../output/${file_name_split[0]}${3}${file_name_split[1]}.png"
}

cd ./Catppuccin/Images/ControlsBase/MassConvert/
rm -r ../output
mkdir ../output

for theme_index in "${!theme_names[@]}"; do
    current_accents_name=${theme_names[$theme_index]}_accents
    declare -n current_theme_accents="$current_accents_name"

    for file in *; do
        recolour $file "${crusts[$theme_index]}" "_theme-${theme_names[$theme_index]}_bar-mono" &

        for colour_index in "${!palette_names[@]}"; do
            recolour $file "rgb(${current_theme_accents[$colour_index]})" "_theme-${theme_names[$theme_index]}_bar-unaccented_accent-${palette_names[$colour_index]}" &
        done
    done

    magick ../Background.png -alpha extract -background "${crusts[$theme_index]}" -alpha shape "../output/Background_theme-${theme_names[$theme_index]}_bar-unaccented_accent-none.png"
    for colour_index in "${!palette_names[@]}"; do
        magick ../Background.png -alpha extract -background "rgb(${current_theme_accents[$colour_index]})" -alpha shape "../output/Background_theme-${theme_names[$theme_index]}_bar-mono-accent-bar-${palette_names[$colour_index]}.png"
    done
done

mv ../output/* ../../Controls