#!/usr/bin/env bash
# install.sh only works with shells that support arrays for now

case "$1" in
	'-v')
		# Set rsync option to be verbose
		rsyncopt='v';	;;
	'-n'|'-d'|'--dry-run')
		rsyncopt='vn';	;;
esac

# Source simyn.sh, lb.sh
myfiles=("sh-tools/bin/yn.sh" "sh-tools/bin/lb.sh")
for f in "${myfiles[@]}"; do 
	. $f || printf "Failed to source %s\n" "$myfiles";
done

# Create neccessary directory
mkdir -p "$HOME/bin" "$HOME/.config/shell";

# Copy sh-tools/bin using rsync(1)
simyn "install.sh: Install sh-tools to $HOME/bin"\
&& rsync "-ra${rsyncopt}" "sh-tools/bin" "$HOME/";

# Home dotfiles (ones which that reside in $HOME)
line;
simyn "install.sh: Install general dotfiles to $HOME"\
&& dots0=($(find "dotfiles/general" -maxdepth 1 -type f));
# Copy using home dotfiles for loop
for f in "${dots0[@]}"; do
	rsync "-ra${rsyncopt}" "$f" "$HOME";
done;

# Copy $HOME/.config dotfiles
line;
printf "install.sh: Listing remaining dotfiles:\n%s\n" "$(find dotfiles/general/config -type f)";
simyn "install.sh: Install these files?"\
&& rsync "-ra${rsyncopt}" "dotfiles/general/config/" "$HOME/.config/";
