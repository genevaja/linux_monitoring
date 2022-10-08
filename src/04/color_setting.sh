#!/bin/bash

# Fonts color
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

NC='\033[0m'  # No Color

font_colors=('\033[0;37m' '\033[0;31m' '\033[0;32m' '\033[0;34m' \
    '\033[0;35m' '\033[0;30m')
bground_colors=('\033[47m' '\033[41m' '\033[42m' '\033[44m' '\033[45m' '\033[40m')

color_names=("(white)" "(red)" "(green)" "(blue)" "(purple)" "(black)")

config="main.conf"

# Default colors
function default_color {
AF_SET=${font_colors[0]}  # Set alias font color
AB_SET=${bground_colors[5]}  # Set alias background color
A_SET="${AF_SET}${AB_SET}"

VF_SET=${font_colors[0]}  # Set value font color
VB_SET=${bground_colors[5]}  # Set value background color
V_SET="${VF_SET}${VB_SET}"

column_1_font="Column 1 font color = default (white)"
column_1_bground="Column 1 background = default (black)"
column_2_font="Column 2 font color = default (white)"
column_2_bground="Column 2 background = default (black)"
}
