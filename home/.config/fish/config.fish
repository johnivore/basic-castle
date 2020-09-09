# basic fish config

if test -e ~/.homesick/repos/homeshick/homeshick.fish
    source ~/.homesick/repos/homeshick/homeshick.fish
end

set -gx LANG 'en_US.UTF-8'
set -gx LC_ALL 'en_US.UTF-8'

set -gx LESS '-g -i -M -R -S -w'
set -gx SYSTEMD_LESS 'FRXMK'

# TODO: vi/vim/nvim

# # list only directories
# if [[ -n $HAVE_COLORFUL_GREP ]]; then
#     alias lsd="ls -lF --color | grep --color=never '^d'"
# else
#     alias lsd="ls -lF --color | grep '^d'"
# fi

abbr cp "cp -i"
abbr mv "mv -i"
abbr rm "rm -i"

abbr crontab 'crontab -i'
abbr more 'less'
abbr df 'df -h'
abbr shred 'shred -z -n 2 -u'

abbr lip 'ip -s -h --color address show'
abbr xip 'curl https://icanhazip.com'

# abbr ssh 'ssh -Y'

# alias gitlog='git log --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%an]" --decorate --date=relative --abbrev-commit --abbrev=10 --graph'


# # make aliases available to sudo
# alias sudo='sudo '

# # ED25519
# alias ssh-keygen='ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)-$(date -I)"'

# # copy working directory
# alias cwd='pwd | tr -d "\r\n" | xclip -selection clipboard'

abbr t "task"
