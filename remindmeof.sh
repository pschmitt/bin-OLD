#!/usr/bin/env sh

# Comment following lines and the last one to allow multiple reminders to show up
PIDFILE=/tmp/remindmeof.pid
[[ -e $PIDFILE ]] && kill -9 $(cat $PIDFILE)

[[ -z "$DISPLAY" ]] && export DISPLAY=:0
[[ -z "$XAUTHORITY" ]] && export XAUTHORITY=$HOME/.Xauthority

zenity --warning --text "$@" &
echo "$!" > $PIDFILE
