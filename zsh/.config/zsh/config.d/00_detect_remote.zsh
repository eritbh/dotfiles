# Detect if the current session is running on a remote server by listing parent
# processes of this shell and checking for things like sshd/tailscaled. Runs
# first because multiple other things rely on this.

# names of daemon processes a remote shell might be a child process of
remote_daemons=(
    sshd
    tailscaled
)

is_remote=()
parent_procs="$(pstree -s $$)"
for d in $remote_daemons[@]; [[ "$parent_procs" =~ "$d" ]] && is_remote+="$d"

[ $#is_remote -gt 0 ] && export IS_REMOTE_SESSION="$is_remote[@]"
