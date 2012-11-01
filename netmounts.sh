#!/bin/bash

MOUNTPOINTS=( "/mnt/laxlinux.net" "/mnt/galaxy_s3" "/mnt/laxlinux-cl" "/mnt/alarmpi" )

function mount_all() {
    for mountpoint in "${MOUNTPOINTS[@]}"; do
        [[ -z $(mount | grep $mountpoint) ]] && mount $mountpoint
    done
}

function unmount_all() {
    for mountpoint in "${MOUNTPOINTS[@]}"; do
        [[ -z $(mount | grep $mountpoint) ]] || umount $mountpoint
    done
    # umount ${MOUNTPOINTS[@]:0}
}

case "$1" in
    umount|u)
        unmount_all
        ;;
    *)    
        mount_all
        ;;
esac

