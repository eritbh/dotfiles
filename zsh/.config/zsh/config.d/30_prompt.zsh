# Prompt stuff
setopt PROMPT_SUBST

# vcs_info - used for displaying VCS information in prompt
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '(%b) '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
autoload -Uz vcs_info
precmd_functions+="vcs_info"

# Prompt shows hostname if connected to a remote or if root
PROMPT="%B$([ -n "$is_remote" ] || [ "$EUID" = 0 ] && echo "%F{magenta}%m%f ")%F{$([ "$EUID" = 0 ] && echo "red" || echo "cyan")}%n%f %F{blue}%~%f%b \${vcs_info_msg_0_}%B%#%b "

