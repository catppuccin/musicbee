#!/usr/bin/env bash
set -euo pipefail

source ./scripts/palette.sh

recolour () {
    local input_file=$1
    local colour=$2
    local variant=$3
    local stem=${input_file%.png}
    local scale_suffix=""

    # If the icon is 150% scale or 200% scale, that bit needs to be at the end of the file name
    if [[ $stem =~ ^(.+)_(150|200)$ ]]; then
        stem=${BASH_REMATCH[1]}
        scale_suffix=_${BASH_REMATCH[2]}
    fi

    # If the icon is for an accented bar, or is the volume bar or the progress bar,
    if [[ $variant == *"bar-mono"* || $input_file == *"volumeslidebar"* || $input_file == *"ProgressBar"* ]]; then
        # Just recolour it
        magick "$input_file" -alpha extract -background "$colour" -alpha shape "../output/${stem}${variant}${scale_suffix}.png"
    else
        if [[ $variant == *"theme-latte"* ]]; then
            # For latte, increase the opacity of any transparent parts
            magick "$input_file" "$input_file" -compose dissolve -define compose:args='200,200' -composite -alpha extract -background "$colour" -alpha shape "../output/${stem}${variant}${scale_suffix}.png"
            magick "../output/${stem}${variant}${scale_suffix}.png" "../output/${stem}${variant}${scale_suffix}.png" -compose dissolve -define compose:args='200,200' -composite -alpha extract -background "$colour" -alpha shape "../output/${stem}${variant}${scale_suffix}.png"
        else
            # For the other 3, reduce the opacity of any transparent parts
            magick "$input_file" -write MPR:orig -alpha extract \( +clone \) -compose multiply -composite MPR:orig +swap -compose copyopacity -composite -alpha extract -background "$colour" -alpha shape "../output/${stem}${variant}${scale_suffix}.png"
        fi
    fi
}

cd ./Catppuccin/Images/

mkdir -p Controls Icons Window

cd ./ControlsBase/MassConvert/
rm -rf ../output
mkdir ../output

for theme_index in "${!theme_names[@]}"; do
    echo "${theme_names[$theme_index]}"
    current_accents_name=${theme_names[$theme_index]}_accents_hex
    declare -n current_theme_accents="$current_accents_name"

    for file in *; do
        # For unaccented bar
        recolour "$file" "#${crusts_hex[$theme_index]}" "_theme-${theme_names[$theme_index]}_bar-mono" &

        # For accented bar for each accent colour
        for colour_index in "${!palette_names[@]}"; do
            recolour "$file" "#${current_theme_accents[$colour_index]}" "_theme-${theme_names[$theme_index]}_bar-unaccented_accent-${palette_names[$colour_index]}" &
        done
    done

    # Unaccented bar
    magick ../Background.png -alpha extract -background "#${crusts_hex[$theme_index]}" -alpha shape "../output/Background_theme-${theme_names[$theme_index]}_bar-unaccented_accent-none.png"
    # Accented bar for each accent colour
    for colour_index in "${!palette_names[@]}"; do
        magick ../Background.png -alpha extract -background "#${current_theme_accents[$colour_index]}" -alpha shape "../output/Background_theme-${theme_names[$theme_index]}_bar-mono-accent-bar-${palette_names[$colour_index]}.png"
    done
done

wait

mv ../output/* ../../Controls
cd ../../


cd ./IconsBase/
cd ./MassConvert/
rm -rf ../output
mkdir ../output

for theme_index in "${!theme_names[@]}"; do
    echo "${theme_names[$theme_index]}"
    current_accents_name=${theme_names[$theme_index]}_accents_hex
    declare -n current_theme_accents="$current_accents_name"

    for file in *; do
        for colour_index in "${!palette_names[@]}"; do
            recolour "$file" "#${current_theme_accents[$colour_index]}" "_theme-${theme_names[$theme_index]}_accent-${palette_names[$colour_index]}"
        done
    done
done

cd ../
cd ./MassConvertText

for theme_index in "${!theme_names[@]}"; do
    echo "${theme_names[$theme_index]}"
    for file in *; do
        recolour "$file" "#${texts_hex[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

cd ../
cd ./MassConvertGray

for theme_index in "${!theme_names[@]}"; do
    echo "${theme_names[$theme_index]}"
    for file in *; do
        recolour "$file" "#${overlay0s_hex[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

mv ../output/* ../../Icons

cd ../../


cd ./WindowBase
cd ./MassConvertText

rm -rf ../output
mkdir ../output

for theme_index in "${!theme_names[@]}"; do
    echo "${theme_names[$theme_index]}"
    for file in *; do
        recolour "$file" "#${texts_hex[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

cd ../
cd ./MassConvertSurface0s

for theme_index in "${!theme_names[@]}"; do
    echo "${theme_names[$theme_index]}"
    for file in *; do
        recolour "$file" "#${surface0s_hex[$theme_index]}" "_theme-${theme_names[$theme_index]}"
    done
done

mv ../output/* ../../Window
