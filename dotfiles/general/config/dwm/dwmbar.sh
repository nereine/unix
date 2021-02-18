#!/bin/sh
# dwmbar.sh - dwm status bar script using 'xsetroot -name'

## Get static status information - These lines should work, yet it doesn't on my Sway setup except the one using 'whoami'
#myname="$(whoami)";
#myname="$USER"
#myhost=$(< /etc/hostname);
#myhost="$HOSTNAME"

# Override example
myname="artnoi";
myhost="t14";

## Get dynamic information
get_status() {
	data="$(sensors|grep -A3 thinkpad)";
	temp="$(echo $data | awk '{print substr($9,2); }')";
	fans="$(echo $data | awk '{print $6 " rpm"}')";
	batt="$(acpi -b | awk '{print tolower(substr($3, 1, length($3)-1)) ": " substr($4, 1, length($4)-1)}';)"; # Battery format = percentage%, status(charge/discharge)
	time="$(date +'%A, %b %d - %H:%M' | awk '{print tolower($0)}';)"; # Time format = DoW Hour:Min

	printf "%s | %s | %s | %s" "${myname}@${myhost}" "${temp}/${fans}" "$batt" "$time";
}

main() {
	while true;
	do
		# $WAYLAND is exported from $HOME/{.kshrc, .bash_profile
		[ -z $WAYLAND ]\
		&& xsetroot -name "$(get_status)"\
		&& arg='&'\
		|| echo "$(get_status)";
		# Status update interval
		sleep 2;
	done;
}

main "$arg";
