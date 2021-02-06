#!/usr/bin/env bash
# source files-to-source (fts)
# It is usually used by sh-tools or web-tools to source yn.sh and lb.sh

# Source functions from scripts - this function is executed at the end of this file
source_fff() {
	# array for ksh
	#set -A fts "$HOME/bin/yn.sh" "$HOME/bin/lb.sh"
	# array for bash
	typeset -a fts=("$HOME/bin/yn.sh" "$HOME/bin/lb.sh")
	for s in "${fts[@]}" ;
		do [[ -x "$s" ]] && . "$s"\
		|| printf "source.sh: couldn't source functions from $fts\n";
	done;
}

# This function will be used by other scripts that use source.sh to run external scripts
run_ext_scripts() {
		. "$1"\
		|| printf "%s: previous command exit with status non-zero\nFTS status = %s\n" "$0" "$fts_status";
}

source_fff\
&& fts_status="ok"\
&& printf "source.sh: %s\n" "$fts_status"\
|| fts_status="failed";
