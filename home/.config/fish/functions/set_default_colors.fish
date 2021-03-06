# argh, colors in pager got fucked, here are the defaults
# see https://github.com/fish-shell/fish-shell/issues/948#issuecomment-22302517

function set_default_colors
    set -g fish_color_normal normal
    set -g fish_color_command 005fd7 purple
    set -g fish_color_param 00afff cyan
    set -g fish_color_redirection normal
    set -g fish_color_comment red
    set -g fish_color_error red --bold
    set -g fish_color_escape cyan
    set -g fish_color_operator cyan
    set -g fish_color_quote brown
    set -g fish_color_autosuggestion 555 yellow
    set -g fish_color_valid_path --underline

    set -g fish_color_cwd green
    set -g fish_color_cwd_root red

    # Background color for matching quotes and parenthesis
    set -g fish_color_match cyan

    # Background color for search matches
    set -g fish_color_search_match --background=purple

    # Pager colors
    set -g fish_pager_color_prefix cyan
    set -g fish_pager_color_completion normal
    set -g fish_pager_color_description 555 yellow
    set -g fish_pager_color_progress cyan
end
