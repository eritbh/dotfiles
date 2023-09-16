# Load seperated config files
for conf in "$HOME/.config/zsh/config.d/"*.zsh; do
  source "${conf}"
done
unset conf

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
if [ -d "$HOME/.1password-ssh-utils/bin" ]; then
  export PATH="$HOME/.1password-ssh-utils/bin:$PATH"
  alias ssh="op-ssh-fetch -n && ssh"
fi

# User program: add rbenv
[ -d "$HOME/.rbenv/bin" ] && eval "$(~/.rbenv/bin/rbenv init - zsh)"
