#!/bin/bash

# TODO: get xdotool to direct key presses towards only correct window?

bar_states=("bar-mono" "bar-unaccented")
theme_names=("mocha" "macchiato" "frappe" "latte")
palette_names=("rosewater" "flamingo" "pink" "mauve" "red" "maroon" "peach" "yellow" "green" "teal" "sky" "sapphire" "blue" "lavender")

mocha_accents=("245,224,220" "242,205,205" "245,194,231" "203,166,247" "243,139,168" "235,160,172" "250,179,135" "249,226,175" "166,227,161" "148,226,213" "137,220,235" "116,199,236" "137,180,250" "180,190,254")
macchiato_accents=("244,219,214" "240,198,198" "245,189,230" "198,160,246" "237,135,150" "238,153,160" "245,169,127" "238,212,159" "166,218,149" "139,213,202" "145,215,227" "125,196,228" "138,173,244" "183,189,248")
frappe_accents=("242,213,207" "238,190,190" "244,184,228" "202,158,230" "231,130,132" "234,153,156" "239,159,118" "229,200,144" "166,209,137" "129,200,190" "153,209,219" "133,193,220" "140,170,238" "186,187,241")
latte_accents=("220,138,120" "221,120,120" "234,118,203" "136,57,239" "210,15,57" "230,69,83" "254,100,11" "223,142,29" "64,160,43" "23,146,153" "4,165,229" "32,159,181" "30,102,245" "114,135,253")

mocha_palette="
		CatppuccinBlack0=\"17,17,27\"
		CatppuccinBlack1=\"24,24,37\"
		CatppuccinBlack2=\"30,30,46\"
		CatppuccinBlack3=\"49,50,68\"
		CatppuccinBlack4=\"69,71,90\"

		CatppuccinGray0=\"88,91,112\"
		CatppuccinGray1=\"108,112,134\"
		CatppuccinGray2=\"127,132,156\"
		CatppuccinGray3=\"147,153,178\"

		CatppuccinGray4=\"166,173,200\"
		CatppuccinGray5=\"186,194,222\"

		CatppuccinForeground=\"205,214,244\"

		CatppuccinRosewater=\"245,224,220\"
		CatppuccinFlamingo=\"242,205,205\"
		CatppuccinPink=\"245,194,231\"
		CatppuccinMauve=\"203,166,247\"
		CatppuccinRed=\"243,139,168\"
		CatppuccinMaroon=\"235,160,172\"
		CatppuccinPeach=\"250,179,135\"
		CatppuccinYellow=\"249,226,175\"
		CatppuccinGreen=\"166,227,161\"
		CatppuccinTeal=\"148,226,213\"
		CatppuccinSky=\"137,220,235\"
		CatppuccinSapphire=\"116,199,236\"
		CatppuccinBlue=\"137,180,250\"
		CatppuccinLavender=\"180,190,254\"
"

macchiato_palette="
		CatppuccinBlack0=\"24,25,38\"
		CatppuccinBlack1=\"30,32,48\"
		CatppuccinBlack2=\"36,39,58\"
		CatppuccinBlack3=\"54,58,79\"
		CatppuccinBlack4=\"73,77,100\"

		CatppuccinGray0=\"91,96,120\"
		CatppuccinGray1=\"110,115,141\"
		CatppuccinGray2=\"128,135,162\"
		CatppuccinGray3=\"147,154,183\"

		CatppuccinGray4=\"165,173,203\"
		CatppuccinGray5=\"184,192,224\"

		CatppuccinForeground=\"202,211,245\"

		CatppuccinRosewater=\"244,219,214\"
		CatppuccinFlamingo=\"240,198,198\"
		CatppuccinPink=\"245,189,230\"
		CatppuccinMauve=\"198,160,246\"
		CatppuccinRed=\"237,135,150\"
		CatppuccinMaroon=\"238,153,160\"
		CatppuccinPeach=\"245,169,127\"
		CatppuccinYellow=\"238,212,159\"
		CatppuccinGreen=\"166,218,149\"
		CatppuccinTeal=\"139,213,202\"
		CatppuccinSky=\"145,215,227\"
		CatppuccinSapphire=\"125,196,228\"
		CatppuccinBlue=\"138,173,244\"
		CatppuccinLavender=\"183,189,248\"
