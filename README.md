# basic-castle

Minimalist dotfiles for use with [homeshick](https://github.com/andsens/homeshick).


## Setup

Copy `bootstrap.sh` to the remote system and run it.

    wget https://raw.githubusercontent.com/johnivore/basic-castle/main/bootstrap.sh
    cat bootstrap.sh
    sh bootstrap.sh


## vim

* <https://github.com/arcticicestudio/nord-vim>
* <https://github.com/itchyny/lightline.vim>


## fzf plugins

    fundle plugin 'edc/bass'
    fundle plugin 'jorgebucaran/fisher'
    fundle plugin 'PatrickF1/fzf.fish'
    fundle plugin 'urbainvaes/fzf-marks'
    fundle plugin joseluisq/gitnow --url 'git@github.com:joseluisq/gitnow.git#tags/2.9.0'
    fundle init


## Android

If this is an Android system:

    homeshick clone https://github.com/johnivore/android-castle.git


## License

```
Copyright 2019-2020  John Begenisich

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```
