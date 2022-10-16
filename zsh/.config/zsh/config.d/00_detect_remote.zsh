# Detect if the current session is running on a remote server
# Runs first because multiple other things rely on this
if [ -n "$IS_REMOTE_SESSION" ] || [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    is_remote=1
else
    is_remote=
fi
export IS_REMOTE_SESSION=$is_remote
