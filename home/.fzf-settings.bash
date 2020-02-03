# fzf - https://github.com/junegunn/fzf/

# Options to fzf command
#export FZF_COMPLETION_OPTS='+c -x'

# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_COMMAND='fd --type f --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

alias yay-fzf-install="yay -Slq | fzf -m --preview 'yay -Si {1}'| xargs -ro yay -S"

# colors - see https://minsw.github.io/fzf-color-picker/
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#a1a1a1,bg:#121212,hl:#5ba35e
 --color=fg+:#80c985,bg+:#262626,hl+:#76ed82
 --color=info:#77a378,prompt:#aee3b0,pointer:#47d951
 --color=marker:#a0d66b,spinner:#5c9c40,header:#87afaf'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# pass completion suggested by @d4ndo (#362)
# TODO: not working
_fzf_complete_pass() {
  _fzf_complete '+m' "$@" < <(
    pwdir=${PASSWORD_STORE_DIR-~/.password-store/}
    stringsize="${#pwdir}"
    find "$pwdir" -name "*.gpg" -print |
        cut -c "$((stringsize + 1))"-  |
        sed -e 's/\(.*\)\.gpg/\1/'
  )
}
complete -F _fzf_complete_pass -o default -o bashdefault pass

MANPATH=/usr/share/man
fman() {
    f=$(fd . $MANPATH/man${1:-1} -t f -x echo {/.} | fzf) && man $f
}
