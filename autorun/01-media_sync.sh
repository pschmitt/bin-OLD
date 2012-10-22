#!/bin/zsh -x
# rsync music sync script

LOCAL_USER=pschmitt
#MUSIC_DIR="$XDG_MUSIC_DIR/"
MUSIC_DIR="$HOME/music/"
#EXCLUDE_FILE=/etc/conf.d/rbackup.exclude
#IPOD_MUSIC_DIR="$(dirname $0)/../music"
IPOD_MUSIC_DIR="/media/iPodClassic/music"
LOGFILE=/tmp/ipod_sync.log

if [[ "$(whoami)" != "$LOCAL_USER" ]]; then
    echo "restarting as $LOCAL_USER" > $LOGFILE
    rm -rf $LOGFILE
    exec eval su "$LOCAL_USER -c '$0 $@'"
fi

# run this process with real low priority
#ionice -c 3 -p $$
#renice +12  -p $$

#rsync -aPvz --delete-excluded --exclude-from=$EXCLUDE_FILE -e "ssh -i $SSH_KEY" $BACKUP_DIR $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/ #&> /dev/null
#echo "$EUID rsync -a --delete $MUSIC_DIR $IPOD_MUSIC_DIR" > $LOGFILE
rsync -PrztD --delete-before --delete $MUSIC_DIR $IPOD_MUSIC_DIR 2> /var/log/ipod_sync.errlog #&>/dev/null 

