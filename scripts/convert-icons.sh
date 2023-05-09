#!/bin/bash

theme_names=("mocha" "macchiato" "frappe" "latte")
palette_names=("rosewater" "flamingo" "pink" "mauve" "red" "maroon" "peach" "yellow" "green" "teal" "sky" "sapphire" "blue" "lavender")

latte_accents=("dc8a78" "dd7878" "ea76cb" "8839ef" "d20f39" "e64553" "fe640b" "df8e1d" "40a02b" "179299" "04a5e5" "209fb5" "1e66f5" "7287fd")
frappe_accents=("f2d5cf" "eebebe" "f4b8e4" "ca9ee6" "e78284" "ea999c" "ef9f76" "e5c890" "a6d189" "81c8be" "99d1db" "85c1dc" "8caaee" "babbf1")
macchiato_accents=("f4dbd6" "f0c6c6" "f5bde6" "c6a0f6" "ed8796" "ee99a0" "f5a97f" "eed49f" "a6da95" "8bd5ca" "91d7e3" "7dc4e4" "8aadf4" "b7bdf8")
mocha_accents=("f5e0dc" "f2cdcd" "f5c2e7" "cba6f7" "f38ba8" "eba0ac" "fab387" "f9e2af" "a6e3a1" "94e2d5" "89dceb" "74c7ec" "89b4fa" "b4befe")
crusts=("11111b" "181926" "232634" "dce0e8")
texts=("cdd6f4" "cad3f5" "c6d0f5" "4c4f69")
overlay0s=("6c7086" "6e738d" "737994" "9ca0b0")

recolour () {
    IFS='\_' read -ra file_name_split <<< "${1::-4}"
    if [ ${#file_name_split[@]} = 2 ]; then
        file_name_split[1]="_${file_name_split[1]}"
    fi

    if [[ $3 == *"bar-mono"* ]]; then
        magick "$1" -alpha extract -background "$2" -alpha shape "../output/${file_name_split[0]}${3}${file_name_split[1]}.png"
    else
        magick "$1" -write MPR:orig -alpha extract \( +clone \) -compose multiply -composite MPR:orig +swap -compose copyopacity -composite -alpha extract -background "$2" -alpha shape "../output/${file_name_split[0]}${3}${file_name_split[1]}.png"
    fi
}

cd ./Catppuccin/Images/ControlsBase/MassConvert/
rm -r ../output
mkdir ../output

for theme_index in "${!theme_names[@]}"; do
    echo ${theme_names[$theme_index]}
    current_accents_name=${theme_names[$theme_index]}_accents
    declare -n current_theme_accents="$current_accents_name"

    for file in *; do
        recolour $file "#${crusts[$theme_index]}" "_theme-${theme_names[$theme_index]}_bar-mono" &

        for colour_index in "${!palette_names[@]}"; do
            recolour $file "#${current_theme_accents[$colour_index]}" "_theme-${theme_names[$theme_index]}_bar-unaccented_accent-${palette_names[$colour_index]}" &
        done
    done

    magick ../Background.png -alpha extract -background "#${crusts[$theme_index]}" -alpha shape "../output/Background_theme-${theme_names[$theme_index]}_bar-unaccented_accent-none.png"
    for colour_index in "${!palette_names[@]}"; do
        magick ../Background.png -alpha extract -background "#${current_theme_accents[$colour_index]}" -alpha shape "../output/Background_theme-${theme_names[$theme_index]}_bar-mono-accent-bar-${palette_names[$colour_index]}.png"
    done
done

mv ../output/* ../../Controls

cd ../../IconsBase/MassConvert/
rm -r ../output
mkdir ../output

for theme_index in "${!theme_names[@]}"; do
    echo ${theme_names[$theme_index]}
    current_accents_name=${theme_names[$theme_index]}_accents
    declare -n current_theme_accents="$current_accents_name"

    for file in *; do
        for colour_index in "${!palette_names[@]}"; do
            recolour $file "#${current_theme_accents[$colour_index]}" "_theme-${theme_names[$theme_index]}_accent-${palette_names[$colour_index]}"
        done
    done
done

cd ../MassConvertText

for theme_index in "${!theme_names[@]}"; do
    echo ${theme_names[$theme_index]}
    for file in *; do
        recolour $file "#${texts[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

cd ../MassConvertGray

for theme_index in "${!theme_names[@]}"; do
    echo ${theme_names[$theme_index]}
    for file in *; do
        recolour $file "#${overlay0s[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

mv ../output/* ../../Icons
