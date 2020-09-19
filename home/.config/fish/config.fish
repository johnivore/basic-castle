# basic fish config

# disable prompt shortening
set -g fish_prompt_pwd_dir_length 0

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


set -gx LANG 'en_US.UTF-8'
set -gx LC_ALL 'en_US.UTF-8'

set -gx LESS '-g -i -M -R -S -w'
set -gx SYSTEMD_LESS 'FRXMK'

if test -z (pgrep ssh-agent)
    echo "Initializing ssh-agent..."
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    ssh-add
end

# TODO: vi/vim/nvim

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


# fucking ads in npm
set -g OPEN_SOURCE_CONTRIBUTOR true
set -g export DISABLE_OPENCOLLECTIVE true
