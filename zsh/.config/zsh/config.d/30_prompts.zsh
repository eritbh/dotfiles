# Prompt stuff

# allow command substitutions at prompt time
setopt PROMPT_SUBST

# Hide rprompt after command execution
setopt TRANSIENT_RPROMPT

lineup=$'\e[1A'
linedown=$'\e[1B'
newline=$'\n'

# vcs_info - used for displaying VCS information in prompt
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '(%b) '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
autoload -Uz vcs_info
precmd_functions+="vcs_info"

# Prompt shows hostname if connected to a remote or if root
PROMPT_NORMAL="$newline%B$([ -n "$is_remote" ] || [ "$EUID" = 0 ] && echo "%F{magenta}%m%f ")%F{$([ "$EUID" = 0 ] && echo "red" || echo "\${PROMPT_NAME_COLOR:-cyan}")}%n%f %F{blue}%~%f%b \${vcs_info_msg_0_}$newline%B%#%b "

# Also create a minimal prompt which is displayed for previously run commands
PROMPT_MINIMAL="%F{$([ -n "$is_remote" ] && echo "magenta" || [ "$EUID" = 0 ] && echo "red" || echo "\${PROMPT_NAME_COLOR:-cyan}")}%B%#%b%f "

# Replace prompt with a smaller form on enter
PROMPT="$PROMPT_NORMAL"
function del-prompt-accept-line {
  # store current prompts
  # remove everything from left prompt except %/#
  PROMPT="$PROMPT_MINIMAL"
  RPROMPT_OLD="$RPROMPT"
  RPROMPT=""
  zle reset-prompt
  PROMPT="$PROMPT_NORMAL"
  RPROMPT="$RPROMPT_OLD"
  zle accept-line
}
zle -N del-prompt-accept-line
bindkey '^M' del-prompt-accept-line

# Multiline incomplete command prompt
PROMPT2="  "

# Hook preexec/precmd to dynamically set RPROMPT with useful info

# start a timer every time we exec something so we can see how long it took
preexec_functions+=start_prompt_timer
function start_prompt_timer {
    # Store command execution start time
    rprompt_exec_timer="${timer:-"$(date +%s.%N)"}"
}

# check the timer and add other info about the exec'd process to RPROMPT
# this needs to be the first precmd function because it needs to run before any
# other precmd hooks (e.g. the VS Code terminal integration hook) happen,
# otherwise $? will be fucked
precmd_functions=(build_rprompt ${precmd_functions[@]})
function build_rprompt {
    # Start with a fresh prompt
    RPROMPT=""
    if [ -z $new_session ]; then
        # If this is the first prompt in a session, there's not much to say
        RPROMPT="%B%F{cyan}new session%f%b"
        new_session=1
    else
        # Show exit code + more info about the last command run as a separate line
        RPROMPT="exited %B%(?.%F{green}%?%f.%F{red}%?%f)%b"
        if [ -z $rprompt_exec_timer ]; then
            # If we never set $timer, preexec was never run (e.g. ^C at prompt)
            RPROMPT="%B%F{cyan}no exec%f%b, $RPROMPT"
        else
            # Calculate elapsed real time for last command
            now="$(date +%s.%N)"
            if [[ $(($now - $rprompt_exec_timer)) > 0.5 ]]; then
                timer_show=$(($now - $rprompt_exec_timer))
                timer_show=$(printf '%.*f\n' 3 $timer_show)
                RPROMPT="took %B%F{cyan}${timer_show}s%f%b, $RPROMPT"
            fi
        fi
    fi

    # add exit time, including timezone if remote, and collapse it if we're out of room
    timeformat="%D{%T$([ -n "$is_remote" ] && echo ' %Z')}"
    exittime="$(print -P "$timeformat")"
    RPROMPT="$RPROMPT at $exittime"

    # this is all info about the previous command, so put it up a line from the main prompt
    RPROMPT="%{$lineup%}$RPROMPT%{$linedown%}"

    # that's an RPROMPT!
    export RPROMPT

    # always unset $timer for the next run
    unset rprompt_exec_timer
}
