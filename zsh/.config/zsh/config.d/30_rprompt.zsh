# Hook preexec/precmd to dynamically set rprompt with useful info
function preexec {
    # Store command execution start time
    timer="${timer:-"$(date +%s.%N)"}"
}
function precmd {
    vcs_info
    # Start with a fresh prompt
    RPROMPT=""
    some_line=""
    if [ -z $new_session ]; then
        # If this is the first prompt in a session, there's not much to say
        RPROMPT="%B%F{cyan}new session%f%b"
        new_session=1
    else
        # Show exit code + more info about the last command run as a separate line
        some_line="exited %B%(?.%F{green}%?%f.%F{red}%?%f)%b"
        if [ -z $timer ]; then
            # If we never set $timer, preexec was never run (e.g. ^C at prompt)
            some_line="$(print -P "%B%F{cyan}no exec%f%b, $some_line")"
        else
            # Calculate elapsed real time for last command
            now="$(date +%s.%N)"
            if [[ $(($now - $timer)) > 0.5 ]]; then
                timer_show=$(($now - $timer))
                timer_show=$(printf '%.*f\n' 3 $timer_show)
                some_line="took %B%F{cyan}${timer_show}s%f%b, $some_line"
            fi
        fi
    fi

    # add current time, including timezone if remote, and collapse it if we're out of room
    RPROMPT="%<#<$RPROMPT at %D{%T$([ -n "$is_remote" ] && echo ' %Z')}"

    # that's an RPROMPT!
    export RPROMPT

    # always unset $timer for the next run
    unset timer
}
preexec_functions+=preexec
precmd_functions+=precmd
