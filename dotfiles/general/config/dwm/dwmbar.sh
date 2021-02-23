# dwmbar.sh - dwm/Sway status bar script
### dwmbar.sh is POSIX shell compatible, and it works both under X11 dwm and Wayland-based Sway
### Just add shell alias sway='WAYLAND=1 sway' and it works just like that
# In short: This idiotic status file gets your basic but essential system info with get_status(),
# if on X11, it will use xsetroot to set dwm's simple status bar with the info string,
# but if on Wayland, it will just use printf to print the exact same string

## Get static status information - These lines should work, yet it doesn't on my Sway setup except the one using 'whoami'
#myname="$(whoami)";
#myname="$USER"
#myhost=$(< /etc/hostname);
#myhost="$HOSTNAME"

# Override example
myhost="T14"
myname="nereine";

## Get dynamic information - I tried my best to optimize this because it may be run very frequently
get_status() {
# Battery information is retrieved by 'acpi -b' and later formatted with awk to show the charging state and charge percentage
# Thermal information is retrieved by 'lm_sensors' and later formatted with awk. awk searches for desired string with regexp, in the default case it is /fan/, although you can always use other regxep to retrieve different lines from lm_sensors ('sensors')

	time="$(date +'%A, %b %d > %H:%M'\
	| awk '{print tolower($0)}';)";
	batt=$(acpi -b\
	| awk '{print tolower(substr($3, 1, length($3)-1)) ": " substr($4, 1, length($4)-1)}';);
	thermals=$(sensors\
	| awk '/fan/{c=2}c&&c-- {printf "%s ",$2} END {print ""}');

	# $thermals has trailing space, so the printf format below is a bit funny. Note that ${str%???} will remove 3 last chars from $str
	printf "%s | %s | %s | %s\n" "${myname}@${myhost}" "RPM ${thermals%?}" "$batt" "$time";
}

main() {
	while true;
	do
		## $WAYLAND is exported from $HOME/{.kshrc, .bash_profile}
		# $arg is used to idiotically enable forking on dwm, and therefore is needed for main()
		[ -z $WAYLAND ]\
		&& xsetroot -name "$(get_status)"\
		&& arg='&'\
		|| get_status;
		# Status update interval
		sleep 2;
	done;
}

# For testing, comment out main() and uncomment get_status()
main "$arg";
#get_status;
	
### other ways to get data
## Get static status information - These lines should work, yet it doesn't on my Sway setup except the one using 'whoami'
#myname="$(whoami)";
#myname="$USER"
#myhost=$(< /etc/hostname);
#myhost="$HOSTNAME"

## My shell can't do foo=$(< file), so I had to use cat(1) or kat (my own cat). For shells supporting foo=$(< file), we can read from file invoking cat needlessly. The different temperature file names are for examples only
	#temp=`kat /sys/class/hwmon/hwmon4/temp1_input`;
	#temp=$(< /sys/class/thermal/thermal_zone0/temp);
	
## Old, working script, though a bit bloated
	#data="$(sensors|grep -A3 thinkpad)";
	#fans="$(echo $data | awk '{print $6 " rpm"}')";
	#temp="$(echo $data | awk '{print substr($9,2); }')";
