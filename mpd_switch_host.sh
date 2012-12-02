#!/bin/bash

TMPFILE=/tmp/mpd_host
CONKYRC=$XDG_CONFIG_HOME/conky/conkyrc
MPD_HOSTS=("LaXLinux" "LaXLinux-CL" "alarmpi")
CURRENT_MPD_HOST=$(cat $TMPFILE 2>/dev/null)

function next_host() {
    local i=0
    for elem in ${MPD_HOSTS[@]}; do
        let i=i+1
        [[ "$elem" == "$CURRENT_MPD_HOST" ]] && break 
    done
    [[ $i -ge ${#MPD_HOSTS[@]} ]] && i=0 
    CURRENT_MPD_HOST=${MPD_HOSTS[$i]}
}

# Default to "localhost"
[[ -z $CURRENT_MPD_HOST ]] && CURRENT_MPD_HOST=$(hostname) || next_host
echo $CURRENT_MPD_HOST > $TMPFILE

sed -i "s/\(mpd_host\) .*/\1 $CURRENT_MPD_HOST/" $HOME/.conkyrc
sed -i "s/\(mpd_host\) .*/\1 $CURRENT_MPD_HOST/" $CONKYRC
