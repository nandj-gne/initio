

#
# User configuration sourced by login shells
#

# XDG Compliant Structure
XDG_CONFIG_HOME=$HOME/.config
source "$XDG_CONFIG_HOME/zsh/zshenv"


# Initialize zim
[[ -s ${ZIM_HOME}/login_init.zsh ]] && source ${ZIM_HOME}/login_init.zsh
