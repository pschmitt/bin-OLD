#!/usr/bin/env sh

[[ -z $XDG_DATA_HOME ]] && XDG_DATA_HOME=~/.local/share
PWSAFE_HOME=$XDG_DATA_HOME/pwsafe
export PWSAFE_DATABASE=$PWSAFE_HOME/pwsafe.dat
export RANDFILE=$PWSAFE_HOME/randfile
pwsafe $@
