#!/usr/bin/env bash
## sendweb.sh - send HTML pages in directories whose names match keyword $sendweb_find to send destination $sendweb_dest

# Source external files and source.sh
[[ "$fts_status" != 'ok' ]]\
&& . 'webtools.conf';


sendweb() {
	
	# Search one-level for directories with names matching $sendweb_find
	declare -a send_dir=$(find . -maxdepth 1 -name "$sendweb_find" -type d);
	
	for dir in ${send_dir[@]};
	do
		# dest is associative array key (index)
		for dest in ${!sendweb_dest[@]};
		do
			simyn "sendweb.sh: Send ${dir} to ${dest}?"\
			|| break

			simyn "Do you want to tar ${dir} before sending?"\
			&& tar -cf "/tmp/${dir}.tar" "${dir}"\
			&& dir="/tmp/${dir}.tar";
			
			line\
			&& printf "sendweb.sh: Sending %s to %s\n" "$dir" "$dest"\
			&& scp -r "$dir" "${sendweb_dest[$dest]}";
		done;
		line;
	done;
}

sendweb;
