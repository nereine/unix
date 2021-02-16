#!/usr/bin/env bash
## cleanup.sh cleans up the directories before processing

# Source webtools.conf and source.sh
[[ "$fts_status" != 'ok' ]]\
&& . 'webtools.conf';

## Delete files matching the keywords $cleanup_find
main() {
	# Get lookup path
	read -r -p "${0}: Relative path to search (DEFAULT=BLANK=${pwd}): " fdd;
	# File to delete directory 'fdd' which will contain files to delete 'ftd', defaults to $(pwd)
	[ -z "$fdd" ]\
	&& fdd='.';
	
	# cleanup_find is defined in webtools.conf
	# Do NOT double quote the array cleanup_find in the for loop below
	for k in ${cleanup_find[*]};
	do
	# cleanup_excl (defined in webtools.conf) is for exclusion
	# See https://stackoverflow.com/questions/4210042/how-to-exclude-a-directory-in-find-command to understand the line below
	ftd=$(find "$fdd" -path "$cleanup_excl" -prune -false -o -name "$k"); # files to delete
	
	findrm;
	done;
}

# Find and remove 'files to delete' $ftd
findrm() {
	# if no matched files were found, return to the loop
	[[ -z "$ftd" ]]\
	&& printf "%s: No files matching %s\n" "$0" "$k" && return 1\
	|| printf "%s\n" "$ftd";	
	# if matches were found, prompt user for removal
	simyn "${0}: Delete these files?"\
	&& find "$fdd" -path "./.stversions" -prune -false\
	-o -name "$k" -exec rm -f {} \;

	unset ynsh;
}

main;
