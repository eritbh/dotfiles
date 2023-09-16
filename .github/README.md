# dotfiles

too many dotfiles

## Installation

Use [GNU Stow][stow] (`apt install stow`, etc.). The repo has a `.stowrc` which
should target your home directory as the installation directory, but in some
cases the `~` may not be evaluated and you'll have to specify
`--target="$HOME"`.

Install the essentials with `stow zsh vim git`.

## Notes

### Git

Most of my git configuration lives in `~/.config/git/personal.gitconfig`, which
is `include`d from `~/.gitconfig`. I do this to separate system-specific
configuration that may be set by automated tools (i.e. the Github CLI setting up
credential managers for guthub.com and gist.github.com) from my personal,
cross-platform configuration (e.g. my identity and aliases).

Keep configuration that should be synced between computers in the
`personal.gitconfig` file, and after cloning the repository, consider telling
Git to ignore local changes to the main `.gitconfig` file:

    git update-index --skip-worktree git/.gitconfig

### zsh

The zsh config has secrets now, because of the prompt username color fetching
thing. You'll probably want to avoid committing your secrets:

    git update-index --skip-worktree zsh/.config/zsh/config.d/00_secrets.zsh

The prompt will still work if you don't fill in anything in that file, it'll
just always be the default color (your terminal's `cyan`).

### KDE

KDE stuff is split up a lot. If you want everything, `stow kde-*` should work in
all the shells I care about.

#### `kde-autostart-ksuperkey`

Adds an autostart entry for `/usr/bin/ksuperkey -e 'Super_L=Alt_L|F2'`, which
maps presses of the left meta key to Alt+F2 (the default bind for krunner).
[ksuperkey][ksuperkey] can only be used in X, it breaks on Wayland. Install it
via adding dependencies, cloning, `make`, and `make install`:

    # on debian/etc: 
    # sudo apt install git gcc make libx11-dev libxtst-dev pkg-config
    # on fedora-based things:
    # sudo dnf install git gcc make libX11-devel libXtst-devel pkgconfig
    mkdir -p ~/src/github.com/hanschen
    cd ~/src/github.com/hanschen
    git clone https://github.com/hanschen/ksuperkey.git
    cd ~/src/github.com/hanschen/ksuperkey
    make
    sudo make install

#### `kde-autostart-syncthing`

Adds an autostart entry for
`/usr/bin/syncthing serve --no-browser --logfile=default`, which starts
Syncthing without opening the web UI and logs to files in
`~/.config/syncthing`. Install [Syncthing][syncthing] via your package manager,
probably.

#### `kde-dolphin`

Configuration for Dolphin. Mostly toolbar layout and icon sizes.

#### `kde-icon-*`

Custom icons for various apps I use. They wind up in
`~/.local/share/icons/hicolor/*` alongside other icons for user-installed apps.

#### `kde-konsole`

My Konsole profile, as well as some additional configuration for default window
size on different screens. You can see what screen sizes I use in here!

Konsole also stores window *position* in this file, which I super do not care
about. You will probably want to skip-worktree this file as well:

    git update-index --skip-worktree kde-konsole/.config/konsolerc

#### `kde-krunner`

Just adds a `.desktop` entry that launches krunner. Mostly useful as a thing I
used to keep on my application switcher, but nowadays I don't really use it - if
I have a launcher icon on my dock at all, it'll be a proper switcher so I can
log out/shutdown/etc without my keyboard if I need to.

#### `kde-kwin-apprules`

Custom application rules for `kwin`. Files in `~/.local/share/color-schemes`
come from [my repo of KDE titlebar color schemes][colors].

#### `kde-spectacle`

Configures Spectacle to act more like ShareX or macOS's screenshot tool by
default - pressing print screen will bring up rectangle select, and hitting
enter will save the screenshot to disk and copy the image contents to the
clipboard. My screenshots are saved to
`~/Pictures/Screenshots/YYYY-MM/YYYYMMDDHHmmSS.png`.

Spectacle also stores the path of the last saved image in config, so it's
another one for skip-worktree:

    git update-index --skip-worktree kde-spectacle/.config/spectaclerc

[colors]: https://github.com/eritbh/kde-application-titlebar-themes
[ksuperkey]: https://github.com/hanschen/ksuperkey
[stow]: https://www.gnu.org/software/stow
[syncthing]: https://syncthing.net
