#!/bin/bash
# Extract data
running_proc=$(ps aux --no-headers | wc -l)

# Add text
running_proc="Process is running: $running_proc"

# Display on dashboard
proc_out="$running_proc\n"