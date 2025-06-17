#!/bin/bash

# Get CPU usage (percentage of CPU that is NOT idle)
cpu_usage=$(top -bn1 | grep 'Cpu(s)' | awk '{print 100 - $8}' | awk '{printf "%.2f", $0}')

# Get Memory usage percentage
mem_usage=$(free | awk '/Mem:/ {print ($3/$2) * 100}' | awk '{printf "%.2f", $0}')

# Get root filesystem usage percentage
disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//' | awk '{printf "%.2f", $0}')

# Output the data as a single line of JSON. This is crucial for easy parsing in Ansible.
echo "{\"cpu\": ${cpu_usage}, \"ram\": ${mem_usage}, \"disk\": ${disk_usage}}"
