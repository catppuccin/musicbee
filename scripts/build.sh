#!/bin/env bash
set -e

export WINEPREFIX="$HOME/.local/share/wineprefixes/MusicBee/"
export DISPLAY=":42"
export WINEDEBUG=-all # don't print any debugging messages for wine

source ./scripts/palette.sh # also makes sure we're in the right directory

# clear any previous output
rm -r ./output
mkdir ./output

# create x11 virtual framebuffer
Xvfb $DISPLAY &
Xvfb_PID=$!

sleep 0.2

cd ./Catppuccin/
wine "./SkinCreator.exe" &
SkinCreator_PID=$!

# will first pop up an error saying "...Could not find file ..." - we can ignore this, we'll be updating the files to the right paths later
window_id=$(xdotool search --sync --all --onlyvisible --pid $SkinCreator_PID --name SkinCreator)
xdotool key --window "$window_id" Enter

# wait for window to appear and get its id
window_id=$(xdotool search --sync --all --onlyvisible --pid $SkinCreator_PID  --name Form1)

swap_in_theme_and_accent() {
	sed -i "s/theme-palette-placeholder/theme-${theme_names[$theme_index]}/g"               ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
	sed -i "s/accent-placeholder/accent-${palette_names[$colour_index]}/g"                  ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
	sed -i "s/Accent=\"placeholder\"/Accent=\"${current_theme_accents[colour_index]}\"/g"   ./catppuccin-base.xml
}

swap_out_theme_and_accent() {
	sed -i "s/theme-${theme_names[$theme_index]}/theme-palette-placeholder/g"               ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
	sed -i "s/accent-${palette_names[$colour_index]}/accent-placeholder/g"                  ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
	sed -i "s/Accent=\"${current_theme_accents[colour_index]}\"/Accent=\"placeholder\"/g"   ./catppuccin-base.xml
}

swap_in_bar_state() {
	if [ "$bar_state" = "bar-unaccented" ]; then
		sed -i "s/bar-mono\./bar-unaccented_accent-${palette_names[$colour_index]}\./g" ./skin_wavebar.xml ./skin.xml ./skin.bak
		sed -i "s/bar-mono-accent-bar-placeholder/bar-unaccented_accent-none/g"         ./skin_wavebar.xml ./skin.xml ./skin.bak
		sed -i "s/\\\\\\\\ Bar text placeholder/MainPlayerText=\"CatppuccinForeground\"/g" ./catppuccin-base.xml
		sed -i "s/SpectrumOff=\"Accent\"/SpectrumOff=\"CatppuccinBlack1\"/g"            ./catppuccin-base.xml
		sed -i "s/SpectrumOn=\"CatppuccinBlack1\"/SpectrumOn=\"Accent\"/g"              ./catppuccin-base.xml
		sed -i "s/WaveBarOn=\"CatppuccinBlack2\"/WaveBarOn=\"Accent\"/g"                ./catppuccin-base.xml
		sed -i "s/WaveBarOff=\"Accent\"/WaveBarOff=\"CatppuccinBlack2\"/g"              ./catppuccin-base.xml
		sed -i "s/StarRatingOn=\"CatppuccinForeground\"/StarRatingOn=\"Accent\"/g"      ./catppuccin-base.xml
	else
		sed -i "s/accent-bar-placeholder/accent-bar-${palette_names[$colour_index]}/g"  ./skin_wavebar.xml ./skin.xml ./skin.bak
		sed -i "s/\\\\\\\\ Bar text placeholder/MainPlayerText=\"CatppuccinBlack0\"/g"  ./catppuccin-base.xml
	fi
}

swap_out_bar_state() {
	if [ "$bar_state" = "bar-unaccented" ]; then
		sed -i "s/bar-unaccented_accent-none/bar-mono-accent-bar-placeholder/g"         ./skin_wavebar.xml ./skin.xml ./skin.bak
		sed -i "s/bar-unaccented_accent-${palette_names[$colour_index]}\./bar-mono\./g" ./skin_wavebar.xml ./skin.xml ./skin.bak
		sed -i "s/MainPlayerText=\"CatppuccinForeground\"/\\\\\\\\ Bar text placeholder/g" ./catppuccin-base.xml
		sed -i "s/SpectrumOn=\"Accent\"/SpectrumOn=\"CatppuccinBlack1\"/g"              ./catppuccin-base.xml
		sed -i "s/SpectrumOff=\"CatppuccinBlack1\"/SpectrumOff=\"Accent\"/g"            ./catppuccin-base.xml
		sed -i "s/WaveBarOff=\"CatppuccinBlack2\"/WaveBarOff=\"Accent\"/g"              ./catppuccin-base.xml
		sed -i "s/WaveBarOn=\"Accent\"/WaveBarOn=\"CatppuccinBlack2\"/g"                ./catppuccin-base.xml
		sed -i "s/StarRatingOn=\"Accent\"/StarRatingOn=\"CatppuccinForeground\"/g"      ./catppuccin-base.xml
	else
		sed -i "s/accent-bar-${palette_names[$colour_index]}/accent-bar-placeholder/g"  ./skin_wavebar.xml ./skin.xml ./skin.bak
		sed -i "s/MainPlayerText=\"CatppuccinBlack0\"/\\\\\\\\ Bar text placeholder/g"  ./catppuccin-base.xml
	fi
}

for theme_index in "${!theme_names[@]}"; do
	printf "%s:\n" "${theme_names[$theme_index]}"

	# yeah this is jank, bash was a mistake, but sunk cost fallacy
	current_accents_name=${theme_names[$theme_index]}_accents_rgb
	current_palette_name=${theme_names[$theme_index]}_palette
	declare -n current_theme_accents="$current_accents_name"
	declare -n current_palette="$current_palette_name"

	# swap in the current palette
	perl -p -i -e "s/\\\\\\\\ Palette placeholder/${current_palette}/g" ./catppuccin-base.xml

	for colour_index in "${!palette_names[@]}"; do
		printf "  %s\n" "${palette_names[$colour_index]}"
		swap_in_theme_and_accent

		for bar_state in "${bar_states[@]}"; do
			swap_in_bar_state

			sleep 0.5
			# reload and save
			xdotool key --window "$window_id" Control_L+r
			sleep 0.1
			xdotool key --window "$window_id" Control_L+s

			sleep 1

			# move the caret to the very end of the text box
			for i in {0..20}; do
				xdotool key --window "$window_id" Control_L+Right
			done

			sleep 0.5

			# select the name of the file and its parent folder so they can be retyped
			xdotool key --window "$window_id" Control_L+Shift_L+Left
			xdotool key --window "$window_id" Control_L+Shift_L+Left

			# using underscores so that the file name can be selected and replaced more easily
			bar_state_underscored=$(echo "$bar_state" | sed 's/-/_/g')

			xdotool type --delay 5 \\output\\catppuccin_"${theme_names[$theme_index]}"_"${palette_names[$colour_index]}"_"${bar_state_underscored}".xmlc
			#import -window root -quality 100 ../output/"${colour_index}"_"${theme_names[$theme_index]}"_"${palette_names[$colour_index]}"_"${bar_state_underscored}".jpg
			sleep 0.5

			# save
			xdotool key --window "$window_id" Enter

			sleep 0.5

			swap_out_bar_state
		done

		swap_out_theme_and_accent
	done

	# swap out the current palette
	perl -0777 -p -i -e "s/${current_palette}/\\\\\\\\ Palette placeholder/g" ./catppuccin-base.xml
done

sleep 5

kill $SkinCreator_PID
kill $Xvfb_PID
cd ..
