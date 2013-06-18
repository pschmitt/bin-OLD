#!/usr/bin/env sh
# Author: Philipp Schmitt (philipp <at> schmitt <dot> co)
# License: WTFPL (http://www.wtfpl.net/txt/copying)
# This script syncs (well it overwrites...) a users GTK2, GTK3 and SpaceFM bookmarks

[[ -n $XDG_CONFIG_HOME ]] || XDG_CONFIG_HOME=$HOME/.config

cat $XDG_CONFIG_HOME/spacefm/bookmarks | tee $XDG_CONFIG_HOME/gtk-3.0/bookmarks $HOME/.gtk-bookmarks
