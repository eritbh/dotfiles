# Set named directories to shorten path display on non-remote systems
if [ -z "$is_remote" ]; then
    hash -d gh=~/src/github.com
    hash -d gl=~/src/gitlab.com
    hash -d gist=~/src/gist.github.com
fi
