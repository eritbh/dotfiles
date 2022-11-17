# dotfiles

too many dotfiles

## Installation

Use [GNU Stow](https://www.gnu.org/software/stow/) (`apt install stow`, etc.). The repo has a `.stowrc` which should target your home directory as the installation directory, but in some cases the `~` may not be evaluated and you'll have to specify `--target="$HOME"`.

If you're using a shell that does match patterns where `*` doesn't match dotfiles by default (bash, zsh) you can just `cd` into this repo and `stow *` to install everything. You may also want to use `*~kde` (using the `~` exclude token) if you want the dotfiles for all the CLI tools but not my desktop environment shit. Or you can just list the shit you want.

## Notes

### Git

Most of my git configuration lives in `~/.config/git/personal.gitconfig`, which is `include`d from `~/.gitconfig`. I do this to separate system-specific configuration that may be set by automated tools (i.e. the Github CLI setting up credential managers for guthub.com and gist.github.com) from my personal, cross-platform configuration (e.g. my identity and aliases).

Keep configuration that should be synced between computers in the `personal.gitconfig` file, and after cloning the repository, consider telling Git to ignore local changes to the main `.gitconfig` file:

    git update-index --skip-worktree git/.gitconfig

## KDE

Files in `~/.local/share/color-schemes` come from [my repo of KDE titlebar color schemes](https://github.com/eritbh/kde-application-titlebar-themes).
