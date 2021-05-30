#!/bin/bash
# Extract data
# Convert all multiple consecutive spaces to a single space with tr -s
# Only the amount of free memory in kb
# Only the amount of total memory in kb
free_mem=$(grep "MemFree" /proc/meminfo | tr -s " " | cut -d" " -f2)
total_mem=$(grep "MemTotal" /proc/meminfo | tr -s " " | cut -d" " -f2) # Not really free memory

# Add text
free_mem="Free memory: $(( $free_mem / 1024))M"
total_mem="Total memory: $(( $total_mem / 1024))M"

# Display on dashboard
mem_out="$free_mem\n$total_mem\n"