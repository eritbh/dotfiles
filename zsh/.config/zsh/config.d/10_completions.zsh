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
