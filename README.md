# dotfiles

too many dotfiles

## Install

Personally I like to keep all my repos in `~/src/github.com/<user>/<repo>`, but it's also handy to have my dotfiles directory at `~/.dotfiles`, so I start by doing:

```
mkdir -p ~/src/github.com/eritbh
git clone https://github.com/eritbh/dotfiles.git src/github.com/eritbh/dotfiles
ln -s ~/src/githhub.com/eritbh/dotfiles ~/.dotfiles
```

Then, you can install other stuff:

### zsh

```
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
```

### vim

```
ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc
```
