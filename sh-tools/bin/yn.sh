#!/bin/sh
# yn.sh stupid yes/no prompt to be used by POSIX shells
# $answer was neither yes/no
notyn() {
	unset answer
	printf "Please enter Y or N for yes or no\n"
	unset yesno
}

# Simple yes/no prompt
simyn() {
	unset answer
	while true ; do
		printf "$1 (y/N): "
		read answer
		case "$answer" in 
			Y|y)	return 0 && break ;;
			N|n)	return 1 && break ;;	
			*) notyn ;;
		esac
	done
}

# Simple string prompt
readprompt() {
	unset answer
	printf "%s: " "$1"
	read answer
}
