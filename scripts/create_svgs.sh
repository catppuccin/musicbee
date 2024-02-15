#!/bin/env bash

source ./scripts/palette.sh # also makes sure we're in the right directory

files=("UnknownArtist" "NoArtwork")

cd ./Catppuccin/SVGs

rm -r ./output
mkdir ./output

svgs_to_pngs_unaccented () {
    rm -r ./output
    mkdir ./output

    for file in *; do
        if test -f $file; then
            echo $file
            for i in "${!theme_names[@]}"; do
                echo "${theme_names[i]}"
                current_palette_name=${theme_names[$i]}_accents_hex
                declare -n accents="$current_palette_name"

                sed -i "s/1e2030/${mantles_hex[i]}/g" "./$file"
                sed -i "s/494d64/${surface1s_hex[i]}/g" "./$file"
                sed -i "s/181926/${crusts_svgs_hex[i]}/g" "./$file"
                sed -i "s/a5adcb/${subtext0s_hex[i]}/g" "./$file"
                sed -i "s/cad3f5/${texts_hex[i]}/g" "./$file"
                sed -i "s/ed8796/${reds_hex[i]}/g" "./$file"

                IFS='\_' read -ra file_name_split <<< "${file::-4}"
                if [ ${#file_name_split[@]} = 2 ]; then
                    file_name_split[1]="_${file_name_split[1]}"
                fi
                inkscape "./$file" -o "./output/${file_name_split[0]}_theme-${theme_names[i]}${file_name_split[1]}.png"

                sed -i "s/${mantles_hex[i]}/1e2030/g" "./$file"
                sed -i "s/${surface1s_hex[i]}/494d64/g" "./$file"
                sed -i "s/${crusts_svgs_hex[i]}/181926/g" "./$file"
                sed -i "s/${subtext0s_hex[i]}/a5adcb/g" "./$file"
                sed -i "s/${texts_hex[i]}/cad3f5/g" "./$file"
                sed -i "s/${reds_hex[i]}/ed8796/g" "./$file"
            done
        fi
    done
}

for file in "${files[@]}"; do
    echo $file
    for i in "${!theme_names[@]}"; do
        echo ${theme_names[$i]}
        current_palette_name=${theme_names[$i]}_accents_hex
        declare -n accents="$current_palette_name"


        sed -i "s/1e2030/${mantles_hex[i]}/g" ./$file.svg
        sed -i "s/494d64/${surface1s_hex[i]}/g" ./$file.svg

        for j in "${!palette_names[@]}"; do
            sed -i "s/c6a0f6/${accents[j]}/g" ./$file.svg
            inkscape ./$file.svg -o ./output/${file}_theme-${theme_names[i]}_accent-${palette_names[j]}.png
            sed -i "s/${accents[j]}/c6a0f6/g" ./$file.svg
        done

        sed -i "s/${mantles_hex[i]}/1e2030/g" ./$file.svg
        sed -i "s/${surface1s_hex[i]}/494d64/g" ./$file.svg
    done
done

mv ./output/* ../Images/Others/

cd ./Controls/
svgs_to_pngs_unaccented
mv ./output/* ../../Images/Controls/

cd ../Window/
svgs_to_pngs_unaccented
mv ./output/* ../../Images/Window/
