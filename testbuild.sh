#!/bin/bash

# TODO: get xdotool to direct key presses towards only correct window?

theme_names=("mocha" "macchiato" "frappe" "latte")
palette_names=("rosewater" "flamingo" "pink" "mauve" "red" "maroon" "peach" "yellow" "green" "teal" "sky" "sapphire" "blue" "lavender")

mocha_accents=("245,224,220" "242,205,205" "245,194,231" "203,166,247" "243,139,168" "235,160,172" "250,179,135" "249,226,175" "166,227,161" "148,226,213" "137,220,235" "116,199,236" "137,180,250" "180,190,254")
macchiato_accents=("244,219,214" "240,198,198" "245,189,230" "198,160,246" "237,135,150" "238,153,160" "245,169,127" "238,212,159" "166,218,149" "139,213,202" "145,215,227" "125,196,228" "138,173,244" "183,189,248")
frappe_accents=("242,213,207" "238,190,190" "244,184,228" "202,158,230" "231,130,132" "234,153,156" "239,159,118" "229,200,144" "166,209,137" "129,200,190" "153,209,219" "133,193,220" "140,170,238" "186,187,241")
latte_accents=("220,138,120" "221,120,120" "234,118,203" "136,57,239" "210,15,57" "230,69,83" "254,100,11" "223,142,29" "64,160,43" "23,146,153" "4,165,229" "32,159,181" "30,102,245" "114,135,253")

mocha_palette="
		\\\\ Crust
		CatppuccinBlack0=\"17,17,27\"
		\\\\ Mantle
		CatppuccinBlack1=\"24,24,37\"
		\\\\ Base
		CatppuccinBlack2=\"30,30,46\"
		\\\\ Surface 0
		CatppuccinBlack3=\"49,50,68\"
		\\\\ Surface 1
		CatppuccinBlack4=\"69,71,90\"

		\\\\ Surface 2
		CatppuccinGray0=\"88,91,112\"
		\\\\ Overlay 0
		CatppuccinGray1=\"108,112,134\"
		\\\\ Overlay 1
		CatppuccinGray2=\"127,132,156\"
		\\\\ Overlay 2
		CatppuccinGray3=\"147,153,178\"

		\\\\ Subtext 0
		CatppuccinGray4=\"166,173,200\"
		\\\\ Subtext 1
		CatppuccinGray5=\"186,194,222\"

		\\\\ Text
		CatppuccinForeground=\"205,214,244\"

		\\\\ Rosewater
		CatppuccinRosewater=\"245,224,220\"
		\\\\ Flamingo
		CatppuccinFlamingo=\"242,205,205\"
		\\\\ Pink
		CatppuccinPink=\"245,194,231\"
		\\\\ Mauve
		CatppuccinMauve=\"203,166,247\"
		\\\\ Red
		CatppuccinRed=\"243,139,168\"
		\\\\ Maroon
		CatppuccinMaroon=\"235,160,172\"
		\\\\ Peach
		CatppuccinPeach=\"250,179,135\"
		\\\\ Yellow
		CatppuccinYellow=\"249,226,175\"
		\\\\ Green
		CatppuccinGreen=\"166,227,161\"
		\\\\ Teal
		CatppuccinTeal=\"148,226,213\"
		\\\\ Sky
		CatppuccinSky=\"137,220,235\"
		\\\\ Sapphire
		CatppuccinSapphire=\"116,199,236\"
		\\\\ Blue
		CatppuccinBlue=\"137,180,250\"
		\\\\ Lavender
		CatppuccinLavender=\"180,190,254\"

		\\\\ Accent theme
		\\\\ Note: For this to be fully applied, some images have to be manually updated
"

