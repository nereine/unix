#!/bin/bash
Xorg_log=("/home/artnoi/.local/share/xorg"/*)
otherlog=("/var/log/Xorg.0.log" "/home/artnoi/.cache/openbox/openbox.log")
cleanlog=(${Xorg_log[@]} "${otherlog[@]}")
# printf "%s\n" "Trimming the following log files:" "${cleanlog[@]}"
for logfile in "${cleanlog[@]}";
do
	tail -n 50 "$logfile" | sudo tee "$logfile" >/dev/null 2>&1 ;
done;
