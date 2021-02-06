#!/bin/sh
# ufw.sh - Stupid shell script for ufw(8)

## get_rules() will source external script ufw.sh.conf
## Example for ufw.sh.conf at https://gitlab.com/artnoi-staple/unix/sh-tools/bin/ufw.sh.conf.example
get_rules() {
	# ufw.sh is usually run as root,
	# so specifying $HOME/path/to/ufw.conf is not actually going to work
	conf="/home/artnoi/bin/ufw.sh.conf";
	
	# If $conf not available, get_rules() will just silently notify user without exiting/returning, and ufw.sh will continue to bring the firewall up
	test -f "$conf" || printf "%s not found\n" "$conf";
	test -r $conf && . $conf || printf "%s not readable\n" "$conf";
}

# Clean slate
ufw reset;

# Some defaults
ufw allow in on l0;
ufw allow in on wg0;
ufw default deny incoming;
ufw default allow outgoing;

# Our rules from ufw.sh.conf
get_rules;

# Bringing firewall up + print current rules
ufw enable;
ufw status numbered;
