#!/bin/bash

# export TMUX_CONF based on its version
# older versions of tmux can't use the -style options, and >= 2.9 must use them

if (( $(echo "`tmux -V | cut -d ' ' -f 2 | sed 's/[^0-9\.]*//g'` <= 2.1" | bc -l) )); then
    export TMUX_CONF=$HOME/.tmux-pre2.1.conf
else
    export TMUX_CONF=$HOME/.tmux.conf
fi
