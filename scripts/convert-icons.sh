#!/bin/bash

currend_directory=${PWD##*/}
if [[ "${currend_directory,,}" != "catppuccin-musicbee" ]]; then
    echo "This should be run from the root directory of the repository! Exiting to avoid breaking things"
    exit
fi

theme_names=("mocha" "macchiato" "frappe" "latte")
palette_names=("rosewater" "flamingo" "pink" "mauve" "red" "maroon" "peach" "yellow" "green" "teal" "sky" "sapphire" "blue" "lavender")

latte_accents=("dc8a78" "dd7878" "ea76cb" "8839ef" "d20f39" "e64553" "fe640b" "df8e1d" "40a02b" "179299" "04a5e5" "209fb5" "1e66f5" "7287fd")
frappe_accents=("f2d5cf" "eebebe" "f4b8e4" "ca9ee6" "e78284" "ea999c" "ef9f76" "e5c890" "a6d189" "81c8be" "99d1db" "85c1dc" "8caaee" "babbf1")
macchiato_accents=("f4dbd6" "f0c6c6" "f5bde6" "c6a0f6" "ed8796" "ee99a0" "f5a97f" "eed49f" "a6da95" "8bd5ca" "91d7e3" "7dc4e4" "8aadf4" "b7bdf8")
mocha_accents=("f5e0dc" "f2cdcd" "f5c2e7" "cba6f7" "f38ba8" "eba0ac" "fab387" "f9e2af" "a6e3a1" "94e2d5" "89dceb" "74c7ec" "89b4fa" "b4befe")
crusts=("11111b" "181926" "232634" "dce0e8")
texts=("cdd6f4" "cad3f5" "c6d0f5" "4c4f69")
overlay0s=("6c7086" "6e738d" "737994" "9ca0b0")
surface0s=("313244" "363a4f" "414559" "ccd0da")

recolour () {
    # If the icon is 150% scale or 200% scale, that bit needs to be at the end of the file name
    IFS='\_' read -ra file_name_split <<< "${1::-4}"
    if [ ${#file_name_split[@]} = 2 ]; then
        file_name_split[1]="_${file_name_split[1]}"
    fi

    # If the icon is for an accented bar, or is the volume bar or the progress bar,
    if [[ "$3" == *"bar-mono"* || "$1" == *"volumeslidebar"* || "$1" == *"ProgressBar"* ]]; then
        # Just recolour it
        magick "$1" -alpha extract -background "$2" -alpha shape "../output/${file_name_split[0]}${3}${file_name_split[1]}.png"
    else
        if [[ $3 == *"theme-latte"* ]]; then
            # For latte, increase the opacity of any transparent parts
            magick "$1" "$1" -compose dissolve -define compose:args='200,200' -composite -alpha extract -background "$2" -alpha shape "../output/${file_name_split[0]}${3}${file_name_split[1]}.png"
            magick "../output/${file_name_split[0]}${3}${file_name_split[1]}.png" "../output/${file_name_split[0]}${3}${file_name_split[1]}.png" -compose dissolve -define compose:args='200,200' -composite -alpha extract -background "$2" -alpha shape "../output/${file_name_split[0]}${3}${file_name_split[1]}.png"
        else
            # For the other 3, reduce the opacity of any transparent parts
            magick "$1" -write MPR:orig -alpha extract \( +clone \) -compose multiply -composite MPR:orig +swap -compose copyopacity -composite -alpha extract -background "$2" -alpha shape "../output/${file_name_split[0]}${3}${file_name_split[1]}.png"
        fi
    fi
}

cd ./Catppuccin/Images/

cd ./ControlsBase/MassConvert/
rm -r ../output
mkdir ../output

for theme_index in "${!theme_names[@]}"; do
    echo ${theme_names[$theme_index]}
    current_accents_name=${theme_names[$theme_index]}_accents
    declare -n current_theme_accents="$current_accents_name"

    for file in *; do
        # For unaccented bar
        recolour $file "#${crusts[$theme_index]}" "_theme-${theme_names[$theme_index]}_bar-mono" &

        # For accented bar for each accent colour
        for colour_index in "${!palette_names[@]}"; do
            recolour $file "#${current_theme_accents[$colour_index]}" "_theme-${theme_names[$theme_index]}_bar-unaccented_accent-${palette_names[$colour_index]}" &
        done
    done

    # Unaccented bar
    magick ../Background.png -alpha extract -background "#${crusts[$theme_index]}" -alpha shape "../output/Background_theme-${theme_names[$theme_index]}_bar-unaccented_accent-none.png"
    # Accented bar for each accent colour
    for colour_index in "${!palette_names[@]}"; do
        magick ../Background.png -alpha extract -background "#${current_theme_accents[$colour_index]}" -alpha shape "../output/Background_theme-${theme_names[$theme_index]}_bar-mono-accent-bar-${palette_names[$colour_index]}.png"
    done
done

mv ../output/* ../../Controls
cd ../../


cd ./IconsBase/
cd ./MassConvert/
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

cd ../
cd ./MassConvertText

for theme_index in "${!theme_names[@]}"; do
    echo ${theme_names[$theme_index]}
    for file in *; do
        recolour $file "#${texts[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

cd ../
cd ./MassConvertGray

for theme_index in "${!theme_names[@]}"; do
    echo ${theme_names[$theme_index]}
    for file in *; do
        recolour $file "#${overlay0s[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

mv ../output/* ../../Icons

cd ../../


cd ./WindowBase
cd ./MassConvertText

rm -r ../output
mkdir ../output

for theme_index in "${!theme_names[@]}"; do
    echo ${theme_names[$theme_index]}
    for file in *; do
        recolour $file "#${texts[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

cd ../
cd ./MassConvertSurface0s

for theme_index in "${!theme_names[@]}"; do
    echo ${theme_names[$theme_index]}
    for file in *; do
        recolour $file "#${surface0s[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

mv ../output/* ../../Window
