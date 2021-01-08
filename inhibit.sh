#!/bin/bash

#desired load average (1 min), above wich we prevent from sleeping and delay (suffix s,m,h) between actions
#debug set to non-zero will produce debug output
lavg_min="0.6"
delay="5m"
debug="0"

#is xdotool installed?
which xdotool &>/dev/null
xdotool_installed="$?"

if [ "$xdotool_installed" -ne 0 ]; then
	echo "xdotool not found/installed, please install and try again."
	exit 1
fi

while true; do
	#get load average (1min, second field from /proc), divide by number of CPUs to get load per core.
	#this makes it suitable for single-core and mulit-core systems equally.
	lavg=$(cat /proc/loadavg | cut -d ' ' -f 2)
	ncpus=$(nproc)
	lavg1=$(bc <<< "scale=2;${lavg}/${ncpus}")
	is_greater=`echo "$lavg1 >= $lavg_min" | bc`
	if [ "$debug" -ne 0 ]; then
		echo $(date)
		echo "Load Average: $lavg"
		echo "CPUS: $ncpus"
		echo "Load Average per CPU: $lavg1"
		echo "Load average (1min) of $lavg1 is greater than $lavg_min: $is_greater"
	fi

	if [ "$is_greater" -ne 0 ]; then
		echo "Condition met, simulating input on $(date)"
		xdotool mousemove --sync 100 100 mousemove --sync restore
	fi
	sleep "$delay"
done
