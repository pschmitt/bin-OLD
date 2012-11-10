#!/bin/sh
# rsync backup script

HOME_NETWORK=AIDS_Netz
REMOTE_HOST=LaXLinux
REMOTE_SHARE=LXL-CL
LOCAL_USER=pschmitt
REMOTE_USER=$LOCAL_USER
BACKUP_DIR=/ # backup root 
EXCLUDE_FILE=/etc/conf.d/rbackup.exclude
PASSWD_FILE=/etc/rsync.passwd
SSH_KEY=/home/$LOCAL_USER/.ssh/id_rsa

[[ "$(netcfg current)" != "$HOME_NETWORK" ]] && { echo -e "Home network ($HOME_NETWORK) unreachable.\nExiting"; exit 0; }
[[ $EUID -ne 0 ]] && { echo -e "This script must be run as root\nInvoking sudo $0" 1>&2; exec sudo $0; }

# run this process with real low priority
ionice -c 3 -p $$
renice +12  -p $$

rsync -aPvz --password-file=$PASSWD_FILE --del --delete-excluded --exclude-from=$EXCLUDE_FILE $BACKUP_DIR rsync://$REMOTE_USER@$REMOTE_HOST/$REMOTE_SHARE/ #&> /dev/null
#rsync -aPO --delete-excluded --exclude-from=$EXCLUDE_FILE $BACKUP_DIR $REMOTE_DIR/
#ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "date > $REMOTE_DIR/LAST_BACKUP"
#rsync -avz / rsync://pschmitt@laxlinux/LXL-CL
