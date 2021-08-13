#!/usr/bin/env bash
# install.sh only works with shells that support arrays for now

case "$1" in
	'-v')
		# Set rsync option to be verbose
		rsyncopt='v';	;;
	'-n'|'-d'|'--dry-run')
		rsyncopt='vn';	;;
esac;

# Use rsync(1) if available, else use cp(1)
[ -n "$(command -v rsync)" ]\
&& copycmd=rsync\
|| copycmd=cp;

# Source simyn.sh, lb.sh
myfiles=("sh-tools/bin/yn.sh" "sh-tools/bin/lb.sh")
for f in "${myfiles[@]}";
do
	. $f || printf "Failed to source %s\n" "$myfiles";
done;

# Create neccessary directory
mkdir -p "$HOME/bin" "$HOME/.config/shell";

rsyncf() {
	# usage: rsyncf $src $dest
	case "$copycmd" in
		'rsync')
			rsync "-ra${rsyncopt}"  "$1" "$2"; ;;
		'cp')
			cp -ra "$1" "$2"; ;;
	esac;
	
	[ -n $rsyncopt ]\
	&& printf "Copied %s to %s using %s\n" "$1" "$2" "$copycmd";
}

# Copy sh-tools/bin using rsync(1)
simyn "install.sh: Install sh-tools to $HOME/bin"\
&& rsync "-ra${rsyncopt}" "sh-tools/bin" "$HOME/";

# Home dotfiles (ones which that reside in $HOME)
line;
dots0="$(find "dotfiles/general" -maxdepth 1)";
printf "install.sh: Listing home dotfiles:\n%s\n" "$dots0";

# Copy home dotfiles, and skipping config for $HOME/.config
simyn "install.sh: Install home dotfiles to $HOME"\
&& \
for f in $dots0;
do
	[ "$f" = "dotfiles/general/config" ]\
	&& printf "Skipping dotfiles/general/config\n"\
	|| rsyncf "$f" "$HOME/";
done;

# Fix .vim symlinks
ICEBERG_VIM="$HOME/.vim/colors/iceberg.vim"
[ -d $HOME/git/iceberg.vim ] && [ -L $ICEBERG_VIM ] && [ ! -f $ICEBERG_VIM ]\
&& rm "$HOME/.vim/colors/iceberg.vim"\
&& ln -s "$HOME/git/iceberg.vim/colors/iceberg.vim" "$ICEBERG_VIM"\
&& printf "Fixed vim color symlink\n";

# $HOME/.config dotfile directories
line;
dots1=$(find dotfiles/general/config -type d);
printf "install.sh: Listing remainder dotfiles for ${HOME}/.config:\n%s\n" "$dots1";

# Copy $HOME/.config dotfile directories
simyn "install.sh: Install these directories?"\
&& \
for d in $dots1;
do
	rsyncf "$d" "$HOME/.config";
done;
