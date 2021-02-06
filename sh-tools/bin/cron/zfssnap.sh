#!/bin/bash
set -e && zfs_pool=("zol" "tank") # add your pools here
for pool in ${zfs_pool[@]}; do zfs snapshot -r "$pool"@cron-"$(date +%F)" >/dev/null 2>&1 ; done && exit 0
