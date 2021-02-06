#!/bin/bash
# bash script for dwm status bar

# version is only updated after x login
VERS=$(uname -a | awk '{print $3}')
# time and battery is updated every minute
while true; do
	date +%A\ %H:%M > /tmp/CurTime.tmp && acpiconf -i 0 | grep Remaining\ cap | awk '{print $3}' > /tmp/Batt.tmp
	sleep 60
done &
# mem and temp are updated every 5s
while true; do
amem="$(freecolor -o | grep Mem )"		# all mem info
umem=$(printf "$amem\n" | awk '{print $3}')	# used memory
fmem=$(printf "$amem\n" | awk '{print $4}')	# free memory
pmem=$(printf "$umem/$fmem*100\n" | bc -l | cut -c1-4) # percentage used
	cputemp=$( sysctl -a | grep temperature | awk 'NR==1{print $2}')
	loctime=$(< /tmp/CurTime.tmp)
	batstat=$(< /tmp/Batt.tmp)
	xsetroot -name " $VERS | mem.used: $pmem% | temp: $cputemp | batt: $batstat | $loctime | $HOSTNAME "
	sleep 5
done &
