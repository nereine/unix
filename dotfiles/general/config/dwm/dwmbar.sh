# dwmbar.sh - dwm status bar script using 'xsetroot -name'

## Get static status information
# These 2 items should work on most systems
myname="$(whoami)";
myhost="$HOSTNAME";
# Override example
myhost="T14"

## Get dynamic information
get_status() {
	sdata="$(sensors|grep -A3 thinkpad)"
	temp="$(echo $sdata | awk '{print $9}')";
	fans="$(echo $sdata | awk '{print $6}')";
	batstat="$(acpi|awk '{print $4}'|sed 's/,//')";
	# Time format = DoW Hour:Min
	loctime="$(date +'%A %b %d | %H:%M')";

	printf "temp: %s rpm | batt: %s | %s | %s" "$temp/$fans" "$batstat" "$loctime" "$myname@$myhost";
}

main() {
	while true; do
		# $WAYLAND is exported from $HOME/{.kshrc, .bash_profile
		[ -z $WAYLAND ]\
		&& xsetroot -name "$(get_status)"\
		&& arg='&'\
		|| echo "$(get_status)";
		# Status update interval
		sleep 5;
	done;
}

main $arg
