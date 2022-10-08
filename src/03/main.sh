#!/bin/bash

# # Fonts color
# F_WHITE='\033[0;37m'
# F_RED='\033[0;31m'
# F_GREEN='\033[0;32m'
# F_BLUE='\033[0;34m'
# F_PURPLE='\033[0;35m'
# F_BLACK='\033[0;30m'

# #background color
# B_WHITE='\033[47m'
# B_RED='\033[41m'
# B_GREEN='\033[42m'
# B_BLUE='\033[44m'
# B_PURPLE='\033[45m'
# B_BLACK='\033[40m'


# Check qty of arguments
if [ "$#" -ne 4 ]; then
    # Redirect output to stderr
    >&2 echo Four arguments required. Run the script again.
    # And exit with error code
    exit 1
fi

# Check the same arguments
if [[ "$1" -eq "$2" || "$3" -eq "$4" ]]; then
    >&2 echo "Args 1 and 2 or 2 and 3 must be different. Run the script again"
    exit 1
fi

for param in "$@"
do
    if [[ $param -gt 6 || $param -lt 1 ]]; then
        >&2 echo "Arguments must be between 1 and 6. Run the script again"
        exit 1
    fi
done

NC='\033[0m'  # No Color

font_colors=('\033[0;37m' '\033[0;31m' '\033[0;32m' '\033[0;34m' \
    '\033[0;35m' '\033[0;30m')
bground_colors=('\033[47m' '\033[41m' '\033[42m' '\033[44m' '\033[45m' '\033[40m')

AF_SET=${font_colors[$1 - 1]}  # Set alias font color
AB_SET=${bground_colors[$2 - 1]}  # Set alias background color
A_SET="${AF_SET}${AB_SET}"

VF_SET=${font_colors[$3 - 1]}  # Set value font color
VB_SET=${bground_colors[$4 - 1]}  # Set value background color
V_SET="${VF_SET}${VB_SET}"


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

exit 0