"

frappe_palette="
		CatppuccinBlack0=\"35,38,52\"
		CatppuccinBlack1=\"41,44,60\"
		CatppuccinBlack2=\"48,52,70\"
		CatppuccinBlack3=\"65,69,89\"
		CatppuccinBlack4=\"81,87,109\"

		CatppuccinGray0=\"98,104,128\"
		CatppuccinGray1=\"115,121,148\"
		CatppuccinGray2=\"131,139,167\"
		CatppuccinGray3=\"148,156,187\"

		CatppuccinGray4=\"165,173,206\"
		CatppuccinGray5=\"181,191,226\"

		CatppuccinForeground=\"198,208,245\"

		CatppuccinRosewater=\"242,213,207\"
		CatppuccinFlamingo=\"238,190,190\"
		CatppuccinPink=\"244,184,228\"
		CatppuccinMauve=\"202,158,230\"
		CatppuccinRed=\"231,130,132\"
		CatppuccinMaroon=\"234,153,156\"
		CatppuccinPeach=\"239,159,118\"
		CatppuccinYellow=\"229,200,144\"
		CatppuccinGreen=\"166,209,137\"
		CatppuccinTeal=\"129,200,190\"
		CatppuccinSky=\"153,209,219\"
		CatppuccinSapphire=\"133,193,220\"
		CatppuccinBlue=\"140,170,238\"
		CatppuccinLavender=\"186,187,241\"
"

latte_palette="
		CatppuccinBlack0=\"220,224,232\"
		CatppuccinBlack1=\"230,233,239\"
		CatppuccinBlack2=\"239,241,245\"
		CatppuccinBlack3=\"204,208,218\"
		CatppuccinBlack4=\"188,192,204\"

		CatppuccinGray0=\"172,176,190\"
		CatppuccinGray1=\"156,160,176\"
		CatppuccinGray2=\"140,143,161\"
		CatppuccinGray3=\"124,127,147\"

		CatppuccinGray4=\"108,111,133\"
		CatppuccinGray5=\"92,95,119\"

		CatppuccinForeground=\"76,79,105\"

		CatppuccinRosewater=\"220,138,120\"
		CatppuccinFlamingo=\"221,120,120\"
		CatppuccinPink=\"234,118,203\"
		CatppuccinMauve=\"136,57,239\"
		CatppuccinRed=\"210,15,57\"
		CatppuccinMaroon=\"230,69,83\"
		CatppuccinPeach=\"254,100,11\"
		CatppuccinYellow=\"223,142,29\"
		CatppuccinGreen=\"64,160,43\"
		CatppuccinTeal=\"23,146,153\"
		CatppuccinSky=\"4,165,229\"
		CatppuccinSapphire=\"32,159,181\"
		CatppuccinBlue=\"30,102,245\"
		CatppuccinLavender=\"114,135,253\"
"

check_exit () {
    evtest --query /dev/input/by-id/usb-04d9_USB-HID_Keyboard-event-kbd EV_KEY 1

    if [ $? == 10 ]; then
        echo "Esc key down, exiting!"
        exit
    fi
}


cd ./Catppuccin/

WINEPREFIX=/home/autumn/.local/share/wineprefixes/MusicBee/ wine /home/autumn/Desktop/Projects/Catppuccin-MusicBee/Catppuccin/SkinCreator.exe &

sleep 1.5
xdotool key Enter
sleep 1

for i in {0..6}; do
    xdotool key Tab
done

