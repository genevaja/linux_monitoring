#!/bin/bash

if [[ "$#" > 0 ]]; then
    >&2 echo Arguments don\'t required. Launch script again without arguments.
    exit 1
fi

echo HOSTNAME = $(hostname) | tee -a output.tmp
echo TIMEZONE = $(cat /etc/timezone) UTC $(date +%:::z) | tee -a output.tmp
echo USER = $(whoami) | tee -a output.tmp
echo OS = $(uname -o) $(grep PRETTY_NAME /etc/os-release | sed 's/PRETTY_NAME=//') | tee -a output.tmp
echo DATE = $(date '+%d %b %Y %X') | tee -a output.tmp
echo UPTIME = $(uptime -p | sed 's/up //') | tee -a output.tmp
echo UPTIME_SEC = $(cat /proc/uptime | awk '{print $1}') | tee -a output.tmp
echo IP = $(ifconfig | grep inet | awk 'NR == 1{print $2}') | tee -a output.tmp
echo MASK = $(ifconfig | grep inet | awk 'NR == 1{print $4}') | tee -a output.tmp
echo GATEWAY = $(ip route | awk 'NR == 1{print $3}') | tee -a output.tmp
echo $(free) > free_output.txt
# Load ram_total from ./free_output.txt in 8th position | tee -a output.tmp
ram_total="$(awk 'NR == 1{print $8/1024/1024}' ./free_output.txt)"
printf "RAM_TOTAL = %.3f GB\n" $ram_total | tee -a output.tmp
ram_used="$(awk 'NR == 1{print $9/1024/1024}' ./free_output.txt)"
printf "RAM_USED = %.3f GB\n" $ram_used | tee -a output.tmp
ram_free="$(awk 'NR == 1{print $10/1024/1024}' ./free_output.txt)"
printf "RAM_FREE = %.3f GB\n" $ram_free | tee -a output.tmp
rm -f free_output.txt
echo $(df | grep '[/]\B') > grep_output.txt
space_root="$(awk 'NR == 1{print $2/1024}' ./grep_output.txt)"
printf "SPACE_ROOT = %.2f MB\n" $space_root | tee -a output.tmp
space_root_used="$(awk 'NR == 1{print $3/1024}' ./grep_output.txt)"
printf "SPACE_ROOT_USED = %.2f MB\n" $space_root_used | tee -a output.tmp
space_root_free="$(awk 'NR == 1{print $4/1024}' ./grep_output.txt)"
printf "SPACE_ROOT_FREE = %.2f MB\n" $space_root_free | tee -a output.tmp
rm -f grep_output.txt
echo -n "Save report? "
read var
if [[ "$var" = y || "$var" = Y ]]; then
    mv output.tmp "$(date '+%d_%b_%Y_%X').status"
else
rm -f output.tmp
fi
exit 0
