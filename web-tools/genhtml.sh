#!/usr/bin/env bash
## genhtml.sh uses ssg5 to generate static HTML web pages from Markdown files

# Source webtools.sh and source.sh
[[ "$fts_status" != 'ok' ]]\
&& . 'webtools.conf';

genhtml() {
	
	## genhtml() uses associative arrays: ["md-dir"]="html-dir"
	# The array ${webdir[]} is defined in webtools.conf
	# See https://linuxconfig.org/how-to-use-arrays-in-bash-script	
	
	for web in "${!webdirs[@]}" ;
	do
		simyn "${0}: Generate html for ${web}"\
		&& ssg5 "${web[@]}" "${webdirs[$web]}"\
		'Artnoi.com' 'https://artnoi.com';
	done;
}

# Generate HTML files
genhtml;
