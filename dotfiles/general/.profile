# .profile - setup shell
# Tested on bash, mksh, ksh, zsh on GNU/Linux
# Get kernel info
if [ -z "$OS" ]; then
	kern="$(uname)";
	case "$kern" in
	# Get OS info
		'Darwin')
			export OS="$kern" ;;
		'OpenBSD')
			export OS="$kern" ;;
		'FreeBSD')
			export OS="$kern" ;;
		'Linux')
			[ -n "$(command -v apt-get )" ] && export OS="Debian";
			[ -n "$(command -v pacman )" ] && export OS="Arch";
			[ -n "$(command -v xbps)" ] && export OS="Void";
			[ -n "$(command -v dns)" ] && export OS="Redhat"; ;;
	esac;
fi;

# Wayland support
[ "$XDG_SESSION_TYPE" = 'wayland' ]\
&& export WAYLAND=1\
&& export MOZ_ENABLE_WAYLAND=1;

case "$SHELL" in
	# For ksh family, e.g. ksh, mksh, loksh
	*'ksh')
		export ENV="$HOME/.kshrc"; ;;
	'bash')
		export ENV="$HOME/.bashrc"; ;;
esac;
