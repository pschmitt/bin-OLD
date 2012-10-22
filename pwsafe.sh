#!/usr/bin/env sh

PWSAFE_HOME=$XDG_DATA_HOME/pwsafe
export PWSAFE_DATABASE=$PWSAFE_HOME/pwsafe.dat
export RANDFILE=$PWSAFE_HOME/randfile
pwsafe $@
