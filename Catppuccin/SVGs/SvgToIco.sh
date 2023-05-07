#!/bin/bash

svg=$1
ico="${2:-icon.ico}"

# Resolutions to contain in the ico
size=(16 42 32 48 64 72 96 128)

# Create temp directory for outputting the PNGs to
mkdir -p tempPngs

str=""

# Generate the set of PNGs using inkscape
# I'd rather have used imagemagick for this too, since it's already being used later down,
# but it didn't seem to resize them - they were all 128x128
# I don't have the time or knowledge to debug this right now, but I might get back to it later
echo "Generating set of PNGs"

for i in ${size[@]}; do
    inkscape $svg -w $i -h $i -o ./tempPngs/$i.png
    str+="./tempPngs/$i.png "
done

# Create .ico from PNGs
echo "Creating .ico from PNGs at $ico"
magick convert $str $ico

# Remove the temp directory
echo "Removing temp directory"
rm -r ./tempPngs
