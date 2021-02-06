#!/bin/sh
# Define your 'sensors' filter
sfilter="thinkpad";
# Get sensor data with 'grep $sfilter'
sdata="$(sensors|grep -A3 $sfilter)";
# And format the output with awk
temp=$(echo $sdata | awk '{print $9}');
fans=$(echo $sdata | awk '{print $6}');
# Print formatted data
printf "%s\n%s RPM\n" "$temp" "$fans";
