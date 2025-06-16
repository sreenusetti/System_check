#!/bin/bash
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
mem=$(free | awk '/Mem:/ {print ($3/$2)*100}')
disk=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "CPU=$cpu"
echo "RAM=$mem"
echo "DISK=$disk"