for theme_index in {0..3}; do # 0..3
    current_accents_name=${theme_names[$theme_index]}_accents
    current_palette_name=${theme_names[$theme_index]}_palette
    declare -n current_theme_accents="$current_accents_name"
    declare -n current_palette="$current_palette_name"

    perl -p -i -e "s/\\\\\\\\ Palette placeholder/${current_palette}/g" ./catppuccin-base.xml

    for colour_index in {0..13}; do # 0..13
        check_exit

        sed -i "s/theme-palette-placeholder/theme-${theme_names[$theme_index]}/g"               ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
        sed -i "s/accent-placeholder/accent-${palette_names[$colour_index]}/g"                  ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
        sed -i "s/Accent=\"placeholder\"/Accent=\"${current_theme_accents[colour_index]}\"/g"   ./catppuccin-base.xml

        for bar_state in "${bar_states[@]}"; do
            check_exit

            if [ $bar_state = "bar-unaccented" ]; then
                bar_state_underscored="bar_unaccented"
                sed -i "s/bar-mono\./bar-unaccented_accent-${palette_names[$colour_index]}\./g" ./skin_wavebar.xml ./skin.xml ./skin.bak
                sed -i "s/bar-mono-accent-bar-placeholder/bar-unaccented_accent-none/g"         ./skin_wavebar.xml ./skin.xml ./skin.bak
                sed -i "s/\\\\\\\\ Bar text placeholder/MainPlayerText=\"CatppuccinForeground\"/g" ./catppuccin-base.xml
                sed -i "s/SpectrumOff=\"Accent\"/SpectrumOff=\"CatppuccinBlack1\"/g"            ./catppuccin-base.xml
                sed -i "s/SpectrumOn=\"CatppuccinBlack1\"/SpectrumOn=\"Accent\"/g"              ./catppuccin-base.xml
                sed -i "s/WaveBarOn=\"CatppuccinBlack1\"/WaveBarOn=\"Accent\"/g"                ./catppuccin-base.xml
                sed -i "s/WaveBarOff=\"Accent\"/WaveBarOff=\"CatppuccinBlack1\"/g"              ./catppuccin-base.xml
            else
                bar_state_underscored="bar_accented"
                sed -i "s/accent-bar-placeholder/accent-bar-${palette_names[$colour_index]}/g"  ./skin_wavebar.xml ./skin.xml ./skin.bak
                sed -i "s/\\\\\\\\ Bar text placeholder/MainPlayerText=\"CatppuccinBlack0\"/g"  ./catppuccin-base.xml
            fi

            xdotool key Enter
            xdotool key Tab
            xdotool key Enter

            xdotool keydown ctrl
            for i in {0..20}; do
                xdotool key Right
            done
            xdotool key shift+Left
            xdotool key shift+Left
            xdotool keyup ctrl

            xdotool type --delay 5 \\output\\catppuccin_${theme_names[$theme_index]}_${palette_names[$colour_index]}_${bar_state_underscored}.xmlc

            xdotool key Tab
            xdotool key Tab
            xdotool key Enter

            sleep 0.15
            xdotool key Shift+Tab

            if [ $bar_state = "bar-unaccented" ]; then
                sed -i "s/bar-unaccented_accent-none/bar-mono-accent-bar-placeholder/g"         ./skin_wavebar.xml ./skin.xml ./skin.bak
                sed -i "s/bar-unaccented_accent-${palette_names[$colour_index]}\./bar-mono\./g" ./skin_wavebar.xml ./skin.xml ./skin.bak
                sed -i "s/MainPlayerText=\"CatppuccinForeground\"/\\\\\\\\ Bar text placeholder/g" ./catppuccin-base.xml
                sed -i "s/SpectrumOn=\"Accent\"/SpectrumOn=\"CatppuccinBlack1\"/g"              ./catppuccin-base.xml
                sed -i "s/SpectrumOff=\"CatppuccinBlack1\"/SpectrumOff=\"Accent\"/g"            ./catppuccin-base.xml
                sed -i "s/WaveBarOff=\"CatppuccinBlack1\"/WaveBarOff=\"Accent\"/g"              ./catppuccin-base.xml
                sed -i "s/WaveBarOn=\"Accent\"/WaveBarOn=\"CatppuccinBlack1\"/g"                ./catppuccin-base.xml
            else
                sed -i "s/accent-bar-${palette_names[$colour_index]}/accent-bar-placeholder/g"  ./skin_wavebar.xml ./skin.xml ./skin.bak
                sed -i "s/MainPlayerText=\"CatppuccinBlack0\"/\\\\\\\\ Bar text placeholder/g"  ./catppuccin-base.xml
            fi

        done

        sed -i "s/theme-${theme_names[$theme_index]}/theme-palette-placeholder/g"               ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
        sed -i "s/accent-${palette_names[$colour_index]}/accent-placeholder/g"                  ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
        sed -i "s/Accent=\"${current_theme_accents[colour_index]}\"/Accent=\"placeholder\"/g"   ./catppuccin-base.xml
    done

    git checkout .

done

cd ..