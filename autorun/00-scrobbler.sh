#!/bin/zsh

LOGFILE="/tmp/ipod_scrobble.log"
SCROBBLE_FILE="$(dirname $0)/../.scrobbler.log"
LOCAL_USER="pschmitt"


if [[ "$(whoami)" != "$LOCAL_USER" ]]; then
    echo "restarting as $LOCAL_USER"
    rm -rf $LOGFILE
    exec eval su "$LOCAL_USER -c '$0 $@'"
fi

printf "%s\nLogging session started\n" "$(date)" > $LOGFILE

function missing() {
    echo "I require $1 but it's not installed.  Aborting."
    exit 1
}

function no_scrobble_file() {
    echo "$SCROBBLE_FILE: No such file. Either there is nothing to commit or you didn't enable LastFM logging on your device."
    exit 1
}

function is_installed() {
    for arg in "$@"; do
        hash $arg 2>/dev/null || missing $arg
    done
}

is_installed "scrobble-cli" "n_login"

[[ -e $SCROBBLE_FILE ]] || no_scrobble_file >> $LOGFILE

username=$(n_login last.fm)
password=$(n_login -p last.fm)

scrobble-cli -u $username -5 $password -l $SCROBBLE_FILE >> $LOGFILE

if [ $? -ne 0 ]; then
    echo -en "Couldn't commit. Re-calculating the play time to now and trying again... "
    scrobble-cli -n -u $username -5 $password -l $SCROBBLE_FILE >> $LOGFILE
    [ $? -eq 0 ] && echo "success !" || echo "failed \!"
fi
