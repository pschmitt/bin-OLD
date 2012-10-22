#!/usr/bin/env bash

USER=pschmitt
HOST=$(hostname)

[[ -z "$HOST" ]] && { echo "Couldn't determine hostname. Exiting."; exit; }    
[[ $HOST = "LaXLinux-CL" ]] || [[ $HOST = "alarmpi" ]] && REMOTE_HOST=LaXLinux
[[ $HOST = "LaXLinux" ]] && REMOTE_HOST=LaXLinux-CL 
[[ -z "$REMOTE_HOST" ]] && REMOTE_HOST=lxl.laxlinux.net

ssh "$USER"@"$REMOTE_HOST"
