# where to look for the syntax highlighting repo
targetdir="$HOME/src/github.com/zsh-users/zsh-syntax-highlighting"
# if this file exists, do not attempt to load the highlight module
nohighlightfile="$HOME/.config/zsh/.nohighlight"

# loads the highlighter
function load_highlight {
	source "$targetdir/zsh-syntax-highlighting.zsh"
}

function confirm {
	while true; do
		read "answer?$* [(yes)/no]: "
		case $answer in
			[Yy]|yes|"")
				return 0
				;;
			[Nn]|no)
				return 1
				;;
		esac
	done
}

# only proceed if we haven't opted out
if [ ! -e "$nohighlightfile" ]; then
	# attempt to load the highlighter if the repo exists
	if [ -d "$targetdir" ]; then
		load_highlight
	else
		# if it isn't found, offer to clone it automatically
		if confirm "zsh-syntax-highlighting not found, clone into ~/src?"; then
			mkdir -p "$targetdir"
			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$targetdir"
			load_highlight
			clear
		else
			# we don't want highlighting, don't ask about it again
			mkdir -p "$(dirname $nohighlightfile)"
			touch "$nohighlightfile"
			echo "If you change your mind, delete $nohighlightfile and I'll ask again on your next session."
		fi
	fi
fi
