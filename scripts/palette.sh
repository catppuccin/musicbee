#!/bin/env bash

bar_states=("bar-mono" "bar-unaccented")
theme_names=("mocha" "macchiato" "frappe" "latte")
palette_names=("rosewater" "flamingo" "pink" "mauve" "red" "maroon" "peach" "yellow" "green" "teal" "sky" "sapphire" "blue" "lavender")

mocha_accents_rgb=("245,224,220" "242,205,205" "245,194,231" "203,166,247" "243,139,168" "235,160,172" "250,179,135" "249,226,175" "166,227,161" "148,226,213" "137,220,235" "116,199,236" "137,180,250" "180,190,254")
macchiato_accents_rgb=("244,219,214" "240,198,198" "245,189,230" "198,160,246" "237,135,150" "238,153,160" "245,169,127" "238,212,159" "166,218,149" "139,213,202" "145,215,227" "125,196,228" "138,173,244" "183,189,248")
frappe_accents_rgb=("242,213,207" "238,190,190" "244,184,228" "202,158,230" "231,130,132" "234,153,156" "239,159,118" "229,200,144" "166,209,137" "129,200,190" "153,209,219" "133,193,220" "140,170,238" "186,187,241")
latte_accents_rgb=("220,138,120" "221,120,120" "234,118,203" "136,57,239" "210,15,57" "230,69,83" "254,100,11" "223,142,29" "64,160,43" "23,146,153" "4,165,229" "32,159,181" "30,102,245" "114,135,253")

latte_accents_hex=("dc8a78" "dd7878" "ea76cb" "8839ef" "d20f39" "e64553" "fe640b" "df8e1d" "40a02b" "179299" "04a5e5" "209fb5" "1e66f5" "7287fd")
frappe_accents_hex=("f2d5cf" "eebebe" "f4b8e4" "ca9ee6" "e78284" "ea999c" "ef9f76" "e5c890" "a6d189" "81c8be" "99d1db" "85c1dc" "8caaee" "babbf1")
macchiato_accents_hex=("f4dbd6" "f0c6c6" "f5bde6" "c6a0f6" "ed8796" "ee99a0" "f5a97f" "eed49f" "a6da95" "8bd5ca" "91d7e3" "7dc4e4" "8aadf4" "b7bdf8")
mocha_accents_hex=("f5e0dc" "f2cdcd" "f5c2e7" "cba6f7" "f38ba8" "eba0ac" "fab387" "f9e2af" "a6e3a1" "94e2d5" "89dceb" "74c7ec" "89b4fa" "b4befe")
crusts_hex=("11111b" "181926" "232634" "dce0e8")
texts_hex=("cdd6f4" "cad3f5" "c6d0f5" "4c4f69")
overlay0s_hex=("6c7086" "6e738d" "737994" "9ca0b0")
surface0s_hex=("313244" "363a4f" "414559" "ccd0da")

# TODO find a better solution than this

mocha_palette="
		CatppuccinBlack0=\"17,17,27\"
		CatppuccinBlack1=\"24,24,37\"
		CatppuccinBlack2=\"30,30,46\"
		CatppuccinBlack3=\"49,50,68\"
		InactiveIconMask=\"193,49,50,68\"
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
		InactiveIconMask=\"193,54,58,79\"
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
		InactiveIconMask=\"193,65,69,89\"
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
		InactiveIconMask=\"123,204,208,218\"
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