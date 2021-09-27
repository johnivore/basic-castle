# NOTE: if you make any changes, run git_prompt_reset (and be in a git repo)

override_git_prompt_colors() {
    GIT_PROMPT_THEME_NAME="Custom"

    GIT_PROMPT_PREFIX="("
    GIT_PROMPT_SUFFIX=")"
    GIT_PROMPT_SEPARATOR=""
    GIT_PROMPT_STAGED="${Yellow}●${ResetColor}"
    GIT_PROMPT_CONFLICTS="${Red}✖${ResetColor}"
    GIT_PROMPT_CHANGED="${Green}●${ResetColor}"
    GIT_PROMPT_UNTRACKED="${Red}●${ResetColor}"
    GIT_PROMPT_STASHED="${Green}⚑${ResetColor}"
    GIT_PROMPT_CLEAN="${Green}✔${ResetColor}"
    GIT_PROMPT_SYMBOLS_NO_REMOTE_TRACKING="✭"
    GIT_PROMPT_BRANCH="${Green}"

    # Python
    GIT_PROMPT_VIRTUALENV="(${DimGreen}_VIRTUALENV_${ResetColor}) ";

    # GIT_PROMPT_SYMBOLS_AHEAD=""
    GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0

    GIT_PROMPT_COMMAND_FAIL="${Red}✘"

    GIT_PROMPT_END_USER=" ${ResetColor}\$ "
    GIT_PROMPT_END_ROOT=" ${Red}# ${ResetColor}"

    GIT_PROMPT_START_USER="${Blue}\\h ${Green}${PathShort}${ResetColor}"
    GIT_PROMPT_START_ROOT="${Red}\\u${ResetColor}@${Yellow}\\h ${Green}${PathShort}${ResetColor}"
}

reload_git_prompt_colors "Custom"
