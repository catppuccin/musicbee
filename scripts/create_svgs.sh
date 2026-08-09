#!/usr/bin/env bash
set -euo pipefail

source ./scripts/palette.sh

repo_root=$PWD
images_dir="$repo_root/Catppuccin/Images"
svg_work_dir="$repo_root/.build/svgs"
accented_files=("UnknownArtist" "NoArtwork")

rm -rf "$svg_work_dir"
mkdir -p "$svg_work_dir"
cp -a Catppuccin/SVGs/. "$svg_work_dir/"
cd "$svg_work_dir"

render_unaccented_directory() {
    local destination=$1
    local file
    local i
    local stem
    local scale_suffix

    rm -rf output
    mkdir output

    for file in *.svg; do
        [[ -f "$file" ]] || continue
        echo "$file"
        cp "$file" "$file.source"

        for i in "${!theme_names[@]}"; do
            echo "${theme_names[i]}"
            cp "$file.source" "$file"
            sed -i "s/1e2030/${mantles_hex[i]}/g; s/494d64/${surface1s_hex[i]}/g; s/181926/${crusts_svgs_hex[i]}/g; s/a5adcb/${subtext0s_hex[i]}/g; s/cad3f5/${texts_hex[i]}/g; s/ed8796/${reds_hex[i]}/g" "$file"

            stem=${file%.svg}
            scale_suffix=""
            if [[ $stem =~ ^(.+)_(150|200)$ ]]; then
                stem=${BASH_REMATCH[1]}
                scale_suffix=_${BASH_REMATCH[2]}
            fi
            inkscape "$file" -o "output/${stem}_theme-${theme_names[i]}${scale_suffix}.png"
        done
        mv "$file.source" "$file"
    done

    mv output/* "$destination/"
}

rm -rf output
mkdir output
for file in "${accented_files[@]}"; do
    echo "$file"
    for i in "${!theme_names[@]}"; do
        echo "${theme_names[i]}"
        current_palette_name=${theme_names[i]}_accents_hex
        declare -n accents="$current_palette_name"

        sed -i "s/1e2030/${mantles_hex[i]}/g; s/494d64/${surface1s_hex[i]}/g" "$file.svg"
        for j in "${!palette_names[@]}"; do
            sed -i "s/c6a0f6/${accents[j]}/g" "$file.svg"
            inkscape "$file.svg" -o "output/${file}_theme-${theme_names[i]}_accent-${palette_names[j]}.png"
            sed -i "s/${accents[j]}/c6a0f6/g" "$file.svg"
        done
        sed -i "s/${mantles_hex[i]}/1e2030/g; s/${surface1s_hex[i]}/494d64/g" "$file.svg"
    done
done
mv output/* "$images_dir/Others/"

cd Controls
render_unaccented_directory "$images_dir/Controls"

cd ../Window
render_unaccented_directory "$images_dir/Window"
