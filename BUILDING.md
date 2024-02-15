## Building

Currently only set up to build on Linux, as that's what I use.

Requires `imagemagick`, `inkscape`, `perl`, `xdotool`, `xvfb`, and `wine`. Requires a wine prefix capable of running MusicBee for `SkinCreator.exe`, which can be set up with:

```bash
export WINEPREFIX="$HOME/.local/share/wineprefixes/MusicBee/"
export WINEARCH="win32"
export WINEDLLOVERRIDES="mscoree,mshtml=" # We don't need wine-mono installed, no need to give a warning over it. https://bugs.winehq.org/show_bug.cgi?id=47316#c4
export WINEDEBUG=-all # Don't print any debugging messages for wine

unset DISPLAY
winetricks arch=32 --unattended dotnet48 xmllite gdiplus
```

Run `./scripts/convert-icons.sh` and `./create_svgs.sh` to generate the icons, then `./scripts/build.sh` to build the theme. (Takes ~8 minutes, and gives a lot of warnings about "XGetInputFocus returned the focused window of 1. This is likely a bug in the X server.", but it works.)
