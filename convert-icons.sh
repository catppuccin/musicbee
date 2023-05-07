#!/bin/bash

bar_states=("bar-mono" "bar-unaccented")
theme_names=("mocha" "macchiato" "frappe" "latte")
palette_names=("rosewater" "flamingo" "pink" "mauve" "red" "maroon" "peach" "yellow" "green" "teal" "sky" "sapphire" "blue" "lavender")

mocha_accents=("245,224,220" "242,205,205" "245,194,231" "203,166,247" "243,139,168" "235,160,172" "250,179,135" "249,226,175" "166,227,161" "148,226,213" "137,220,235" "116,199,236" "137,180,250" "180,190,254")
macchiato_accents=("244,219,214" "240,198,198" "245,189,230" "198,160,246" "237,135,150" "238,153,160" "245,169,127" "238,212,159" "166,218,149" "139,213,202" "145,215,227" "125,196,228" "138,173,244" "183,189,248")
frappe_accents=("242,213,207" "238,190,190" "244,184,228" "202,158,230" "231,130,132" "234,153,156" "239,159,118" "229,200,144" "166,209,137" "129,200,190" "153,209,219" "133,193,220" "140,170,238" "186,187,241")
latte_accents=("220,138,120" "221,120,120" "234,118,203" "136,57,239" "210,15,57" "230,69,83" "254,100,11" "223,142,29" "64,160,43" "23,146,153" "4,165,229" "32,159,181" "30,102,245" "114,135,253")

cd ./Catppuccin/Images/ControlsBase/MassConvert/
rm -r ../output
mkdir ../output

for theme_index in "${!theme_names[@]}"; do
    current_accents_name=${theme_names[$theme_index]}_accents
    declare -n current_theme_accents="$current_accents_name"

    for colour_index in "${!palette_names[@]}"; do
        for file in *; do
            magick $file -alpha extract -background "rgb(${current_theme_accents[$colour_index]})" -alpha shape "../output/${file::-4}_theme-${theme_names[$theme_index]}_accent-${palette_names[$colour_index]}.png"
        done
    done
done