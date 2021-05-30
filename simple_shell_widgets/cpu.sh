#!/bin/bash
# Extract data
cpu_name=$(grep "model name" /proc/cpuinfo | cut -d":" -f2 | sed s"/ //")
cpu_core=$(grep "cpu core" /proc/cpuinfo | cut -d":" -f2 | sed s"/ //")
cpu_mhz=$(grep "cpu MHz" /proc/cpuinfo | cut -d":" -f2 | sed s"/ //")

# Add text
cpu_name="CPU Name: $cpu_name"
cpu_core="CPU Cores: $cpu_core" # Wrong core number
cpu_mhz=$( bc <<< "scale=2; $cpu_mhz / 1024" ) # Floating-point arithmetic for GHz
cpu_mhz="CPU Freq: $cpu_mhz GHz"

# Display on dashboard
cpu_out="$cpu_name\n$cpu_core\n$cpu_mhz\n"