# .bashrc

# It's stupid to maintain both .bashrc and .bash_profile,
# so everything is in here.

# $HOME/.bash-local.sh can contain stuff not in git, or in another git repo
for file in {/etc/profile,/etc/bashrc,$HOME/{.bash-dotfiles.sh,.bash-local.sh,.homesick/repos/homeshick/homeshick.sh},/usr/bin/virtualenvwrapper.sh,/usr/share/fzf/{key-bindings.bash,completion.bash}}; do
    if [[ -f "$file" ]]; then
        # echo "sourcing $file"
        source "$file"
    fi
done
unset file

# print a warning if our old-style ~/.bashrc_local exists
if [[ -f $HOME/.bashrc_local ]]; then
    echo "$HOME/.bashrc_local found.  Please do something like:"
    echo "    mv $HOME/.bashrc_local $HOME/.bash-local.sh"
fi

# Append our default paths
appendpath () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
        PATH="$PATH:$1"
    esac
}

appendpath '$HOME/bin'

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export COLORTERM=truecolor
export TERM=xterm-256color

# history
export HISTSIZE=10000
export HISTCONTROL=ignoredups

# Don’t clear the screen after quitting a manual page
export LESS='-g -i -M -R -S -w -X -z-4'
[ -x /usr/bin/lesspipe ] && export LESSOPEN="|lesspipe %s"

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null
done

# prefer neovim; else vim; else vi
if [ -x "$(command -v nvim)" ]; then
    alias vi='nvim'
    export EDITOR=nvim
elif [ -x "$(command -v vim)" ]; then
    alias vi='vim'
    export EDITOR=vim
else
    export EDITOR=vi
fi
export VISUAL=$EDITOR

# symlink vimrc to neovim config
if [[ ! -e ~/.config/nvim/init.vim ]]; then
    echo "Symlinking ~/.config/nvim/init.vim → ~/.vimrc"
    mkdir -p ~/.config/nvim
    ln -s ~/.vimrc ~/.config/nvim/init.vim
fi

# ls colors for transparent terminal
eval `dircolors -b $HOME/.dircolors`

# grep needs to complete successfully in order to test for --color=auto support
if grep --color=auto "s" $HOME/.bash_profile &> /dev/null
then
    alias grep='grep --color=auto'
    export GREP_COLOR='37'
    HAVE_COLORFUL_GREP=true
fi

# ls aliases
alias ls='ls -F --color'
alias l='ls'
alias ll='ls -la'
alias lst='ll --sort=t | head -20'
# list only directories
if [[ -n $HAVE_COLORFUL_GREP ]]; then
    alias lsd="ls -lF --color | grep --color=never '^d'"
else
    alias lsd="ls -lF --color | grep '^d'"
fi
# detailed list in alphabetical order
alias lss='ls --group-directories-first --color=always --time-style=+"%Y-%m-%d %H:%M:%S" -lhF'
# detailed list in reverse time order
alias ltr='ls --group-directories-first --color=always --time-style=+"%Y-%m-%d %H:%M:%S" -lhFtr'

# other aliases
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias crontab='crontab -i'
alias more='less'
alias df='df -h'
alias du='du -h'
alias dus='du -sk * | sort -n'
alias dusdot='du -sk * .[a-zA-Z0-9]* | sort -n'
alias dust='du -sk * | sort -n | tail'
alias shred='shred -z -n 2 -u'
alias ssh='ssh -Y'
# force tmux to start in 256-color mode
alias tmux='tmux -2'
alias gitlog='git log --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%an]" --decorate --date=relative --abbrev-commit --abbrev=10 --graph'
# local IP@@
alias lip='ip -s -h --color address show "${@}"'
# external IP
alias xip='curl https://icanhazip.com'

# make aliases available to sudo
alias sudo='sudo '

# ED25519
alias ssh-keygen='ssh-keygen -t ed25519 -C "$(whoami)@$(hostname)-$(date -I)"'

# copy working directory
alias cwd='pwd | tr -d "\r\n" | xclip -selection clipboard'

# stopwatch
alias timer='echo "Timer started; stop with Ctrl-D." && date && time cat && date'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Go
export GOPATH=~/.go

# bash-completion
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
fi

# if our session is SSH, set a variable so we can use it later in our tmux title
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    export SESSION_TYPE=remote/ssh
    # many other tests omitted
else
    case $(ps -o comm= -p $PPID) in sshd|*/sshd)
        export SESSION_TYPE=remote/ssh;;
    esac
fi
if [[ -n $SESSION_TYPE ]] && [ $SESSION_TYPE = "remote/ssh" ]; then
    export TMUX_TITLE_PREFIX="`whoami`@`hostname -s`:"
fi


# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
    -o "nospace" \
    -W "$(grep "^Host" ~/.ssh/config | \
    grep -v "[?*]" | cut -d " " -f2 | \
    tr ' ' '\n')" scp sftp ssh lftp


