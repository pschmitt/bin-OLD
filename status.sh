#!/bin/zsh

SCREENCOUNT=$(xrdr count)

DZEN_TITLE="xmonad_rbar"
DZEN_TA="r" # Alignment
BG='#161616'
FG='#8c8b8e'
FONT="Profont-11"

XPOS="430"
YPOS="0"

DZEN_CMD="tee >(dzen2 \
    -dock \
    -title-name \"$DZEN_TITLE\" \
    -u \
    -xs 1 \
    -x \"$XPOS\" \
    -y \"$YPOS\" \
    -ta \"$DZEN_TA\" \
    -bg \"$BG\" \
    -fg \"$FG\" \
    -fn \"$FONT\" \
    -e \"button3=;onstart=lower\")"

if [[ $SCREENCOUNT -gt 1 ]]; then
    DZEN_CMD="${DZEN_CMD} >(dzen2 \
    -dock \
    -title-name \"${DZEN_TITLE}_2\" \
    -u \
    -xs 2 \
    -x \"$XPOS\" \
    -y \"$YPOS\" \
    -ta \"$DZEN_TA\" \
    -bg \"$BG\" \
    -fg \"$FG\" \
    -fn \"$FONT\" \
    -e \"button3=;onstart=lower\")"
fi

if [[ "${HOST:l}" != "laxlinux" ]]; then
    while; do
        if nmap -sP --max-retries=1 --host-timeout=150ms laxlinux > /dev/null 2>&1 | grep "is up" > /dev/null; then
            sed -i 's/\(mpd_host\) localhost/\1 laxlinux/' $HOME/.conkyrc
        else
            sed -i 's/\(mpd_host\) laxlinux/\1 localhost/' $HOME/.conkyrc
        fi
        sleep 300
    done &
else
    sed -i 's/\(mpd_host\) laxlinux/\1 localhost/' $HOME/.conkyrc
fi

conky | eval $DZEN_CMD & # | tee > /var/log/statusbar.log
#watch -n 300 "nmap -sP --max-retries=1 --host-timeout=150ms laxlinux > /dev/null 2>&1 | grep "is up" > /dev/null"
#conky | dzen2 -bg '#161616' -fg '#8c8b8e' -y 20 -xs 1 -fn Profont-11 -expand l
