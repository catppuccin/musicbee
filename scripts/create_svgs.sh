#!/bin/bash

cd ./Catppuccin/SVGs

rm -r ./output
mkdir ./output

files=("UnknownArtist" "NoArtwork")
theme_names=("latte" "frappe" "macchiato" "mocha")
accent_names=("rosewater" "flamingo" "pink" "mauve" "red" "maroon" "peach" "yellow" "green" "teal" "sky" "sapphire" "blue" "lavender")

mantles=("e6e9ef" "292c3c" "1e2030" "181825")
surface1s=("bcc0cc" "51576d" "494d64" "45475a")

latte_accents=("dc8a78" "dd7878" "ea76cb" "8839ef" "d20f39" "e64553" "fe640b" "df8e1d" "40a02b" "179299" "04a5e5" "209fb5" "1e66f5" "7287fd")
frappe_accents=("f2d5cf" "eebebe" "f4b8e4" "ca9ee6" "e78284" "ea999c" "ef9f76" "e5c890" "a6d189" "81c8be" "99d1db" "85c1dc" "8caaee" "babbf1")
macchiato_accents=("f4dbd6" "f0c6c6" "f5bde6" "c6a0f6" "ed8796" "ee99a0" "f5a97f" "eed49f" "a6da95" "8bd5ca" "91d7e3" "7dc4e4" "8aadf4" "b7bdf8")
mocha_accents=("f5e0dc" "f2cdcd" "f5c2e7" "cba6f7" "f38ba8" "eba0ac" "fab387" "f9e2af" "a6e3a1" "94e2d5" "89dceb" "74c7ec" "89b4fa" "b4befe")

for file in "${files[@]}"; do
    echo $file
    for i in {0..3}; do
        echo ${theme_names[$i]}
        current_palette_name=${theme_names[$i]}_accents
        declare -n accents="$current_palette_name"


        sed -i "s/1e2030/${mantles[i]}/g" ./$file.svg
        sed -i "s/494d64/${surface1s[i]}/g" ./$file.svg

        for j in {0..13}; do
            sed -i "s/c6a0f6/${accents[j]}/g" ./$file.svg
            inkscape ./$file.svg -o ./output/${file}_theme-${theme_names[i]}_accent-${accent_names[j]}.png
            sed -i "s/${accents[j]}/c6a0f6/g" ./$file.svg
        done

        sed -i "s/${mantles[i]}/1e2030/g" ./$file.svg
        sed -i "s/${surface1s[i]}/494d64/g" ./$file.svg
    done
done

mv ./output/* ../Images/Others/