# if using systemd, enable ssh-agent via systemd
# note, systemd --user is not in EL7, see https://bugs.centos.org/view.php?id=8767
if [[ -L "/sbin/init" ]] && [[ ! -f /etc/redhat-release ]]; then
    if [[ ! -f ~/.config/systemd/user/default.target.wants/ssh-agent.service ]]; then
        echo "Enabling and starting ssh-agent..."
        systemctl --user enable ssh-agent
        systemctl --user start ssh-agent
    fi
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
else
    alias sshagent='eval `ssh-agent -s` && ssh-add'
fi


# --- prompt ---

# bash-git-prompt doesn't work on Android (and perhaps other busybox-type systems)
# to enable the less-pretty but more reliable git prompt,
# set $USE_OLD_BASH_GIT_PROMPT to a non-null value
if [[ -n $USE_OLD_BASH_GIT_PROMPT ]]; then
    source $HOME/.git-prompt-fallback.sh
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWCOLORHINTS=true
    export PS1='\[\033[34m\]\u\[\033[0m\]@\[\033[33m\]\h\[\033[0m\]:\[\033[32m\]\w\[\033[0m\]\[\033[0m\]$(__git_ps1 " (%s)")$ '
else
    # bash-git-prpompt - https://github.com/magicmonty/bash-git-prompt
    # Set config variables first
    GIT_PROMPT_ONLY_IN_REPO=0
    GIT_PROMPT_FETCH_REMOTE_STATUS=0       # uncomment to avoid fetching remote status
    # GIT_PROMPT_IGNORE_SUBMODULES=1       # uncomment to avoid searching for changed files in submodules
    # GIT_PROMPT_SHOW_UPSTREAM=1           # uncomment to show upstream tracking branch
    # GIT_PROMPT_SHOW_UNTRACKED_FILES=all  # can be no, normal or all; determines counting of untracked files
    GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0  # uncomment to avoid printing the number of changed files
    # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh  # uncomment to support Git older than 1.7.10
    # as last entry source the gitprompt script
    GIT_PROMPT_THEME=Custom # use custom theme specified in file GIT_PROMPT_THEME_FILE (default ~/.git-prompt-colors.sh)
    GIT_PROMPT_THEME_FILE=~/.git-prompt-colors.sh
    source ~/.bash-git-prompt/gitprompt.sh
fi


# --- cleanup ---
unset HAVE_COLORFUL_GREP


# --- functions ---

# Move Verbose Lowercase Underscore
# Rename files to lowercase, replace spaces with underscores,
# and delete quotes and control characters.
mvlu () {
    for filename in "${@}"; do
        mv --verbose -- \
            "${filename}" \
            "$(echo "${filename}" \
                | tr '[:upper:]' '[:lower:]' \
                | tr '[:blank:]' '_' \
                | tr -d \'\" \
                | tr -d '[:cntrl:]'
              )"
    done
}

# build .gitignore using gitignore.io API
function wgitignore() {
    wget "https://www.gitignore.io/api/$1" -O - >> .gitignore
}

# Simple calculator
calc() {
    local result=""
    result="$(printf "scale=10;%s\\n" "$*" | bc --mathlib | tr -d '\\\n')"
    #						└─ default (when `--mathlib` is used) is 20

    if [[ "$result" == *.* ]]; then
        # improve the output for decimal numbers
        # add "0" for cases like ".5"
        # add "0" for cases like "-.5"
        # remove trailing zeros
        printf "%s" "$result" |
        sed -e 's/^\./0./'  \
        -e 's/^-\./-0./' \
        -e 's/0*$//;s/\.$//'
    else
        printf "%s" "$result"
    fi
    printf "\\n"
}

# Create a .tar.gz archive, using `pigz` or `gzip` for compression
targz() {
    local tmpFile="${1%/}.tar"
    tar -cf "${tmpFile}" "${1}" || return 1

    if hash pigz 2> /dev/null; then
        cmd="pigz"
    else
        cmd="gzip"
    fi

    echo "Compressing .tar using \`${cmd}\`..."
    "${cmd}" -v "${tmpFile}" || return 1
    [ -f "${tmpFile}" ] && rm "${tmpFile}"
    echo "${tmpFile}.gz created successfully."
}

# Determine size of a file or total size of a directory
fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi
    # shellcheck disable=SC2199
    if [[ -n "$@" ]]; then
        du $arg -- "$@"
    else
        du $arg -- .[^.]* *
    fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre() {
    tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
}

# simple function to send myself a file
mailmethis() {
    echo "Here is the file I Requested." | mail -a "$@" -s "Requested file" `whoami`
}

# colors in man
man() {
    env \
    LESS_TERMCAP_mb="$(printf '\e[1;31m')" \
    LESS_TERMCAP_md="$(printf '\e[1;31m')" \
    LESS_TERMCAP_me="$(printf '\e[0m')" \
    LESS_TERMCAP_se="$(printf '\e[0m')" \
    LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
    LESS_TERMCAP_ue="$(printf '\e[0m')" \
    LESS_TERMCAP_us="$(printf '\e[1;32m')" \
    man "$@"
}
