# If on WSL, define DISPLAY with the local system address from /etc/resolv.conf
# to enable GUI applications via an X server running under Windows
if [ -n "$WSL_DISTRO_NAME" ]; then
    export DISPLAY="$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0"
fi
