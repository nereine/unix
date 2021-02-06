#!/bin/sh
# firefox.sh - launch Firefox with specific environment variable

# Source environment table from firefox.sh.conf
ffconf="$HOME/bin/priv/firefox.sh.conf";
[ -f "$ffconf" ]\
&& . $ffconf;

# Browser is specified as 2nd argument in the command-line
# Default is firefox
[ -z "$2" ]\
&& BROWSER='firefox'\
|| BROWSER="$2";

# Example 0: 'firefox.sh artnoi.com' will use firefox to browse to artnoi.com
# Example 1: 'firefox.sh artnoi.com surf' will use surf to browse to artnoi.com
"$BROWSER" "$1";
