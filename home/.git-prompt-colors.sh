# NOTE: if you make any changes, run git_prompt_reset (and be in a git repo)

override_git_prompt_colors() {
    GIT_PROMPT_THEME_NAME="Custom"

    GIT_PROMPT_PREFIX="("
    GIT_PROMPT_SUFFIX=")"
    GIT_PROMPT_SEPARATOR=""
    GIT_PROMPT_STAGED="${DimYellow}●${ResetColor}"
    GIT_PROMPT_CONFLICTS="${Red}✖${ResetColor}"
    GIT_PROMPT_CHANGED="${DimGreen}●${ResetColor}"
    GIT_PROMPT_UNTRACKED="${DimRed}●${ResetColor}"
    GIT_PROMPT_STASHED="${Green}⚑${ResetColor}"
    GIT_PROMPT_CLEAN="${Green}✔${ResetColor}"
    GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING="✭"
    GIT_PROMPT_BRANCH="${DimGreen}"

    # GIT_PROMPT_SYMBOLS_AHEAD=""
    GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0

    GIT_PROMPT_COMMAND_FAIL="${Red}✘"

    GIT_PROMPT_END_USER="${ResetColor}\$ "
    GIT_PROMPT_END_ROOT="${BoldRed}# ${ResetColor}"

    GIT_PROMPT_START_USER="${DimGreen}\\u${ResetColor}@${DimYellow}\\h ${DimGreen}${PathShort}${ResetColor}"
    GIT_PROMPT_START_ROOT="${BoldRed}\\u${ResetColor}@${DimYellow}\\h ${DimGreen}${PathShort}${ResetColor}"
}

reload_git_prompt_colors "Custom"
