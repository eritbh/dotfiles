# Completion settings
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' format '%B%U%d%u%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(@s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:]}={[:upper:]}' '+r:|[._-]=** r:|=**' '+'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=0 yes=0
zstyle ':completion:*' select-prompt '%SScroll to view more completions (%l, %p)%s'
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/erin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# History management
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="$HOME/.zhistory"
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

# If on WSL, define DISPLAY with the local system address from /etc/resolv.conf
# to enable GUI applications via an X server running under Windows
if [ -n "$WSL_DISTRO_NAME" ]; then
    export DISPLAY="$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0"
fi

# Aliases for color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
fi

# Functional aliases
alias ll='ls -laFh'
alias la='ls -aFh'
alias l='ls -CFh'
alias clip='xclip -selection clipboard'
alias copy='clip'

# Prompt stuff
setopt PROMPT_SUBST

# Detect if the current session is running on a remote server
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    is_remote=1
else
    is_remote=
fi

# Function to get the current branch name
function parse_git_branch {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' -e 's/((/(/' -e 's/))/)/'
}

# Set the main prompt to show hostname if connected remotely + git branch
export PROMPT="%B$([ -n "$is_remote" ] && echo "%F{blue}%m%f ")%F{cyan}%n%f %F{blue}%~%f%b\$(parse_git_branch) %B%#%b "

# Hook preexec/precmd to dynamically set rprompt with useful info
function preexec {
    # Store command execution start time
    timer="${timer:-"$(date +%s.%N)"}"
}
function precmd {
    # Start with a fresh prompt
    RPROMPT=""
    if [ -z $new_session ]; then
        # If this is the first prompt in a session, there's not much to say
        RPROMPT="%B%F{cyan}new session%f%b"
        new_session=1
    else
        # Show exit code + more info about the last command run
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

    # add current time, including timezone if remote, and collapse it if we're out of room
    RPROMPT="%<#<$RPROMPT at %D{%T$([ -n "$is_remote" ] && echo ' %Z')}"

    # that's an RPROMPT!
    export RPROMPT

    # always unset $timer for the next run
    unset timer
}
preexec_functions+=preexec
precmd_functions+=precmd

# mostly just adding stuff to $PATH now

# User program: add node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# User program: add ~/.local/bin/*
export PATH="$PATH:$HOME/.local/bin"

# User program: add dart sass
export PATH="$PATH:$HOME/.local/bin/dart-sass"

# User program: add yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# User program: add 1password SSH utils
export PATH="$HOME/.1password-ssh-utils/bin:$PATH"
alias ssh="op-ssh-fetch -n && ssh"
