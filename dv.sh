#!/usr/bin/env bash
# dv - stupid diff viewer using 'diff -rq'. It is strictly bash-dependent.

# To use dv, edit defdirs[] values in main() or enter just them in the prompts below

# dvdirs[0] is usually your working directory.
# dvdirs[1] is usually your reference/upstream directory.

# e.g. If [0] is empty and [1] has a new file, dv.sh will then show that the new file differs, but will show nothing when [0] has a new file which does not exist in [1].

# If 'f', 's', 'sync', 'fix' is given at the command-line,
# dv.sh will use rsync to sync certain files from [0] to [1].

# Always print the comment lines above
head -n 12 < "$0";

get_userdirs() {
	printf "\nEnter dvdirs[] below without the trailing slashes\n"
	for i in 0 1; do
		printf "Enter dvdirs[%s]: " "$i";
		read userdirs["$i"];
	done;
}

main() {
	# Default directories defdirs[2] is can be set here
	defdirs[0]="$HOME/bin"
	defdirs[1]="$HOME/git/unix/sh-tools/bin"
	#defdirs[0]="$HOME/.config"
	#defdirs[1]="$HOME/git/unix/dotfiles/general/config"

	# Our directories will be stored in an array of 2 ${dvdirs[]}.
	# You should audit dv before deciding which item is which array items
	for i in 0 1; do
		[ -z "${userdirs[$i]}" ]\
		&& printf "Using default for dvdirs[%s]: %s\n" "$i" "${defdirs[$i]}"\
		&& dvdirs[$i]="${defdirs[$i]}"\
		|| dvdirs[$i]="${userdirs[$i]}";
	done;

	# 'awk' is used to filter all but the 2nd field of the output, which is the files in ${mydir[0]}
	# 'sed' is then used to extract the relative path of the file to ${mydir[0]}
	# For unfiltered 'diff -rq' output, use the line without 'awk' and 'sed' below
	#differf="$(diff -rq ${dvdirs[0]} ${dvdirs[1]} | grep 'differ')"
	differf="$(diff -rq ${dvdirs[0]} ${dvdirs[1]} | grep 'differ'| awk '{print $2}' | sed "s,${dvdirs[0]}/,,g")";
	
	printf "\nListing differing files (reference = %s):\n%s\n" "${dvdirs[1]}" "$differf";
	printf "\n%s compared to %s\n" "${dvdirs[0]}" "${dvdirs[1]}";
	
	[ -z "$1" ] && return 0;
	case "$1" in
		# Sync differing files
		'-f'|'f'|'fix'|'s'|'sync')
			printf "dv.sh: option=fix/sync\n";
			rsyncf "${dvdirs[1]}" "${dvdirs[0]}"; ;;
		'-r'|'r'|'reverse')
			printf "dv.sh: option=reverse-sync\n";
			rsyncf "${dvdirs[0]}" "${dvdirs[1]}"; ;;
	esac
}

# If argument $1 is specified, then dv.sh will use rsync to copy from ${dvdirs[0]} to ${dvdirs[1]}
rsyncf() {
	# Source yn.sh from user's home to provide readprompt()
	# dv.sh should already be distributed with sh-tools/bin/yn.sh
	. "$HOME/bin/yn.sh";
	
	# Prompt user for target files - user input will be returned by as $answer by readprompt()
	# main() displayed filtered output, so it's safe if the user enters relative path as displayed
	printf "\nrsyncf(): Copy from %s to %s\n" "$1" "$2";
	readprompt "Select file or directory name from above output";

		# We will try to sync ${dvdirs[*]} here
		if [[ "$answer" == *"/"* ]]; then
				# If $answer contains forward slash, append $answer to target
				rsync -rva "$1/$answer" "$2/$answer";
		else
				# If $answer does not have forward slash,
				# i.e. it is top-level file or directory, use dot '.'
				rsync -rva "$1/$answer" "$2/.";
		fi;
}

declare -a dvdirs defdirs userdirs;
get_userdirs;
main "$1";
