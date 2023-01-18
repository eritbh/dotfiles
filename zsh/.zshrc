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
export PATH="$HOME/.1password-ssh-utils/bin:$PATH"
alias ssh="op-ssh-fetch -n && ssh"

# User program: make `wg-quick up wg0` less of a pain
function systemctl_toggle {
	if systemctl is-active --quiet $1; then
		sudo systemctl stop $1
	else
		sudo systemctl start $1
	fi
}
alias wg0="systemctl_toggle wg-quick@wg0.service"
