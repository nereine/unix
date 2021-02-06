#!/bin/sh
set -e
fstrim_history=/home/artnoi/fstrim
echo "$(date +%F): $(fstrim -av)" >> $fstrim_history
echo "$(date +%F): $(fstrim -v /)" >> $fstrim_history
# ZFS on root can use 'autotrim' option or manually issuing "zpool trim"
exit
