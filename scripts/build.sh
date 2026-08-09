#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f templates/catppuccin-base.xml.tera ]]; then
    echo "Run this script from the repository root." >&2
    exit 1
fi

export WINEPREFIX="${MUSICBEE_WINEPREFIX:-$HOME/.local/share/wineprefixes/MusicBee/}"
export DISPLAY="${MUSICBEE_BUILD_DISPLAY:-:42}"
export WINEDEBUG="${WINEDEBUG:--all}"

printf 'Using Wine prefix: %s\n' "$WINEPREFIX"

xvfb_pid=""
skin_creator_pid=""
cleanup() {
    [[ -z "$skin_creator_pid" ]] || kill "$skin_creator_pid" 2>/dev/null || true
    [[ -z "$xvfb_pid" ]] || kill "$xvfb_pid" 2>/dev/null || true
}
trap cleanup EXIT

rm -rf .build/skins .build/Catppuccin .build/output output
mkdir -p .build/output output

echo "Rendering skin sources with Whiskers"
whiskers templates/catppuccin-base.xml.tera
whiskers templates/skin.xml.tera
whiskers templates/skin_wavebar.xml.tera

# SkinCreator expects these files and all image assets in its working directory.
cp -a Catppuccin .build/Catppuccin

install_variant() {
    local variant_dir=$1
    cp "$variant_dir/catppuccin-base.xml" .build/Catppuccin/catppuccin-base.xml
    cp "$variant_dir/skin.xml" .build/Catppuccin/skin.xml
    cp "$variant_dir/skin.xml" .build/Catppuccin/skin.bak
    cp "$variant_dir/skin_wavebar.xml" .build/Catppuccin/skin_wavebar.xml
}

wait_for_completed_output() {
    local output_file=$1

    for _ in {1..120}; do
        if [[ -s "$output_file" ]]; then
            sleep 0.5
            return 0
        fi
        sleep 0.25
    done

    echo "SkinCreator did not produce $output_file" >&2
    return 1
}

variant_dirs=(.build/skins/*/*/*)
install_variant "${variant_dirs[0]}"

Xvfb "$DISPLAY" &
xvfb_pid=$!
sleep 0.2

cd .build/Catppuccin
wine ./SkinCreator.exe &
skin_creator_pid=$!

# wait for the main window
window_id=""
for _ in {1..20}; do
    if warning_id=$(xdotool search --all --onlyvisible --name SkinCreator 2>/dev/null); then
        xdotool key --window "${warning_id%%$'\n'*}" Enter 2>/dev/null || true
    fi
    if window_id=$(xdotool search --all --onlyvisible --name Form1 2>/dev/null); then
        window_id=${window_id%%$'\n'*}
        break
    fi
    sleep 0.5
done
if [[ -z "$window_id" ]]; then
    echo "SkinCreator did not open its main window." >&2
    exit 1
fi
cd ../..

for variant_dir in "${variant_dirs[@]}"; do
    variant=${variant_dir#.build/skins/}
    IFS=/ read -r flavor accent bar <<< "$variant"
    printf '%s / %s / %s\n' "$flavor" "$accent" "$bar"

    install_variant "$variant_dir"
    window_id=$(xdotool search --sync --all --onlyvisible --name Form1)
    window_id=${window_id##*$'\n'}

    sleep 0.5
    xdotool key --window "$window_id" Control_L+r
    sleep 0.1
    xdotool key --window "$window_id" Control_L+s
    sleep 1

    # Replace the entire path in the save dialog.
    # `xdotool type --window` loses shifted characters under Wine (for example, `_` becomes `-`)
    expected_output=".build/output/catppuccin_${flavor}_${accent}_bar_${bar}.xmlc"
    absolute_output=$(realpath -m "$expected_output")
    windows_output="Z:${absolute_output//\//\\}"
    xdotool key --clearmodifiers Control_L+a
    xdotool type --clearmodifiers --delay 5 "$windows_output"
    sleep 0.5
    xdotool key --clearmodifiers Enter
    wait_for_completed_output "$expected_output"
done

sleep 5
cleanup
skin_creator_pid=""
xvfb_pid=""

mv .build/output/*.xmlc output/
