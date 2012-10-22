#!/bin/zsh

SCREENCOUNT=$(xrdr count)

DZEN_TITLE="xmonad_lbar"
DZEN_TA="r" # Alignment
BG='#161616'
FG='#8c8b8e'
FONT="Profont-11"

XPOS="0"
YPOS="0"
WIDTH="430"

DZEN_CMD="tee >(dzen2 \
    -dock \
    -title-name \"$DZEN_TITLE\" \
    -u \
    -xs 1 \
    -x \"$XPOS\" \
    -y \"$YPOS\" \
    -w \"$WIDTH\" \
    -ta \"$DZEN_TA\" \
    -bg \"$BG\" \
    -fg \"$FG\" \
    -fn \"$FONT\" \
    -e \"button3=;onstart=lower\")"

if [[ $SCREENCOUNT -gt 2 ]]; then
    DZEN_CMD="${DZEN_CMD} >(dzen2 \
    -dock \
    -title-name \"${DZEN_TITLE}_2\" \
    -u \
    -xs 2 \
    -x \"$XPOS\" \
    -y \"$YPOS\" \
    -w \"$WIDTH\" \
    -ta \"$DZEN_TA\" \
    -bg \"$BG\" \
    -fg \"$FG\" \
    -fn \"$FONT\" \
    -e \"button3=;onstart=lower\")"
fi

echo $DZEN_CMD

read pipe_data 
    echo $pipe_data | eval $DZEN_CMD & # | tee > /var/log/statusbar.log
#done
#
