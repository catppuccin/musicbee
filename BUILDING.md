## Building

Building is currently supported on Linux.

Install [Whiskers](https://whiskers.catppuccin.com/getting-started/installation/), `imagemagick`, `inkscape`, `xdotool`, `xvfb`, and `wine`.

`SkinCreator.exe` also requires a Wine prefix with MS .NET rather than Wine Mono. The default prefix is `$HOME/.local/share/wineprefixes/MusicBee/` (overrideable with `MUSICBEE_WINEPREFIX`). One way to prepare the prefix is:

```bash
export MUSICBEE_WINEPREFIX="$HOME/.local/share/wineprefixes/MusicBee/"
export WINEPREFIX="$MUSICBEE_WINEPREFIX"
export WINEARCH="win32"
export WINEDLLOVERRIDES="mscoree,mshtml=" # We don't need wine-mono installed, no need to give a warning over it. https://bugs.winehq.org/show_bug.cgi?id=47316#c4
export WINEDEBUG=-all # Don't print any debugging messages for wine

unset DISPLAY
winetricks arch=32 --unattended dotnet48 xmllite gdiplus
```

Generate the assets, then compile every flavor/accent/player-bar combination:

```bash
./scripts/convert-icons.sh
./scripts/create_svgs.sh
./scripts/build.sh
```
