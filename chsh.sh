# chsh.sh is used to change sh-tools script headers to invoke different shells. It is written for ksh.

# chsh.sh must always be given 2 arguments $oldshell and $newshell, OR string literal '-l' and $newlinecontent, as $1 and $2 respectively.
# 'chsh.sh dash bash' will change (substitute) the first '#!/usr/bin/env dash' string (hopefully in 1st line) to '/usr/bin/env bash'
# 'chsh.sh -l "#!/bin/sh"' would substitute the whole line to '#!/bin/sh'

case "$1" in
	'-h'|'--help'|'h'|'help')
		less $0; ;;
esac

if [ -z "$2" ]; then
	printf "shctl: Illegal arguments\n";
	sed -n '4p;5p' < "$0";
else
	# Default wdir and script header
	dwdir="sh-tools/bin";
	# Get user input for working directory
	# Source readprompt() from yn.sh
	. sh-tools/bin/yn.sh;
	printf "Enter working directory without the trailing slash: \n";
	readprompt "[default = $dwdir]";
	
	if [ -z "$answer" ]; then
		wdir="$dwdir";
	else
		wdir="$answer";
	fi;

	case "$1" in
		# Line mode. Enter '-l' as $1 to use sed to substitute the whole line.
		'-l')
			sedcmd="1s,.*,$2,";
			;;

		# Env mode. sed will substitute the string '#!/usr/bin/env $1' to '#!/usr/bin/env $2'
		*)
			oldshell=$1;
			newshell=$2;
			shheader="#!/usr/bin/env";
			sedcmd="s,$shheader $oldshell,$shheader $newshell,";
			;;
	esac
	
	# Loop through all files in wdir
	printf "Will change 1st line of the following files to %s?\n" "$2"
	for f in "$wdir"/*; do
			# Prompt user for every file to change
			simyn "$f"\
			&& sed -i "$sedcmd" "$f"\
			&& printf "$f done:1:%s\n" "$(head -n 1 $f)";
	done;
fi;
