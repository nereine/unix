#!/usr/bin/env bash
## linkweb.sh - link files for ssg5

# Source webtools.conf and source.sh
[[ "$fts_status" != 'ok' ]]\
&& . 'webtools.conf';

# Resource files are entered in webtools.conf

# Markdown directories (array indices/keys)
linkmd() {
	for d in "${!webdirs[@]}";
	do
		
		# for ssg5
		ln -sf "$linkweb_headf" "$d/_header.html";
		ln -sf "$linkweb_footf" "$d/_footer.html";
		
		# Non-ssg5
		# You can uncomment the lines below if you want ssg5 to automatically copy style.css and favicon.ico for you
		#ln -sf $linkweb_style "$d/style.css";
		#ln -sf $linkweb_logof "$d/favicon.svg";
		#ln -sf $linkweb_logof "$d/favicon.ico";
	done;
}

# HTML directories
linkht() {
	for d in "${webdirs[@]}";
	do
		ln -sf "$linkweb_logof" "$d/favicon.svg";
		ln -sf "$linkweb_logof" "$d/favicon.ico";
		ln -sf "$linkweb_style" "$d/style.css";
	done;
}

simyn "${0}: Link Markdown directories?"\
&& linkmd;
simyn "${0}: Link HTML directories?"\
&& linkht;