macchiato_palette="
		\\\\ Crust
		CatppuccinBlack0=\"24,25,38\"
		\\\\ Mantle
		CatppuccinBlack1=\"30,32,48\"
		\\\\ Base
		CatppuccinBlack2=\"36,39,58\"
		\\\\ Surface 0
		CatppuccinBlack3=\"54,58,79\"
		\\\\ Surface 1
		CatppuccinBlack4=\"73,77,100\"

		\\\\ Surface 2
		CatppuccinGray0=\"91,96,120\"
		\\\\ Overlay 0
		CatppuccinGray1=\"110,115,141\"
		\\\\ Overlay 1
		CatppuccinGray2=\"128,135,162\"
		\\\\ Overlay 2
		CatppuccinGray3=\"147,154,183\"

		\\\\ Subtext 0
		CatppuccinGray4=\"165,173,203\"
		\\\\ Subtext 1
		CatppuccinGray5=\"184,192,224\"

		\\\\ Text
		CatppuccinForeground=\"202,211,245\"

		\\\\ Rosewater
		CatppuccinRosewater=\"244,219,214\"
		\\\\ Flamingo
		CatppuccinFlamingo=\"240,198,198\"
		\\\\ Pink
		CatppuccinPink=\"245,189,230\"
		\\\\ Mauve
		CatppuccinMauve=\"198,160,246\"
		\\\\ Red
		CatppuccinRed=\"237,135,150\"
		\\\\ Maroon
		CatppuccinMaroon=\"238,153,160\"
		\\\\ Peach
		CatppuccinPeach=\"245,169,127\"
		\\\\ Yellow
		CatppuccinYellow=\"238,212,159\"
		\\\\ Green
		CatppuccinGreen=\"166,218,149\"
		\\\\ Teal
		CatppuccinTeal=\"139,213,202\"
		\\\\ Sky
		CatppuccinSky=\"145,215,227\"
		\\\\ Sapphire
		CatppuccinSapphire=\"125,196,228\"
		\\\\ Blue
		CatppuccinBlue=\"138,173,244\"
		\\\\ Lavender
		CatppuccinLavender=\"183,189,248\"

		\\\\ Accent theme
		\\\\ Note: For this to be fully applied, some images have to be manually updated
"

frappe_palette="
		\\\\ Crust
		CatppuccinBlack0=\"35,38,52\"
		\\\\ Mantle
		CatppuccinBlack1=\"41,44,60\"
		\\\\ Base
		CatppuccinBlack2=\"48,52,70\"
		\\\\ Surface 0
		CatppuccinBlack3=\"65,69,89\"
		\\\\ Surface 1
		CatppuccinBlack4=\"81,87,109\"

		\\\\ Surface 2
		CatppuccinGray0=\"98,104,128\"
		\\\\ Overlay 0
		CatppuccinGray1=\"115,121,148\"
		\\\\ Overlay 1
		CatppuccinGray2=\"131,139,167\"
		\\\\ Overlay 2
		CatppuccinGray3=\"148,156,187\"

		\\\\ Subtext 0
		CatppuccinGray4=\"165,173,206\"
		\\\\ Subtext 1
		CatppuccinGray5=\"181,191,226\"

		\\\\ Text
		CatppuccinForeground=\"198,208,245\"

		\\\\ Rosewater
		CatppuccinRosewater=\"242,213,207\"
		\\\\ Flamingo
		CatppuccinFlamingo=\"238,190,190\"
		\\\\ Pink
		CatppuccinPink=\"244,184,228\"
		\\\\ Mauve
		CatppuccinMauve=\"202,158,230\"
		\\\\ Red
		CatppuccinRed=\"231,130,132\"
		\\\\ Maroon
		CatppuccinMaroon=\"234,153,156\"
		\\\\ Peach
		CatppuccinPeach=\"239,159,118\"
		\\\\ Yellow
		CatppuccinYellow=\"229,200,144\"
		\\\\ Green
		CatppuccinGreen=\"166,209,137\"
		\\\\ Teal
		CatppuccinTeal=\"129,200,190\"
		\\\\ Sky
		CatppuccinSky=\"153,209,219\"
		\\\\ Sapphire
		CatppuccinSapphire=\"133,193,220\"
		\\\\ Blue
		CatppuccinBlue=\"140,170,238\"
		\\\\ Lavender
		CatppuccinLavender=\"186,187,241\"

		\\\\ Accent theme (Currently mauve)
		\\\\ Note: For this to be fully applied, some images have to be manually updated
