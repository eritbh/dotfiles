# Hook preexec/precmd to dynamically set rprompt with useful info
preexec_functions+=start_prompt_timer
function start_prompt_timer {
    # Store command execution start time
    timer="${timer:-"$(date +%s.%N)"}"
}

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
        if [ -z $timer ]; then
            # If we never set $timer, preexec was never run (e.g. ^C at prompt)
            RPROMPT="%B%F{cyan}no exec%f%b, $RPROMPT"
        else
            # Calculate elapsed real time for last command
            now="$(date +%s.%N)"
            if [[ $(($now - $timer)) > 0.5 ]]; then
                timer_show=$(($now - $timer))
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
    lineup=$'\e[1A'
    linedown=$'\e[1B'
    RPROMPT="%{$lineup%}$RPROMPT%{$linedown%}"

    # that's an RPROMPT!
    export RPROMPT

    # always unset $timer for the next run
    unset timer
}
