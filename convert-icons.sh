#!/bin/bash

icons="./Catppuccin/Images/Controls Base/*"

for i in $icons; do
    echo $i
    magick $i -alpha extract -background blue -alpha shape "${i::-4}_blue.png"
done