#!/usr/bin/zsh

if [[ "$1" == "up" ]]; then
#systemctl start dropbox@pschmitt insync@pschmitt nfsd
    mount /mnt/nfs-raid
elif [[ "$1" == "down" ]]; then
#systemctl stop dropbox@pschmitt insync@pschmitt nfsd
    killall insync
    umount /mnt/nfs-raid
fi

exit 0
