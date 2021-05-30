#!/bin/bash
# Colors
none="\e[0m"
cyan="\e[36m"
dgrey="\e[90m"

# Extract data
disk_name=$(lsblk -o NAME | grep "^sd" | sed s"/^sd/\/dev\/sd/")
disk_num=$(lsblk -o NAME |grep "^sd" | wc -l) 
(( disk_num > 1 )) && disk_name=$(echo $disk_name | sed "s/ /, /g") # Nicer looking if more than 1 disk
disk_size=$(df --output=size / | tail -n +2 | sed "s/ //") # in K
disk_free=$(df --output=avail / | tail -n +2 | sed "s/ //") # in K
disk_used=$(df --output=pcent / | tail -n +2 | sed "s/ //") # %
# Draw status bar for used space
disk_used_num=${disk_used:0:1}
disk_used_full="##########"
disk_used_empty="##########"
disk_status="[$cyan${disk_used_full:0:$disk_used_num}$dgrey${disk_used_empty:0:-$disk_used_num}$none]"


# Add text
disk_name="All available disks: $disk_name"
disk_size="Total size: $(( $disk_size / 1024 ))M"
disk_free="Free disk space: $(( $disk_free / 1024 ))M"
disk_used="Used: $disk_used"

# Display on dashboard
disk_out="$disk_name\n$disk_size\n$disk_free\n$disk_used $disk_status\n"