#!/bin/bash

# install homeshick
if [ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]; then
    git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi

# set up homeshick
. $HOME/.homesick/repos/homeshick/homeshick.sh

# install this castle
if [ ! -d $HOME/.homesick/repos/basic-castle ]; then
    homeshick clone https://gitlab.com/johnivore/basic-castle.git
fi
