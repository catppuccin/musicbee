#!/bin/env bash

source ./scripts/palette.sh # also makes sure we're in the right directory

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
    current_accents_name=${theme_names[$theme_index]}_accents_hex
    declare -n current_theme_accents="$current_accents_name"

    for file in *; do
        # For unaccented bar
        recolour $file "#${crusts_hex[$theme_index]}" "_theme-${theme_names[$theme_index]}_bar-mono" &

        # For accented bar for each accent colour
        for colour_index in "${!palette_names[@]}"; do
            recolour $file "#${current_theme_accents[$colour_index]}" "_theme-${theme_names[$theme_index]}_bar-unaccented_accent-${palette_names[$colour_index]}" &
        done
    done

    # Unaccented bar
    magick ../Background.png -alpha extract -background "#${crusts_hex[$theme_index]}" -alpha shape "../output/Background_theme-${theme_names[$theme_index]}_bar-unaccented_accent-none.png"
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
    current_accents_name=${theme_names[$theme_index]}_accents_hex
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
        recolour $file "#${texts_hex[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

cd ../
cd ./MassConvertGray

for theme_index in "${!theme_names[@]}"; do
    echo ${theme_names[$theme_index]}
    for file in *; do
        recolour $file "#${overlay0s_hex[$theme_index]}" "_theme-${theme_names[$theme_index]}"
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
        recolour $file "#${texts_hex[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

cd ../
cd ./MassConvertSurface0s

for theme_index in "${!theme_names[@]}"; do
    echo ${theme_names[$theme_index]}
    for file in *; do
        recolour $file "#${surface0s_hex[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

mv ../output/* ../../Window
