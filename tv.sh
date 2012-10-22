#!/usr/bin/env zsh

[[ -z "$DISPLAY" ]] && export DISPLAY=:0
[[ -z "$XAUTHORITY" ]] && export XAUTHORITY=$HOME/.Xauthority
CHANNELS_FILE=/mnt/iHD/videos/tv/channels_SB.xspf

exec $(where vlc) -f $CHANNELS_FILE
