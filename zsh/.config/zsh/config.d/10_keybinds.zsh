# Bind ^Z on an empty line to resume the last suspended job
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# make delete key work; this gets fucked with by badly-behaved distros sometimes
bindkey "\e[3~" delete-char
