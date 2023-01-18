# Enable comments at the command line (idk where else to put this)
setopt interactivecomments

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
function mkcd { mkdir -p $1 && cd $1 }

# Alias `code` to `code -r` if we're in the integrated terminal
if [ "$TERM_PROGRAM" = "vscode" ]; then
    alias code='code -r'
fi
