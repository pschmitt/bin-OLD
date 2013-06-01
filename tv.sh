#!/usr/bin/env zsh

[[ -z "$DISPLAY" ]] && export DISPLAY=:0
[[ -z "$XAUTHORITY" ]] && export XAUTHORITY=$HOME/.Xauthority
CHANNELS_FILE=/mnt/raid/videos/tv/dvb-t/channels_SB.xspf

exec $(where vlc) -f $CHANNELS_FILE