"

latte_palette="
		\\\\ Crust
		CatppuccinBlack0=\"220,224,232\"
		\\\\ Mantle
		CatppuccinBlack1=\"230,233,239\"
		\\\\ Base
		CatppuccinBlack2=\"239,241,245\"
		\\\\ Surface 0
		CatppuccinBlack3=\"204,208,218\"
		\\\\ Surface 1
		CatppuccinBlack4=\"188,192,204\"

		\\\\ Surface 2
		CatppuccinGray0=\"172,176,190\"
		\\\\ Overlay 0
		CatppuccinGray1=\"156,160,176\"
		\\\\ Overlay 1
		CatppuccinGray2=\"140,143,161\"
		\\\\ Overlay 2
		CatppuccinGray3=\"124,127,147\"

		\\\\ Subtext 0
		CatppuccinGray4=\"108,111,133\"
		\\\\ Subtext 1
		CatppuccinGray5=\"92,95,119\"

		\\\\ Text
		CatppuccinForeground=\"76,79,105\"

		\\\\ Rosewater
		CatppuccinRosewater=\"220,138,120\"
		\\\\ Flamingo
		CatppuccinFlamingo=\"221,120,120\"
		\\\\ Pink
		CatppuccinPink=\"234,118,203\"
		\\\\ Mauve
		CatppuccinMauve=\"136,57,239\"
		\\\\ Red
		CatppuccinRed=\"210,15,57\"
		\\\\ Maroon
		CatppuccinMaroon=\"230,69,83\"
		\\\\ Peach
		CatppuccinPeach=\"254,100,11\"
		\\\\ Yellow
		CatppuccinYellow=\"223,142,29\"
		\\\\ Green
		CatppuccinGreen=\"64,160,43\"
		\\\\ Teal
		CatppuccinTeal=\"23,146,153\"
		\\\\ Sky
		CatppuccinSky=\"4,165,229\"
		\\\\ Sapphire
		CatppuccinSapphire=\"32,159,181\"
		\\\\ Blue
		CatppuccinBlue=\"30,102,245\"
		\\\\ Lavender
		CatppuccinLavender=\"114,135,253\"

		\\\\ Accent theme (Currently mauve)
		\\\\ Note: For this to be fully applied, some images have to be manually updated
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

for theme_index in {0..3}; do
    current_accents_name=${theme_names[$theme_index]}_accents
    current_palette_name=${theme_names[$theme_index]}_palette
    declare -n current_theme_accents="$current_accents_name"
    declare -n current_palette="$current_palette_name"

    sed -i "s/\\\\ Palette placeholder/${current_palette}/g"

    for colour_index in {0..13}; do
        check_exit

        sed -i "s/theme-palette-placeholder/theme-${theme_names[$theme_index]}/g"               ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
        sed -i "s/accent-placeholder/accent-${palette_names[$colour_index]}/g"                  ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
        sed -i "s/Accent=\"placeholder\"/Accent=\"${current_theme_accents[colour_index]}\"/g"  ./catppuccin-base.xml

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

        xdotool type --delay 5 \\output\\catppuccin_${theme_names[$theme_index]}_${palette_names[$colour_index]}.xmlc

        xdotool key Tab
        xdotool key Tab
        xdotool key Enter

        sleep 0.1
        xdotool key Shift+Tab

        sed -i "s/theme-${theme_names[$theme_index]}/theme-palette-placeholder/g"               ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
        sed -i "s/accent-${palette_names[$colour_index]}/accent-placeholder/g"                  ./catppuccin-base.xml ./skin_wavebar.xml ./skin.xml ./skin.bak
        sed -i "s/Accent=\"${current_theme_accents[colour_index]}\"/Accent=\"placeholder\"/g"   ./catppuccin-base.xml
    done
done

cd ..