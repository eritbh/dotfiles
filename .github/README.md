# dotfiles

too many dotfiles

## Installation

Use [[GNU Stow]] (`apt install stow`, etc.). The repo has a `.stowrc` which should target your home directory as the installation directory, but in some cases the `~` may not be evaluated and you'll have to specify `--target="$HOME"`.

If you're using a shell that does match patterns where `*` doesn't match dotfiles by default (bash, zsh) you can just `cd` into this repo and `stow *` to install everything. You may also want to use `*~kde` (using the `~` exclude token) if you want the dotfiles for all the CLI tools but not my desktop environment shit. Or you can just list the shit you want.
