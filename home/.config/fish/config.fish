# basic fish config

# disable prompt shortening
set -g fish_prompt_pwd_dir_length 0

# disable greeting
set fish_greeting

set PATH $HOME/.local/bin $HOME/.cargo/bin $PATH

if test -e ~/.homesick/repos/homeshick/homeshick.fish
    source ~/.homesick/repos/homeshick/homeshick.fish
end

set -g fish_color_search_match 'bryellow'  '--background=brblack'
set -g fish_pager_color_progress 'cyan'  '--background=brblack'

# git prompt - see https://fishshell.com/docs/current/cmds/fish_git_prompt.html
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_color_branch green
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_showdirtystate "yes"
set -g __fish_git_prompt_color_dirtystate A96000
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_char_stagedstate '∙'
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_cleanstate green
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_upstream_prefix ' '
set -g __fish_git_prompt_char_untrackedfiles ' '
set -g __fish_git_prompt_color_untrackedfiles "red"

function fish_prompt
    set -l last_status $status
    printf '%s%s %s%s%s%s ' (set_color $fish_color_host) (prompt_hostname) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (__fish_git_prompt)
    if not test $last_status -eq 0
        set_color $fish_color_error
    end
    echo -n '❯ '
    set_color normal
end

# theme
if test -d ~/.config/kitty/kitty-themes
    if not test -e ~/.config/kitty/theme.conf
        echo "Setting theme to one dark; to change theme, change symlink - see https://github.com/dexpota/kitty-themes"
        echo "Restart kitty for theme to take effect"
        ln -s ~/.config/kitty/kitty-themes/themes/OneDark.conf ~/.config/kitty/theme.conf
    end
end

# neovim > vim > vi
if type -q nvim
    alias vi 'nvim'
    alias vim 'nvim'
    set -g EDITOR nvim
else if type -q vim
    alias vi 'vim'
    set -g EDITOR vim
else
    set -g EDITOR vi
end
set -x VISUAL $EDITOR
set -x GIT_EDITOR $EDITOR

# to make vim and nvim to work with the same config:
if not test -e ~/.config/nvim
    echo "Symlinking ~/.config/nvim/ → ~/.vim/"
    ln -s ~/.vim ~/.config/nvim
end
if not test -e ~/.vim/init.vim
    echo "Symlinking ~/.vim/init.vim → ~/.vimrc"
    ln -s ~/.vimrc ~/.vim/init.vim
end

set -gx LANG 'en_US.UTF-8'
set -gx LC_ALL 'en_US.UTF-8'

# less
set -gx LESS '-g -i -M -R -S -w'
set -gx SYSTEMD_LESS 'FRXMK'
set -x LESS_TERMCAP_mb (printf "\033[01;31m")
set -x LESS_TERMCAP_md (printf "\033[01;31m")
set -x LESS_TERMCAP_me (printf "\033[0m")
set -x LESS_TERMCAP_se (printf "\033[0m")
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\033[0m")
set -x LESS_TERMCAP_us (printf "\033[01;32m")
if test -e /usr/share/source-highlight/src-hilite-lesspipe.sh
    # Debian has just gotta be different
    set -x LESSOPEN "| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
else if test -e /usr/bin/src-hilite-lesspipe.sh
    # Arch / CentOS
    set -x LESSOPEN "| /usr/bin/src-hilite-lesspipe.sh %s"
end

# fucking ads in npm
set -g OPEN_SOURCE_CONTRIBUTOR true
set -g DISABLE_OPENCOLLECTIVE true

if test -z (pgrep ssh-agent)
    echo "Initializing ssh-agent..."
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    ssh-add
end

abbr cp "cp -i"
abbr mv "mv -i"
abbr rm "rm -i"

abbr crontab 'crontab -i'
abbr more 'less'
abbr df 'df -h'
abbr shred 'shred -z -n 2 -u'

abbr lip 'ip -s -h --color address show'
abbr xip 'curl https://icanhazip.com'

abbr ssh-keygen 'ssh-keygen -t ed25519 -C \"(whoami)@(hostname)-(date -I)\"'

# older versions of tmux can't use the -style options, and >= 2.9 must use them
bass export TMUX_CONF=`~/.local/bin/set-tmux-conf.sh`
abbr tmux tmux -2 -f $TMUX_CONF

# quick and dirty password generator
abbr pwgen30 'pwgen -s 30 1'
