#!/bin/bash

. ./color_setting.sh
. ./color_scheme.sh
. ./getting_presets.sh

if [[ "$#" > 0 ]]; then
    >&2 echo Arguments don\'t required. Launch script again without arguments.
    exit 1
fi

getting_presets2

echo -e "${A_SET}HOSTNAME${NC} = ${V_SET}$(hostname)${NC}" 
echo -e "${A_SET}TIMEZONE${NC} = ${V_SET}$(cat /etc/timezone) UTC $(date +%:::z)${NC}"
echo -e "${A_SET}USER${NC} = ${V_SET}$(whoami)${NC}" 
echo -e "${A_SET}OS${NC} = ${V_SET}$(uname -o) $(grep PRETTY_NAME /etc/os-release | sed \
    's/PRETTY_NAME=//')${NC}" 
echo -e "${A_SET}DATE${NC} = ${V_SET}$(date '+%d %b %Y %X')${NC}" 
echo -e "${A_SET}UPTIME${NC} = ${V_SET}$(uptime -p | sed 's/up //')${NC}"
echo -e "${A_SET}UPTIME_SEC${NC} = ${V_SET}$(cat /proc/uptime | awk '{print $1}')${NC}"
echo -e "${A_SET}IP${NC} = ${V_SET}$(ifconfig | grep inet \
    | awk 'NR == 1{print $2}')${NC}" 
echo -e "${A_SET}MASK${NC} = ${V_SET}$(ifconfig | grep inet \
    | awk 'NR == 1{print $4}')${NC}" 
echo -e "${A_SET}GATEWAY${NC} = ${V_SET}$(ip route | awk 'NR == 1{print $3}')${NC}"
echo $(free) > free_output.txt
# Load ram_total from ./free_output.txt in 8th position 
ram_total=$(awk 'NR == 1{print $8/1024/1024}' ./free_output.txt)
# formatted output like printf in C 
printf "${A_SET}RAM_TOTAL${NC} = ${V_SET}%.3f GB${NC}\n" $ram_total 
ram_used="$(awk 'NR == 1{print $9/1024/1024}' ./free_output.txt)"
printf "${A_SET}RAM_USED${NC} = ${V_SET}%.3f GB${NC}\n" $ram_used 
ram_free="$(awk 'NR == 1{print $10/1024/1024}' ./free_output.txt)"
printf "${A_SET}RAM_FREE${NC} = ${V_SET}%.3f GB${NC}\n" $ram_free 
rm -f free_output.txt
echo $(df | grep '[/]\B') > grep_output.txt
space_root="$(awk 'NR == 1{print $2/1024}' ./grep_output.txt)"
printf "${A_SET}SPACE_ROOT${NC} = ${V_SET}%.2f MB${NC}\n" $space_root 
space_root_used="$(awk 'NR == 1{print $3/1024}' ./grep_output.txt)"
printf "${A_SET}SPACE_ROOT_USED${NC} = ${V_SET}%.2f MB${NC}\n" $space_root_used
space_root_free="$(awk 'NR == 1{print $4/1024}' ./grep_output.txt)"
printf "${A_SET}SPACE_ROOT_FREE${NC} = ${V_SET}%.2f MB${NC}\n" $space_root_free
rm -f grep_output.txt
echo

color_scheme

exit 0
